Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A792075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oNZZYMZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgESTsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:48:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E81C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:48:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 142so968160qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40NWANgzUC9sGVXNwplW4AYRC9383MiLAyHs+6kDGyk=;
        b=oNZZYMZSln58Iz3M6Q0iaT923ZlU9XQ156KYUg0KxAADlqWMEUQgkRezuP9b05fMRR
         lmmjkxcQ5s1lt5bX1gefXRLhwFtZPrtxX5Fyk4AhlC1wAqPg7uPAt1rF5l3O2gXs0S9U
         1ASkHdiYH3CsUeDTlG9XfFGFYBFcBwk31B/3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40NWANgzUC9sGVXNwplW4AYRC9383MiLAyHs+6kDGyk=;
        b=Iqaz08CA7L18WEGOpkdY8PyXq5I56zgY/A9ZB5HViQ8vNQrb/W3TJDprAMFHynPYYO
         hxpv5aGCg9FT9Gi2OHztGtr4kPakLMeVPvoRlPy2+NC8YVJP+CiG4VrKkhKDbPlNBeXM
         5a8ibd0wCHKXtxQSU62ZHIkcQTkm2ki6Sr7ZwSVK6KEAAS5WkptcIRAEJ3EKb2HNdEGW
         pyyw34L43bWhDSJPx0lYN7M8hJUAHN3djAJCW6tH0QqfuIk+MoNMChKQ19XIq65mCQvG
         P/Mqj/ubmQFWS6J+3jcvQ0LUVkj9TI7CWa39DUXjjwJIML6e0XCdAyZUFu6qRhZj+ZTx
         zY2A==
X-Gm-Message-State: AOAM531an0zKQqO9ToIjDxwuVY1n4ORvZ7Tki+tmxXeDGrO4NlnwGQ51
        VhYmM8LLANM+XuSPiStQ0Yyjcg==
X-Google-Smtp-Source: ABdhPJywvv51IPEOCrMaFohjqx0bo6CaASeR9NRN3kDJCI+Ex/rjR94J7JNdMMCV7BaIVtH6F/dbDg==
X-Received: by 2002:a05:620a:2190:: with SMTP id g16mr1043893qka.323.1589917688841;
        Tue, 19 May 2020 12:48:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g19sm455971qke.32.2020.05.19.12.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:48:08 -0700 (PDT)
Date:   Tue, 19 May 2020 15:48:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>, vineethrp@gmail.com
Subject: Re: [patch V4 part 1 25/36] rcu/tree: Mark the idle relevant
 functions noinstr
Message-ID: <20200519194807.GA17484@google.com>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.575356107@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134100.575356107@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, May 05, 2020 at 03:16:27PM +0200, Thomas Gleixner wrote:
> These functions are invoked from context tracking and other places in the
> low level entry code. Move them into the .noinstr.text section to exclude
> them from instrumentation.
> 
> Mark the places which are safe to invoke traceable functions with
> instr_begin/end() so objtool won't complain.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/rcu/tree.c        |   85 +++++++++++++++++++++++++----------------------
>  kernel/rcu/tree_plugin.h |    4 +-
>  kernel/rcu/update.c      |    7 +--
>  3 files changed, 52 insertions(+), 44 deletions(-)
[...]

Just a few nits/questions but otherwise LGTM.

