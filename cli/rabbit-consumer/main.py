#!/usr/bin/env python3
import pika
import sys
import os


class Environment:
    def __init__(self, host, exchange, binding_keys):
        self.host = host
        self.exchange = exchange
        self.binding_keys = binding_keys


def read_environment():
    return Environment(
        host='localhost',
        exchange='location',
        binding_keys='location.*'
    )

def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))


def main():
    env = read_environment()
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=env.host))
    channel = connection.channel()

    channel.exchange_declare(exchange=env.exchange, exchange_type='topic')
    result = channel.queue_declare('', exclusive=True)
    queue_name = result.method.queue

    for binding_key in env.binding_keys:
        channel.queue_bind(exchange=env.exchange, queue=queue_name, routing_key=binding_key)

    print(' [*] Waiting for messages. To exit press CTRL+C')

    channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)

    channel.start_consuming()


if __name__ == '__main__':
    main()
