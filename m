Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF3DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0719420849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgESUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgEST6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531BBC08C5C2;
        Tue, 19 May 2020 12:58:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nq-0008NE-K8; Tue, 19 May 2020 21:58:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CA181C04E3;
        Tue, 19 May 2020 21:58:32 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide IDTENTRY_ERRORCODE
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134905.258989060@linutronix.de>
References: <20200505134905.258989060@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831206.17951.2276680916440156418.tip-bot2@tip-bot2>
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

Commit-ID:     c7fd4ec398dc3e23414da137637bf1182bfe0585
Gitweb:        https://git.kernel.org/tip/c7fd4ec398dc3e23414da137637bf1182bfe0585
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:16:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:00 +02:00

x86/idtentry: Provide IDTENTRY_ERRORCODE

Same as IDTENTRY but the C entry point has an error code argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134905.258989060@linutronix.de



---
 arch/x86/include/asm/idtentry.h | 46 ++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0c33740..f35d5c9 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -57,6 +57,49 @@ __visible noinstr void func(struct pt_regs *regs)			\
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
+	instrumentation_begin();					\
+	__##func (regs, error_code);					\
+	instrumentation_end();						\
+	idtentry_exit(regs);						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code)
+
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -65,6 +108,9 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY(vector, func)					\
 	idtentry vector asm_##func func has_error_code=0 sane=1
 
+#define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
+	idtentry vector asm_##func func has_error_code=1 sane=1
+
 #endif /* __ASSEMBLY__ */
 
 /*
