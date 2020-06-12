Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70E320878
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591932401;
	bh=HR8RVi4akUBWyDcQsxs2TtLmSm4GKbNLfDmkTSvwbtc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aLzghmP3v/jvUUNh/+R891HtZLi3Lc1Ppnm6Ure2ymDRUhhOHJddH6tWC0P3b8DLP
	 bYUYi3qcyipHKH2DrCGXX5FejsnflBxw7lUaG+lxXnZqQV/m1C7640+CSOp34r1QH9
	 zL2FUZR5i8J4WTVRFwRH5YFvcNCZ5pFIHqq8L2fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgFLD0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 23:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgFLD0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 23:26:40 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D98E20878;
        Fri, 12 Jun 2020 03:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591932399;
        bh=HR8RVi4akUBWyDcQsxs2TtLmSm4GKbNLfDmkTSvwbtc=;
        h=From:To:Cc:Subject:Date:From;
        b=mZ4ICSiXB6Y1Il8ydBYWtJMp0WqUkwzGn6g5Jf5hn1QKvz+beqJHZWAWHnUmYVM1A
         o+QY69JBL554R1nZkQfL4IW3EWWMHpU8GikXvOZ3lG/njlcgtuByK0HFjvUKbEhirj
         S6796C79/4V0/Vy57Pimq6H02N0tZNOrx1tedHio=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/entry: Treat BUG/WARN as NMI-like entries
Date:   Thu, 11 Jun 2020 20:26:38 -0700
Message-Id: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we BUG or WARN in a funny RCU context, we cleverly optimize the
BUG/WARN using the ud2 hack, which takes us through the
idtentry_enter...() paths, which might helpfully WARN that the RCU
context is invalid, which results in infinite recursion.

Split the BUG/WARN handling into an nmi_enter()/nmi_exit() path in
exc_invalid_op() to increase the chance that we survive the
experience.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

This is not as well tested as I would like, but it does cause the splat
I'm chasing to display a nice warning instead of causing an undebuggable
stack overflow.

(It would have been debuggable on x86_64, but it's a 32-bit splat, and
x86_32 doesn't have ORC.)

 arch/x86/kernel/traps.c | 61 +++++++++++++++++++++++------------------
 arch/x86/mm/extable.c   | 15 ++++++++--
 2 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index cb8c3d26cdf5..6340b12a6616 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -98,24 +98,6 @@ int is_valid_bugaddr(unsigned long addr)
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
@@ -191,13 +173,6 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
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
@@ -242,9 +217,43 @@ static inline void handle_invalid_op(struct pt_regs *regs)
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
+		type = report_bug(regs->ip, regs);
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
index b991aa4bdfae..1d6cb07f4f86 100644
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
-- 
2.25.4

