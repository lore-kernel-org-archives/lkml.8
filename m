Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC80206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tXBVCcMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgHTKxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbgHTKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:52:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8384C061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9cui8yGpBY2ZOyPniSDNd2mkKvm1A1hT7OP8vChaDSw=; b=tXBVCcMpUX96dGkP/1qyea08Rw
        hvYF89TlNee70zCpU7Ec/1P3QywaWPWaGqYTNQYZIz6cZeeDCknCHBYkaobqS65ReHFWw6O78Ooz1
        RfodqZqyZQCo9ozGzqK2plPGysUPU+c8OYvqE0fWMyo1mKU5ZdTuEhLS+cvymYl0nHehDywOxR7cF
        DQaRRS6zVmPdzVclaMZNR4LGX5ikCJDnFaI/Os9GG0oDQ3mNpcBE2K99bkYMLWyVJlaB/ya+hDN0e
        oYmPCRhz/IgzE7D/GqY/FWx02OwWkRxHS+9yn9ldPVVdwyXorO/NLVv78dYvVKOIuFHyWYm41M5tD
        AHHxZA/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8iBS-0008Fs-Gn; Thu, 20 Aug 2020 10:52:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A15C305B23;
        Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3DE4628B7E856; Thu, 20 Aug 2020 12:52:36 +0200 (CEST)
Message-ID: <20200820104905.118636133@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 12:38:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/7] x86/debug: Allow a single level of #DB recursion
References: <20200820103832.486877479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Trying to clear DR7 around a #DB from usermode malfunctions if we
schedule when delivering SIGTRAP.  Rather than trying to define a
special no-recursion region, just allow a single level of recursion.
We do the same thing for NMI, and it hasn't caused any problems yet.

Fixes: 9f58fdde95c9 ("x86/db: Split out dr6/7 handling")
Reported-by: Kyle Huey <me@kylehuey.com>
Debugged-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/8b9bd05f187231df008d48cf818a6a311cbd5c98.1597882384.git.luto@kernel.org
---
 arch/x86/kernel/traps.c |   65 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -729,20 +729,9 @@ static bool is_sysenter_singlestep(struc
 #endif
 }
 
-static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
+static __always_inline unsigned long debug_read_clear_dr6(void)
 {
-	/*
-	 * Disable breakpoints during exception handling; recursive exceptions
-	 * are exceedingly 'fun'.
-	 *
-	 * Since this function is NOKPROBE, and that also applies to
-	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
-	 * HW_BREAKPOINT_W on our stack)
-	 *
-	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
-	 * includes the entry stack is excluded for everything.
-	 */
-	*dr7 = local_db_save();
+	unsigned long dr6;
 
 	/*
 	 * The Intel SDM says:
@@ -755,15 +744,12 @@ static __always_inline void debug_enter(
 	 *
 	 * Keep it simple: clear DR6 immediately.
 	 */
-	get_debugreg(*dr6, 6);
+	get_debugreg(dr6, 6);
 	set_debugreg(0, 6);
 	/* Filter out all the reserved bits which are preset to 1 */
-	*dr6 &= ~DR6_RESERVED;
-}
+	dr6 &= ~DR6_RESERVED;
 
-static __always_inline void debug_exit(unsigned long dr7)
-{
-	local_db_restore(dr7);
+	return dr6;
 }
 
 /*
@@ -863,6 +849,18 @@ static void handle_debug(struct pt_regs
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
+	/*
+	 * Disable breakpoints during exception handling; recursive exceptions
+	 * are exceedingly 'fun'.
+	 *
+	 * Since this function is NOKPROBE, and that also applies to
+	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
+	 * HW_BREAKPOINT_W on our stack)
+	 *
+	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
+	 * includes the entry stack is excluded for everything.
+	 */
+	unsigned long dr7 = local_db_save();
 	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
 
@@ -883,6 +881,8 @@ static __always_inline void exc_debug_ke
 
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
+
+	local_db_restore(dr7);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
@@ -894,6 +894,15 @@ static __always_inline void exc_debug_us
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
+	/*
+	 * NB: We can't easily clear DR7 here because
+	 * idtentry_exit_to_usermode() can invoke ptrace, schedule, access
+	 * user memory, etc.  This means that a recursive #DB is possible.  If
+	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
+	 * Since we're not on the IST stack right now, everything will be
+	 * fine.
+	 */
+
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
@@ -907,36 +916,24 @@ static __always_inline void exc_debug_us
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
-	exc_debug_kernel(regs, dr6);
-	debug_exit(dr7);
+	exc_debug_kernel(regs, debug_read_clear_dr6());
 }
 
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
-	exc_debug_user(regs, dr6);
-	debug_exit(dr7);
+	exc_debug_user(regs, debug_read_clear_dr6());
 }
 #else
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)
 {
-	unsigned long dr6, dr7;
-
-	debug_enter(&dr6, &dr7);
+	unsigned long dr6 = debug_read_clear_dr6();
 
 	if (user_mode(regs))
 		exc_debug_user(regs, dr6);
 	else
 		exc_debug_kernel(regs, dr6);
-
-	debug_exit(dr7);
 }
 #endif
 


