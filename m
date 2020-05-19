Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E70C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C405520826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgESUCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgEST6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2127C08C5C0;
        Tue, 19 May 2020 12:58:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ni-0008DP-UP; Tue, 19 May 2020 21:58:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 658D91C04E3;
        Tue, 19 May 2020 21:58:24 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide IDTENTRY_IST
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.137125609@linutronix.de>
References: <20200505135314.137125609@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830430.17951.15718024979580894099.tip-bot2@tip-bot2>
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

Commit-ID:     2f2ed27cb62200e4faa2a088131e972e26b5b585
Gitweb:        https://git.kernel.org/tip/2f2ed27cb62200e4faa2a088131e972e26b5b585
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:07 +02:00

x86/idtentry: Provide IDTENTRY_IST

Same as IDTENTRY but for exceptions which run on Interrupt Stacks (IST) on
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
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.137125609@linutronix.de



---
 arch/x86/include/asm/idtentry.h | 54 ++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3dc4d5b..3edd6d0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -132,6 +132,42 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 #define DEFINE_IDTENTRY_RAW(func)					\
 __visible noinstr void func(struct pt_regs *regs)
 
+#ifdef CONFIG_X86_64
+/**
+ * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW
+ */
+#define DECLARE_IDTENTRY_IST(vector, func)				\
+	DECLARE_IDTENTRY_RAW(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_IST - Emit code for IST entry points
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW
+ */
+#define DEFINE_IDTENTRY_IST(func)					\
+	DEFINE_IDTENTRY_RAW(func)
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
 
 /*
@@ -149,6 +185,24 @@ __visible noinstr void func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY_RAW(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+#ifdef CONFIG_X86_64
+# define DECLARE_IDTENTRY_MCE(vector, func)				\
+	idtentry_mce_db vector asm_##func func
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
+	idtentry_mce_db vector asm_##func func
+
+#else
+# define DECLARE_IDTENTRY_MCE(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+#endif
+
+/* No ASM code emitted for NMI */
+#define DECLARE_IDTENTRY_NMI(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /*
