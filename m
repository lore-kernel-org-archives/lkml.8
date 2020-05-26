Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0127320885
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590481393;
	bh=YEzEGDq8eb4XxvW/RSR2MzW4ts+L/TLeDb70yhtakDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yo7xq9L+RMzV9BK6bagA7Auq2u5R4CPr4GyEaBcM3+uE6i5b70Yg6tU+z1OxxW9Y3
	 PWbPPlo3iM9r5aTuADBNDuV3oql1DPmbFXrFjqs/+DmBn/knSLv3mTXeu15Se7xdb+
	 plsNU+gOZbYccYGWkPKHFYZo5sgfARcJQqOvdQOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgEZIXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:23:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF4C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:23:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f5so2350522wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8CUm1LFTnrJ7QRSnag0GsDVIfe8MydrGxtOgXBR5Yo=;
        b=RJxJ4f1fuCKPldmZpekP1xrAS2jdfg/+o9NozeCD7s7uf1Ukm/yy3Ngu6aDLIHK0XZ
         y8aOSoCem0Px9J7urMqIzuRLpoX5LXIivYqZbz5B/z+kji6muuRuYWoHnUxlRV5ACfMg
         3D7jj3j2MEBxKxqCT2apiZ/cASVIsHHUXsp53ECEWANoqla8iwt8Q0qXEzoJnk3ybL5/
         qUYuXdL6Ow0I2iVwTeK1YKZZA6nL6ynqZ5Wt6lG2ZgXErDItopR4oCVbdt4/E2ussFxh
         1vkl5/IgAO6Eou5T9S9l3EEgUJWXRXnLep630k3MgTwLidkxc+MIVSpj+3m0kPQ7/ZAJ
         yaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b8CUm1LFTnrJ7QRSnag0GsDVIfe8MydrGxtOgXBR5Yo=;
        b=Gf2hFFAZiqb7S1R/rje0AbCL9QI/tRVX25YA84rOoGCJgmy+g+qw7hQr2yu2VZNrKD
         /X4dxiVIf1NYGgEkXzh5/nvYT53Mj0MlhyzNcLoChFLPfEsJV8xNkOVIZKDsuGxp1ySd
         +viX0SINJqZ8CxGIbaqf+CS7+bZSvCYqhqyZpiBV/vFPqvQQ4i/SdqDDjz3pERDJjP+N
         FVPgNi5QHfcox/nnBjZ+kppb6LEYG+6B1QA/7uQXuDJlnsIP985TfRG60PoBniU8d/ZL
         d+P0311K9MTH9/lK/fdGee3uvuvFdPvTPN75RPhCZ+58Qy3aYvj2hi6fHMTIWAK7fDcI
         inng==
X-Gm-Message-State: AOAM533LOuuNsn3fQuun6RmXlaCtGci++wiqTG2/VIAagTq3GUy36WGn
        vO7RU71Z8Z0L4WPZTou9BP8=
X-Google-Smtp-Source: ABdhPJym0oRyYGoesH3HeHySi5ktRLsaYg4lcXoX4XP1MvxiZaj6fNVL7TV93E06lJsj/vT3Qt3Naw==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr276557wmi.158.1590481387052;
        Tue, 26 May 2020 01:23:07 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u13sm962733wrp.53.2020.05.26.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:23:06 -0700 (PDT)
Date:   Tue, 26 May 2020 10:23:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch V9 04/39] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200526082303.GB35238@gmail.com>
References: <20200521200513.656533920@linutronix.de>
 <20200521202117.181397835@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202117.181397835@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> After a lengthy discussion [1] it turned out that RCU does not need a full
