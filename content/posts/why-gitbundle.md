+++
title = 'Why GitBundle'
date = 2023-12-14T11:02:28+08:00
draft = false
+++

## Why GitBundle

So, Why GitBundle. Why I have planed to develop a project as there have been many open-source vcs project. eg. Github, Gitlab, Gitea.

It's because that I found these project is very good, but like github, its core code is not open-source. like Gitlab, the code is mainly developed with ruby.

Besides Gitlab is so complicated, if user want to add some custom features for their company, they should pay a lot of time and energy. And the most important thing is that, these project did not support the kubernetes natively, because most company have made their services and architecture with micro-service.

As the kubernetes has natively supported the micro-service, so it's very nice to use kubernetes to organize the whole service for these companies. And I also found that many companies have their own devops teams and have paid a lot of money to develop a ci/cd and monitoring system.

While Gitea is open-source, but its core code is so redundancy and did not use the frontend and backend separation design. If you want to add a new feature for yourself. It's very hard to do that. You should also spend a lot of time and money for that. So in other words, the whole design is not that good for agile development.

And now many companies will use the services provided by different cloud vendors, but each of these different cloud vendors has its own operating interface, which undoubtedly increases the user's learning cost, and in order to eliminate this cost, the company will have a professional devops team to develop and maintain a set of their own ci/cd system to dock with these cloud vendors.

Eventually, GitBundle comes. GitBundle just want to help the devops teams to save their time and energy for the duplicated jobs, and let them to do some more important things. And GitBundle also want to give you a easy way for organize your whole micro-service architecture and make your whole development more reliable and securely.

So the goal for GitBundle is to help people to custom their whole development toolchain more easy and better with the modern technology like kubernetes and docker.

## 为什么要开发 GitBundle，GitBundle 有什么优势？

我本人是一个从事开发有近 10年的程序员，了解很多开发语言与架构，有过多家公司的工作经历。经过这么多年的开发，与所见过的一些各种各样的团队，基本可以肯定的是，每个 team 虽然根据自己公司的业务有一些差别，但是大家基本都是在重复的造轮子，而且有的轮子造的并不好用。比如 ci/cd，光这一块东西，我就发现无论什么样的公司都有自己的一套，有的使用 jekins，有的使用一些 python 脚本，有的使用自己在服务器搭建的一些简易的程序。而且有各种各样的问题，工具不统一，带来的问题是学习成本的增加，以及无法利用统一的架构去可靠安全的迭代生产环境的业务与项目。因为对于微服务的架构来讲，不同团队都会有很多自己团队维护的服务，然后这些服务可能会依赖其他 team 的服务，或者他们的这些服务会被其他的 team 依赖，因为缺少必要的测试环境，以及预发布环境，导致有些功能的上线会触发一些低级错误，这些错误根本原因是没有一个统一合理的架构来让这些所有的工作有序可靠的进行。

所以为了解决这些问题，GitBundle 决定尝试使用一些新的方法去重新设计，有效的规避这些问题。帮助用户有效的解决自己技术团队因为各种环境配置不统一，以及沟通方面带来的成本。