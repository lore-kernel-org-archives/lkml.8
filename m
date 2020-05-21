Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8D2207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590095021;
	bh=4LNfQkxWy5yVPPyMWOZ3E8Oy+UhotFZEryHO0JMs03s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=NFnScHYKz4Ama475UCaEosGOCjpKatGb/VoXru7H7NyBiV7G/VNLl1bLA9kVJpgdW
	 O0rHFX7Iyua8W+5y6sxpmpfaG4e8+6JOAYoX+Z3YO42eBL2UTGV7Et+FflxSaUmdlK
	 9tBgVUsjpZT+nsb45Ee3KC1enzjSQ18bi0UWM11g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgEUVDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:03:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B412078B;
        Thu, 21 May 2020 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590095019;
        bh=4LNfQkxWy5yVPPyMWOZ3E8Oy+UhotFZEryHO0JMs03s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fhUqlb0E190OI4j8xFV+ZjXyoRyc8FXFlMumjEU73DJNVhcQlbdHhlAySh9wgEE8+
         NFUlMYdylSOd8sn09MX9sHUskfq6Wx9OKp4W0BX/gN0uYaNPjvvlWPNRZQQNGqDhzM
         kNHU1zsVTTHlnR8In99ARAoFXoh/SK/T1JDx+1w4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 677183522FEB; Thu, 21 May 2020 14:03:39 -0700 (PDT)
Date:   Thu, 21 May 2020 14:03:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 02/39] rcu: Abstract out rcu_irq_enter_check_tick()
 from rcu_nmi_enter()
Message-ID: <20200521210339.GC2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200521200513.656533920@linutronix.de>
 <20200521202116.996113173@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202116.996113173@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:05:15PM +0200, Thomas Gleixner wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> There will likely be exception handlers that can sleep, which rules
> out the usual approach of invoking rcu_nmi_enter() on entry and also
> rcu_nmi_exit() on all exit paths.  However, the alternative approach of
> just not calling anything can prevent RCU from coaxing quiescent states
> from nohz_full CPUs that are looping in the kernel:  RCU must instead
> IPI them explicitly.  It would be better to enable the scheduler tick
> on such CPUs to interact with RCU in a lighter-weight manner, and this
> enabling is one of the things that rcu_nmi_enter() currently does.
> 
> What is needed is something that helps RCU coax quiescent states while
> not preventing subsequent sleeps.  This commit therefore splits out the
> nohz_full scheduler-tick enabling from the rest of the rcu_nmi_enter()
> logic into a new function named rcu_irq_enter_check_tick().
> 
> [ tglx: Renamed the function and made it a nop when context tracking is off ]

The new name works for me!  A couple of nits called out below.

							Thanx, Paul

> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V9: New patch
> ---
>  include/linux/hardirq.h |    9 +++++
>  kernel/rcu/tree.c       |   82 ++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 71 insertions(+), 20 deletions(-)
> 
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -2,6 +2,7 @@
>  #ifndef LINUX_HARDIRQ_H
>  #define LINUX_HARDIRQ_H
>  
> +#include <linux/context_tracking_state.h>
>  #include <linux/preempt.h>
>  #include <linux/lockdep.h>
>  #include <linux/ftrace_irq.h>
> @@ -27,6 +28,14 @@ extern void rcu_nmi_enter(void);
>  extern void rcu_nmi_exit(void);
>  #endif
>  
> +void __rcu_irq_enter_check_tick(void);
> +
> +static __always_inline void rcu_irq_enter_check_tick(void)
> +{
> +	if (context_tracking_enabled())
> +		__rcu_irq_enter_check_tick();

I suggest moving the WARN_ON_ONCE(in_nmi()) check here to avoid calling
in_nmi() twice.  Because of the READ_ONCE(), the compiler cannot (had
better not!) eliminate the double call.

> +}
> +
>  /*
>   * It is safe to do non-atomic ops on ->hardirq_context,
>   * because NMI handlers may not preempt and the ops are
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -848,6 +848,67 @@ void noinstr rcu_user_exit(void)
>  {
>  	rcu_eqs_exit(1);
>  }
> +
> +/**
> + * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
> + *
> + * The scheduler tick is not normally enabled when CPUs enter the kernel
> + * from nohz_full userspace execution.  After all, nohz_full userspace
> + * execution is an RCU quiescent state and the time executing in the kernel
> + * is quite short.  Except of course when it isn't.  And it is not hard to
> + * cause a large system to spend tens of seconds or even minutes looping
> + * in the kernel, which can cause a number of problems, include RCU CPU
> + * stall warnings.
> + *
> + * Therefore, if a nohz_full CPU fails to report a quiescent state
> + * in a timely manner, the RCU grace-period kthread sets that CPU's
> + * ->rcu_urgent_qs flag with the expectation that the next interrupt or
> + * exception will invoke this function, which will turn on the scheduler
> + * tick, which will enable RCU to detect that CPU's quiescent states,
> + * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
> + * The tick will be disabled once a quiescent state is reported for
> + * this CPU.
> + *
> + * Of course, in carefully tuned systems, there might never be an
> + * interrupt or exception.  In that case, the RCU grace-period kthread
> + * will eventually cause one to happen.  However, in less carefully
> + * controlled environments, this function allows RCU to get what it
> + * needs without creating otherwise useless interruptions.
> + */
> +void __rcu_irq_enter_check_tick(void)
> +{
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +
> +	 // Enabling the tick is unsafe in NMI handlers.

There is an extra space before the "//", probably the one that used to
be after the ";" below.  ;-)