> rcu_irq_enter/exit() when RCU is already watching. All it needs if
> NOHZ_FULL is active is to check whether the tick needs to be restarted.
> 
> This allows to avoid a separate variant for the pagefault handler which
> cannot invoke rcu_irq_enter() on a kernel pagefault which might sleep.
> 
> The cond_rcu argument is only temporary and will be removed once the
> existing users of idtentry_enter/exit() have been cleaned up. After that
> the code can be significantly simplified.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: [1] https://lkml.kernel.org/r/20200515235125.628629605@linutronix.de
> ---
> V9: Reworked to the new RCU mode
> ---
>  arch/x86/entry/common.c         |   84 ++++++++++++++++++++++++++++++----------
>  arch/x86/include/asm/idtentry.h |   14 +++++-
>  2 files changed, 77 insertions(+), 21 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -512,8 +512,10 @@ SYSCALL_DEFINE0(ni_syscall)
>  }
>  
>  /**
> - * idtentry_enter - Handle state tracking on idtentry
> + * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
> + *			     RCU handling
>   * @regs:	Pointer to pt_regs of interrupted context
> + * @cond_rcu:	Invoke rcu_irq_enter() only if RCU is not watching
>   *
>   * Invokes:
>   *  - lockdep irqflag state tracking as low level ASM entry disabled
> @@ -521,40 +523,81 @@ SYSCALL_DEFINE0(ni_syscall)
>   *
>   *  - Context tracking if the exception hit user mode.
>   *
> - *  - RCU notification if the exception hit kernel mode.
> - *
>   *  - The hardirq tracer to keep the state consistent as low level ASM
>   *    entry disabled interrupts.
> + *
> + * For kernel mode entries RCU handling is done conditional. If RCU is
> + * watching then the only RCU requirement is to check whether the tick has
> + * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
> + * invoked on entry and rcu_irq_exit() on exit.
> + *
> + * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
> + * solves the problem of kernel mode pagefaults which can schedule, which
> + * is not possible after invoking rcu_irq_enter() without undoing it.
> + *
> + * For user mode entries enter_from_user_mode() must be invoked to
> + * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
> + * would not be possible.
> + *
> + * Returns: True if RCU has been adjusted on a kernel entry
> + *	    False otherwise
> + *
> + * The return value must be fed into the rcu_exit argument of
> + * idtentry_exit_cond_rcu().
>   */
> -void noinstr idtentry_enter(struct pt_regs *regs)
> +bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu)
>  {
>  	if (user_mode(regs)) {
>  		enter_from_user_mode();
>  	} else {
> -		lockdep_hardirqs_off(CALLER_ADDR0);
> -		rcu_irq_enter();
> -		instrumentation_begin();
> -		trace_hardirqs_off_prepare();
> -		instrumentation_end();
> +		if (!cond_rcu || !__rcu_is_watching()) {
> +			/*
> +			 * If RCU is not watching then the same careful
> +			 * sequence vs. lockdep and tracing is required
> +			 * as in enter_from_user_mode().
> +			 *
> +			 * This only happens for IRQs that hits the idle
> +			 * loop, i.e. if idle is not using MWAIT.
> +			 */
> +			lockdep_hardirqs_off(CALLER_ADDR0);
> +			rcu_irq_enter();
> +			instrumentation_begin();
> +			trace_hardirqs_off_prepare();
> +			instrumentation_end();
> +			return true;
> +		} else {
> +			/*
> +			 * If RCU is watching then RCU only wants to check
> +			 * whether it needs to restart the tick in NOHZ
> +			 * mode.
> +			 */
> +			instrumentation_begin();
> +			rcu_irq_enter_check_tick();
> +			/* Use the combo lockdep/tracing function */
> +			trace_hardirqs_off();
> +			instrumentation_end();
> +		}
>  	}
> +	return false;
>  }

Any objections to the simplified/flattened control flow below?

Thanks,

	Ingo

 common.c |   59 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)
Index: tip/arch/x86/entry/common.c
===================================================================
--- tip.orig/arch/x86/entry/common.c
+++ tip/arch/x86/entry/common.c
@@ -549,35 +549,38 @@ bool noinstr idtentry_enter_cond_rcu(str
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
-	} else {
-		if (!cond_rcu || !__rcu_is_watching()) {
-			/*
-			 * If RCU is not watching then the same careful
-			 * sequence vs. lockdep and tracing is required
-			 * as in enter_from_user_mode().
-			 *
-			 * This only happens for IRQs that hit the idle
-			 * loop, i.e. if idle is not using MWAIT.
-			 */
-			lockdep_hardirqs_off(CALLER_ADDR0);
-			rcu_irq_enter();
-			instrumentation_begin();
-			trace_hardirqs_off_prepare();
-			instrumentation_end();
-			return true;
-		} else {
-			/*
-			 * If RCU is watching then RCU only wants to check
-			 * whether it needs to restart the tick in NOHZ
-			 * mode.
-			 */
-			instrumentation_begin();
-			rcu_irq_enter_check_tick();
-			/* Use the combo lockdep/tracing function */
-			trace_hardirqs_off();
-			instrumentation_end();
-		}
+		return false;
 	}
+
+	if (!cond_rcu || !__rcu_is_watching()) {
+		/*
+		 * If RCU is not watching then the same careful
+		 * sequence vs. lockdep and tracing is required
+		 * as in enter_from_user_mode().
+		 *
+		 * This only happens for IRQs that hit the idle
+		 * loop, i.e. if idle is not using MWAIT.
+		 */
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_prepare();
+		instrumentation_end();
+
+		return true;
+	}
+
+	/*
+	 * If RCU is watching then RCU only wants to check
+	 * whether it needs to restart the tick in NOHZ
+	 * mode.
+	 */
+	instrumentation_begin();
+	rcu_irq_enter_check_tick();
+	/* Use the combo lockdep/tracing function */
+	trace_hardirqs_off();
+	instrumentation_end();
+
 	return false;
 }
 

