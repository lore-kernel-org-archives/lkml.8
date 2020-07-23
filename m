Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A310C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF162086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595506561;
	bh=HrXmDc9dESX2nsJkgXOKI7SspxVw0iWAoTVT9elnuis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oMM9GmPI8b3+GwxRFqYat+P867Pffc4sALPnyBOWsFkxHR1My20ivp4HovcCanSyT
	 Q7Qas9r3jwsek0YIjV2jpFpw17J56fuybk0pdf8bQNWfgzS+sbC4yoT/+Eurps2+zA
	 gAxwecNQU5QLtoUieVW751zHWfNzQNqabMzI8OyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGWMQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWMP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:15:59 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2032080D;
        Thu, 23 Jul 2020 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595506559;
        bh=HrXmDc9dESX2nsJkgXOKI7SspxVw0iWAoTVT9elnuis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+mPlJSJOaFNL5b6JoIMMb17lBd3fqt4WHVq1uU51xTnwB/7sh0UBa6DtH1BIP/Bq
         jeqe2i55F32IjDrZ9x8eEoriZXAfaOFQVpELGoCtsf40+1xqY6s8tE0frY/ZgcUIEa
         Xte8rEwtWk+h6dTmGzqZpIB3JKftdvZcgz+vIRQo=
Date:   Thu, 23 Jul 2020 14:15:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer
 timer handling to task_work
Message-ID: <20200723121555.GB28401@lenoir>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.734067877@linutronix.de>
 <20200716225034.GK5523@worktop.programming.kicks-ass.net>
 <20200723010314.GA28401@lenoir>
 <875zaezl55.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zaezl55.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:32:54AM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > On Fri, Jul 17, 2020 at 12:50:34AM +0200, Peter Zijlstra wrote:
> >> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
> >> > +static void __run_posix_cpu_timers(struct task_struct *tsk)
> >> > +{
> >> > +	struct posix_cputimers *pct = &tsk->posix_cputimers;
> >> > +
> >> > +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
> >> > +		task_work_add(tsk, &pct->task_work, true);
> >> > +}
> >> > +
> >> > +static inline void posix_cpu_timers_enable_work(struct task_struct *tsk)
> >> > +{
> >> > +	clear_bit(CPUTIMERS_WORK_SCHEDULED, &tsk->posix_cputimers.flags);
> >> 	/*
> >> 	 * Ensure we observe everything before a failing test_and_set()
> >> 	 * in __run_posix_cpu_timers().
> >> 	 */
> >> 	smp_mb__after_atomic();
> >> > +}
> >> 
> >> Such that when another timer interrupt happens while we run this, we're
> >> guaranteed to either see it, or get re-queued and thus re-run the
> >> function.
> >
> > But each thread in the process enqueues its own task work and flips its
> > own flags. So if task A runs the task work and task B runs __run_posix_cpu_timers(),
> > they wouldn't be ordering against the same flags.
> 
> If two tasks queue work independent of each other then one of them will
> find it done already, which is the same as if two tasks of the same
> process execute run_posix_cpu_timers() in parallel.
> 
> I really don't want to go into the rathole of making the work or the
> synchronization process wide. That's a guarantee for disaster.
> 
> Handling task work strictly per task is straight forward and simple. The
> eventually resulting contention on sighand lock in task work is
> unavoidable, but that's a reasonable tradeoff vs. the complexity you
> need to handle task work process wide.

Definetly!

I was only commenting on the barrier suggestion. But I believe it shouldn't
be needed in the end.

If we were to have a per task work for thread timers and a per process work
for process timers, that means we would need to cut down the whole thing, and also
take care about timers firing after exit_task_work(), which isn't an issue
in the thread case as the work will simply be ignored for an exiting task but
it's a big issue in the case of process wide handling.

Anyway, the current layout is simple enough.
