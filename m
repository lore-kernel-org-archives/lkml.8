Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC767C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C7D206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgEEOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729657AbgEEOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFCDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyL6-00015T-BN; Tue, 05 May 2020 16:14:28 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C63931001F5;
        Tue,  5 May 2020 16:14:27 +0200 (CEST)
Message-Id: <20200505134341.272248024@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:24 +0200
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
Subject: [patch V4 part 2 12/18] x86,objtool: Make entry_64_compat.S objtool clean
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

Currently entry_64_compat is exempt from objtool, but with vmlinux
mode there is no hiding it.

Make the following changes to make it pass:

 - change entry_SYSENTER_compat to STT_NOTYPE; it's not a function
   and doesn't have function type stack setup.

 - mark all STT_NOTYPE symbols with UNWIND_HINT_EMPTY; so we do
   validate them and don't treat them as unreachable.

 - don't abuse RSP as a temp register, this confuses objtool
   mightily as it (rightfully) thinks we're doing unspeakable
   things to the stack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/Makefile          |    2 --
 arch/x86/entry/entry_64_compat.S |   25 ++++++++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,8 +11,6 @@ CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRA
 CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
 
-OBJECT_FILES_NON_STANDARD_entry_64_compat.o := y
-
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -46,12 +46,14 @@
  * ebp  user stack
  * 0(%ebp) arg6
  */
-SYM_FUNC_START(entry_SYSENTER_compat)
+SYM_CODE_START(entry_SYSENTER_compat)
+	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
 	SWAPGS
 
-	/* We are about to clobber %rsp anyway, clobbering here is OK */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
+	pushq	%rax
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
+	popq	%rax
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
@@ -104,6 +106,9 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
+
+	UNWIND_HINT_REGS
+
 	cld
 
 	/*
@@ -141,7 +146,7 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
-SYM_FUNC_END(entry_SYSENTER_compat)
+SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
  * 32-bit SYSCALL entry.
@@ -191,6 +196,7 @@ SYM_FUNC_END(entry_SYSENTER_compat)
  * 0(%esp) arg6
  */
 SYM_CODE_START(entry_SYSCALL_compat)
+	UNWIND_HINT_EMPTY
 	/* Interrupts are off on entry. */
 	swapgs
 
@@ -241,6 +247,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
 
+	UNWIND_HINT_REGS
+
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -328,6 +336,7 @@ SYM_CODE_END(entry_SYSCALL_compat)
  * ebp  arg6
  */
 SYM_CODE_START(entry_INT80_compat)
+	UNWIND_HINT_EMPTY
 	/*
 	 * Interrupts are off on entry.
 	 */
@@ -349,8 +358,11 @@ SYM_CODE_START(entry_INT80_compat)
 
 	/* Need to switch before accessing the thread stack. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+
 	/* In the Xen PV case we already run on the thread stack. */
-	ALTERNATIVE "movq %rsp, %rdi", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
+	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
+
+	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	pushq	6*8(%rdi)		/* regs->ss */
@@ -389,6 +401,9 @@ SYM_CODE_START(entry_INT80_compat)
 	xorl	%r14d, %r14d		/* nospec   r14 */
 	pushq   %r15                    /* pt_regs->r15 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
+
+	UNWIND_HINT_REGS
+
 	cld
 
 	movq	%rsp, %rdi

