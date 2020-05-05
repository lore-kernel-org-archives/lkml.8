Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF34A2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgEEOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729559AbgEEOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD71C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKs-0000w6-MQ; Tue, 05 May 2020 16:14:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0C513FFC8D;
        Tue,  5 May 2020 16:14:14 +0200 (CEST)
Message-Id: <20200505134340.227579223@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:13 +0200
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
Subject: [patch V4 part 2 01/18] x86/entry/64: Move non entry code into .text section
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

All ASM code which is not part of the entry functionality can move out into
the .text section. No reason to keep it in the non-instrumentable entry
section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S   |   10 ++++++++++
 arch/x86/kernel/ftrace_64.S |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -279,6 +279,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  * %rdi: prev task
  * %rsi: next task
  */
+.pushsection .text, "ax"
 SYM_CODE_START(__switch_to_asm)
 	UNWIND_HINT_FUNC
 	/*
@@ -322,6 +323,7 @@ SYM_CODE_START(__switch_to_asm)
 
 	jmp	__switch_to
 SYM_CODE_END(__switch_to_asm)
+.popsection
 
 /*
  * A newly forked process directly context switches into this address.
@@ -330,6 +332,7 @@ SYM_CODE_END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
+.pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
@@ -358,6 +361,7 @@ SYM_CODE_START(ret_from_fork)
 	movq	$0, RAX(%rsp)
 	jmp	2b
 SYM_CODE_END(ret_from_fork)
+.popsection
 
 /*
  * Build the entry stubs with some assembler magic.
@@ -1042,6 +1046,7 @@ idtentry simd_coprocessor_error		do_simd
 	 * Reload gs selector with exception handling
 	 * edi:  new selector
 	 */
+.pushsection .text, "ax"
 SYM_FUNC_START(native_load_gs_index)
 	FRAME_BEGIN
 	pushfq
@@ -1058,6 +1063,7 @@ SYM_FUNC_START(native_load_gs_index)
 	ret
 SYM_FUNC_END(native_load_gs_index)
 EXPORT_SYMBOL(native_load_gs_index)
+.popsection
 
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
@@ -1077,6 +1083,7 @@ SYM_CODE_END(.Lbad_gs)
 	.previous
 
 /* Call softirq on interrupt stack. Interrupts are off. */
+.pushsection .text, "ax"
 SYM_FUNC_START(do_softirq_own_stack)
 	pushq	%rbp
 	mov	%rsp, %rbp
@@ -1086,6 +1093,7 @@ SYM_FUNC_START(do_softirq_own_stack)
 	leaveq
 	ret
 SYM_FUNC_END(do_softirq_own_stack)
+.popsection
 
 #ifdef CONFIG_XEN_PV
 idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
@@ -1730,6 +1738,7 @@ SYM_CODE_START(ignore_sysret)
 SYM_CODE_END(ignore_sysret)
 #endif
 
+.pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
@@ -1741,3 +1750,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
+.popsection
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -12,7 +12,7 @@
 #include <asm/frame.h>
 
 	.code64
-	.section .entry.text, "ax"
+	.section .text, "ax"
 
 #ifdef CONFIG_FRAME_POINTER
 /* Save parent and function stack frames (rip and rbp) */

