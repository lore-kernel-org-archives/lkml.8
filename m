Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE83C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EE3215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgE0IOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgE0ILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B78C061A0F;
        Wed, 27 May 2020 01:11:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAA-0002UG-Im; Wed, 27 May 2020 10:11:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2C7D51C03A9;
        Wed, 27 May 2020 10:11:46 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Remove IRQ stack switching ASM
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202120.021462159@linutronix.de>
References: <20200521202120.021462159@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710606.17951.9824050639615238342.tip-bot2@tip-bot2>
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

Commit-ID:     300e5654198501a8cde5ad843ebad7dfbee147e4
Gitweb:        https://git.kernel.org/tip/300e5654198501a8cde5ad843ebad7dfbee147e4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry/64: Remove IRQ stack switching ASM

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202120.021462159@linutronix.de
---
 arch/x86/entry/entry_64.S | 96 +--------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 389f97f..29a8a83 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -370,102 +370,6 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-/*
- * Enters the IRQ stack if we're not already using it.  NMI-safe.  Clobbers
- * flags and puts old RSP into old_rsp, and leaves all other GPRs alone.
- * Requires kernel GSBASE.
- *
- * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
- */
-.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
-	DEBUG_ENTRY_ASSERT_IRQS_OFF
-
-	.if \save_ret
-	/*
-	 * If save_ret is set, the original stack contains one additional
-	 * entry -- the return address. Therefore, move the address one
-	 * entry below %rsp to \old_rsp.
-	 */
-	leaq	8(%rsp), \old_rsp
-	.else
-	movq	%rsp, \old_rsp
-	.endif
-
-	.if \regs
-	UNWIND_HINT_REGS base=\old_rsp
-	.endif
-
-	incl	PER_CPU_VAR(irq_count)
-	jnz	.Lirq_stack_push_old_rsp_\@
-
-	/*
-	 * Right now, if we just incremented irq_count to zero, we've
-	 * claimed the IRQ stack but we haven't switched to it yet.
-	 *
-	 * If anything is added that can interrupt us here without using IST,
-	 * it must be *extremely* careful to limit its stack usage.  This
-	 * could include kprobes and a hypothetical future IST-less #DB
-	 * handler.
-	 *
-	 * The OOPS unwinder relies on the word at the top of the IRQ
-	 * stack linking back to the previous RSP for the entire time we're
-	 * on the IRQ stack.  For this to work reliably, we need to write
-	 * it before we actually move ourselves to the IRQ stack.
-	 */
-
-	movq	\old_rsp, PER_CPU_VAR(irq_stack_backing_store + IRQ_STACK_SIZE - 8)
-	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
-
-#ifdef CONFIG_DEBUG_ENTRY
-	/*
-	 * If the first movq above becomes wrong due to IRQ stack layout
-	 * changes, the only way we'll notice is if we try to unwind right
-	 * here.  Assert that we set up the stack right to catch this type
-	 * of bug quickly.
-	 */
-	cmpq	-8(%rsp), \old_rsp
-	je	.Lirq_stack_okay\@
-	ud2
-	.Lirq_stack_okay\@:
-#endif
-
-.Lirq_stack_push_old_rsp_\@:
-	pushq	\old_rsp
-
-	.if \regs
-	UNWIND_HINT_REGS indirect=1
-	.endif
-
-	.if \save_ret
-	/*
-	 * Push the return address to the stack. This return address can
-	 * be found at the "real" original RSP, which was offset by 8 at
-	 * the beginning of this macro.
-	 */
-	pushq	-8(\old_rsp)
-	.endif
-.endm
-
-/*
- * Undoes ENTER_IRQ_STACK.
- */
-.macro LEAVE_IRQ_STACK regs=1
-	DEBUG_ENTRY_ASSERT_IRQS_OFF
-	/* We need to be off the IRQ stack before decrementing irq_count. */
-	popq	%rsp
-
-	.if \regs
-	UNWIND_HINT_REGS
-	.endif
-
-	/*
-	 * As in ENTER_IRQ_STACK, irq_count == 0, we are still claiming
-	 * the irq stack but we're not on it.
-	 */
-
-	decl	PER_CPU_VAR(irq_count)
-.endm
-
 /**
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called
