Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB5120849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEST63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgEST6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70485C08C5C1;
        Tue, 19 May 2020 12:58:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NX-00089A-K3; Tue, 19 May 2020 21:58:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C03F1C0178;
        Tue, 19 May 2020 21:58:19 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Restructure #DB handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.283276272@linutronix.de>
References: <20200505135315.283276272@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829913.17951.6613776015582569375.tip-bot2@tip-bot2>
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

Commit-ID:     ee8324f0167a914509d1db5ee0263620fd8e83b8
Gitweb:        https://git.kernel.org/tip/ee8324f0167a914509d1db5ee0263620fd8e83b8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 May 2020 19:56:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:13 +02:00

x86/traps: Restructure #DB handling

Now that there are separate entry points, move the kernel/user_mode specifc
checks into the entry functions so the common handling code does not need
the extra mode checks. Make the code more readable while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.283276272@linutronix.de


---
 arch/x86/kernel/traps.c | 69 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4f248c5..b62e962 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -775,39 +775,12 @@ static __always_inline void debug_exit(unsigned long dr7)
  *
  * May run on IST stack.
  */
-static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
+				 bool user_icebp)
 {
 	struct task_struct *tsk = current;
-	int user_icebp = 0;
 	int si_code;
 
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
-
-	if (unlikely(!user_mode(regs) && (dr6 & DR_STEP) &&
-		     is_sysenter_singlestep(regs))) {
-		dr6 &= ~DR_STEP;
-		if (!dr6)
-			return;
-		/*
-		 * else we might have gotten a single-step trap and hit a
-		 * watchpoint at the same time, in which case we should fall
-		 * through and handle the watchpoint.
-		 */
-	}
-
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	if (!dr6 && user_mode(regs))
-		user_icebp = 1;
-
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
@@ -832,9 +805,7 @@ static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
 				 X86_TRAP_DB);
-		cond_local_irq_disable(regs);
-		debug_stack_usage_dec();
-		return;
+		goto out;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -848,9 +819,12 @@ static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
 		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 		regs->flags &= ~X86_EFLAGS_TF;
 	}
+
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(regs, 0, si_code);
+
+out:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 }
@@ -859,7 +833,27 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
 	nmi_enter();
-	handle_debug(regs, dr6);
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
+	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
+	 * watchpoint at the same time then that will still be handled.
+	 */
+	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+		dr6 &= ~DR_STEP;
+
+	/*
+	 * If DR6 is zero, no point in trying to handle it. The kernel is
+	 * not using INT1.
+	 */
+	if (dr6)
+		handle_debug(regs, dr6, false);
+
 	nmi_exit();
 }
 
@@ -867,7 +861,14 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
 	idtentry_enter(regs);
-	handle_debug(regs, dr6);
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	handle_debug(regs, dr6, !dr6);
 	idtentry_exit(regs);
 }
 
