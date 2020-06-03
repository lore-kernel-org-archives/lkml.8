Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADB82074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591178375;
	bh=IzFcQybnWhy0o7ePqiwAbjE20V7uSYo4yk8k+ca5LWk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Tk+OWAizMna2ZtTjwYURz8Y0fGapfL0YqV+fN2tEdOOeQac4zjLKDlILlUiwY90Tl
	 XDp7MlXm4crOi7rvGR0Yp0IqKs4Ex96wH6t4HpraSIGgGMXO8l2SmSOlSrTe3g6kaj
	 C3u48DDYZTGIuTEPDc/JupFb11pRF5DikKQBZSGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFCJ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgFCJ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:59:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B958720734;
        Wed,  3 Jun 2020 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591178372;
        bh=IzFcQybnWhy0o7ePqiwAbjE20V7uSYo4yk8k+ca5LWk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CQ3ENkUih/3yjm1HsvrgHxRFdP0J+pqYjVui3V8pACDoR3+bOLRkFFB5AqJuFcVux
         fiusxdVBIYjeKlCCoJ/CIuX77dIcjSX8+uZW+9JhosSKeq1L2IhtxPZj+K7+BvMivd
         nrOmok80cpMvuVjrbdQoaIErxOFS1Ve3xI06Tcq4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9D36D352281E; Wed,  3 Jun 2020 02:59:32 -0700 (PDT)
Date:   Wed, 3 Jun 2020 02:59:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fixup noinstr warnings
Message-ID: <20200603095932.GM29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200602184409.22142-1-elver@google.com>
 <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net>
 <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
 <20200602193853.GF2604@hirez.programming.kicks-ass.net>
 <20200603084818.GB2627@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603084818.GB2627@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:48:18AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 02, 2020 at 09:38:53PM +0200, Peter Zijlstra wrote:
> 
> > That said; noinstr's __no_sanitize combined with atomic_t might be
> > 'interesting', because the regular atomic things have explicit
> > annotations in them. That should give validation warnings for the right
> > .config, I'll have to go try -- so far I've made sure to never enable
> > the *SAN stuff.
> 
> ---
> Subject: rcu: Fixup noinstr warnings
> 
> A KCSAN build revealed we have explicit annoations through atomic_t
> usage, switch to arch_atomic_*() for the respective functions.
> 
> vmlinux.o: warning: objtool: rcu_nmi_exit()+0x4d: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0x4f: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2a: call to __kcsan_check_access() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __rcu_is_watching()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This one does not apply cleanly onto the -rcu tree's "dev" branch, so
I am guessing that it is intended to be carried in -tip with yours and
Thomas's patch series.

If you do instead want this in -rcu, please let me know.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c716eadc7617..162656b80db9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -250,7 +250,7 @@ static noinstr void rcu_dynticks_eqs_enter(void)
>  	 * next idle sojourn.
>  	 */
>  	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>  	// RCU is no longer watching.  Better be in extended quiescent state!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     (seq & RCU_DYNTICK_CTRL_CTR));
> @@ -274,13 +274,13 @@ static noinstr void rcu_dynticks_eqs_exit(void)
>  	 * and we also must force ordering with the next RCU read-side
>  	 * critical section.
>  	 */
> -	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> +	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
>  	// RCU is now watching.  Better not be in an extended quiescent state!
>  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     !(seq & RCU_DYNTICK_CTRL_CTR));
>  	if (seq & RCU_DYNTICK_CTRL_MASK) {
> -		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> +		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
>  		smp_mb__after_atomic(); /* _exit after clearing mask. */
>  	}
>  }
> @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
>  }
>  
>  /*
> @@ -692,6 +692,7 @@ noinstr void rcu_nmi_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> +	instrumentation_begin();
>  	/*
>  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
>  	 * (We are exiting an NMI handler, so RCU better be paying attention
> @@ -705,7 +706,6 @@ noinstr void rcu_nmi_exit(void)
>  	 * leave it in non-RCU-idle state.
>  	 */
>  	if (rdp->dynticks_nmi_nesting != 1) {
> -		instrumentation_begin();
>  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
>  				  atomic_read(&rdp->dynticks));
>  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> @@ -714,7 +714,6 @@ noinstr void rcu_nmi_exit(void)
>  		return;
>  	}
>  
> -	instrumentation_begin();
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
>  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
