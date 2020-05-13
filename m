Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dXhLrquR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgEMTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:53:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26160 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732875AbgEMTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:53:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589399630; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=e34hcWJf1dwWUrXW+nXPpywwnaaeWmUQ6fC6pmySpV0=;
 b=dXhLrquR32Q9zWWMEmsz+yHHfTz6Z637XbsgLDXeEndymQkFhU0YbNTUpUEogxK5qifTbcQs
 aiYFp7Ooj89JCsSPdDBhjQe1FMDWlnm+f44j79gTlDR+WobvRqLLATqK0IGGBwjz8opVBLVP
 zYJwFTUNhoivpc8+mW7H+WnN32U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc504e.7fa948b996c0-smtp-out-n03;
 Wed, 13 May 2020 19:53:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 43A8CC43636; Wed, 13 May 2020 19:53:49 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E2EEC433D2;
        Wed, 13 May 2020 19:53:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 May 2020 12:53:48 -0700
From:   psodagud@codeaurora.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        pkondeti@codeaurora.org, Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really
 not bound to a cpu
In-Reply-To: <87a72lkx9t.fsf@nanos.tec.linutronix.de>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org>
 <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
 <87a72lkx9t.fsf@nanos.tec.linutronix.de>
Message-ID: <dbc01cd27346bb465744b93ece2b6362@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tglx,

On 2020-05-06 06:28, Thomas Gleixner wrote:
> Prasad Sodagudi <psodagud@codeaurora.org> writes:
>> To make all cpu unbound deferrable timers are scalable, introduce a 
>> common
>> timer base which is only for cpu unbound deferrable timers to make 
>> those
>> are indeed cpu unbound so that can be scheduled by any of non idle 
>> cpus.
>> This common timer fixes scalability issue of delayed work and all 
>> other cpu
>> unbound deferrable timer using implementations.
> 
> Scalability? That's really the wrong term here. A global timer base is
> the opposite and you really want to explain why this is not creating a
> scalability problem on large systems.
> 
>>  #ifdef CONFIG_SMP
>> +struct timer_base timer_base_deferrable;
>>  unsigned int sysctl_timer_migration = 1;
>> 
>>  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
>> @@ -841,8 +842,14 @@ static inline struct timer_base 
>> *get_timer_cpu_base(u32 tflags, u32 cpu)
>>  	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
>>  	 * to use the deferrable base.
>>  	 */
>> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
>> -		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) 
>> {
>> +#ifdef CONFIG_SMP
>> +		base = &timer_base_deferrable;
>> +#endif
> 
> There are definitely smarter ways of solving this than sprinkling
> #ifdef's around the code.

I am able to understand all other comments and I will address all those 
comments in the next patch set.
It is not clear to me how to avoid #ifdef's in this case. Could you 
please share an example here?


> 
>> +		if (tflags & TIMER_PINNED)
>> +			base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>> +	}
>> +
>>  	return base;
>>  }
>> @@ -1785,8 +1798,14 @@ static __latent_entropy void 
>> run_timer_softirq(struct softirq_action *h)
>>  	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
>> 
>>  	__run_timers(base);
>> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
>> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
>>  		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
>> +#ifdef CONFIG_SMP
>> +		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
>> +				tick_do_timer_cpu == smp_processor_id())
>> +			__run_timers(&timer_base_deferrable);
>> +#endif
> 
> Again, this can be solved in readable ways. Just slapping #ifdefs all
> over the place is sloppy and lazy.
Sorry. I will try to address this.  It is not clear to me how to avoid 
#ifdefs in this case too.
Please provide me more information.

> 
> Aside of that accessing the tick internals here open coded is just a
> layering violation.
I will fix this and avoid using referring to tick internals here.

> 
>> +	}
>>  }
>> 
>>  /*
>> @@ -2025,6 +2044,16 @@ static void __init init_timer_cpu(int cpu)
>>  	}
>>  }
>> 
>> +#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
>> +static void __init init_timer_deferrable_global(void)
>> +{
>> +	timer_base_deferrable.cpu = nr_cpu_ids;
> 
> This was obviously never tested with CONFIG_DEBUG_PER_CPU_MAPS=y as 
> this
> will simply result in out of bounds accesses.

Sure. I will test this CONFIG_DEBUG_PER_CPU_MAPS=y enabled before 
pushing the next patch set.
> 
>>  static void __init init_timer_cpus(void)
>>  {
>>  	int cpu;
>> @@ -2036,6 +2065,9 @@ static void __init init_timer_cpus(void)
>>  void __init init_timers(void)
>>  {
>>  	init_timer_cpus();
>> +#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
>> +	init_timer_deferrable_global();
>> +#endif
> 
> Stub functions exist to avoid this unreadable #ifdef garbage.
Got it. I will fix this in the next patch set.

> 
> Thanks,
> 
>         tglx
