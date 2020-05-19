Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E62C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC320899
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEST6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgEST60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E181C08C5C0;
        Tue, 19 May 2020 12:58:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NZ-0008A6-G1; Tue, 19 May 2020 21:58:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B689A1C047E;
        Tue, 19 May 2020 21:58:19 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Implement user mode C entry points for
 #DB and #MCE
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.177564104@linutronix.de>
References: <20200505135315.177564104@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829963.17951.716625387568892205.tip-bot2@tip-bot2>
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

Commit-ID:     210d5380b6e055f0cd991a2ebefaa884689d4f95
Gitweb:        https://git.kernel.org/tip/210d5380b6e055f0cd991a2ebefaa884689d4f95
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:12 +02:00

x86/entry: Implement user mode C entry points for #DB and #MCE

The MCE entry point uses the same mechanism as the IST entry point for
now. For #DB split the inner workings and just keep the nmi_enter/exit()
magic in the IST variant. Fixup the ASM code to emit the proper
noist_##cfunc call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.177564104@linutronix.de


---
 arch/x86/entry/entry_64.S      |  2 +-
 arch/x86/kernel/cpu/mce/core.c | 40 +++++++++++++++----
 arch/x86/kernel/traps.c        | 70 +++++++++++++++++++++++++--------
 3 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index eeb4285..d302839 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -657,7 +657,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector \cfunc, has_error_code=0
+	idtentry_body vector noist_\cfunc, has_error_code=0 sane=1
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3177652..a72c013 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,24 +1904,50 @@ static void unexpected_machine_check(struct pt_regs *regs)
 /* Call the installed machine check handler for this CPU setup. */
 void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
-DEFINE_IDTENTRY_MCE(exc_machine_check)
+static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	/*
+	 * Only required when from kernel mode. See
+	 * mce_check_crashing_cpu() for details.
+	 */
 	if (machine_check_vector == do_machine_check &&
 	    mce_check_crashing_cpu())
 		return;
 
-	if (user_mode(regs))
-		idtentry_enter(regs);
-	else
-		nmi_enter();
+	nmi_enter();
+	machine_check_vector(regs);
+	nmi_exit();
+}
 
+static __always_inline void exc_machine_check_user(struct pt_regs *regs)
+{
+	idtentry_enter(regs);
 	machine_check_vector(regs);
+	idtentry_exit(regs);
+}
 
+#ifdef CONFIG_X86_64
+/* MCE hit kernel mode */
+DEFINE_IDTENTRY_MCE(exc_machine_check)
+{
+	exc_machine_check_kernel(regs);
+}
+
+/* The user mode variant. */
+DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
+{
+	exc_machine_check_user(regs);
+}
+#else
+/* 32bit unified entry point */
+DEFINE_IDTENTRY_MCE(exc_machine_check)
+{
 	if (user_mode(regs))
-		idtentry_exit(regs);
+		exc_machine_check_user(regs);
 	else
-		nmi_exit();
+		exc_machine_check_kernel(regs);
 }
+#endif
 
 /*
  * Called for each booted CPU to set up machine checks.
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 569408a..4f248c5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -775,20 +775,12 @@ static __always_inline void debug_exit(unsigned long dr7)
  *
  * May run on IST stack.
  */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
+static noinstr void handle_debug(struct pt_regs *regs, unsigned long dr6)
 {
 	struct task_struct *tsk = current;
-	unsigned long dr6, dr7;
 	int user_icebp = 0;
 	int si_code;
 
-	debug_enter(&dr6, &dr7);
-
-	if (user_mode(regs))
-		idtentry_enter(regs);
-	else
-		nmi_enter();
-
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
@@ -800,7 +792,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		     is_sysenter_singlestep(regs))) {
 		dr6 &= ~DR_STEP;
 		if (!dr6)
-			goto exit;
+			return;
 		/*
 		 * else we might have gotten a single-step trap and hit a
 		 * watchpoint at the same time, in which case we should fall
@@ -821,12 +813,12 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 
 #ifdef CONFIG_KPROBES
 	if (kprobe_debug_handler(regs))
-		goto exit;
+		return;
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP)
-		goto exit;
+		return;
 
 	/*
 	 * Let others (NMI) know that the debug stack is in use
@@ -842,7 +834,7 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 				 X86_TRAP_DB);
 		cond_local_irq_disable(regs);
 		debug_stack_usage_dec();
-		goto exit;
+		return;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -861,14 +853,60 @@ DEFINE_IDTENTRY_DEBUG(exc_debug)
 		send_sigtrap(regs, 0, si_code);
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
+}
+
+static __always_inline void exc_debug_kernel(struct pt_regs *regs,
+					     unsigned long dr6)
+{
+	nmi_enter();
+	handle_debug(regs, dr6);
+	nmi_exit();
+}
+
+static __always_inline void exc_debug_user(struct pt_regs *regs,
+					   unsigned long dr6)
+{
+	idtentry_enter(regs);
+	handle_debug(regs, dr6);
+	idtentry_exit(regs);
+}
+
+#ifdef CONFIG_X86_64
+/* IST stack entry */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
+	exc_debug_kernel(regs, dr6);
+	debug_exit(dr7);
+}
+
+/* User entry, runs on regular task stack */
+DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
+	exc_debug_user(regs, dr6);
+	debug_exit(dr7);
+}
+#else
+/* 32 bit does not have separate entry points. */
+DEFINE_IDTENTRY_DEBUG(exc_debug)
+{
+	unsigned long dr6, dr7;
+
+	debug_enter(&dr6, &dr7);
 
-exit:
 	if (user_mode(regs))
-		idtentry_exit(regs);
+		exc_debug_user(regs, dr6);
 	else
-		nmi_exit();
+		exc_debug_kernel(regs, dr6);
+
 	debug_exit(dr7);
 }
+#endif
 
 /*
  * Note that we play around with the 'TS' bit in an attempt to get
