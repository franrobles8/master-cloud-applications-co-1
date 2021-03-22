package es.codeurjc.mastercloudapps.planner.configuration;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import com.rabbitmq.client.ConnectionFactory;

import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.retry.support.RetryTemplate;

@Configuration
public class RabbitMQConfig {

    @Value("${spring.rabbitmq.host}")
    String hostname;

    @Value("${spring.rabbitmq.port}")
    int port;

    @Value("${spring.rabbitmq.username}")
    String userName;

    @Value("${spring.rabbitmq.password}")
    String password;

    @Bean
    CachingConnectionFactory connectionFactory() {
        ConnectionFactory cf = new ConnectionFactory();
        cf.setHost(hostname);
        cf.setPort(port);
        cf.setUsername(userName);
        cf.setPassword(password);

        return new CachingConnectionFactory(cf);
    }

    @Bean
    RabbitAdmin rabbitAdmin(org.springframework.amqp.rabbit.connection.ConnectionFactory  cf) {
        return new RabbitAdmin(cf);
    }

    @Bean
    RabbitTemplate rabbitTemplate(org.springframework.amqp.rabbit.connection.ConnectionFactory cf) {
        RabbitTemplate template = new RabbitTemplate(cf);
        RetryTemplate retry = new RetryTemplate();
        template.setRetryTemplate(retry);
        template.setMessageConverter(new Jackson2JsonMessageConverter());
        return template;
    }
}