Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E343C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6831F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgE0IMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgE0IMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F8C03E97C;
        Wed, 27 May 2020 01:12:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAQ-0002bV-47; Wed, 27 May 2020 10:12:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AC3831C00ED;
        Wed, 27 May 2020 10:11:54 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:54 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove the transition leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.331115895@linutronix.de>
References: <20200521202118.331115895@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711458.17951.16458122101554477080.tip-bot2@tip-bot2>
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

Commit-ID:     ae8f8f2116d86618cf43be142c495906a17811ef
Gitweb:        https://git.kernel.org/tip/ae8f8f2116d86618cf43be142c495906a17811ef
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Remove the transition leftovers

Now that all exceptions are converted over the sane flag is not longer
needed. Also the vector argument of idtentry_body on 64-bit is pointless
now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202118.331115895@linutronix.de
---
 arch/x86/entry/entry_32.S       |  3 +--
 arch/x86/entry/entry_64.S       | 26 ++++----------------------
 arch/x86/include/asm/idtentry.h |  6 +++---
 3 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 1674deb..8b29330 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -734,9 +734,8 @@
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Compatibility flag with 64bit
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5789f76..2e476f4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -496,27 +496,14 @@ SYM_CODE_END(spurious_entries_start)
 
 /**
  * idtentry_body - Macro to emit code calling the C function
- * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  */
-.macro idtentry_body vector cfunc has_error_code:req sane=0
+.macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
 	UNWIND_HINT_REGS
 
-	.if \sane == 0
-	TRACE_IRQS_OFF
-
-#ifdef CONFIG_CONTEXT_TRACKING
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_ctxt_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_ctxt_tracking_\@:
-#endif
-	.endif
-
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
 	.if \has_error_code == 1
@@ -526,11 +513,7 @@ SYM_CODE_END(spurious_entries_start)
 
 	call	\cfunc
 
-	.if \sane == 0
-	jmp	error_exit
-	.else
 	jmp	error_return
-	.endif
 .endm
 
 /**
@@ -539,12 +522,11 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -567,7 +549,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code \sane
+	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -642,7 +624,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector noist_\cfunc, has_error_code=0 sane=1
+	idtentry_body noist_\cfunc, has_error_code=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 92054ff..53e7f14 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -283,10 +283,10 @@ __visible noinstr void func(struct pt_regs *regs,			\
  * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
  */
 #define DECLARE_IDTENTRY(vector, func)					\
-	idtentry vector asm_##func func has_error_code=0 sane=1
+	idtentry vector asm_##func func has_error_code=0
 
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	idtentry vector asm_##func func has_error_code=1 sane=1
+	idtentry vector asm_##func func has_error_code=1
 
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
@@ -324,7 +324,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* XEN NMI and DB wrapper */
 #define DECLARE_IDTENTRY_XEN(vector, func)				\
-	idtentry vector asm_exc_xen##func exc_##func has_error_code=0 sane=1
+	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
 #endif /* __ASSEMBLY__ */
 
