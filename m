Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C877207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgEST6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgEST6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9C4C08C5C1;
        Tue, 19 May 2020 12:58:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NW-00087w-Bm; Tue, 19 May 2020 21:58:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E78941C047E;
        Tue, 19 May 2020 21:58:17 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:17 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide IDTENTRY_DF
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.583415264@linutronix.de>
References: <20200505135315.583415264@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991829784.17951.5084767126120807951.tip-bot2@tip-bot2>
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

Commit-ID:     9bf779984c19883354f55a54283292b927939b6a
Gitweb:        https://git.kernel.org/tip/9bf779984c19883354f55a54283292b927939b6a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:14 +02:00

x86/idtentry: Provide IDTENTRY_DF

Provide a separate macro for #DF as this needs to emit paranoid only code
and has also a special ASM stub in 32bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.583415264@linutronix.de



---
 arch/x86/include/asm/idtentry.h | 87 ++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 060f9e3..9521f32 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -132,6 +132,35 @@ static __always_inline void __##func(struct pt_regs *regs,		\
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
@@ -165,10 +194,58 @@ __visible noinstr void func(struct pt_regs *regs)
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
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code,			\
+			    unsigned long address)
+
 #endif	/* !CONFIG_X86_64 */
 
 /* C-Code mapping */
@@ -212,6 +289,9 @@ __visible noinstr void func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY_RAW(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+#define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
+	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func
@@ -219,12 +299,19 @@ __visible noinstr void func(struct pt_regs *regs)
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
