Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060DCC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56062083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mrmEgL8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEGQTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEGQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B5C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uIN2xepvgr5OnWDbMySP85PjY1gp0RNAj2iZR6fUC0U=; b=mrmEgL8dqzJsAGSkAZivxoDNbK
        1wISFNq2mNGFU7k+1iMslo/qL964b+vo5VshJ9Y7uapygiCcSnm6PjwsmtKmlDJXb1pDf3WiBzF8F
        4yMYMs5lKi6VetzZ5CCOtKEZ9hA9mQ0v4j72lLRGXQq8UDRgKVLnSttJWlESwdz2fRlz99rW9M4X9
        9EyXDEd1spN4fwoq418XC759Vuo8Gi6loALtyQ5LPDBqFg9Ni9nePMMZkXEUASFieqGi6oGcZoLZW
        uY637aRPC9oOWL8Xd470RSojIEzkMQ7zd3aJ5HxQT2gjPHu0d4KA/w3Hd6mcEiZACRHd+1z5feEDI
        8S9o2KZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWjEf-0003RF-QQ; Thu, 07 May 2020 16:18:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FEE4301EE3;
        Thu,  7 May 2020 18:18:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4CCF92038FB64; Thu,  7 May 2020 18:18:55 +0200 (CEST)
Message-Id: <20200507161828.683233459@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 18:10:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     jpoimboe@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 1/3] x86/entry: Collapse the 3 IRQ stack instances into a single macro
References: <20200507161020.783541450@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because 1 copy of this magic is plenty.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -12,10 +12,8 @@ static __always_inline bool irqstack_act
 	return __this_cpu_read(irq_count) != -1;
 }
 
-/*
- * Macro to emit code for running @func on the irq stack.
- */
-#define RUN_ON_IRQSTACK(func)	{					\
+#define __RUN_ON_IRQSTACK(_asm, ...)					\
+do {									\
 	unsigned long tos;						\
 									\
 	lockdep_assert_irqs_disabled();					\
@@ -30,45 +28,27 @@ static __always_inline bool irqstack_act
 		"	.pushsection .discard.instr_begin	\n"	\
 		"	.long 1b - .				\n"	\
 		"	.popsection				\n"	\
-		"call	" __ASM_FORM(func) "			\n"	\
+		_asm "                                          \n"	\
 		"2:						\n"	\
 		"	.pushsection .discard.instr_end		\n"	\
 		"	.long 2b - .				\n"	\
 		"	.popsection				\n"	\
 		"popq	%%rsp					\n"	\
 		:							\
-		: [ts] "r" (tos)					\
+		: [ts] "r" (tos), ##__VA_ARGS__				\
 		: "memory"						\
 		);							\
 	__this_cpu_sub(irq_count, 1);					\
-}
+} while (0)
 
-#define RUN_ON_IRQSTACK_ARG1(func, arg) {				\
-	unsigned long tos;						\
-									\
-	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
-									\
-	__this_cpu_add(irq_count, 1);					\
-	asm volatile(							\
-		"movq	%%rsp, (%[ts])				\n"	\
-		"movq	%[ts], %%rsp				\n"	\
-		"1:						\n"	\
-		"	.pushsection .discard.instr_begin	\n"	\
-		"	.long 1b - .				\n"	\
-		"	.popsection				\n"	\
-		"call	" __ASM_FORM(func) "			\n"	\
-		"2:						\n"	\
-		"	.pushsection .discard.instr_end		\n"	\
-		"	.long 2b - .				\n"	\
-		"	.popsection				\n"	\
-		"popq	%%rsp					\n"	\
-		:							\
-		: [ts] "r" (tos),					\
-		  "D" (arg)						\
-		: "memory"						\
-		);							\
-	__this_cpu_sub(irq_count, 1);					\
-}
+/*
+ * Macro to emit code for running @func on the irq stack.
+ */
+#define RUN_ON_IRQSTACK(func) \
+	__RUN_ON_IRQSTACK("call" __ASM_FORM(func))
+
+#define RUN_ON_IRQSTACK_ARG1(func, arg) \
+	__RUN_ON_IRQSTACK("call" __ASM_FORM(func), "D" (arg))
 
 #else /* CONFIG_X86_64 */
 static __always_inline bool irqstack_active(void) { return false; }
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -74,35 +74,7 @@ int irq_init_percpu_irqstack(unsigned in
 
 static noinstr void handle_irq_on_irqstack(struct irq_desc *desc)
 {
-	unsigned long tos;
-
-	tos = (unsigned long) __this_cpu_read(hardirq_stack_ptr) - 8;
-
-	__this_cpu_add(irq_count, 1);
-	/*
-	 * The unwinder requires that the top of the IRQ stack links back
-	 * to the previous stack and RBP is set up.
-	 */
-	asm volatile(
-		"movq	%%rsp, (%[ts])				\n"
-		"movq	%[ts], %%rsp				\n"
-		"1:						\n"
-		"	.pushsection .discard.instr_begin	\n"
-		"	.long 1b - .				\n"
-		"	.popsection				\n"
-		CALL_NOSPEC
-		"2:						\n"
-		"	.pushsection .discard.instr_end		\n"
-		"	.long 2b - .				\n"
-		"	.popsection				\n"
-		"popq	%%rsp					\n"
-		:
-		: [ts] "r" (tos),
-		  [thunk_target] "r" (desc->handle_irq),
-		  "D" (desc)
-		: "memory"
-		);
-	__this_cpu_sub(irq_count, 1);
+	__RUN_ON_IRQSTACK(CALL_NOSPEC, THUNK_TARGET(desc->handle_irq), "D" (desc));
 }
 
 void handle_irq(struct irq_desc *desc, struct pt_regs *regs)


