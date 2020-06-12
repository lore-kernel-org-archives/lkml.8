Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D00920723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLTuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:50:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D588C03E96F;
        Fri, 12 Jun 2020 12:50:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jjpgn-0003Ph-5Q; Fri, 12 Jun 2020 21:50:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B59481C0489;
        Fri, 12 Jun 2020 21:50:08 +0200 (CEST)
Date:   Fri, 12 Jun 2020 19:50:08 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
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

Commit-ID:     15a416e8aaa758b5534f64a3972dae05275bc225
Gitweb:        https://git.kernel.org/tip/15a416e8aaa758b5534f64a3972dae05275bc225
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 11 Jun 2020 20:26:38 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Jun 2020 12:12:57 +02:00

x86/entry: Treat BUG/WARN as NMI-like entries

BUG/WARN are cleverly optimized using UD2 to handle the BUG/WARN out of
line in an exception fixup.

But if BUG or WARN is issued in a funny RCU context, then the
idtentry_enter...() path might helpfully WARN that the RCU context is
invalid, which results in infinite recursion.

Split the BUG/WARN handling into an nmi_enter()/nmi_exit() path in
exc_invalid_op() to increase the chance to survive the experience.

[ tglx: Make the declaration match the implementation ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org

---
 arch/x86/include/asm/idtentry.h |  2 +-
 arch/x86/kernel/traps.c         | 64 +++++++++++++++++++-------------
 arch/x86/mm/extable.c           | 15 ++++++--
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d203c54..2fc6b0c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -543,7 +543,6 @@ SYM_CODE_END(spurious_entries_start)
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
 DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
-DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
 DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 DECLARE_IDTENTRY(X86_TRAP_SPURIOUS,	exc_spurious_interrupt_bug);
@@ -561,6 +560,7 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
 /* Raw exception entries which need extra work */
+DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_PF,	exc_page_fault);
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7febae3..af75109 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,24 +97,6 @@ int is_valid_bugaddr(unsigned long addr)
 	return ud == INSN_UD0 || ud == INSN_UD2;
 }
 
-int fixup_bug(struct pt_regs *regs, int trapnr)
-{
-	if (trapnr != X86_TRAP_UD)
-		return 0;
-
-	switch (report_bug(regs->ip, regs)) {
-	case BUG_TRAP_TYPE_NONE:
-	case BUG_TRAP_TYPE_BUG:
-		break;
-
-	case BUG_TRAP_TYPE_WARN:
-		regs->ip += LEN_UD2;
-		return 1;
-	}
-
-	return 0;
-}
-
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -190,13 +172,6 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
-	/*
-	 * WARN*()s end up here; fix them up before we call the
-	 * notifier chain.
-	 */
-	if (!user_mode(regs) && fixup_bug(regs, trapnr))
-		return;
-
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
@@ -241,9 +216,46 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-DEFINE_IDTENTRY(exc_invalid_op)
+DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
+	bool rcu_exit;
+
+	/*
+	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
+	 * if we bugged/warned in a bad RCU context, for example, the last
+	 * thing we want is to BUG/WARN again in the idtentry code, ad
+	 * infinitum.
+	 */
+	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
+		enum bug_trap_type type;
+
+		nmi_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_finish();
+		type = report_bug(regs->ip, regs);
+		if (regs->flags & X86_EFLAGS_IF)
+			trace_hardirqs_on_prepare();
+		instrumentation_end();
+		nmi_exit();
+
+		if (type == BUG_TRAP_TYPE_WARN) {
+			/* Skip the ud2. */
+			regs->ip += LEN_UD2;
+			return;
+		}
+
+		/*
+		 * Else, if this was a BUG and report_bug returns or if this
+		 * was just a normal #UD, we want to continue onward and
+		 * crash.
+		 */
+	}
+
+	rcu_exit = idtentry_enter_cond_rcu(regs);
+	instrumentation_begin();
 	handle_invalid_op(regs);
+	instrumentation_end();
+	idtentry_exit_cond_rcu(regs, rcu_exit);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b991aa4..1d6cb07 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -204,8 +204,19 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 	if (fixup_exception(regs, trapnr, regs->orig_ax, 0))
 		return;
 
-	if (fixup_bug(regs, trapnr))
-		return;
+	if (trapnr == X86_TRAP_UD) {
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+			/* Skip the ud2. */
+			regs->ip += LEN_UD2;
+			return;
+		}
+
+		/*
+		 * If this was a BUG and report_bug returns or if this
+		 * was just a normal #UD, we want to continue onward and
+		 * crash.
+		 */
+	}
 
 fail:
 	early_printk("PANIC: early exception 0x%02x IP %lx:%lx error %lx cr2 0x%lx\n",
