Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71D2207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T42VgDeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFOWXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgFOWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE7C061A0E;
        Mon, 15 Jun 2020 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IDCWp2EbugCC0kC6ljaZ+2IcWTJdtn0pH9LuXNHFyAs=; b=T42VgDeVirYG+yiCdji/2v4TAG
        sjSo852STrpCiiwNW/FhG2DBXIYVF2PoKLCFQ5NA2EcSBKDOgVVCYtl1iE8j8F1v3lGI+spqYft6y
        JVYy0MRIfGE9dxE8sUrKHTQweIMwoZSVAn1eNa1X/44uGAnJ6jIShkMCKgg1SvqquMWc0R7sVBTvO
        b6+pkJza7AIYXtNEgfR8uyPyp+oVvLcDvQdeE7nSkx+PGn2WrXjWx7EtPsYmY+Ep4wS6JD7/i0nf6
        bs4SVE+KQDKCY2AA16//E2Yb5kcHPBW5LkSV0ICGgNIK4tVwcNs48LrgNf6rs40+8GVZ92yIUsZZ8
        MkJTzrlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkxVs-0003i5-Kc; Mon, 15 Jun 2020 22:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A21653060FD;
        Tue, 16 Jun 2020 00:23:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89C262BDC1508; Tue, 16 Jun 2020 00:23:30 +0200 (CEST)
Date:   Tue, 16 Jun 2020 00:23:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
Message-ID: <20200615222330.GI2514@hirez.programming.kicks-ass.net>
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net>
 <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
 <20200615194458.GL2531@hirez.programming.kicks-ass.net>
 <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:08:16PM -0700, Andy Lutomirski wrote:

> > All !user exceptions really should be NMI-like. If you want to go
> > overboard, I suppose you can look at IF and have them behave interrupt
> > like when set, but why make things complicated.
> 
> This entire rabbit hole opened because of #PF. So we at least need the
> set of exceptions that are permitted to schedule if they came from
> kernel mode to remain schedulable.

What exception, other than #PF, actually needs to schedule from kernel?

> Prior to the giant changes, all the non-IST *exceptions*, but not the
> interrupts, were schedulable from kernel mode, assuming the original
> context could schedule. Right now, interrupts can schedule, too, which
> is nice if we ever want to fully clean up the Xen abomination. I
> suppose we could make it so #PF opts in to special treatment again,
> but we should decide that the result is simpler or otherwise better
> before we do this.
> 
> One possible justification would be that the schedulable entry variant
> is more complicated, and most kernel exceptions except the ones with
> fixups are bad news, and we want the oopses to succeed. But page
> faults are probably the most common source of oopses, so this is a bit
> weak, and we really want page faults to work even from nasty contexts.

I think I'd prefer the argument of consistent failure.

Do we ever want #UD to schedule? If not, then why allow it to sometimes
schedule and sometimes fail, better to always fail.

#DB is still a giant trainwreck in this regard as well.

Something like this...

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -216,10 +216,25 @@ static inline void handle_invalid_op(str
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-DEFINE_IDTENTRY_RAW(exc_invalid_op)
+static void handle_invalid_op_kernel(struct pt_regs *regs)
+{
+	if (is_valid_bugaddr(regs->ip) &&
+	    report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+		/* Skip the ud2. */
+		regs->ip += LEN_UD2;
+		return;
+	}
+
+	handle_invalid_op(regs);
+}
+
+static void handle_invalid_op_user(struct pt_regs *regs)
 {
-	bool rcu_exit;
+	handle_invalid_op(regs);
+}
 
+DEFINE_IDTENTRY_RAW(exc_invalid_op)
+{
 	/*
 	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
 	 * if we bugged/warned in a bad RCU context, for example, the last
@@ -227,38 +242,25 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	 * infinitum.
 	 */
 	if (!user_mode(regs)) {
-		enum bug_trap_type type = BUG_TRAP_TYPE_NONE;
-
 		nmi_enter();
 		instrumentation_begin();
 		trace_hardirqs_off_finish();
 
-		if (is_valid_bugaddr(regs->ip))
-			type = report_bug(regs->ip, regs);
+		handle_invalid_op_kernel(regs);
 
 		if (regs->flags & X86_EFLAGS_IF)
 			trace_hardirqs_on_prepare();
 		instrumentation_end();
 		nmi_exit();
+	} else {
+		bool rcu_exit;
 
-		if (type == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
-			return;
-		}
-
-		/*
-		 * Else, if this was a BUG and report_bug returns or if this
-		 * was just a normal #UD, we want to continue onward and
-		 * crash.
-		 */
+		rcu_exit = idtentry_enter_cond_rcu(regs);
+		instrumentation_begin();
+		handle_invalid_op_user(regs);
+		instrumentation_end();
+		idtentry_exit_cond_rcu(regs, rcu_exit);
 	}
-
-	rcu_exit = idtentry_enter_cond_rcu(regs);
-	instrumentation_begin();
-	handle_invalid_op(regs);
-	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
