Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA78FC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FCB2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgBYX3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:29:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgBYX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:18 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaQ-0004lK-Pm; Wed, 26 Feb 2020 00:26:00 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B491510409F;
        Wed, 26 Feb 2020 00:25:39 +0100 (CET)
Message-Id: <20200225222649.656805644@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:21 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 15/24] x86/entry: Provide IDTENTRY_ERRORCODE
References: <20200225221606.511535280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as IDTENTRY but the C entry point has an error code argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -68,12 +68,55 @@ NOKPROBE_SYMBOL(func);							\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
 
+/**
+ * DECLARE_IDTENTRY_ERRORCODE - Declare functions for simple IDT entry points
+ *				Error code pushed by hardware
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ */
+#define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
+	asmlinkage void asm_##func(void);				\
+	asmlinkage void xen_asm_##func(void);				\
+	__visible void func(struct pt_regs *regs, unsigned long error_code)
+
+/**
+ * DEFINE_IDTENTRY_ERRORCODE - Emit code for simple IDT entry points
+ *			       Error code pushed by hardware
+ * @func:	Function name of the entry point
+ *
+ * Same as DEFINE_IDTENTRY, but has an extra error_code argument
+ */
+#define DEFINE_IDTENTRY_ERRORCODE(func)					\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code);		\
+									\
+__visible notrace void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	idtentry_enter(regs);						\
+	__##func (regs, error_code);					\
+	idtentry_exit(regs);						\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code)
+
+
 #else /* !__ASSEMBLY__ */
 
 /* Defines for ASM code to construct the IDT entries */
 #define DECLARE_IDTENTRY(vector, func)				\
 	idtentry vector asm_##func func has_error_code=0
 
+#define DECLARE_IDTENTRY_ERRORCODE(vector, func)		\
+	idtentry vector asm_##func func has_error_code=1
+
 #endif /* __ASSEMBLY__ */
 
 /* Simple exception entries: */

