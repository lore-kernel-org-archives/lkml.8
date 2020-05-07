Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 253A820735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OUiY28i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEGM3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgEGM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:29:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A4C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:29:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b188so5689221qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=f+0YtocF0cAAetB1w+AFwOGpgW2A5+rcI7viqe5dsd0=;
        b=OUiY28i8h2NHisORIRwwkwXw6BFhGMlRr1XHiLJyBOIuFZLoaFMUgQMirmJo3LjGBM
         gnfwgWW20xI+wmTg1qrfeVNp1LmlOsdoqrWFJa40Fjoe27X7aeIIOOnPNQlJx7Ldh+QA
         oGqTkpl9Zw3nm/sXtyaWB2Kogc3Op43F9lQ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=f+0YtocF0cAAetB1w+AFwOGpgW2A5+rcI7viqe5dsd0=;
        b=jrp4bI5QlXI/tIxI+fdRdwKStpz3IFtV9C9ZWFMhzK1NY04bPic5yHMJ+7Z/PMxQTn
         KtEmOH1bk70eFCayA/uZkrQy8zsSNE2bbnBi5FSgR82BMm4c1EvPPBqQgqW7bxIWdm+I
         xAvWwf3sFC9PLCq/d4HDBo4wKvmiItjwI+LcoafKKC0zmrIc3eOE2LtdSt5wY5HaYNLD
         2Oaop8OWLR0k/rKP2gyO4uFKiPKEKHVWaFyx4vlC2UgzaL+O2wiou5la3kMTSFOkjP+6
         PZqvEnPxLF2HGM18AKb+Ql5mch0GAfZnBOjWyY5YSN2zRKtPEftRoQ9OACTmKd/RX3YI
         iEdQ==
X-Gm-Message-State: AGi0PuawlvC+dn8lkjh3r0XzUu5BYhkntk+WpmrDyf+fYfA0TPBEAP4e
        rQBDRwykxEdGW72V0DCv0em/dQ==
X-Google-Smtp-Source: APiQypKVwLV1s9Dl+J0mz5ybMAJYjQ9i/3jkrdB6Qop9UW1v2AYCVBrz7QljzgPtRQYVvhgeTFfTqg==
X-Received: by 2002:a37:5941:: with SMTP id n62mr13891342qkb.419.1588854553419;
        Thu, 07 May 2020 05:29:13 -0700 (PDT)
Received: from [192.168.1.8] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id d9sm3746924qtj.77.2020.05.07.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 05:29:12 -0700 (PDT)
Date:   Thu, 07 May 2020 08:29:10 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <5EB3DD4E.7060000@cn.fujitsu.com>
References: <20200424223630.224895-1-joel@joelfernandes.org> <5EA80319.7080005@cn.fujitsu.com> <20200428104409.0995ceb0@gandalf.local.home> <20200428104543.3926eaaf@gandalf.local.home> <5EA96AE8.6000707@cn.fujitsu.com> <20200429123141.580f89ce@gandalf.local.home> <20200429191224.GA75562@google.com> <20200506093805.1f86f3f0@gandalf.local.home> <20200506103017.72abd2cd@gandalf.local.home> <5EB3DD4E.7060000@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Wait for preempt irq delay thread to finish
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
From:   joel@joelfernandes.org
Message-ID: <8C3E6BAF-255D-41C7-B652-7C68877BDBED@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 7, 2020 6:05:02 AM EDT, Xiao Yang <yangx=2Ejy@cn=2Efujitsu=2Ecom> w=
rote:
>Hi Steven,
>
>Thanks for your further investigation=2E
>
>I used the following ways to test your fix patch on my slow vm and=20
>didn't see any issue:
>1) Insert and remove preemptirq_delay_test in loops=2E
>2) Insert preemptirq_delay_test, write to=20
>/sys/kernel/preemptirq_delay_test/trigger and remove=20
>preemptirq_delay_test in loops=2E
>3) Ran irqsoff_tracer=2Etc in loops=2E
>
>BTW: For irqsoff_tracer=2Etc, should we extend code to test the burst=20
>feature and the sysfs trigger?
>
>Reviewed-by: Xiao Yang <yangx=2Ejy@cn=2Efujitsu=2Ecom>
>

