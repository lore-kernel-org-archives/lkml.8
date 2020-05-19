Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A97C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgESUBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgEST6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43370C08C5C0;
        Tue, 19 May 2020 12:58:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Ng-0008FM-80; Tue, 19 May 2020 21:58:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AF9A61C04D6;
        Tue, 19 May 2020 21:58:25 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:25 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide IDTENTRY_RAW
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135313.830540017@linutronix.de>
References: <20200505135313.830540017@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830560.17951.9756673520268291937.tip-bot2@tip-bot2>
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

Commit-ID:     e448b97001b48f410dd9843f4611e879db261ee2
Gitweb:        https://git.kernel.org/tip/e448b97001b48f410dd9843f4611e879db261ee2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Mar 2020 15:22:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:06 +02:00

x86/idtentry: Provide IDTENTRY_RAW

Some exception handlers need to do extra work before any of the entry
helpers are invoked. Provide IDTENTRY_RAW for this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135313.830540017@linutronix.de



---
 arch/x86/include/asm/idtentry.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ee6ebfe..2f31d03 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -104,6 +104,34 @@ __visible noinstr void func(struct pt_regs *regs,			\
 static __always_inline void __##func(struct pt_regs *regs,		\
 				     unsigned long error_code)
 
+/**
+ * DECLARE_IDTENTRY_RAW - Declare functions for raw IDT entry points
+ *		      No error code pushed by hardware
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY().
+ */
+#define DECLARE_IDTENTRY_RAW(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+/**
+ * DEFINE_IDTENTRY_RAW - Emit code for raw IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from ASM entry code with interrupts disabled.
+ *
+ * The macro is written so it acts as function definition. Append the
+ * body with a pair of curly brackets.
+ *
+ * Contrary to DEFINE_IDTENTRY() this does not invoke the
+ * idtentry_enter/exit() helpers before and after the body invocation. This
+ * needs to be done in the body itself if applicable. Use if extra work
+ * is required before the enter/exit() helpers are invoked.
+ */
+#define DEFINE_IDTENTRY_RAW(func)					\
+__visible noinstr void func(struct pt_regs *regs)
+
 #else /* !__ASSEMBLY__ */
 
 /*
@@ -118,6 +146,9 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 
+#define DECLARE_IDTENTRY_RAW(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
 #endif /* __ASSEMBLY__ */
 
 /*
