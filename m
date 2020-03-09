Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD7C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160722464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583786833;
	bh=n7cCW4Y+8tXr+CFatRyuIx4cUK8SgM3pz3iHA38COOU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Erbpw7XiJ1d73Stz9NkFVF8Yk8cAVahHqiYVyduH09uLLxcT/ho1cKGs7FTrrQGYo
	 HCkljyKIuVLJWrDrpsq9HOEjbyN9HCl1xwauXhHnXnaKiXEoV/CrBoFnvWZ97alQiA
	 zk6tLoXvc2+RFULpLDUCUAQX+1PM5xiTxq+/FVr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCIUrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCIUrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:47:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BE424649;
        Mon,  9 Mar 2020 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583786830;
        bh=n7cCW4Y+8tXr+CFatRyuIx4cUK8SgM3pz3iHA38COOU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NNgxqVc6b6c60pfDhqn/ivFBjNx5Wi7z3uoCM+fHYOcdNEp7MBD8t5oUCVnz4uwuT
         7j0/Zv1ErZ9fkNp8wdV6Kd1elu9wbEePT2mC/HFqKAixAO5OaygxYF0t3N7ZlebsxS
         Rp+M7vo4yFo+kJn38ekIPKXBFnZuRVy9C1E9GR3U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B9B803522730; Mon,  9 Mar 2020 13:47:10 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:47:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
Message-ID: <20200309204710.GU2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu8p797b.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 06:02:32PM +0100, Thomas Gleixner wrote:
> Folks,
> 
> I'm starting a new conversation because there are about 20 different
> threads which look at that problem in various ways and the information
> is so scattered that creating a coherent picture is pretty much
> impossible.
> 
> There are several problems to solve:
> 
>    1) Fragile low level entry code
> 
>    2) Breakpoint utilization
> 
>    3) RCU idle
> 
>    4) Callchain protection
> 
> #1 Fragile low level entry code
> 
>    While I understand the desire of instrumentation to observe
>    everything we really have to ask the question whether it is worth the
>    trouble especially with entry trainwrecks like x86, PTI and other
>    horrors in that area.
> 
>    I don't think so and we really should just bite the bullet and forbid
>    any instrumentation in that code unless it is explicitly designed
>    for that case, makes sense and has a real value from an observation
>    perspective.
> 
>    This is very much related to #3..
> 
> #2) Breakpoint utilization
> 
>     As recent findings have shown, breakpoint utilization needs to be
>     extremly careful about not creating infinite breakpoint recursions.
> 
>     I think that's pretty much obvious, but falls into the overall
>     question of how to protect callchains.
> 
> #3) RCU idle
> 
>     Being able to trace code inside RCU idle sections is very similar to
>     the question raised in #1.
> 
>     Assume all of the instrumentation would be doing conditional RCU
>     schemes, i.e.:
> 
>     if (rcuidle)
>     	....
>     else
>         rcu_read_lock_sched()
> 
>     before invoking the actual instrumentation functions and of course
>     undoing that right after it, that really begs the question whether
>     it's worth it.
> 
>     Especially constructs like:
> 
>     trace_hardirqs_off()
>        idx = srcu_read_lock()
>        rcu_irq_enter_irqson();
>        ...
>        rcu_irq_exit_irqson();
>        srcu_read_unlock(idx);
> 
>     if (user_mode)
>        user_exit_irqsoff();
>     else
>        rcu_irq_enter();
> 
>     are really more than questionable. For 99.9999% of instrumentation
>     users it's absolutely irrelevant whether this traces the interrupt
>     disabled time of user_exit_irqsoff() or rcu_irq_enter() or not.
> 
>     But what's relevant is the tracer overhead which is e.g. inflicted
>     with todays trace_hardirqs_off/on() implementation because that
>     unconditionally uses the rcuidle variant with the scru/rcu_irq dance
>     around every tracepoint.
> 
>     Even if the tracepoint sits in the ASM code it just covers about ~20
>     low level ASM instructions more. The tracer invocation, which is
>     even done twice when coming from user space on x86 (the second call
>     is optimized in the tracer C-code), costs definitely way more
>     cycles. When you take the scru/rcu_irq dance into account it's a
>     complete disaster performance wise.

Suppose that we had a variant of RCU that had about the same read-side
overhead as Preempt-RCU, but which could be used from idle as well as
from CPUs in the process of coming online or going offline?  I have not
thought through the irq/NMI/exception entry/exit cases, but I don't see
why that would be problem.

This would have explicit critical-section entry/exit code, so it would
not be any help for trampolines.

Would such a variant of RCU help?

Yeah, I know.  Just what the kernel doesn't need, yet another variant
of RCU...

							Thanx, Paul

> #4 Protecting call chains
> 
>    Our current approach of annotating functions with notrace/noprobe is
>    pretty much broken.
> 
>    Functions which are marked NOPROBE or notrace call out into functions
>    which are not marked and while this might be ok, there are enough
>    places where it is not. But we have no way to verify that.
> 
>    That's just a recipe for disaster. We really cannot request from
>    sysadmins who want to use instrumentation to stare at the code first
>    whether they can place/enable an instrumentation point somewhere.
>    That'd be just a bad joke.
> 
>    I really think we need to have proper text sections which are off
>    limit for any form of instrumentation and have tooling to analyze the
>    calls into other sections. These calls need to be annotated as safe
>    and intentional.
> 
> Thoughts?
> 
> Thanks,
> 
>         tglx
> 
> 
> 
> 
> 
> 
>    
> 