Thanks!

Reviewed-by: Joel Fernandes <joel@joelfernandes=2Eorg>

- Joel


>Thanks,
>Xiao Yang
>On 2020/5/6 22:30, Steven Rostedt wrote:
>> From: "Steven Rostedt (VMware)"<rostedt@goodmis=2Eorg>
>>
>> Running on a slower machine, it is possible that the preempt delay
>kernel
>> thread may still be executing if the module was immediately removed
>after
>> added, and this can cause the kernel to crash as the kernel thread
>might be
>> executing after its code has been removed=2E
>>
>> There's no reason that the caller of the code shouldn't just wait for
>the
>> delay thread to finish, as the thread can also be created by a
>trigger in
>> the sysfs code, which also has the same issues=2E
>>
>> Link: http://lore=2Ekernel=2Eorg/r/5EA2B0C8=2E2080706@cn=2Efujitsu=2Eco=
m
>>
>> Cc: stable@vger=2Ekernel=2Eorg
>> Fixes: 793937236d1ee ("lib: Add module for testing preemptoff/irqsoff
>latency tracers")
>> Reported-by: Xiao Yang<yangx=2Ejy@cn=2Efujitsu=2Ecom>
>> Signed-off-by: Steven Rostedt (VMware)<rostedt@goodmis=2Eorg>
>> ---
>>   kernel/trace/preemptirq_delay_test=2Ec | 30
>++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/trace/preemptirq_delay_test=2Ec
>b/kernel/trace/preemptirq_delay_test=2Ec
>> index 31c0fad4cb9e=2E=2Ec4c86de63cf9 100644
>> --- a/kernel/trace/preemptirq_delay_test=2Ec
>> +++ b/kernel/trace/preemptirq_delay_test=2Ec
>> @@ -113,22 +113,42 @@ static int preemptirq_delay_run(void *data)
>>
>>   	for (i =3D 0; i<  s; i++)
>>   		(testfuncs[i])(i);
>> +
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +	while (!kthread_should_stop()) {
>> +		schedule();
>> +		set_current_state(TASK_INTERRUPTIBLE);
>> +	}
>> +
>> +	__set_current_state(TASK_RUNNING);
>> +
>>   	return 0;
>>   }
>>
>> -static struct task_struct *preemptirq_start_test(void)
>> +static int preemptirq_run_test(void)
>>   {
>> +	struct task_struct *task;
>> +
>>   	char task_name[50];
>>
>>   	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
>> -	return kthread_run(preemptirq_delay_run, NULL, task_name);
>> +	task =3D  kthread_run(preemptirq_delay_run, NULL, task_name);
>> +	if (IS_ERR(task))
>> +		return PTR_ERR(task);
>> +	if (task)
>> +		kthread_stop(task);
>> +	return 0;
>>   }
>>
>>
>>   static ssize_t trigger_store(struct kobject *kobj, struct
>kobj_attribute *attr,
>>   			 const char *buf, size_t count)
>>   {
>> -	preemptirq_start_test();
>> +	ssize_t ret;
>> +
>> +	ret =3D preemptirq_run_test();
>> +	if (ret)
>> +		return ret;
>>   	return count;
>>   }
>>
>> @@ -148,11 +168,9 @@ static struct kobject *preemptirq_delay_kobj;
>>
>>   static int __init preemptirq_delay_init(void)
>>   {
>> -	struct task_struct *test_task;
>>   	int retval;
>>
>> -	test_task =3D preemptirq_start_test();
>> -	retval =3D PTR_ERR_OR_ZERO(test_task);
>> +	retval =3D preemptirq_run_test();
>>   	if (retval !=3D 0)
>>   		return retval;
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
