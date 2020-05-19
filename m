Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8847FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B2207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEST61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgEST6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9CC08C5C3;
        Tue, 19 May 2020 12:58:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8NY-00089p-HJ; Tue, 19 May 2020 21:58:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 250731C0480;
        Tue, 19 May 2020 21:58:20 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Provide IDTRENTRY_NOIST variants for
 #DB and #MC
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135315.084882104@linutronix.de>
References: <20200505135315.084882104@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830005.17951.1353363997980016294.tip-bot2@tip-bot2>
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

Commit-ID:     97f4e8b75a99efc7376b6c7b5bc2a3124f609bc1
Gitweb:        https://git.kernel.org/tip/97f4e8b75a99efc7376b6c7b5bc2a3124f609bc1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Feb 2020 23:33:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:12 +02:00

x86/idtentry: Provide IDTRENTRY_NOIST variants for #DB and #MC

Provide NOIST entry point macros which allows to implement NOIST variants
of the C entry points. These are invoked when #DB or #MC enter from user
space. This allows explicit handling of the difference between user mode
and kernel mode entry later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135315.084882104@linutronix.de


---
 arch/x86/include/asm/idtentry.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index fcd4230..060f9e3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -138,10 +138,12 @@ __visible noinstr void func(struct pt_regs *regs)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_RAW
+ * Maps to DECLARE_IDTENTRY_RAW, but declares also the NOIST C handler
+ * which is called from the ASM entry point on user mode entry
  */
 #define DECLARE_IDTENTRY_IST(vector, func)				\
-	DECLARE_IDTENTRY_RAW(vector, func)
+	DECLARE_IDTENTRY_RAW(vector, func);				\
+	__visible void noist_##func(struct pt_regs *regs)
 
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
@@ -152,6 +154,17 @@ __visible noinstr void func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_IST(func)					\
 	DEFINE_IDTENTRY_RAW(func)
 
+/**
+ * DEFINE_IDTENTRY_NOIST - Emit code for NOIST entry points which
+ *			   belong to a IST entry point (MCE, DB)
+ * @func:	Function name of the entry point. Must be the same as
+ *		the function name of the corresponding IST variant
+ *
+ * Maps to DEFINE_IDTENTRY_RAW().
+ */
+#define DEFINE_IDTENTRY_NOIST(func)					\
+	DEFINE_IDTENTRY_RAW(noist_##func)
+
 #else	/* CONFIG_X86_64 */
 /* Maps to a regular IDTENTRY on 32bit for now */
 # define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
@@ -161,12 +174,14 @@ __visible noinstr void func(struct pt_regs *regs)
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
 
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
 
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
 
 /**
  * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points
