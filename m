Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D9C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797D24654
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583807211;
	bh=nQXDEoo6Qa8IkKSSYjqM1U7q4GgW+WWnETvYqiwoqgs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hnPqBb5/8ZX9GEZff1ByrTNBSuP5D3uWTHL9FVrAyEtvUVFNWJlRU7l3gqUboM9dl
	 RRSiU565vDJYK3KJrH9EMAmR2/xcLlTCIJPqgY1GyR0giq6e8y1G/IZ/iWu4MOC0eb
	 BHDujiMe+jNDI3DyI+Nw2OpnwILZ958Vly/VCcB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCJC0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgCJC0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:26:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C1D20637;
        Tue, 10 Mar 2020 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583807209;
        bh=nQXDEoo6Qa8IkKSSYjqM1U7q4GgW+WWnETvYqiwoqgs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=egIcQ56YpmAPHTS7ypaqsTA/2uGGF8z0keKlDwRMqns3cH6/KHuNtxSsIT65+9uIb
         HhlixC6yd+qo1Bn6D/kGmf6whPjv/SRCZlOp6RZis8NZk0Utm1vUlvXbsGBmLzNqg0
         CpRBitk3tKU0XXIB2UnlGhNyBq2UxFarHZ8WRiXc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 465CA3522730; Mon,  9 Mar 2020 19:26:49 -0700 (PDT)
Date:   Mon, 9 Mar 2020 19:26:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: Instrumentation and RCU
Message-ID: <20200310022649.GW2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309204710.GU2935@paulmck-ThinkPad-P72>
 <20200309235210.GB20868@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309235210.GB20868@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:52:11AM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 09, 2020 at 01:47:10PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 09, 2020 at 06:02:32PM +0100, Thomas Gleixner wrote:
> > > #3) RCU idle
> > > 
> > >     Being able to trace code inside RCU idle sections is very similar to
> > >     the question raised in #1.
> > > 
> > >     Assume all of the instrumentation would be doing conditional RCU
> > >     schemes, i.e.:
> > > 
> > >     if (rcuidle)
> > >     	....
> > >     else
> > >         rcu_read_lock_sched()
> > > 
> > >     before invoking the actual instrumentation functions and of course
> > >     undoing that right after it, that really begs the question whether
> > >     it's worth it.
> > > 
> > >     Especially constructs like:
> > > 
> > >     trace_hardirqs_off()
> > >        idx = srcu_read_lock()
> > >        rcu_irq_enter_irqson();
> > >        ...
> > >        rcu_irq_exit_irqson();
> > >        srcu_read_unlock(idx);
> > > 
> > >     if (user_mode)
> > >        user_exit_irqsoff();
> > >     else
> > >        rcu_irq_enter();
> > > 
> > >     are really more than questionable. For 99.9999% of instrumentation
> > >     users it's absolutely irrelevant whether this traces the interrupt
> > >     disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
> > > 
> > >     But what's relevant is the tracer overhead which is e.g. inflicted
> > >     with todays trace_hardirqs_off/on() implementation because that
> > >     unconditionally uses the rcuidle variant with the scru/rcu_irq dance
> > >     around every tracepoint.
> > > 
> > >     Even if the tracepoint sits in the ASM code it just covers about ~20
> > >     low level ASM instructions more. The tracer invocation, which is
> > >     even done twice when coming from user space on x86 (the second call
> > >     is optimized in the tracer C-code), costs definitely way more
> > >     cycles. When you take the scru/rcu_irq dance into account it's a
> > >     complete disaster performance wise.
> > 
> > Suppose that we had a variant of RCU that had about the same read-side
> > overhead as Preempt-RCU, but which could be used from idle as well as
> > from CPUs in the process of coming online or going offline?  I have not
> > thought through the irq/NMI/exception entry/exit cases, but I don't see
> > why that would be problem.
> > 
> > This would have explicit critical-section entry/exit code, so it would
> > not be any help for trampolines.
> > 
> > Would such a variant of RCU help?
> > 
> > Yeah, I know.  Just what the kernel doesn't need, yet another variant
> > of RCU...
> 
> I was thinking about having a tracing-specific implementation of RCU.
> Last week Steve told me that the tracing ring buffer has its own ad-hoc
> RCU implementation which schedule a thread on each CPU to complete a grace
> period (did I understand it right?). Of course such a flavour of RCU wouldn't
> be nice to nohz_full but surely we can arrange some tweaks for those who
> require strong isolation. I'm sure you're having a much better idea though.

Well, that too.  Please see CONFIG_TASKS_RCU_RUDE in current
"dev" on -rcu.  But yes, another is on its way...

Hey, it compiled, so it much be perfect, right?  :-/

							Thanx, Paul
