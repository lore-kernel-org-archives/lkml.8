Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CDBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D24420644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xy2S1HP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgFOOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFOOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:50:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB4C061A0E;
        Mon, 15 Jun 2020 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F/uU9124WJoifhY4Z3glA8wwsDguMo5Cs74nr5r2OjQ=; b=Xy2S1HP53FrZsAIYTmdcWPuTkU
        OUWmp0MzkvZbEbMZEVcLa+s7ukh3INOD8DDdNPNuYEFHMrSMmOxY22yZntiL8dZJzhweWcD5hv5yB
        Y8FP8+vbiVE2JWfyOhZD4XJmjkBZyB+0Ce+yr+YLz2jZY1OGfUyjiZpVPHKD0ckOXRgUfhQ+qjW6T
        8t7o3Nk03//hCmB5KgUUmAQvh73g+M2d/BieZZ8O/AlZENpEkbPKbkZDGPw8OE1FiWoReiKQUofmi
        qCsa4t/1rDBnd3MLEb5vtVy6SFdmQvooLDGk2Zz3K9v5u7gsNX3wvHI65Joxu1cqp1oJGQvNp4Sn/
        z0he5udA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqRH-0006rj-N7; Mon, 15 Jun 2020 14:50:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8747D3010C8;
        Mon, 15 Jun 2020 16:50:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E317203D48BF; Mon, 15 Jun 2020 16:50:18 +0200 (CEST)
Date:   Mon, 15 Jun 2020 16:50:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
Message-ID: <20200615145018.GU2531@hirez.programming.kicks-ass.net>
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:50:08PM -0000, tip-bot2 for Andy Lutomirski wrote:
> +DEFINE_IDTENTRY_RAW(exc_invalid_op)
>  {
> +	bool rcu_exit;
> +
> +	/*
> +	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
> +	 * if we bugged/warned in a bad RCU context, for example, the last
> +	 * thing we want is to BUG/WARN again in the idtentry code, ad
> +	 * infinitum.
> +	 */
> +	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {

vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section

> +		enum bug_trap_type type;
> +
> +		nmi_enter();
> +		instrumentation_begin();
> +		trace_hardirqs_off_finish();
> +		type = report_bug(regs->ip, regs);
> +		if (regs->flags & X86_EFLAGS_IF)
> +			trace_hardirqs_on_prepare();
> +		instrumentation_end();
> +		nmi_exit();
> +
> +		if (type == BUG_TRAP_TYPE_WARN) {
> +			/* Skip the ud2. */
> +			regs->ip += LEN_UD2;
> +			return;
> +		}
> +
> +		/*
> +		 * Else, if this was a BUG and report_bug returns or if this
> +		 * was just a normal #UD, we want to continue onward and
> +		 * crash.
> +		 */
> +	}
> +
> +	rcu_exit = idtentry_enter_cond_rcu(regs);
> +	instrumentation_begin();
>  	handle_invalid_op(regs);
> +	instrumentation_end();
> +	idtentry_exit_cond_rcu(regs, rcu_exit);
>  }


For now something like so will do, but we need a DEFINE_IDTENTRY_foo()
for the whole:

	if (user_mode()) {
		rcu = idtentry_enter_cond_rcu()
		foo_user()
		idtentry_exit_cond_rcu(rcu);
	} else {
		nmi_enter();
		foo_kernel()
		nmi_exit()
	}

thing, we're repeating that far too often.


---

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c26..a47e74923c4c8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -218,21 +218,22 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	bool rcu_exit;
-
 	/*
 	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
 	 * if we bugged/warned in a bad RCU context, for example, the last
 	 * thing we want is to BUG/WARN again in the idtentry code, ad
 	 * infinitum.
 	 */
-	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
-		enum bug_trap_type type;
+	if (!user_mode(regs)) {
+		enum bug_trap_type type = BUG_TRAP_TYPE_NONE;
 
 		nmi_enter();
 		instrumentation_begin();
 		trace_hardirqs_off_finish();
-		type = report_bug(regs->ip, regs);
+
+		if (is_valid_bugaddr(regs->ip))
+			type = report_bug(regs->ip, regs);
+
 		if (regs->flags & X86_EFLAGS_IF)
 			trace_hardirqs_on_prepare();
 		instrumentation_end();
@@ -249,13 +250,16 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 		 * was just a normal #UD, we want to continue onward and
 		 * crash.
 		 */
-	}
+		handle_invalid_op(regs);
+	} else {
+		bool rcu_exit;
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
-	instrumentation_begin();
-	handle_invalid_op(regs);
-	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+		rcu_exit = idtentry_enter_cond_rcu(regs);
+		instrumentation_begin();
+		handle_invalid_op(regs);
+		instrumentation_end();
+		idtentry_exit_cond_rcu(regs, rcu_exit);
+	}
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)


