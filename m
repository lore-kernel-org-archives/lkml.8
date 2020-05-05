Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFF7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BD42075A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588716147;
	bh=jqBGVHODT2ZorzgQ2/+DwPIqnnfhekndrsHXricHH9I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xZgbD1n/zzK3xhPkHG3mPzTQywIqUpmLJKGWlnmLwIoGstItfyFT4D7/uAC0dwwwH
	 SLQEN2Krf+1C6ZPWQHnuO32ZX/8FvpSxBSpXHcuhfSsrgWHTZsu/r18iLk9Ltn6vYU
	 LzUfaUe5fnCF5ON8eNolLzFwa111Mmk04RUlTLLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEWC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgEEWCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:02:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D47C206B8;
        Tue,  5 May 2020 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588716145;
        bh=jqBGVHODT2ZorzgQ2/+DwPIqnnfhekndrsHXricHH9I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aOlZTH/98A1zwce46k+/fi1I4wNQxzGSYOhtSyYx1Jn1p/waNXqZ1ZIe7+xkMMT6t
         NQEF/EKpJHDMpphEhy1gWAslQEKmVQOCLJX67D971XmXA1AM+dcOqU0xVe9CKoVioT
         dAPV3UcaQpoOEimGY6Tbd7vtyPYa+65B8UIkuZhk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DC1243523039; Tue,  5 May 2020 15:02:24 -0700 (PDT)
Date:   Tue, 5 May 2020 15:02:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
Message-ID: <20200505220224.GT2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505134354.774943181@linutronix.de>
 <20200505134904.364456424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134904.364456424@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:
> Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
> invoke rcu_irq_exit() before they either return to the interrupted code or
> invoke the scheduler due to preemption.
> 
> The general assumption is that RCU idle code has to have preemption
> disabled so that a return from interrupt cannot schedule. So the return
> from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().
> 
> If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
> had preemption enabled then this goes unnoticed until the CPU goes idle or
> some other RCU check is executed.
> 
> Provide rcu_irq_exit_preempt() which can be invoked from the
> interrupt/exception return code in case that preemption is enabled. It
> invokes rcu_irq_exit() and contains a few sanity checks in case that
> CONFIG_PROVE_RCU is enabled to catch such issues directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>

The ->dynticks_nmi_nesting field is going away at some point, but
there is always "git merge".  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcutiny.h |    1 +
>  include/linux/rcutree.h |    1 +
>  kernel/rcu/tree.c       |   21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -71,6 +71,7 @@ static inline void rcu_irq_enter(void) {
>  static inline void rcu_irq_exit_irqson(void) { }
>  static inline void rcu_irq_enter_irqson(void) { }
>  static inline void rcu_irq_exit(void) { }
> +static inline void rcu_irq_exit_preempt(void) { }
>  static inline void exit_rcu(void) { }
>  static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -46,6 +46,7 @@ void rcu_idle_enter(void);
>  void rcu_idle_exit(void);
>  void rcu_irq_enter(void);
>  void rcu_irq_exit(void);
> +void rcu_irq_exit_preempt(void);
>  void rcu_irq_enter_irqson(void);
>  void rcu_irq_exit_irqson(void);
>  
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -706,6 +706,27 @@ void noinstr rcu_irq_exit(void)
>  	rcu_nmi_exit();
>  }
>  
> +/**
> + * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
> + *			  towards in kernel preemption
> + *
> + * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
> + * from RCU point of view. Invoked from return from interrupt before kernel
> + * preemption.
> + */
> +void rcu_irq_exit_preempt(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +	rcu_nmi_exit();
> +
> +	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
> +			 "RCU dynticks_nesting counter underflow/zero!");
> +	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> +			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> +			 "RCU in extended quiescent state!");
> +}
> +
>  /*
>   * Wrapper for rcu_irq_exit() where interrupts are enabled.
>   *
> 
