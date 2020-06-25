Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E5CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6CB207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbgFYLyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgFYLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA04C061573;
        Thu, 25 Jun 2020 04:53:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRg-0005sB-UR; Thu, 25 Jun 2020 13:53:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C5551C0092;
        Thu, 25 Jun 2020 13:53:32 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Fix #UD vs WARN more
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200622114713.GE577403@hirez.programming.kicks-ass.net>
References: <20200622114713.GE577403@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159308601215.16989.11684885436197238827.tip-bot2@tip-bot2>
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

Commit-ID:     145a773aef83181d47ebab21bb33c89233aadb1e
Gitweb:        https://git.kernel.org/tip/145a773aef83181d47ebab21bb33c89233aadb1e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 16 Jun 2020 13:28:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:40 +02:00

x86/entry: Fix #UD vs WARN more

vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section

Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
Have the bare exception handler do the report_bug() thing.

Fixes: 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200622114713.GE577403@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/traps.c | 72 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a7d1570..1d9ea21 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -84,17 +84,16 @@ static inline void cond_local_irq_disable(struct pt_regs *regs)
 		local_irq_disable();
 }
 
-int is_valid_bugaddr(unsigned long addr)
+__always_inline int is_valid_bugaddr(unsigned long addr)
 {
-	unsigned short ud;
-
 	if (addr < TASK_SIZE_MAX)
 		return 0;
 
-	if (probe_kernel_address((unsigned short *)addr, ud))
-		return 0;
-
-	return ud == INSN_UD0 || ud == INSN_UD2;
+	/*
+	 * We got #UD, if the text isn't readable we'd have gotten
+	 * a different exception.
+	 */
+	return *(unsigned short *)addr == INSN_UD2;
 }
 
 static nokprobe_inline int
@@ -216,40 +215,45 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-DEFINE_IDTENTRY_RAW(exc_invalid_op)
+static noinstr bool handle_bug(struct pt_regs *regs)
 {
-	bool rcu_exit;
+	bool handled = false;
+
+	if (!is_valid_bugaddr(regs->ip))
+		return handled;
 
 	/*
-	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
-	 * if we bugged/warned in a bad RCU context, for example, the last
-	 * thing we want is to BUG/WARN again in the idtentry code, ad
-	 * infinitum.
+	 * All lies, just get the WARN/BUG out.
 	 */
-	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
-		enum bug_trap_type type;
+	instrumentation_begin();
+	/*
+	 * Since we're emulating a CALL with exceptions, restore the interrupt
+	 * state to what it was at the exception site.
+	 */
+	if (regs->flags & X86_EFLAGS_IF)
+		raw_local_irq_enable();
+	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+		regs->ip += LEN_UD2;
+		handled = true;
+	}
+	if (regs->flags & X86_EFLAGS_IF)
+		raw_local_irq_disable();
+	instrumentation_end();
 
-		nmi_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		type = report_bug(regs->ip, regs);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
-		instrumentation_end();
-		nmi_exit();
+	return handled;
+}
 
-		if (type == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
-			return;
-		}
+DEFINE_IDTENTRY_RAW(exc_invalid_op)
+{
+	bool rcu_exit;
 
-		/*
-		 * Else, if this was a BUG and report_bug returns or if this
-		 * was just a normal #UD, we want to continue onward and
-		 * crash.
-		 */
-	}
+	/*
+	 * We use UD2 as a short encoding for 'CALL __WARN', as such
+	 * handle it before exception entry to avoid recursive WARN
+	 * in case exception entry is the one triggering WARNs.
+	 */
+	if (!user_mode(regs) && handle_bug(regs))
+		return;
 
 	rcu_exit = idtentry_enter_cond_rcu(regs);
 	instrumentation_begin();
