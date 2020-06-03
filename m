Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793092068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFCRum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgFCRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28351C08C5C1;
        Wed,  3 Jun 2020 10:50:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX5-0005xq-34; Wed, 03 Jun 2020 19:50:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A1CB11C0081;
        Wed,  3 Jun 2020 19:50:30 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:30 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Re-order #DB handler to avoid *SAN
 instrumentation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.127756554@infradead.org>
References: <20200603114052.127756554@infradead.org>
MIME-Version: 1.0
Message-ID: <159120663051.17951.17347906616397144665.tip-bot2@tip-bot2>
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

Commit-ID:     6452aaf182a1deb9fda63754cf8e92353c5f49fd
Gitweb:        https://git.kernel.org/tip/6452aaf182a1deb9fda63754cf8e92353c5f49fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:37 +02:00

x86/entry: Re-order #DB handler to avoid *SAN instrumentation

vmlinux.o: warning: objtool: exc_debug()+0xbb: call to clear_ti_thread_flag.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: noist_exc_debug()+0x55: call to clear_ti_thread_flag.constprop.0() leaves .noinstr.text section

Rework things so that handle_debug() looses the noinstr and move the
clear_thread_flag() into that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.127756554@infradead.org

---
 arch/x86/kernel/traps.c | 55 +++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 5566fe5..7febae3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -775,26 +775,44 @@ static __always_inline void debug_exit(unsigned long dr7)
  *
  * May run on IST stack.
  */
-static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
-				 bool user_icebp)
+static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 {
 	struct task_struct *tsk = current;
+	bool user_icebp;
 	int si_code;
 
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
+	 * If DR6 is zero, no point in trying to handle it. The kernel is
+	 * not using INT1.
+	 */
+	if (!user && !dr6)
+		return;
+
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	user_icebp = user && !dr6;
+
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
-	instrumentation_begin();
 #ifdef CONFIG_KPROBES
 	if (kprobe_debug_handler(regs)) {
-		instrumentation_end();
 		return;
 	}
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP) {
-		instrumentation_end();
 		return;
 	}
 
@@ -825,7 +843,6 @@ static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
 
 out:
 	cond_local_irq_disable(regs);
-	instrumentation_end();
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -834,14 +851,6 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	nmi_enter();
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
-	instrumentation_end();
-
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
@@ -850,14 +859,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	/*
-	 * If DR6 is zero, no point in trying to handle it. The kernel is
-	 * not using INT1.
-	 */
-	if (dr6)
-		handle_debug(regs, dr6, false);
+	handle_debug(regs, dr6, false);
 
-	instrumentation_begin();
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
@@ -868,14 +871,10 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
 	idtentry_enter_user(regs);
-	clear_thread_flag(TIF_BLOCKSTEP);
+	instrumentation_begin();
 
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	handle_debug(regs, dr6, !dr6);
+	handle_debug(regs, dr6, true);
+	instrumentation_end();
 	idtentry_exit_user(regs);
 }
 
