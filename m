Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFCEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423242065F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgESUAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEST7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C7C08C5C2;
        Tue, 19 May 2020 12:59:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OA-0000Ag-IJ; Tue, 19 May 2020 21:58:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 435741C0480;
        Tue, 19 May 2020 21:58:44 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:44 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Move non entry code into .text section
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134340.227579223@linutronix.de>
References: <20200505134340.227579223@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832414.17951.16868122316293261767.tip-bot2@tip-bot2>
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

Commit-ID:     be06832a9a628bca72b0c6ceb447e5f5f529cd30
Gitweb:        https://git.kernel.org/tip/be06832a9a628bca72b0c6ceb447e5f5f529cd30
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 19:45:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:49 +02:00

x86/entry/64: Move non entry code into .text section

All ASM code which is not part of the entry functionality can move out into
the .text section. No reason to keep it in the non-instrumentable entry
section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134340.227579223@linutronix.de


---
 arch/x86/entry/entry_64.S   | 18 ++++++++++++++----
 arch/x86/kernel/ftrace_64.S |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a15b70a..b199f43 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -279,6 +279,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  * %rdi: prev task
  * %rsi: next task
  */
+.pushsection .text, "ax"
 SYM_FUNC_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
@@ -321,6 +322,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 	jmp	__switch_to
 SYM_FUNC_END(__switch_to_asm)
+.popsection
 
 /*
  * A newly forked process directly context switches into this address.
@@ -329,6 +331,7 @@ SYM_FUNC_END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
+.pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
@@ -357,6 +360,7 @@ SYM_CODE_START(ret_from_fork)
 	movq	$0, RAX(%rsp)
 	jmp	2b
 SYM_CODE_END(ret_from_fork)
+.popsection
 
 /*
  * Build the entry stubs with some assembler magic.
@@ -1037,10 +1041,12 @@ idtentry alignment_check		do_alignment_check		has_error_code=1
 idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
 
 
-	/*
-	 * Reload gs selector with exception handling
-	 * edi:  new selector
-	 */
+/*
+ * Reload gs selector with exception handling
+ * edi:  new selector
+ *
+ * Is in entry.text as it shouldn't be instrumented.
+ */
 SYM_FUNC_START(native_load_gs_index)
 	FRAME_BEGIN
 	pushfq
@@ -1076,6 +1082,7 @@ SYM_CODE_END(.Lbad_gs)
 	.previous
 
 /* Call softirq on interrupt stack. Interrupts are off. */
+.pushsection .text, "ax"
 SYM_FUNC_START(do_softirq_own_stack)
 	pushq	%rbp
 	mov	%rsp, %rbp
@@ -1085,6 +1092,7 @@ SYM_FUNC_START(do_softirq_own_stack)
 	leaveq
 	ret
 SYM_FUNC_END(do_softirq_own_stack)
+.popsection
 
 #ifdef CONFIG_XEN_PV
 idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
@@ -1728,6 +1736,7 @@ SYM_CODE_START(ignore_sysret)
 SYM_CODE_END(ignore_sysret)
 #endif
 
+.pushsection .text, "ax"
 SYM_CODE_START(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
@@ -1739,3 +1748,4 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
+.popsection
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index aa5d28a..083a3da 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -12,7 +12,7 @@
 #include <asm/frame.h>
 
 	.code64
-	.section .entry.text, "ax"
+	.section .text, "ax"
 
 #ifdef CONFIG_FRAME_POINTER
 /* Save parent and function stack frames (rip and rbp) */
