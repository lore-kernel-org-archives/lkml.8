Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419CCC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9124680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgBYX1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbgBYX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:03 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jai-0004wQ-3M; Wed, 26 Feb 2020 00:26:16 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 345E91040B2;
        Wed, 26 Feb 2020 00:25:46 +0100 (CET)
Message-Id: <20200225224145.020876774@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 09/16] x86/entry: Provide IDTENTRY_DF
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

Provide a separate macro for #DF as this needs to emit paranoid only code
and has also a special ASM stub in 32bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   82 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -160,10 +160,85 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY(noist_##func)
 
+/**
+ * DECLARE_IDTENTRY_DF - Declare functions for double fault
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_ERRORCODE
+ */
+#define DECLARE_IDTENTRY_DF(vector, func)				\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_DF - Emit code for double fault
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ */
+#define DEFINE_IDTENTRY_DF(func)					\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address);		\
+									\
+__visible notrace void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	unsigned long address = read_cr2();				\
+									\
+	trace_hardirqs_off();						\
+	__##func (regs, error_code, address);				\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address)
+
 #else	/* CONFIG_X86_64 */
 /* Maps to a regular IDTENTRY on 32bit for now */
 # define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
 # define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
+
+/**
+ * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The C handler called from the C shim
+ */
+#define DECLARE_IDTENTRY_DF(vector, func)				\
+	asmlinkage void asm_##func(void);				\
+	__visible void func(struct pt_regs *regs,			\
+			    unsigned long error_code,			\
+			    unsigned long address)
+
+/**
+ * DEFINE_IDTENTRY_DF - Emit code for double fault on 32bit
+ * @func:	Function name of the entry point
+ *
+ * This is called through the doublefault shim which already provides
+ * cr2 in the address argument.
+ */
+#define DEFINE_IDTENTRY_DF(func)					\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address);		\
+									\
+__visible notrace void func(struct pt_regs *regs,			\
+			    unsigned long error_code,			\
+			    unsigned long address)			\
+{									\
+	__##func (regs, error_code, address);				\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code,		\
+				     unsigned long address)
+
 #endif	/* !CONFIG_X86_64 */
 
 /* C-Code mapping */
@@ -209,12 +284,19 @@ static __always_inline void __##func(str
 # define DECLARE_IDTENTRY_DEBUG(vector, func)			\
 	idtentry_mce_db vector asm_##func func
 
+# define DECLARE_IDTENTRY_DF(vector, func)			\
+	idtentry_df vector asm_##func func
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)			\
 	DECLARE_IDTENTRY(vector, func)
 
 # define DECLARE_IDTENTRY_DEBUG(vector, func)			\
 	DECLARE_IDTENTRY(vector, func)
+
+/* No ASM emitted for DF as this goes through a C shim */
+# define DECLARE_IDTENTRY_DF(vector, func)
+
 #endif
 
 /* No ASM code emitted for NMI */

