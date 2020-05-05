Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6602BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486E2215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgEEOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730033AbgEEOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:11 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMT-0001th-Dh; Tue, 05 May 2020 16:15:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E5732FFC8D;
        Tue,  5 May 2020 16:15:52 +0200 (CEST)
Message-Id: <20200505135314.045220765@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 4 07/24] x86/traps: Split int3 handler up
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For code simplicity split up the int3 handler into a kernel and user part
which makes the code flow simpler to understand.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |   67 +++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -564,6 +564,35 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	cond_local_irq_disable(regs);
 }
 
+static bool do_int3(struct pt_regs *regs)
+{
+	int res;
+
+#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
+	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
+			 SIGTRAP) == NOTIFY_STOP)
+		return true;
+#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
+
+#ifdef CONFIG_KPROBES
+	if (kprobe_int3_handler(regs))
+		return true;
+#endif
+	res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
+
+	return res == NOTIFY_STOP;
+}
+
+static void do_int3_user(struct pt_regs *regs)
+{
+	if (do_int3(regs))
+		return;
+
+	cond_local_irq_enable(regs);
+	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
+	cond_local_irq_disable(regs);
+}
+
 DEFINE_IDTENTRY_RAW(exc_int3)
 {
 	/*
@@ -581,37 +610,19 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	 * because the INT3 could have been hit in any context including
 	 * NMI.
 	 */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
 		idtentry_enter(regs);
-	else
-		nmi_enter();
-
-	instr_begin();
-#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
-	if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
-				SIGTRAP) == NOTIFY_STOP)
-		goto exit;
-#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
-
-#ifdef CONFIG_KPROBES
-	if (kprobe_int3_handler(regs))
-		goto exit;
-#endif
-
-	if (notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
-			SIGTRAP) == NOTIFY_STOP)
-		goto exit;
-
-	cond_local_irq_enable(regs);
-	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
-	cond_local_irq_disable(regs);
-
-exit:
-	instr_end();
-	if (user_mode(regs))
+		instr_begin();
+		do_int3_user(regs);
+		instr_end();
 		idtentry_exit(regs);
-	else
+	} else {
+		nmi_enter();
+		instr_begin();
+		do_int3(regs);
+		instr_end();
 		nmi_exit();
+	}
 }
 
 #ifdef CONFIG_X86_64

