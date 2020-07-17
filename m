Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89752076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnUMGTuF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cIko/HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGQSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:35:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgGQSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:35:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595010946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uiwrMAqmxawI1Rcn1I56Kp6XcBO1SrZK17qX3Nlc3kE=;
        b=tnUMGTuFhdwPg+pZQK4Kj3X6yUKyH3XkRktnBEstN/JwQr6b8ytSs633JTcxcsmQjXKMXW
        YCqzdLvEas7DeI44guNooVpBElpE679FIkfMKP+bQtWCUtNYpnqtk6Ifl35sUIi7MBNDAz
        UvFtSwNj0uSqvXi1tWsxYuwc3KKgnq161DjLT9I8InSmlx1LzrvNrx90fuVbU0/XDowDQt
        RlaULjsBTJxYmL014hXjZh7fwjP7ry2LjhljZgJomjYJWaJ+dn8t4FyesmBdPMsyJqHkgY
        zvosasnwsprN2t9i2YjRSqD2Zp0jqW9vFAd3vc85mOd+5zh6GmaLdvL0GVh2Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595010946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uiwrMAqmxawI1Rcn1I56Kp6XcBO1SrZK17qX3Nlc3kE=;
        b=2cIko/HOAOpf3QwZjLesonVO1v0OVldA6urZyg/KCHfYF/AueNyuYTdi9tsLyqTmOAKJx3
        3I8Tl5YbnxP6veAA==
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <20200717172627.GC6067@redhat.com>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200717172627.GC6067@redhat.com>
Date:   Fri, 17 Jul 2020 20:35:46 +0200
Message-ID: <87zh7yq9a5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg,

Oleg Nesterov <oleg@redhat.com> writes:
> Looks correct to me, but I forgot everything about posix-timers.c

that's not a problem because this is about posix-cpu-timers.c :)

> this obviously means that the expired timer won't fire until the
> task returns to user-mode but probably we don't care.

If the signal goes to the task itself it does not matter at all because
it's going to be delivered when the task goes out to user space.

If the signal goes to a supervisor process, then it will be slightly
delayed but I could not find a problem with that at all.

I'll add more reasoning to the changelog on V3.

>> +#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
>> +void posix_cpu_timers_work(struct callback_head *work);
>> +
>> +static inline void posix_cputimer_init_work(struct posix_cputimers *pct)
>> +{
>> +	pct->task_work.func = posix_cpu_timers_work;
>
> init_task_work() ?

Yeah.

>> +}
>> +#else
>> +static inline void posix_cputimer_init_work(struct posix_cputimers *pct) { }
>> +#endif
>> +
>>  static inline void posix_cputimers_init(struct posix_cputimers *pct)
>>  {
>>  	memset(pct, 0, sizeof(*pct));
>>  	pct->bases[0].nextevt = U64_MAX;
>>  	pct->bases[1].nextevt = U64_MAX;
>>  	pct->bases[2].nextevt = U64_MAX;
>> +	posix_cputimer_init_work(pct);
>>  }
>
> And I can't resist. I know this is a common practice, please ignore, but to me
>
> 	static inline void posix_cputimers_init(struct posix_cputimers *pct)
> 	{
> 		memset(pct, 0, sizeof(*pct));
> 		pct->bases[0].nextevt = U64_MAX;
> 		pct->bases[1].nextevt = U64_MAX;
> 		pct->bases[2].nextevt = U64_MAX;
> 	#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
> 		init_task_work(&pct->task_work, posix_cpu_timers_work);
> 	#endif
> 	}
>
> looks better than 2 posix_cputimer_init_work() definitions above.

Gah, I hate ifdefs in the middle of the code :)

> Note also that signal_struct->posix_cputimers.task_work is never used, perhaps
> it would be better to move this task_work into task_struct? This way we do not
> even need to change posix_cputimers_init(), we call simply initialize
> init_task.posix_task_work.

Let me look into that.

Thanks,

        tglx
