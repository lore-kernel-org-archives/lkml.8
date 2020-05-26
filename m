Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99D020787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590507255;
	bh=wZsFbXQuM7MjfrRU576qrM/dfqXW3YX4P29Td4olhQc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ppy//uI0/AfSiQxckB4xZEJXgCkm8ortdY+QU5aypVJ2ca/S3l5RG0Mu+hV4sJsXo
	 +NHFSS2bIcHvpEjcFdJBy0Q09PO828L6b6zxn3vkLfhik8fMjwbZghYIV6nZAGeucF
	 ilx2jHIGUzfrM4dHjyVrdl+rdwbueSLCqVNG2+ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgEZPeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgEZPeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:34:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F7F20663;
        Tue, 26 May 2020 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590507253;
        bh=wZsFbXQuM7MjfrRU576qrM/dfqXW3YX4P29Td4olhQc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YwB5C5xSJAIQS54Syy4KeUn3r6iDmj67x7HBwi9GZu03JQfqUACdY9hw9bWDIEN5v
         +mJY253DZf2Z/KOYtugdIzPnPTeYg6r60886uyEpWQ0KO5LdekxOVIUcLQuDZtg5IZ
         6JF4RdXllT47CN/Ud9rp3VTWB9XeikPerKw8y3W8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ABC313522A8B; Tue, 26 May 2020 08:34:13 -0700 (PDT)
Date:   Tue, 26 May 2020 08:34:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200526153413.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200521200513.656533920@linutronix.de>
 <20200521202116.996113173@linutronix.de>
 <20200521210339.GC2869@paulmck-ThinkPad-P72>
 <20200526081456.GA35238@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526081456.GA35238@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:14:56AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > +	if (!tick_nohz_full_cpu(rdp->cpu) ||
> > > +	    !READ_ONCE(rdp->rcu_urgent_qs) ||
> > > +	    READ_ONCE(rdp->rcu_forced_tick)) {
> > > +		// RCU doesn't need nohz_full help from this CPU, or it is
> > > +		// already getting that help.
> > > +		return;
> > > +	}
> > > +
> > > +	// We get here only when not in an extended quiescent state and
> > > +	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
> > > +	// already watching and (2) The fact that we are in an interrupt
> > > +	// handler and that the rcu_node lock is an irq-disabled lock
> > > +	// prevents self-deadlock.  So we can safely recheck under the lock.
> > > +	// Note that the nohz_full state currently cannot change.
> > > +	raw_spin_lock_rcu_node(rdp->mynode);
> > > +	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > +		// A nohz_full CPU is in the kernel and RCU needs a
> > > +		// quiescent state.  Turn on the tick!
> > > +		WRITE_ONCE(rdp->rcu_forced_tick, true);
> > > +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > > +	}
> > > +	raw_spin_unlock_rcu_node(rdp->mynode);
> 
> BTW., can we please not ever use this weird comment style in the future?
> 
> Linus gave an exception to single-line C++ style comments - but I 
> don't think that should be extrapolated to a license to uglify the 
> kernel with inconsistent muck like this. :-/
> 
> I've sanitized it via the patch below.

The "//" comment style does save vertical space.  Is it really ugly
or just unfamiliar?  For purposes of comparison, back in the day, the
"/* */" style seemed quite strange compared to my earlier languages'
commenting styles.

> ( I also fixed the whitespace damage and a capitalization typo while 
>   at it, and fixed the spelling in the big comment explaining 
>   __rcu_irq_enter_check_tick(). )

Some were stylistic rather than wrong, but I have no objection to
any of these changes.

							Thanx, Paul

> Thanks,
> 
> 	Ingo
> 
> --- tip.orig/kernel/rcu/tree.c
> +++ tip/kernel/rcu/tree.c
> @@ -850,14 +850,14 @@ void noinstr rcu_user_exit(void)
>  }
>  
>  /**
> - * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
> + * __rcu_irq_enter_check_tick - Enable the scheduler tick on a CPU if RCU needs it.
>   *
>   * The scheduler tick is not normally enabled when CPUs enter the kernel
>   * from nohz_full userspace execution.  After all, nohz_full userspace
>   * execution is an RCU quiescent state and the time executing in the kernel
> - * is quite short.  Except of course when it isn't.  And it is not hard to
> + * is quite short.  Except of course when it isn't: it is not hard to
>   * cause a large system to spend tens of seconds or even minutes looping
> - * in the kernel, which can cause a number of problems, include RCU CPU
> + * in the kernel, which can cause a number of problems, including RCU CPU
>   * stall warnings.
>   *
>   * Therefore, if a nohz_full CPU fails to report a quiescent state
> @@ -879,7 +879,7 @@ void __rcu_irq_enter_check_tick(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	 // Enabling the tick is unsafe in NMI handlers.
> +	/* Enabling the tick is unsafe in NMI handlers. */
>  	if (WARN_ON_ONCE(in_nmi()))
>  		return;
>  
> @@ -889,21 +889,27 @@ void __rcu_irq_enter_check_tick(void)
>  	if (!tick_nohz_full_cpu(rdp->cpu) ||
>  	    !READ_ONCE(rdp->rcu_urgent_qs) ||
>  	    READ_ONCE(rdp->rcu_forced_tick)) {
> -		// RCU doesn't need nohz_full help from this CPU, or it is
> -		// already getting that help.
> +		/*
> +		 * RCU doesn't need nohz_full help from this CPU, or it is
> +		 * already getting that help.
> +		 */
>  		return;
>  	}
>  
> -	// We get here only when not in an extended quiescent state and
> -	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
> -	// already watching and (2) The fact that we are in an interrupt
> -	// handler and that the rcu_node lock is an irq-disabled lock
> -	// prevents self-deadlock.  So we can safely recheck under the lock.
> -	// Note that the nohz_full state currently cannot change.
> +	/*
> +	 * We get here only when not in an extended quiescent state and
> +	 * from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
> +	 * already watching and (2) the fact that we are in an interrupt
> +	 * handler and that the rcu_node lock is an irq-disabled lock
> +	 * prevents self-deadlock.  So we can safely recheck under the lock.
> +	 * Note that the nohz_full state currently cannot change.
> +	 */
>  	raw_spin_lock_rcu_node(rdp->mynode);
>  	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> -		// A nohz_full CPU is in the kernel and RCU needs a
> -		// quiescent state.  Turn on the tick!
> +		/*
> +		 * A nohz_full CPU is in the kernel and RCU needs a
> +		 * quiescent state.  Turn on the tick!
> +		 */
>  		WRITE_ONCE(rdp->rcu_forced_tick, true);
>  		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>  	}
