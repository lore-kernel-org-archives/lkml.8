Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05ADC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDE02088E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEST7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgEST66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C3C08C5C4;
        Tue, 19 May 2020 12:58:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O4-0008W8-Df; Tue, 19 May 2020 21:58:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D02EF1C0854;
        Tue, 19 May 2020 21:58:38 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:38 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/traps: Make interrupt enable/disable symmetric in C code
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.622702796@linutronix.de>
References: <20200505134903.622702796@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831873.17951.7873689032893572882.tip-bot2@tip-bot2>
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

Commit-ID:     1b208500418d351c476e173f2e4bebaaf0959ef0
Gitweb:        https://git.kernel.org/tip/1b208500418d351c476e173f2e4bebaaf0959ef0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Oct 2019 14:27:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:54 +02:00

x86/traps: Make interrupt enable/disable symmetric in C code

Traps enable interrupts conditionally but rely on the ASM return code to
disable them again. That results in redundant interrupt disable and trace
calls.

Make the trap handlers disable interrupts before returning to avoid that,
which allows simplification of the ASM entry code in follow up changes.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134903.622702796@linutronix.de



---
 arch/x86/kernel/traps.c | 28 +++++++++++++++++++---------
 arch/x86/mm/fault.c     | 15 +++++++++++++--
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index adcc623..f5f4a76 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -201,6 +201,7 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
+		cond_local_irq_disable(regs);
 	}
 }
 
@@ -397,6 +398,8 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		die("bounds", regs, error_code);
 
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+
+	cond_local_irq_disable(regs);
 }
 
 enum kernel_gp_hint {
@@ -456,12 +459,13 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 
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
 
@@ -473,12 +477,11 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 
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
@@ -490,11 +493,11 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
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
@@ -516,6 +519,8 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 
 	die_addr(desc, regs, error_code, gp_addr);
 
+exit:
+	cond_local_irq_disable(regs);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
@@ -773,7 +778,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, error_code, 0))
-			return;
+			goto exit;
 
 		task->thread.error_code = error_code;
 		task->thread.trap_nr = trapnr;
@@ -781,7 +786,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 		if (notify_die(DIE_TRAP, str, regs, error_code,
 					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		return;
+		goto exit;
 	}
 
 	/*
@@ -795,10 +800,12 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
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
@@ -853,6 +860,8 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 
 		info.regs = regs;
 		math_emulate(&info);
+
+		cond_local_irq_disable(regs);
 		return;
 	}
 #endif
@@ -883,6 +892,7 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
 			ILL_BADSTK, (void __user *)NULL);
 	}
+	local_irq_disable();
 }
 #endif
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6486cce..0715720 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -927,6 +927,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
+		local_irq_disable();
+
 		return;
 	}
 
@@ -1548,9 +1550,18 @@ do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
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
