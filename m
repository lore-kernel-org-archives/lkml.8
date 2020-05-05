Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B08C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808DA20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgEEOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729269AbgEEOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLs-0001WD-2N; Tue, 05 May 2020 16:15:16 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 99DB7FFC8D;
        Tue,  5 May 2020 16:15:15 +0200 (CEST)
Message-Id: <20200505134905.258989060@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:44:14 +0200
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
Subject: [patch V4 part 3 20/29] x86/entry: Provide IDTENTRY_ERRORCODE
References: <20200505134354.774943181@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Same as IDTENTRY but the C entry point has an error code argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/idtentry.h |   46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -57,6 +57,49 @@ static __always_inline void __##func(str
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
+ *
+ * Same as DECLARE_IDTENTRY, but has an extra error_code argument for the
+ * C-handler.
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
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	idtentry_enter(regs);						\
+	instr_begin();							\
+	__##func (regs, error_code);					\
+	instr_end();							\
+	idtentry_exit(regs);						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code)
+
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -65,6 +108,9 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY(vector, func)					\
 	idtentry vector asm_##func func has_error_code=0 sane=1
 
+#define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
+	idtentry vector asm_##func func has_error_code=1 sane=1
+
 #endif /* __ASSEMBLY__ */
 
 /*

