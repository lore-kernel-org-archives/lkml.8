Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0932072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsH+Qo1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgEUNqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22733 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729442AbgEUNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590068767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9nvSofCV52RXcsAitaDMM08AxjyFwYncksRqjuaKbQ=;
        b=ZsH+Qo1QR2uk4G7Uj+56IhWHS07p5ZZiR0aFFY2SfLFgJoEM5amZozgMXg3O1rBebLnhO4
        6DwMwr9oqfZQM8BEX2OqVjetK0aHr2uvJgMPGSd3zTukbi3UkOSgLjWr3TSMwvy3H80uk/
        YGOg95/bp6a+/t0TfKmRWK9S8aayiTA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-suFdPwE8NpirPz9Lm1NgCg-1; Thu, 21 May 2020 09:46:05 -0400
X-MC-Unique: suFdPwE8NpirPz9Lm1NgCg-1
Received: by mail-qt1-f197.google.com with SMTP id z29so7741880qtj.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9nvSofCV52RXcsAitaDMM08AxjyFwYncksRqjuaKbQ=;
        b=Kwf5HPtX0uxOI2xAz5b2/9XDIuo1GfkvLZHX7lP2MoOBtEyURylopgnTI3oGRd8VjE
         JlppMOPSQI6tyiJfpa+TTvxLRbPChfU0HiABfbGP0ZZwlwJBmj6kkHpVUh95nmvPT1LA
         BEze+gBldeAof3RNMBfL6TEvckZJUs42CJ/MsNyEobQKIUxoJasYd9/JKI/m1rkHQFpV
         ox0yqq0HN4I4BHzPkM108JqE1AVRS54R8Lm+t0FvbVeIY8GwZKQthQYOqxym2j1nODcG
         0rsqnoX4KLH7D8fkwguhq3RCyJMyTNSrU43yKZYwbiBhwNUG0RxUqYae36r3JNfOIo7S
         4qbQ==
X-Gm-Message-State: AOAM531zJQqj3vyRZF2QV7K1cpCj/ZCGA3RwUctnhiLPYstVKzVLbu+n
        N5ghE4fp9yllTTeJ/JjTQy9B1Rl5oEqqcCs+anFRd8JHy8h9dLJCvzUhzAa5LiFEEst+z+JzbKJ
        isnK9+2vp8IS4E5hz9zM0qhks
X-Received: by 2002:a37:9f0c:: with SMTP id i12mr10214413qke.264.1590068765199;
        Thu, 21 May 2020 06:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVcpJRmfrmJofHKmCSye3jM76Zmi7hamSiTqffrsSxrKPptuYrGJk7ic7GXjHVDDn07nuBCA==
X-Received: by 2002:a37:9f0c:: with SMTP id i12mr10214380qke.264.1590068764877;
        Thu, 21 May 2020 06:46:04 -0700 (PDT)
Received: from x1.bristot.me ([95.247.206.136])
        by smtp.gmail.com with ESMTPSA id b11sm4865410qti.50.2020.05.21.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 06:46:03 -0700 (PDT)
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20200520183830.GN10078@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <33d2d98a-0388-b1df-cc02-1ed4bffedb1c@redhat.com>
Date:   Thu, 21 May 2020 15:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520183830.GN10078@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 8:38 PM, Juri Lelli wrote:
> Hi Peter,
> 
> On 26/07/19 16:54, Peter Zijlstra wrote:
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Luca Abeni <luca.abeni@santannapisa.it>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>  include/linux/sched/sysctl.h |    3 +++
>>  kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
>>  kernel/sysctl.c              |   14 ++++++++++++++
>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>
>> --- a/include/linux/sched/sysctl.h
>> +++ b/include/linux/sched/sysctl.h
>> @@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
>>  extern unsigned int sysctl_sched_rt_period;
>>  extern int sysctl_sched_rt_runtime;
>>  
>> +extern unsigned int sysctl_sched_dl_period_max;
>> +extern unsigned int sysctl_sched_dl_period_min;
>> +
>>  #ifdef CONFIG_UCLAMP_TASK
>>  extern unsigned int sysctl_sched_uclamp_util_min;
>>  extern unsigned int sysctl_sched_uclamp_util_max;
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
>>  }
>>  
>>  /*
>> + * Default limits for DL period; on the top end we guard against small util
>> + * tasks still getting rediculous long effective runtimes, on the bottom end we
>> + * guard against timer DoS.
>> + */
>> +unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
>> +unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
>> +
>> +/*
>>   * This function validates the new parameters of a -deadline task.
>>   * We ask for the deadline not being zero, and greater or equal
>>   * than the runtime, as well as the period of being zero or
>> @@ -2608,6 +2616,8 @@ void __getparam_dl(struct task_struct *p
>>   */
>>  bool __checkparam_dl(const struct sched_attr *attr)
>>  {
>> +	u64 period, max, min;
>> +
>>  	/* special dl tasks don't actually use any parameter */
>>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>>  		return true;
>> @@ -2631,12 +2641,21 @@ bool __checkparam_dl(const struct sched_
>>  	    attr->sched_period & (1ULL << 63))
>>  		return false;
>>  
>> +	period = attr->sched_period;
>> +	if (!period)
>> +		period = attr->sched_deadline;
>> +
>>  	/* runtime <= deadline <= period (if period != 0) */
>> -	if ((attr->sched_period != 0 &&
>> -	     attr->sched_period < attr->sched_deadline) ||
>> +	if (period < attr->sched_deadline ||
>>  	    attr->sched_deadline < attr->sched_runtime)
>>  		return false;
>>  
>> +	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
>> +	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
>> +
>> +	if (period < min || period > max)
>> +		return false;
>> +
>>  	return true;
>>  }
>>  
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -443,6 +443,20 @@ static struct ctl_table kern_table[] = {
>>  		.proc_handler	= sched_rt_handler,
>>  	},
>>  	{
>> +		.procname	= "sched_deadline_period_max_us",
>> +		.data		= &sysctl_sched_dl_period_max,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec,
>> +	},
>> +	{
>> +		.procname	= "sched_deadline_period_min_us",
>> +		.data		= &sysctl_sched_dl_period_min,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec,
>> +	},
>> +	{
>>  		.procname	= "sched_rr_timeslice_ms",
>>  		.data		= &sysctl_sched_rr_timeslice,
>>  		.maxlen		= sizeof(int),
> I think this never made it upstream. And I believe both me and Daniel
> were OK with it. Do you recall if any additional change was needed?

Just to confirm, yes I am OK with it!

-- Daniel

