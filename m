Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A6C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A020624680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgBYXaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55598 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgBYXZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:59 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaA-0004aQ-MI; Wed, 26 Feb 2020 00:25:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 70CD4104098;
        Wed, 26 Feb 2020 00:25:33 +0100 (CET)
Message-Id: <20200225221305.813084267@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 6/8] x86/entry: Move irq tracing to syscall_slow_exit_work
References: <20200225220801.571835584@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which removes the ASM IRQ tracepoints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c   |    2 ++
 arch/x86/entry/entry_32.S |    3 ++-
 arch/x86/entry/entry_64.S |    3 ---
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -299,6 +299,8 @@ static void syscall_slow_exit_work(struc
 
 	local_irq_disable();
 	__prepare_exit_to_usermode(regs);
+	/* Return to user space enables interrupts */
+	trace_hardirqs_on();
 }
 NOKPROBE_SYMBOL(syscall_return_slowpath);
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -812,7 +812,7 @@ SYM_CODE_START(ret_from_fork)
 	movl    %esp, %eax
 	call    syscall_return_slowpath
 	STACKLEAK_ERASE
-	jmp     restore_all
+	jmp     restore_all_switch_stack
 
 	/* kernel thread */
 1:	movl	%edi, %eax
@@ -1077,6 +1077,7 @@ SYM_FUNC_START(entry_INT80_32)
 
 restore_all:
 	TRACE_IRQS_IRET
+restore_all_switch_stack:
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -172,8 +172,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 	movq	%rsp, %rsi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
-	TRACE_IRQS_ON			/* return enables interrupts */
-
 	/*
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
@@ -340,7 +338,6 @@ SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
-	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:

