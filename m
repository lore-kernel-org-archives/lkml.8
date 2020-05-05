Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A44C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8BD20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgEEOQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730140AbgEEOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB6C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:35 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMk-00029Z-O9; Tue, 05 May 2020 16:16:10 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 48033FFC8D;
        Tue,  5 May 2020 16:16:10 +0200 (CEST)
Message-Id: <20200505135315.380927730@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:47 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 21/24] x86/traps: Address objtool noinstr complaints in #DB
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

The functions invoked from handle_debug() can be instrumented. Tell objtool
about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -762,14 +762,19 @@ static void noinstr handle_debug(struct
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
+	instr_begin();
 #ifdef CONFIG_KPROBES
-	if (kprobe_debug_handler(regs))
+	if (kprobe_debug_handler(regs)) {
+		instr_end();
 		return;
+	}
 #endif
 
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP)
+		       SIGTRAP) == NOTIFY_STOP) {
+		instr_end();
 		return;
+	}
 
 	/*
 	 * Let others (NMI) know that the debug stack is in use
@@ -805,6 +810,7 @@ static void noinstr handle_debug(struct
 out:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
+	instr_end();
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -816,7 +822,7 @@ static __always_inline void exc_debug_ke
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
 	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
 	 */
-	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
+	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
@@ -839,7 +845,7 @@ static __always_inline void exc_debug_us
 					   unsigned long dr6)
 {
 	idtentry_enter(regs);
-	clear_tsk_thread_flag(tsk, TIF_BLOCKSTEP);
+	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,

