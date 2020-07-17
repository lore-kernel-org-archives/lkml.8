Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364B22076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlHU8kpF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nj+OjvE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgGQShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:37:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:37:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595011072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcE5z9+Sra7MEy1EdgVToG0hJlja1wBJ+TAiPeOSSYs=;
        b=QlHU8kpFaNTx/dWooNhid0nWD0bCO28vnptZib5TBUvZwxuTVtrCpouWd0QUT4YFflKiF7
        QzXYeDPujgZ+fED+d39wSfOyw7o7Jr2hYLuyhudx3Cu4jKB7ptLNrKbxcCapKsVuQvysra
        ZPXtG+fgITQH29aCjmikLa3fH8shIMpEn7iPC15cqo16fKmAsE4PSP4ZPnFRLVBIJm66x2
        qk75kHslpy0ixZdIduz/LTjC66oghROvdSABIZNHefB6X/BBq4m1pJLc0fd6hShSYFuxw1
        PAUoYmg9VHsyU8TPr5DvrMD8m4rndB1h4UOehZOWEBZpJbTwNb9GgZP08LmTwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595011072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcE5z9+Sra7MEy1EdgVToG0hJlja1wBJ+TAiPeOSSYs=;
        b=Nj+OjvE2IDHvTt1RQZHHg7qh5xNqT8aAXpVLmawpocIAdY3VYmKRqKOwSQsLIBwlXVewRr
        u+y1Ae2HYyA3j0AQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <20200716225034.GK5523@worktop.programming.kicks-ass.net>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200716225034.GK5523@worktop.programming.kicks-ass.net>
Date:   Fri, 17 Jul 2020 20:37:51 +0200
Message-ID: <87wo32q96o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
>
>> @@ -1096,6 +1099,12 @@ static void __run_posix_cpu_timers(struc
>>  	check_process_timers(tsk, &firing);
>>  
>>  	/*
>> +	 * Allow new work to be scheduled. The expiry cache
>> +	 * is up to date.
>> +	 */
>> +	posix_cpu_timers_enable_work(tsk);
>> +
>> +	/*
>>  	 * We must release these locks before taking any timer's lock.
>>  	 * There is a potential race with timer deletion here, as the
>>  	 * siglock now protects our private firing list.  We have set
>
> I think I would feel more comfortable if this was done at the very
> beginning of that function, possibly even with:
>
>> +static void __run_posix_cpu_timers(struct task_struct *tsk)
>> +{
>> +	struct posix_cputimers *pct = &tsk->posix_cputimers;
>> +
>> +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
>> +		task_work_add(tsk, &pct->task_work, true);
>> +}
>> +
>> +static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
>> +{
>> +	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
> 	/*
> 	 * Ensure we observe everything before a failing test_and_set()
> 	 * in __run_posix_cpu_timers().
> 	 */
> 	smp_mb__after_atomic();
>> +}
>
> Such that when another timer interrupt happens while we run this, we're
> guaranteed to either see it, or get re-queued and thus re-run the
> function.

Makes sense.

Thanks,

        tglx
