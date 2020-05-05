Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3622C20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgEEOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729756AbgEEOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2941C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLY-0001HN-PX; Tue, 05 May 2020 16:14:57 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C093DFFC8D;
        Tue,  5 May 2020 16:14:55 +0200 (CEST)
Message-Id: <20200505134903.622702796@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:43:58 +0200
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
Subject: [patch V4 part 3 04/29] x86/traps: Make interrupt enable/disable
 symmetric in C code
References: <20200505134354.774943181@linutronix.de>
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

Traps enable interrupts conditionally but rely on the ASM return code to
disable them again. That results in redundant interrupt disable and trace
calls.

Make the trap handlers disable interrupts before returning to avoid that,
which allows simplification of the ASM entry code.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/traps.c |   28 +++++++++++++++++++---------
 arch/x86/mm/fault.c     |   15 +++++++++++++--
 2 files changed, 32 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -201,6 +201,7 @@ static void do_error_trap(struct pt_regs
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
+		cond_local_irq_disable(regs);
 	}
 }
 
@@ -399,6 +400,8 @@ dotraplinkage void do_bounds(struct pt_r
 		die("bounds", regs, error_code);
 
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+
+	cond_local_irq_disable(regs);
 }
 
 enum kernel_gp_hint {
@@ -458,12 +461,13 @@ dotraplinkage void do_general_protection
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
-			return;
+			goto exit;
 	}
 
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+		local_irq_disable();
 		return;
 	}
 
@@ -475,12 +479,11 @@ dotraplinkage void do_general_protection
 
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
-
-		return;
+		goto exit;
 	}
 
 	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		return;
+		goto exit;
 
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
@@ -492,11 +495,11 @@ dotraplinkage void do_general_protection
 	if (!preemptible() &&
 	    kprobe_running() &&
 	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		return;
+		goto exit;
 
 	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
 	if (ret == NOTIFY_STOP)
-		return;
+		goto exit;
 
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
@@ -518,6 +521,8 @@ dotraplinkage void do_general_protection
 
 	die_addr(desc, regs, error_code, gp_addr);
 
+exit:
+	cond_local_irq_disable(regs);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
@@ -775,7 +780,7 @@ static void math_error(struct pt_regs *r
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, error_code, 0))
-			return;
+			goto exit;
 
 		task->thread.error_code = error_code;
 		task->thread.trap_nr = trapnr;
@@ -783,7 +788,7 @@ static void math_error(struct pt_regs *r
 		if (notify_die(DIE_TRAP, str, regs, error_code,
 					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		return;
+		goto exit;
 	}
 
 	/*
@@ -797,10 +802,12 @@ static void math_error(struct pt_regs *r
 	si_code = fpu__exception_code(fpu, trapnr);
 	/* Retry when we get spurious exceptions: */
 	if (!si_code)
-		return;
+		goto exit;
 
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
+exit:
+	cond_local_irq_disable(regs);
 }
 
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
@@ -855,6 +862,8 @@ do_device_not_available(struct pt_regs *
 
 		info.regs = regs;
 		math_emulate(&info);
+
+		cond_local_irq_disable(regs);
 		return;
 	}
 #endif
@@ -885,6 +894,7 @@ dotraplinkage void do_iret_error(struct
 		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
 			ILL_BADSTK, (void __user *)NULL);
 	}
+	local_irq_disable();
 }
 #endif
 
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -927,6 +927,8 @@ static void
 
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
+		local_irq_disable();
+
 		return;
 	}
 
@@ -1548,9 +1550,18 @@ do_page_fault(struct pt_regs *regs, unsi
 		return;
 
 	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address)))
+	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, hw_error_code, address);
-	else
+	} else {
 		do_user_addr_fault(regs, hw_error_code, address);
+		/*
+		 * User address page fault handling might have reenabled
+		 * interrupts. Fixing up all potential exit points of
+		 * do_user_addr_fault() and its leaf functions is just not
+		 * doable w/o creating an unholy mess or turning the code
+		 * upside down.
+		 */
+		local_irq_disable();
+	}
 }
 NOKPROBE_SYMBOL(do_page_fault);

