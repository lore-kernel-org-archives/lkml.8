Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F473208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEHNqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727852AbgEHNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A480C05BD0A;
        Fri,  8 May 2020 06:46:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kh-0001kV-AB; Fri, 08 May 2020 15:46:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B60111C03AB;
        Fri,  8 May 2020 15:46:30 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:30 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Add __kcsan_{enable,disable}_current() variants
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559066.8414.13269261025969395346.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     19acd03d95dad1f50d06f28179a1866fca431fed
Gitweb:        https://git.kernel.org/tip/19acd03d95dad1f50d06f28179a1866fca431fed
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Apr 2020 17:47:29 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 May 2020 10:58:46 -07:00

kcsan: Add __kcsan_{enable,disable}_current() variants

The __kcsan_{enable,disable}_current() variants only call into KCSAN if
KCSAN is enabled for the current compilation unit. Note: This is
typically not what we want, as we usually want to ensure that even calls
into other functions still have KCSAN disabled.

These variants may safely be used in header files that are shared
between regular kernel code and code that does not link the KCSAN
runtime.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 17 ++++++++++++++---
 kernel/kcsan/core.c          |  7 +++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index ef95ddc..7b0b9c4 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -49,6 +49,7 @@ void kcsan_disable_current(void);
  * Supports nesting.
  */
 void kcsan_enable_current(void);
+void kcsan_enable_current_nowarn(void); /* Safe in uaccess regions. */
 
 /**
  * kcsan_nestable_atomic_begin - begin nestable atomic region
@@ -149,6 +150,7 @@ static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 
 static inline void kcsan_disable_current(void)		{ }
 static inline void kcsan_enable_current(void)		{ }
+static inline void kcsan_enable_current_nowarn(void)	{ }
 static inline void kcsan_nestable_atomic_begin(void)	{ }
 static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
@@ -165,15 +167,24 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
 
 #endif /* CONFIG_KCSAN */
 
+#ifdef __SANITIZE_THREAD__
 /*
- * kcsan_*: Only calls into the runtime when the particular compilation unit has
- * KCSAN instrumentation enabled. May be used in header files.
+ * Only calls into the runtime when the particular compilation unit has KCSAN
+ * instrumentation enabled. May be used in header files.
  */
-#ifdef __SANITIZE_THREAD__
 #define kcsan_check_access __kcsan_check_access
+
+/*
+ * Only use these to disable KCSAN for accesses in the current compilation unit;
+ * calls into libraries may still perform KCSAN checks.
+ */
+#define __kcsan_disable_current kcsan_disable_current
+#define __kcsan_enable_current kcsan_enable_current_nowarn
 #else
 static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 				      int type) { }
+static inline void __kcsan_enable_current(void)  { }
+static inline void __kcsan_disable_current(void) { }
 #endif
 
 /**
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index a572aae..a73a66c 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -625,6 +625,13 @@ void kcsan_enable_current(void)
 }
 EXPORT_SYMBOL(kcsan_enable_current);
 
+void kcsan_enable_current_nowarn(void)
+{
+	if (get_ctx()->disable_count-- == 0)
+		kcsan_disable_current();
+}
+EXPORT_SYMBOL(kcsan_enable_current_nowarn);
+
 void kcsan_nestable_atomic_begin(void)
 {
 	/*
