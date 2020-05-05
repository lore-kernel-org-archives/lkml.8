Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13323C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C2420836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEEOQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730125AbgEEOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA028C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:30 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMn-0002Ba-Ff; Tue, 05 May 2020 16:16:13 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BC791FFC8D;
        Tue,  5 May 2020 16:16:12 +0200 (CEST)
Message-Id: <20200505135315.583415264@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 23/24] x86/entry: Provide IDTENTRY_DF
References: <20200505134926.578885807@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 arch/x86/include/asm/idtentry.h |   99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -132,6 +132,35 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_RAW(func)					\
 __visible noinstr void func(struct pt_regs *regs)
 
+/**
+ * DECLARE_IDTENTRY_RAW_ERRORCODE - Declare functions for raw IDT entry points
+ *				    Error code pushed by hardware
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ */
+#define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_RAW_ERRORCODE - Emit code for raw IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ *
+ * The macro is written so it acts as function definition. Append the
+ * body with a pair of curly brackets.
+ *
+ * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
+ * idtentry_enter/exit() helpers before and after the body invocation. This
+ * needs to be done in the body itself if applicable. Use if extra work
+ * is required before the enter/exit() helpers are invoked.
+ */
+#define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
+__visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
+
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -165,10 +194,70 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY_RAW(noist_##func)
 
+/**
+ * DECLARE_IDTENTRY_DF - Declare functions for double fault
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DECLARE_IDTENTRY_DF(vector, func)				\
+	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_DF - Emit code for double fault
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
+
 #else	/* CONFIG_X86_64 */
+
 /* Maps to a regular IDTENTRY on 32bit for now */
 # define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
 # define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
+
+/**
+ * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares two functions:
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
@@ -212,6 +301,9 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_RAW(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+#define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func
@@ -219,12 +311,19 @@ static __always_inline void __##func(str
 # define DECLARE_IDTENTRY_DEBUG(vector, func)				\
 	idtentry_mce_db vector asm_##func func
 
+# define DECLARE_IDTENTRY_DF(vector, func)				\
+	idtentry_df vector asm_##func func
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
 # define DECLARE_IDTENTRY_DEBUG(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
+
+/* No ASM emitted for DF as this goes through a C shim */
+# define DECLARE_IDTENTRY_DF(vector, func)
+
 #endif
 
 /* No ASM code emitted for NMI */

