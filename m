Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B45C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DC6207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tF/iESut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgENClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgENClT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:41:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:41:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t8so1004210qvw.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLNMURY1HIlbAzrkLrAtdhSWRbezGbA/8tIoq51rm1I=;
        b=tF/iESutHw2ygT+gJ6RIvMj0G7kzpPqwx14VsBrRv6A2AO486D5Pp7V/n/k2FON4LR
         CI/6zVQfrJhr/CWJ4z7ImG+0VjgJ1Mi7p8A9ydvaxzSqFx/1bFU18XstWvd0Ezh8UHuw
         Zije9465zXym8aIpIcrXxj23B79yZEW9FbZVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLNMURY1HIlbAzrkLrAtdhSWRbezGbA/8tIoq51rm1I=;
        b=fPp910+jlOokNvi51cTGwy1LbM2oM9hBxj+Dr0HnRM2Mf807MX9K5DE6GnyGIwiofD
         7YZYYT5HhUY0cwNzHCyZ+Lm+MsiPj/ZEEQQsdUfHQ2bZEPKd6SJ3i6ly49WvSUALRSOF
         K063JJkug1iX2+G76zDxXybXDp2STDYCvxT0btSfXtkEz1u+qkkmJC+Ggf3l6KlIPnUY
         3zVmClNw29S7LxQZzyFy5u1HlKpunTgiGZSKOX/bQHGKhg4owY9shwAU608Y3vhmS8Ud
         TzAbsIsG1UwZNhrGcR5E3c35t/C9DOIqVikIgWMlwgzQhtyO6onChjdljFReY4FZ5S8K
         oL7g==
X-Gm-Message-State: AOAM533u3ypHuGu/676+ikV/ikMCkPGu0kX9r+G/kd3Eux4o3a4flHiQ
        xRnN4QeAbL1yP3JNME/X5oa0QA==
X-Google-Smtp-Source: ABdhPJyAGxD54Yg+fb1o5Nxdmhm+S7+56mOursXIuv8jDwEXKiHcvWMY3PMKsHIDKle3OjMFJoSzhA==
X-Received: by 2002:ad4:53a2:: with SMTP id j2mr2685796qvv.159.1589424077931;
        Wed, 13 May 2020 19:41:17 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h22sm1104944qtn.23.2020.05.13.19.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 19:41:17 -0700 (PDT)
Date:   Wed, 13 May 2020 22:41:16 -0400
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
Message-ID: <20200514024116.GA231286@google.com>
References: <20200505134354.774943181@linutronix.de>
 <20200505134904.364456424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134904.364456424@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:

Thank you for CC'ing me.

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

Could you let me know which patch or part in the multi-part series is using it?

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
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

Makes sense.

> +	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> +			 "RCU dynticks_nmi_nesting counter underflow/zero!");

This new function will be called only from the outer-most IRQ that
interrupted kernel mode (process context). Right? If so, a better (more
specific) check for the second RCU_LOCKDEP_WARN above is:

RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) != DYNTICK_IRQ_NONIDLE,
			 "Bad RCU dynticks_nmi_nesting counter\n");

That will make sure, it is only called from outer-most rcu_irq_exit() and
interrupting kernel mode.

Or, if [1] is merged, then we could just combine the checks into one check.
	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) != 1,
			 "Bad RCU dynticks_nmi_nesting counter\n");

> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> +			 "RCU in extended quiescent state!");

Makes sense.

BTW, I wonder if a better place to do this "don't enter scheduler while RCU
is not watching" is rcu_note_context_switch()...

thanks,

 - Joel
[1] https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu-dynticks-may4-rebased&id=b48863c234295d8ec956b50f6cf5ae0a0269f48d

> +}
> +
>  /*
>   * Wrapper for rcu_irq_exit() where interrupts are enabled.
>   *
> 
