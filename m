Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F1C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2624680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgBYX1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgBYX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:41 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jat-000520-Fh; Wed, 26 Feb 2020 00:26:27 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A12F31040BD;
        Wed, 26 Feb 2020 00:25:51 +0100 (CET)
Message-Id: <20200225231609.216265343@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:22 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 03/15] x86/entry: Add IRQENTRY_IRQ macro
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

Provide a seperate IDTENTRY macro for device interrupts, which supports the
interrupt stack switch mode on 64 bit. Otherwise its the same as
IDTENTRY_ERRORCODE.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -171,6 +171,46 @@ static __always_inline void __##func(str
 				     unsigned long error_code,		\
 				     unsigned long address)
 
+/**
+ * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
+ *			  points (common/spurious)
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ */
+#define DECLARE_IDTENTRY_IRQ(vector, func)				\
+	asmlinkage void asm_##func(void);				\
+	asmlinkage void xen_asm_##func(void);				\
+	__visible void func(struct pt_regs *regs, unsigned long vector)
+
+/**
+ * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ *
+ * Used for C handlers which require the vector number.
+ */
+#define DEFINE_IDTENTRY_IRQ(func)					\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long vector);		\
+									\
+__visible notrace __irq_entry void func(struct pt_regs *regs,		\
+					unsigned long vector)		\
+{									\
+	idtentry_enter(regs);						\
+	__##func (regs, vector);					\
+	idtentry_exit(regs);						\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long vector)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -340,6 +380,10 @@ static __always_inline void __##func(str
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 
+/* Entries for common/spurious (device) interrupts */
+#define DECLARE_IDTENTRY_IRQ(vector, func)			\
+	idtentry_irq vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)			\
 	idtentry_mce_db vector asm_##func func

