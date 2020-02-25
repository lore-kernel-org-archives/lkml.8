Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B025C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15412246A8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgBYX07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55950 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbgBYX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jas-00051R-0e; Wed, 26 Feb 2020 00:26:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 67D9C1040BC;
        Wed, 26 Feb 2020 00:25:51 +0100 (CET)
Message-Id: <20200225231609.110531538@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:21 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [patch 02/15] x86/entry/64: Add ability to switch to IRQ stacks in idtentry
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the idtentry macro so it supports switching to interrupt stacks on
64bit. Preparatory change to let regular device interrupts use idtentry
instead of having their own mechanism.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -495,8 +495,9 @@ SYM_CODE_END(spurious_entries_start)
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @irq_stack:		Execute @cfunc on the IRQ stack (device interrupts)
  */
-.macro idtentry_body cfunc has_error_code:req
+.macro idtentry_body cfunc has_error_code:req irq_stack:req
 
 	call	error_entry
 	UNWIND_HINT_REGS
@@ -508,8 +509,16 @@ SYM_CODE_END(spurious_entries_start)
 		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	.endif
 
+	.if \irq_stack
+		ENTER_IRQ_STACK old_rsp=%rdi
+	.endif
+
 	call	\cfunc
 
+	.if \irq_stack
+		LEAVE_IRQ_STACK			/* interrupts are disabled */
+	.endif
+
 	jmp	error_exit
 .endm
 
@@ -519,11 +528,12 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
+ * @irq_stack:		Execute @cfunc on the IRQ stack (device interrupts)
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req
+.macro idtentry vector asmsym cfunc has_error_code:req irq_stack=0
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -546,7 +556,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \cfunc \has_error_code
+	idtentry_body \cfunc \has_error_code \irq_stack
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -621,7 +631,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body noist_\cfunc, has_error_code=0
+	idtentry_body noist_\cfunc, has_error_code=0 irq_stack=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)