> @@ -299,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -566,7 +561,7 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data
>   * the possibility of usermode upcalls having messed up our count
>   * of interrupt nesting level during the prior busy period.
>   */
> -static void rcu_eqs_enter(bool user)
> +static noinstr void rcu_eqs_enter(bool user)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -581,12 +576,14 @@ static void rcu_eqs_enter(bool user)
>  	}
>  
>  	lockdep_assert_irqs_disabled();
> +	instr_begin();
>  	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rdp = this_cpu_ptr(&rcu_data);
>  	do_nocb_deferred_wakeup(rdp);
>  	rcu_prepare_for_idle();
>  	rcu_preempt_deferred_qs(current);
> +	instr_end();
>  	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
>  	// RCU is watching here ...
>  	rcu_dynticks_eqs_enter();
> @@ -623,7 +620,7 @@ void rcu_idle_enter(void)
>   * If you add or remove a call to rcu_user_enter(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_user_enter(void)
> +noinstr void rcu_user_enter(void)
>  {
>  	lockdep_assert_irqs_disabled();
>  	rcu_eqs_enter(true);
> @@ -656,19 +653,23 @@ static __always_inline void rcu_nmi_exit
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (rdp->dynticks_nmi_nesting != 1) {
> +		instr_begin();
>  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
>  				  atomic_read(&rdp->dynticks));
>  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
>  			   rdp->dynticks_nmi_nesting - 2);
> +		instr_end();

Can instr_end() be moved before the WRITE_ONCE() ?

> @@ -737,7 +738,7 @@ void rcu_irq_exit_irqson(void)
>   * allow for the possibility of usermode upcalls messing up our count of
>   * interrupt nesting level during the busy period that is just now starting.
>   */
> -static void rcu_eqs_exit(bool user)
> +static void noinstr rcu_eqs_exit(bool user)
>  {
>  	struct rcu_data *rdp;
>  	long oldval;
> @@ -755,12 +756,14 @@ static void rcu_eqs_exit(bool user)
>  	// RCU is not watching here ...
>  	rcu_dynticks_eqs_exit();
>  	// ... but is watching here.
> +	instr_begin();
>  	rcu_cleanup_after_idle();
>  	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(rdp->dynticks_nesting, 1);
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> +	instr_end();

And here I think instr_end() can be moved after the trace_rcu_dyntick() call?

>  }
>  
>  /**
> @@ -791,7 +794,7 @@ void rcu_idle_exit(void)
>   * If you add or remove a call to rcu_user_exit(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_user_exit(void)
> +void noinstr rcu_user_exit(void)
>  {
>  	rcu_eqs_exit(1);
>  }
> @@ -839,28 +842,35 @@ static __always_inline void rcu_nmi_ente
>  			rcu_cleanup_after_idle();
>  
>  		incby = 1;
> -	} else if (irq && tick_nohz_full_cpu(rdp->cpu) &&
> -		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> -		   READ_ONCE(rdp->rcu_urgent_qs) &&
> -		   !READ_ONCE(rdp->rcu_forced_tick)) {
> -		// We get here only if we had already exited the extended
> -		// quiescent state and this was an interrupt (not an NMI).
> -		// Therefore, (1) RCU is already watching and (2) The fact
> -		// that we are in an interrupt handler and that the rcu_node
> -		// lock is an irq-disabled lock prevents self-deadlock.
> -		// So we can safely recheck under the lock.
> -		raw_spin_lock_rcu_node(rdp->mynode);
> -		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> -			// A nohz_full CPU is in the kernel and RCU
> -			// needs a quiescent state.  Turn on the tick!
> -			WRITE_ONCE(rdp->rcu_forced_tick, true);
> -			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> +	} else if (irq) {
> +		instr_begin();
> +		if (tick_nohz_full_cpu(rdp->cpu) &&

Not a huge fan of the extra indentation but don't see a better way :)

> +		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
> +		    READ_ONCE(rdp->rcu_urgent_qs) &&
> +		    !READ_ONCE(rdp->rcu_forced_tick)) {
> +			// We get here only if we had already exited the
> +			// extended quiescent state and this was an
> +			// interrupt (not an NMI).  Therefore, (1) RCU is
> +			// already watching and (2) The fact that we are in
> +			// an interrupt handler and that the rcu_node lock
> +			// is an irq-disabled lock prevents self-deadlock.
> +			// So we can safely recheck under the lock.
> +			raw_spin_lock_rcu_node(rdp->mynode);
> +			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> +				// A nohz_full CPU is in the kernel and RCU
> +				// needs a quiescent state.  Turn on the tick!
> +				WRITE_ONCE(rdp->rcu_forced_tick, true);
> +				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> +			}
> +			raw_spin_unlock_rcu_node(rdp->mynode);
>  		}
> -		raw_spin_unlock_rcu_node(rdp->mynode);
> +		instr_end();
>  	}
> +	instr_begin();
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  rdp->dynticks_nmi_nesting,
>  			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
> +	instr_end();
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
>  		   rdp->dynticks_nmi_nesting + incby);
>  	barrier();
> @@ -869,11 +879,10 @@ static __always_inline void rcu_nmi_ente
>  /**
>   * rcu_nmi_enter - inform RCU of entry to NMI context
>   */
> -void rcu_nmi_enter(void)
> +noinstr void rcu_nmi_enter(void)
>  {
>  	rcu_nmi_enter_common(false);
>  }
> -NOKPROBE_SYMBOL(rcu_nmi_enter);
>  
>  /**
>   * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
> @@ -897,7 +906,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
>   * If you add or remove a call to rcu_irq_enter(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_enter(void)
> +noinstr void rcu_irq_enter(void)

Just checking if rcu_irq_enter_irqson() needs noinstr too?

Would the noinstr checking be enforced by the kernel build as well or is the
developer required to run it themselves?

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  {
>  	lockdep_assert_irqs_disabled();
>  	rcu_nmi_enter_common(true);
> @@ -942,7 +951,7 @@ static void rcu_disable_urgency_upon_qs(
>   * if the current CPU is not in its idle loop or is in an interrupt or
>   * NMI handler, return true.
>   */
> -bool notrace rcu_is_watching(void)
> +noinstr bool rcu_is_watching(void)
>  {
>  	bool ret;
>  
> @@ -986,7 +995,7 @@ void rcu_request_urgent_qs_task(struct t
>   * RCU on an offline processor during initial boot, hence the check for
>   * rcu_scheduler_fully_active.
>   */
> -bool rcu_lockdep_current_cpu_online(void)
> +noinstr bool rcu_lockdep_current_cpu_online(void)
>  {
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
> @@ -994,12 +1003,12 @@ bool rcu_lockdep_current_cpu_online(void
>  
>  	if (in_nmi() || !rcu_scheduler_fully_active)
>  		return true;
> -	preempt_disable();
> +	preempt_disable_notrace();
>  	rdp = this_cpu_ptr(&rcu_data);
>  	rnp = rdp->mynode;
>  	if (rdp->grpmask & rcu_rnp_online_cpus(rnp))
>  		ret = true;
> -	preempt_enable();
> +	preempt_enable_notrace();
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2553,7 +2553,7 @@ static void rcu_bind_gp_kthread(void)
>  }
>  
>  /* Record the current task on dyntick-idle entry. */
> -static void rcu_dynticks_task_enter(void)
> +static void noinstr rcu_dynticks_task_enter(void)
>  {
>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>  	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
> @@ -2561,7 +2561,7 @@ static void rcu_dynticks_task_enter(void
>  }
>  
>  /* Record no current task on dyntick-idle exit. */
> -static void rcu_dynticks_task_exit(void)
> +static void noinstr rcu_dynticks_task_exit(void)
>  {
>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -95,7 +95,7 @@ module_param(rcu_normal_after_boot, int,
>   * Similarly, we avoid claiming an RCU read lock held if the current
>   * CPU is offline.
>   */
> -static bool rcu_read_lock_held_common(bool *ret)
> +static noinstr bool rcu_read_lock_held_common(bool *ret)
>  {
>  	if (!debug_lockdep_rcu_enabled()) {
>  		*ret = 1;
> @@ -112,7 +112,7 @@ static bool rcu_read_lock_held_common(bo
>  	return false;
>  }
>  
> -int rcu_read_lock_sched_held(void)
> +noinstr int rcu_read_lock_sched_held(void)
>  {
>  	bool ret;
>  
> @@ -270,13 +270,12 @@ struct lockdep_map rcu_callback_map =
>  	STATIC_LOCKDEP_MAP_INIT("rcu_callback", &rcu_callback_key);
>  EXPORT_SYMBOL_GPL(rcu_callback_map);
>  
> -int notrace debug_lockdep_rcu_enabled(void)
> +noinstr int notrace debug_lockdep_rcu_enabled(void)
>  {
>  	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
>  	       current->lockdep_recursion == 0;
>  }
>  EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
> -NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
>  
>  /**
>   * rcu_read_lock_held() - might we be in RCU read-side critical section?
> 
