Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337BC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BB924680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgBYX25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55799 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbgBYX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:25 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jab-0004rL-Fm; Wed, 26 Feb 2020 00:26:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5B2B3104096;
        Wed, 26 Feb 2020 00:25:44 +0100 (CET)
Message-Id: <20200225224144.204871995@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:22 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 01/16] x86/entry: Provide IDTENTRY_IST
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

Same as IDTENTRY but for exceptions which run on Interrupt STacks (IST) on
64bit. For 32bit this maps to IDTENTRY.

There are 3 variants which will be used:
      IDTENTRY_MCE
      IDTENTRY_DB
      IDTENTRY_NMI

These map to IDTENTRY_IST, but only the MCE and DB variants are emitting
ASM code as the NMI entry needs hand crafted ASM still.

The function defines do not contain any idtenter/exit calls as these
exceptions need special treatment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -111,6 +111,58 @@ NOKPROBE_SYMBOL(func);							\
 static __always_inline void __##func(struct pt_regs *regs,		\
 				     unsigned long error_code)
 
+#ifdef CONFIG_X86_64
+/**
+ * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ */
+#define DECLARE_IDTENTRY_IST(vector, func)				\
+	asmlinkage void asm_##func(void);				\
+	asmlinkage void xen_asm_##func(void);				\
+	__visible void func(struct pt_regs *regs)
+
+/**
+ * DEFINE_IDTENTRY_IST - Emit code for IST entry points
+ * @func:	Function name of the entry point
+ *
+ * This provides two entry points:
+ * - The real IST based entry
+ * - The regular stack based entry invoked when coming from user mode
+ *   or XEN_PV
+ */
+#define DEFINE_IDTENTRY_IST(func)					\
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible notrace void func(struct pt_regs *regs)			\
+{									\
+	__##func (regs);						\
+}									\
+NOKPROBE_SYMBOL(func);							\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
+
+#else	/* CONFIG_X86_64 */
+/* Maps to a regular IDTENTRY on 32bit for now */
+# define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
+# define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
+#endif	/* !CONFIG_X86_64 */
+
+/* C-Code mapping */
+#define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
+
+#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+
+#define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
+
 #else /* !__ASSEMBLY__ */
 
 /* Defines for ASM code to construct the IDT entries */
@@ -123,6 +175,24 @@ static __always_inline void __##func(str
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 
+#ifdef CONFIG_X86_64
+# define DECLARE_IDTENTRY_MCE(vector, func)			\
+	idtentry_mce_db vector asm_##func func
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)			\
+	idtentry_mce_db vector asm_##func func
+
+#else
+# define DECLARE_IDTENTRY_MCE(vector, func)			\
+	DECLARE_IDTENTRY(vector, func)
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)			\
+	DECLARE_IDTENTRY(vector, func)
+#endif
+
+/* No ASM code emitted for NMI */
+# define DECLARE_IDTENTRY_NMI(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /* Simple exception entries: */

