Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8CD207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgEEOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729645AbgEEOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA09C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:43 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyL3-00013W-RK; Tue, 05 May 2020 16:14:25 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4B0CBFFC8D;
        Tue,  5 May 2020 16:14:25 +0200 (CEST)
Message-Id: <20200505134341.087595319@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:22 +0200
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
Subject: [patch V4 part 2 10/18] x86/entry/64: Check IF in
 __preempt_enable_notrace() thunk
References: <20200505134112.272268764@linutronix.de>
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

The preempt_enable_notrace() ASM thunk is called from tracing, entry code
RCU and other places which are already in or going to be in the noinstr
section which protects sensitve code from being instrumented.

Calls out of these sections happen with interrupts disabled, which is
handled in C code, but the push regs, call, pop regs sequence can be
completely avoided in this case.

This is also a preparatory step for annotating the call from the thunk to
preempt_enable_notrace() safe from a noinstr section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/thunk_64.S       |   27 +++++++++++++++++++++++----
 arch/x86/include/asm/irqflags.h |    3 +--
 arch/x86/include/asm/paravirt.h |    3 +--
 3 files changed, 25 insertions(+), 8 deletions(-)

--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -9,10 +9,28 @@
 #include "calling.h"
 #include <asm/asm.h>
 #include <asm/export.h>
+#include <asm/irqflags.h>
+
+.code64
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
-	.macro THUNK name, func, put_ret_addr_in_rdi=0
+	.macro THUNK name, func, put_ret_addr_in_rdi=0, check_if=0
 SYM_FUNC_START_NOALIGN(\name)
+
+	.if \check_if
+	/*
+	 * Check for interrupts disabled right here. No point in
+	 * going all the way down
+	 */
+	pushq	%rax
+	SAVE_FLAGS(CLBR_RAX)
+	testl	$X86_EFLAGS_IF, %eax
+	popq	%rax
+	jnz	1f
+	ret
+1:
+	.endif
+
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -38,14 +56,15 @@ SYM_FUNC_END(\name)
 	.endm
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
+	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller, put_ret_addr_in_rdi=1
+	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller, put_ret_addr_in_rdi=1
 #endif
 
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
-	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
+
+	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace, check_if=1
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -127,9 +127,8 @@ static inline notrace unsigned long arch
 #define DISABLE_INTERRUPTS(x)	cli
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_DEBUG_ENTRY
+
 #define SAVE_FLAGS(x)		pushfq; popq %rax
-#endif
 
 #define SWAPGS	swapgs
 /*
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -907,14 +907,13 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
 
-#ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
 		  ANNOTATE_RETPOLINE_SAFE;			    \
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
-#endif
+
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
 

