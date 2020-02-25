Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA7CC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4E24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgBYX1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgBYX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:08 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jao-0004yy-2I; Wed, 26 Feb 2020 00:26:23 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5CDD31040B7;
        Wed, 26 Feb 2020 00:25:47 +0100 (CET)
Message-Id: <20200225224145.551342225@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:35 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 14/16] x86/entry: Provide IDTENTRY_CR2
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a CR2 aware variant of IDTENTRY which reads CR2 right at the begin
of the C entry point before invoking irq tracing and
enter_from_user_mode(). This allows  to move the CR2 handling to C code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -128,6 +128,48 @@ NOKPROBE_SYMBOL(func);							\
 static __always_inline void __##func(struct pt_regs *regs,		\
 				     unsigned long error_code)
 
+/**
+ * DECLARE_IDTENTRY_CR2 - Declare functions for fault handling IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ */
+#define DECLARE_IDTENTRY_CR2(vector, func)				\
+	asmlinkage void asm_##func(void);				\
+	asmlinkage void xen_asm_##func(void);				\
+	__visible void func(struct pt_regs *regs, unsigned long error_code)
+
+/**
+ * DEFINE_IDTENTRY_CR2 - Emit code for fault handling IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * Same as IDTENTRY_ERRORCODE but reads CR2 before invoking
+ * idtentry_enter() and hands the CR2 address into the function body.
+ */
+#define DEFINE_IDTENTRY_CR2(func)					\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address);		\
+									\
+__visible notrace void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	unsigned long address = read_cr2();				\
+									\
+	idtentry_enter(regs);						\
+	__##func (regs, error_code, address);				\
+	idtentry_exit(regs);						\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -291,6 +333,9 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)		\
 	idtentry vector asm_##func func has_error_code=1
 
+#define DECLARE_IDTENTRY_CR2(vector, func)			\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 

