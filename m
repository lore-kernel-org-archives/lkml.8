Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90C1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39C120872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgEST73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgEST7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:59:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C793C08C5C0;
        Tue, 19 May 2020 12:59:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OB-0000Da-H8; Tue, 19 May 2020 21:58:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 695D11C04D6;
        Tue, 19 May 2020 21:58:46 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] bug: Annotate WARN/BUG/stackfail as noinstr safe
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.376598577@linutronix.de>
References: <20200505134100.376598577@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832633.17951.16329253492440093410.tip-bot2@tip-bot2>
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

Commit-ID:     4b162e41d8bb552516cd8fa5efaca5cd8160d5c8
Gitweb:        https://git.kernel.org/tip/4b162e41d8bb552516cd8fa5efaca5cd8160d5c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Mar 2020 13:49:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:23 +02:00

bug: Annotate WARN/BUG/stackfail as noinstr safe

Warnings, bugs and stack protection fails from noinstr sections, e.g. low
level and early entry code, are likely to be fatal.

Mark them as "safe" to be invoked from noinstr protected code to avoid
annotating all usage sites. Getting the information out is important.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134100.376598577@linutronix.de


---
 arch/x86/include/asm/bug.h |  3 +++
 include/asm-generic/bug.h  |  9 +++++++--
 kernel/panic.c             |  4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index facba9b..fb34ff6 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -70,14 +70,17 @@ do {									\
 #define HAVE_ARCH_BUG
 #define BUG()							\
 do {								\
+	instrumentation_begin();				\
 	_BUG_FLAGS(ASM_UD2, 0);					\
 	unreachable();						\
 } while (0)
 
 #define __WARN_FLAGS(flags)					\
 do {								\
+	instrumentation_begin();				\
 	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
 	annotate_reachable();					\
+	instrumentation_end();					\
 } while (0)
 
 #include <asm-generic/bug.h>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 384b5c8..c94e33a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -83,14 +83,19 @@ extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
-#define __WARN_printf(taint, arg...)					\
-	warn_slowpath_fmt(__FILE__, __LINE__, taint, arg)
+#define __WARN_printf(taint, arg...) do {				\
+		instrumentation_begin();				\
+		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
+		instrumentation_end();					\
+	} while (0)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
+		instrumentation_begin();				\
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		instrumentation_end();					\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e..1cfb47d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -662,10 +662,12 @@ device_initcall(register_warn_debugfs);
  * Called when gcc's -fstack-protector feature is used, and
  * gcc detects corruption of the on-stack canary value
  */
-__visible void __stack_chk_fail(void)
+__visible noinstr void __stack_chk_fail(void)
 {
+	instrumentation_begin();
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+	instrumentation_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
 
