Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D3AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5520849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESUCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgEST6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192EC08C5C0;
        Tue, 19 May 2020 12:58:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ne-0008Au-Q2; Tue, 19 May 2020 21:58:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6736C1C0178;
        Tue, 19 May 2020 21:58:21 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/db: Split out dr6/7 handling
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.808628211@linutronix.de>
References: <20200505135314.808628211@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830132.17951.16392458247550490927.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     9a3d7c76d28e55173be5dd7cadbe8760fb814afa
Gitweb:        https://git.kernel.org/tip/9a3d7c76d28e55173be5dd7cadbe8760fb814afa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 06 Apr 2020 21:02:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:10 +02:00

x86/db: Split out dr6/7 handling

DR6/7 should be handled before nmi_enter() is invoked and restore after
nmi_exit() to minimize the exposure.

Split it out into helper inlines and bring it into the correct order.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.808628211@linutronix.de


---
 arch/x86/kernel/hw_breakpoint.c |  6 +---
 arch/x86/kernel/traps.c         | 75 +++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index d42fc0e..9ddf441 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -464,7 +464,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 {
 	int i, cpu, rc = NOTIFY_STOP;
 	struct perf_event *bp;
-	unsigned long dr7, dr6;
+	unsigned long dr6;
 	unsigned long *dr6_p;
 
 	/* The DR6 value is pointed by args->err */
@@ -479,9 +479,6 @@ static int hw_breakpoint_handler(struct die_args *args)
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
 
-	get_debugreg(dr7, 7);
-	/* Disable breakpoints during exception handling */
-	set_debugreg(0UL, 7);
 	/*
 	 * Assert that local interrupts are disabled
 	 * Reset the DRn bits in the virtualized register value.
@@ -538,7 +535,6 @@ static int hw_breakpoint_handler(struct die_args *args)
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
-	set_debugreg(dr7, 7);
 	put_cpu();
 
 	return rc;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 21c8cfc..de5120e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -700,6 +700,57 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 #endif
 }
 
+static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
+{
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
+	get_debugreg(*dr7, 7);
+	set_debugreg(0, 7);
+
+	/*
+	 * Ensure the compiler doesn't lower the above statements into
+	 * the critical section; disabling breakpoints late would not
+	 * be good.
+	 */
+	barrier();
+
+	/*
+	 * The Intel SDM says:
+	 *
+	 *   Certain debug exceptions may clear bits 0-3. The remaining
+	 *   contents of the DR6 register are never cleared by the
+	 *   processor. To avoid confusion in identifying debug
+	 *   exceptions, debug handlers should clear the register before
+	 *   returning to the interrupted task.
+	 *
+	 * Keep it simple: clear DR6 immediately.
+	 */
+	get_debugreg(*dr6, 6);
+	set_debugreg(0, 6);
+	/* Filter out all the reserved bits which are preset to 1 */
+	*dr6 &= ~DR6_RESERVED;
+}
+
+static __always_inline void debug_exit(unsigned long dr7)
+{
+	/*
+	 * Ensure the compiler doesn't raise this statement into
+	 * the critical section; enabling breakpoints early would
+	 * not be good.
+	 */
+	barrier();
+	set_debugreg(dr7, 7);
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -727,28 +778,13 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 {
 	struct task_struct *tsk = current;
+	unsigned long dr6, dr7;
 	int user_icebp = 0;
-	unsigned long dr6;
 	int si_code;
 
-	nmi_enter();
-
-	get_debugreg(dr6, 6);
-	/*
-	 * The Intel SDM says:
-	 *
-	 *   Certain debug exceptions may clear bits 0-3. The remaining
-	 *   contents of the DR6 register are never cleared by the
-	 *   processor. To avoid confusion in identifying debug
-	 *   exceptions, debug handlers should clear the register before
-	 *   returning to the interrupted task.
-	 *
-	 * Keep it simple: clear DR6 immediately.
-	 */
-	set_debugreg(0, 6);
+	debug_enter(&dr6, &dr7);
 
-	/* Filter out all the reserved bits which are preset to 1 */
-	dr6 &= ~DR6_RESERVED;
+	nmi_enter();
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
@@ -786,7 +822,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
-							SIGTRAP) == NOTIFY_STOP)
+		       SIGTRAP) == NOTIFY_STOP)
 		goto exit;
 
 	/*
@@ -825,6 +861,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 
 exit:
 	nmi_exit();
+	debug_exit(dr7);
 }
 NOKPROBE_SYMBOL(do_debug);
 
