Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A3E20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEST7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEST64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B41C08C5C1;
        Tue, 19 May 2020 12:58:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O3-000075-FL; Tue, 19 May 2020 21:58:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 13C7F1C0857;
        Tue, 19 May 2020 21:58:41 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:40 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Make entry_64_compat.S objtool clean
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134341.272248024@linutronix.de>
References: <20200505134341.272248024@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832097.17951.17826399641705845911.tip-bot2@tip-bot2>
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

Commit-ID:     b5f7e5db3839c5e67af6544872f35e2d70359518
Gitweb:        https://git.kernel.org/tip/b5f7e5db3839c5e67af6544872f35e2d70359518
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 May 2020 18:17:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:52 +02:00

x86/entry: Make entry_64_compat.S objtool clean

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134341.272248024@linutronix.de


---
 arch/x86/entry/Makefile          |  2 --
 arch/x86/entry/entry_64_compat.S | 25 ++++++++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index cdf45ff..b7a5790 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,8 +11,6 @@ CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-
 CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
 
-OBJECT_FILES_NON_STANDARD_entry_64_compat.o := y
-
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 7c29ed8..0f974ae 100644
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
 
@@ -241,6 +247,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
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
