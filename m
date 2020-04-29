Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD3C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8122085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2LsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:48:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48367 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726457AbgD2LsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:48:02 -0400
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="90776462"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Apr 2020 19:47:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6CC7E50A996E;
        Wed, 29 Apr 2020 19:47:58 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Apr 2020 19:47:59 +0800
Message-ID: <5EA9696D.9020505@cn.fujitsu.com>
Date:   Wed, 29 Apr 2020 19:47:57 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
References: <20200424223630.224895-1-joel@joelfernandes.org> <5EA80319.7080005@cn.fujitsu.com> <20200428141505.GA141102@google.com>
In-Reply-To: <20200428141505.GA141102@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 6CC7E50A996E.ABEDC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/28 22:15, Joel Fernandes wrote:
> I am wondering if it is because in your test, the kthread exits too quickly.
> We have these comments in kthread_stop():
>   * If threadfn() may call do_exit() itself, the caller must ensure
>   * task_struct can't go away.
>
> Does the below diff on top of the previous patch help?
>
> ---8<-----------------------
>
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 1c28ca20e30b6..8051946a18989 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -152,6 +152,8 @@ static int __init preemptirq_delay_init(void)
>   	int retval;
>
>   	test_task = preemptirq_start_test();
> +	get_task_struct(test_task);
> +
>   	retval = PTR_ERR_OR_ZERO(test_task);
>   	if (retval != 0)
>   		return retval;
> @@ -172,8 +174,10 @@ static void __exit preemptirq_delay_exit(void)
>   {
>   	kobject_put(preemptirq_delay_kobj);
>
> -	if (test_task)
> +	if (test_task) {
>   		kthread_stop(test_task);
> +		put_task_struct(test_task);
> +	}
>   }

Hi Joel,

Thanks for your additional patch.

First, We have to avoid kbuild error by including <linux/sched/task.h>
---------------------------------------
kernel/trace/preemptirq_delay_test.c: In function ‘preemptirq_delay_init’:
kernel/trace/preemptirq_delay_test.c:155:2: error: implicit declaration 
of function ‘get_task_struct’; did you mean ‘set_task_cpu’? 
[-Werror=implicit-function-declaration]
   get_task_struct(test_task);
   ^~~~~~~~~~~~~~~
   set_task_cpu
kernel/trace/preemptirq_delay_test.c: In function ‘preemptirq_delay_exit’:
kernel/trace/preemptirq_delay_test.c:179:3: error: implicit declaration 
of function ‘put_task_struct’; did you mean ‘set_task_cpu’? 
[-Werror=implicit-function-declaration]
    put_task_struct(test_task);
    ^~~~~~~~~~~~~~~
    set_task_cpu
cc1: some warnings being treated as errors
---------------------------------------

Second, I used the following steps to do test and didn't get any 
warning/panic after applying your additional patch：
---------------------------------------
for i in $(seq 1 100); do modprobe preemptirq_delay_test test_mode=irq 
delay=500000; rmmod preemptirq_delay_test; done
for i in $(seq 1 100); do modprobe preemptirq_delay_test 
test_mode=preempt delay=500000; rmmod preemptirq_delay_test; done
---------------------------------------

Thanks,
Xiao Yang


