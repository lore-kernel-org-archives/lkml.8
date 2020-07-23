Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C3C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcLArYGx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m10+pFDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgGWIc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:32:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA75C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:32:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595493175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZCjUytfdljZjKQoTLLThKMyonbpmcJ1ogC2T/UoXv4=;
        b=mcLArYGxD/scevathgu5sl4mvgSYKHp/kOjZqDVIArTdFuut6z+JkK/LQec4+4TCR7YKVb
        8RLuSDPJXSgdDbCFZIN/f2NwkM2x6aK5dqIzPnTPzK3KTDRCB4ryTEtvhZXoDFI6YjYP3M
        cRdi2ffy+4o1QhIdUMCV+J4BB8nySLxP9nOgVsRuMqoTn690IH58u9InWcWR4AJ1NW9zm2
        tWajUPCMoJXElI83AAbNBCj2zePCHxeUxw1/onuP6RsuhJZv/6Ahqs5VnQ7mGz0rxj0gau
        Fd8Dij0OpHNXyH4I14YUczOMvq3y/COa2+kD2QvfvQYLyGhX3gAQlvhWXdtQxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595493175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZCjUytfdljZjKQoTLLThKMyonbpmcJ1ogC2T/UoXv4=;
        b=m10+pFDSCPNAl02+tA+LOdV8GevqwXHYpGQVp4J4hsoj/Kh0JuRYAJo/zNIWjJxuBE3GOX
        buRdv8/2M+QNskAg==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <20200723010314.GA28401@lenoir>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200716225034.GK5523@worktop.programming.kicks-ass.net> <20200723010314.GA28401@lenoir>
Date:   Thu, 23 Jul 2020 10:32:54 +0200
Message-ID: <875zaezl55.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
> On Fri, Jul 17, 2020 at 12:50:34AM +0200, Peter Zijlstra wrote:
>> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
>> > +static void __run_posix_cpu_timers(struct task_struct *tsk)
>> > +{
>> > +	struct posix_cputimers *pct = &tsk->posix_cputimers;
>> > +
>> > +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
>> > +		task_work_add(tsk, &pct->task_work, true);
>> > +}
>> > +
>> > +static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
>> > +{
>> > +	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
>> 	/*
>> 	 * Ensure we observe everything before a failing test_and_set()
>> 	 * in __run_posix_cpu_timers().
>> 	 */
>> 	smp_mb__after_atomic();
>> > +}
>> 
>> Such that when another timer interrupt happens while we run this, we're
>> guaranteed to either see it, or get re-queued and thus re-run the
>> function.
>
> But each thread in the process enqueues its own task work and flips its
> own flags. So if task A runs the task work and task B runs __run_posix_cpu_timers(),
> they wouldn't be ordering against the same flags.

If two tasks queue work independent of each other then one of them will
find it done already, which is the same as if two tasks of the same
process execute run_posix_cpu_timers() in parallel.

I really don't want to go into the rathole of making the work or the
synchronization process wide. That's a guarantee for disaster.

Handling task work strictly per task is straight forward and simple. The
eventually resulting contention on sighand lock in task work is
unavoidable, but that's a reasonable tradeoff vs. the complexity you
need to handle task work process wide.

Thanks,

        tglx
