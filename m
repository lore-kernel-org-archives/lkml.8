Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF96C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF172075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588789738;
	bh=wZc8GE0Iy2gyxMgpOHL9RTIZW0KwAwAYkEbYTQG3M24=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=e1i8Tb/o6IMnweqV0ZisZEMS3SwMxTm1QK4PsSH6RlwwouCoHgSzE0SAMf4AOZzym
	 glRPTE1Cl/EBjfPCwuiwzIYEDB0g4CsX2Tk9yc75/IZmrbPuPxOczCtQIwKSLWbCXE
	 CAumu+HhBiTFFzBgZMqyUxvPuYoG/xD5nfJ1Firg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgEFS25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgEFS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:28:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20EE020708;
        Wed,  6 May 2020 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588789736;
        bh=wZc8GE0Iy2gyxMgpOHL9RTIZW0KwAwAYkEbYTQG3M24=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qo8WuAbK9clfsd5xkAs+kEy2nfWEE+FJejg+4kv4+p05N4aCxt0M8Td/qebmw6Ti7
         a69avL7vupXS4pJtza7UeVXQmhYPsMUFdGyy3AdRDFCGBcPjbRNadkSM5nfq0OzvXh
         EXedyliq9dadDN/WzVIbqhnZwzYg/KgsNZCXzJVY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 09D92352306C; Wed,  6 May 2020 11:28:56 -0700 (PDT)
Date:   Wed, 6 May 2020 11:28:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
Message-ID: <20200506182856.GD2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
 <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
 <20200506153300.GB5281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506153300.GB5281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:33:00PM +0200, Peter Zijlstra wrote:
> On Wed, May 06, 2020 at 02:37:19PM +0200, Alexandre Chartre wrote:
> > On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> > > @@ -650,6 +655,16 @@ static inline bool got_nohz_idle_kick(vo
> > >   	return false;
> > >   }
> > > +static void nohz_csd_func(void *info)
> > > +{
> > > +	struct rq *rq = info;
> > > +
> > > +	if (got_nohz_idle_kick()) {
> > > +		rq->idle_balance = 1;
> > > +		raise_softirq_irqoff(SCHED_SOFTIRQ);
> > > +	}
> > > +}
> > > +
> > >   #else /* CONFIG_NO_HZ_COMMON */
> > >   static inline bool got_nohz_idle_kick(void)
> 
> > >   #ifdef CONFIG_NO_HZ_COMMON
> > >   		rq->last_blocked_load_update_tick = jiffies;
> > >   		atomic_set(&rq->nohz_flags, 0);
> > > +
> > > +		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
> > >   #endif
> > >   #endif /* CONFIG_SMP */
> > >   		hrtick_rq_init(rq);
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10009,12 +10009,11 @@ static void kick_ilb(unsigned int flags)
> > >   		return;
> > >   	/*
> > > -	 * Use smp_send_reschedule() instead of resched_cpu().
> > > -	 * This way we generate a sched IPI on the target CPU which
> > > +	 * This way we generate an IPI on the target CPU which
> > >   	 * is idle. And the softirq performing nohz idle load balance
> > >   	 * will be run before returning from the IPI.
> > >   	 */
> > > -	smp_send_reschedule(ilb_cpu);
> > > +	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->wake_csd);
> > 
> > This should be nohz_csd instead of wake_csd, no? I.e.:
> > 
> >        smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
> 
> You figured correctly. Thanks!

And this does get rid of the smp_call_function splats I was seeing
earlier, thank you!

I still see warnings of the form "leave instruction with modified stack
frame" from older complilers and of the form "undefined stack state"
from newer compilers.  I am running stock objtool versions, so I am
guessing that this is at least one reason for these warnings.

							Thanx, Paul