> +	if (WARN_ON_ONCE(in_nmi()))
> +		return;
> +
> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> +			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");

The instrumentation_begin() has disappeared, presumably because
instrumentation is already enabled in the non-RCU code that directly calls
rcu_irq_enter_check_tick().  (I do see the calls in rcu_nmi_enter() below.)

> +
> +	if (!tick_nohz_full_cpu(rdp->cpu) ||
> +	    !READ_ONCE(rdp->rcu_urgent_qs) ||
> +	    READ_ONCE(rdp->rcu_forced_tick)) {
> +		// RCU doesn't need nohz_full help from this CPU, or it is
> +		// already getting that help.
> +		return;
> +	}
> +
> +	// We get here only when not in an extended quiescent state and
> +	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
> +	// already watching and (2) The fact that we are in an interrupt
> +	// handler and that the rcu_node lock is an irq-disabled lock
> +	// prevents self-deadlock.  So we can safely recheck under the lock.
> +	// Note that the nohz_full state currently cannot change.
> +	raw_spin_lock_rcu_node(rdp->mynode);
> +	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +		// A nohz_full CPU is in the kernel and RCU needs a
> +		// quiescent state.  Turn on the tick!
> +		WRITE_ONCE(rdp->rcu_forced_tick, true);
> +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> +	}
> +	raw_spin_unlock_rcu_node(rdp->mynode);
> +}
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> @@ -894,26 +955,7 @@ noinstr void rcu_nmi_enter(void)
>  		incby = 1;
>  	} else if (!in_nmi()) {

This can just be "else" given the in_nmi() check in
__rcu_irq_enter_check_tick(), right?  Ah, that check got a
WARN_ON_ONCE(), so never mind!

I guess that will discourage NMI-handler calls to
rcu_irq_enter_check_tick().  ;-)

It does mean a double call to in_nmi(), though, so should that
WARN_ON_ONCE(in_nmi()) check go into the rcu_irq_enter_check_tick()
wrapper?  Or do modern compilers figure this one out?  Given the
READ_ONCE() in preempt_count(), I have to say that I hope not.
So see my comment above on rcu_irq_enter_check_tick().

>  		instrumentation_begin();
> -		if (tick_nohz_full_cpu(rdp->cpu) &&
> -		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> -		    READ_ONCE(rdp->rcu_urgent_qs) &&
> -		    !READ_ONCE(rdp->rcu_forced_tick)) {
> -			// We get here only if we had already exited the
> -			// extended quiescent state and this was an
> -			// interrupt (not an NMI).  Therefore, (1) RCU is
> -			// already watching and (2) The fact that we are in
> -			// an interrupt handler and that the rcu_node lock
> -			// is an irq-disabled lock prevents self-deadlock.
> -			// So we can safely recheck under the lock.
> -			raw_spin_lock_rcu_node(rdp->mynode);
> -			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> -				// A nohz_full CPU is in the kernel and RCU
> -				// needs a quiescent state.  Turn on the tick!
> -				WRITE_ONCE(rdp->rcu_forced_tick, true);
> -				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> -			}
> -			raw_spin_unlock_rcu_node(rdp->mynode);
> -		}
> +		rcu_irq_enter_check_tick();
>  		instrumentation_end();
>  	}
>  	instrumentation_begin();
> 
