Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A932C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D116320826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgESUBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgEST6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EDC08C5C0;
        Tue, 19 May 2020 12:58:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nx-0008Tl-U2; Tue, 19 May 2020 21:58:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1BEBA1C06DA;
        Tue, 19 May 2020 21:58:37 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:37 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Provide sane error entry/exit
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.058904490@linutronix.de>
References: <20200505134904.058904490@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831702.17951.16780777270107867698.tip-bot2@tip-bot2>
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

Commit-ID:     3660da2d124813bed342e25b39df0251cbe2ac4f
Gitweb:        https://git.kernel.org/tip/3660da2d124813bed342e25b39df0251cbe2ac4f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Mar 2020 16:56:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:56 +02:00

x86/entry/64: Provide sane error entry/exit

For gradual conversion provide a macro parameter and the required code
which allows to handle instrumentation and interrupt flags tracking in C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134904.058904490@linutronix.de


---
 arch/x86/entry/entry_64.S | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 01bfe7f..96ad26f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -499,8 +499,9 @@ SYM_CODE_END(spurious_entries_start)
  * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Sane variant which handles irq tracing, context tracking in C
  */
-.macro idtentry_body vector cfunc has_error_code:req
+.macro idtentry_body vector cfunc has_error_code:req sane=0
 
 	call	error_entry
 	UNWIND_HINT_REGS
@@ -514,6 +515,7 @@ SYM_CODE_END(spurious_entries_start)
 		GET_CR2_INTO(%r12);
 	.endif
 
+	.if \sane == 0
 	TRACE_IRQS_OFF
 
 #ifdef CONFIG_CONTEXT_TRACKING
@@ -522,6 +524,7 @@ SYM_CODE_END(spurious_entries_start)
 	CALL_enter_from_user_mode
 .Lfrom_kernel_no_ctxt_tracking_\@:
 #endif
+	.endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
@@ -538,7 +541,11 @@ SYM_CODE_END(spurious_entries_start)
 
 	call	\cfunc
 
+	.if \sane == 0
 	jmp	error_exit
+	.else
+	jmp	error_return
+	.endif
 .endm
 
 /**
@@ -547,11 +554,12 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Sane variant which handles irq tracing, context tracking in C
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req
+.macro idtentry vector asmsym cfunc has_error_code:req sane=0
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -574,7 +582,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code
+	idtentry_body \vector \cfunc \has_error_code \sane
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -1403,6 +1411,14 @@ SYM_CODE_START_LOCAL(error_exit)
 	jmp	.Lretint_user
 SYM_CODE_END(error_exit)
 
+SYM_CODE_START_LOCAL(error_return)
+	UNWIND_HINT_REGS
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
+	testb	$3, CS(%rsp)
+	jz	restore_regs_and_return_to_kernel
+	jmp	swapgs_restore_regs_and_return_to_usermode
+SYM_CODE_END(error_return)
+
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
  * so we can use real assembly here.
