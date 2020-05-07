Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD2C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A422083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEGKFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:05:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48571 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725985AbgEGKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:05:12 -0400
X-IronPort-AV: E=Sophos;i="5.73,362,1583164800"; 
   d="scan'208";a="91544946"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 May 2020 18:05:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 52B994CE2E7D;
        Thu,  7 May 2020 18:05:05 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 7 May 2020 18:05:04 +0800
Message-ID: <5EB3DD4E.7060000@cn.fujitsu.com>
Date:   Thu, 7 May 2020 18:05:02 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] tracing: Wait for preempt irq delay thread to finish
References: <20200424223630.224895-1-joel@joelfernandes.org>    <5EA80319.7080005@cn.fujitsu.com>       <20200428104409.0995ceb0@gandalf.local.home>    <20200428104543.3926eaaf@gandalf.local.home>    <5EA96AE8.6000707@cn.fujitsu.com>       <20200429123141.580f89ce@gandalf.local.home>    <20200429191224.GA75562@google.com>     <20200506093805.1f86f3f0@gandalf.local.home> <20200506103017.72abd2cd@gandalf.local.home>
In-Reply-To: <20200506103017.72abd2cd@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 52B994CE2E7D.AC111
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thanks for your further investigation.

I used the following ways to test your fix patch on my slow vm and 
didn't see any issue:
1) Insert and remove preemptirq_delay_test in loops.
2) Insert preemptirq_delay_test, write to 
/sys/kernel/preemptirq_delay_test/trigger and remove 
preemptirq_delay_test in loops.
3) Ran irqsoff_tracer.tc in loops.

BTW: For irqsoff_tracer.tc, should we extend code to test the burst 
feature and the sysfs trigger?

Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang
On 2020/5/6 22:30, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)"<rostedt@goodmis.org>
>
> Running on a slower machine, it is possible that the preempt delay kernel
> thread may still be executing if the module was immediately removed after
> added, and this can cause the kernel to crash as the kernel thread might be
> executing after its code has been removed.
>
> There's no reason that the caller of the code shouldn't just wait for the
> delay thread to finish, as the thread can also be created by a trigger in
> the sysfs code, which also has the same issues.
>
> Link: http://lore.kernel.org/r/5EA2B0C8.2080706@cn.fujitsu.com
>
> Cc: stable@vger.kernel.org
> Fixes: 793937236d1ee ("lib: Add module for testing preemptoff/irqsoff latency tracers")
> Reported-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Signed-off-by: Steven Rostedt (VMware)<rostedt@goodmis.org>
> ---
>   kernel/trace/preemptirq_delay_test.c | 30 ++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 31c0fad4cb9e..c4c86de63cf9 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -113,22 +113,42 @@ static int preemptirq_delay_run(void *data)
>
>   	for (i = 0; i<  s; i++)
>   		(testfuncs[i])(i);
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	while (!kthread_should_stop()) {
> +		schedule();
> +		set_current_state(TASK_INTERRUPTIBLE);
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +
>   	return 0;
>   }
>
> -static struct task_struct *preemptirq_start_test(void)
> +static int preemptirq_run_test(void)
>   {
> +	struct task_struct *task;
> +
>   	char task_name[50];
>
>   	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
> -	return kthread_run(preemptirq_delay_run, NULL, task_name);
> +	task =  kthread_run(preemptirq_delay_run, NULL, task_name);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +	if (task)
> +		kthread_stop(task);
> +	return 0;
>   }
>
>
>   static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
>   			 const char *buf, size_t count)
>   {
> -	preemptirq_start_test();
> +	ssize_t ret;
> +
> +	ret = preemptirq_run_test();
> +	if (ret)
> +		return ret;
>   	return count;
>   }
>
> @@ -148,11 +168,9 @@ static struct kobject *preemptirq_delay_kobj;
>
>   static int __init preemptirq_delay_init(void)
>   {
> -	struct task_struct *test_task;
>   	int retval;
>
> -	test_task = preemptirq_start_test();
> -	retval = PTR_ERR_OR_ZERO(test_task);
> +	retval = preemptirq_run_test();
>   	if (retval != 0)
>   		return retval;
>



