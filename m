Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5E520878
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEST7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgEST6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0327C08C5C0;
        Tue, 19 May 2020 12:58:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nw-0008TQ-8o; Tue, 19 May 2020 21:58:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AA21C1C0852;
        Tue, 19 May 2020 21:58:36 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:36 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Provide macro to emit IDT entry stubs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134904.166735365@linutronix.de>
References: <20200505134904.166735365@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831658.17951.1329853288584058411.tip-bot2@tip-bot2>
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

Commit-ID:     e94587c501c82a3c9153217a97db11a81ed37f85
Gitweb:        https://git.kernel.org/tip/e94587c501c82a3c9153217a97db11a81ed37f85
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:56 +02:00

x86/entry/32: Provide macro to emit IDT entry stubs

32 and 64 bit have unnecessary different ways to populate the exception
entry code. Provide a idtentry macro which allows to consolidate all of
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134904.166735365@linutronix.de


---
 arch/x86/entry/entry_32.S | 68 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d9da0b7..eb64e78 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -44,6 +44,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
+#include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 
 #include "calling.h"
@@ -726,6 +727,31 @@
 
 .Lend_\@:
 .endm
+
+/**
+ * idtentry - Macro to generate entry stubs for simple IDT entries
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ * @has_error_code:	Hardware pushed error code on stack
+ * @sane:		Compatibility flag with 64bit
+ */
+.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+SYM_CODE_START(\asmsym)
+	ASM_CLAC
+	cld
+
+	.if \has_error_code == 0
+		pushl	$0		/* Clear the error code */
+	.endif
+
+	/* Push the C-function address into the GS slot */
+	pushl	$\cfunc
+	/* Invoke the common exception entry */
+	jmp	handle_exception
+SYM_CODE_END(\asmsym)
+.endm
+
 /*
  * %eax: prev task
  * %edx: next task
@@ -1517,6 +1543,48 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
+SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
+	/* the function address is in %gs's slot on the stack */
+	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
+	ENCODE_FRAME_POINTER
+
+	/* fixup %gs */
+	GS_TO_REG %ecx
+	movl	PT_GS(%esp), %edi		# get the function address
+	REG_TO_PTGS %ecx
+	SET_KERNEL_GS %ecx
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
+	movl	%esp, %eax			# pt_regs pointer
+	CALL_NOSPEC edi
+
+#ifdef CONFIG_VM86
+	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	movb	PT_CS(%esp), %al
+	andl	$(X86_EFLAGS_VM | SEGMENT_RPL_MASK), %eax
+#else
+	/*
+	 * We can be coming here from child spawned by kernel_thread().
+	 */
+	movl	PT_CS(%esp), %eax
+	andl	$SEGMENT_RPL_MASK, %eax
+#endif
+	cmpl	$USER_RPL, %eax			# returning to v8086 or userspace ?
+	jnb	ret_to_user
+
+	PARANOID_EXIT_TO_KERNEL_MODE
+	BUG_IF_WRONG_CR3
+	RESTORE_REGS 4
+	jmp	.Lirq_return
+
+ret_to_user:
+	movl	%esp, %eax
+	jmp	restore_all_switch_stack
+SYM_CODE_END(handle_exception)
+
 SYM_CODE_START(debug)
 	/*
 	 * Entry from sysenter is now handled in common_exception
