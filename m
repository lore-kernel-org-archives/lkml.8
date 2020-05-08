Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF94C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CBF24960
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEHNrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728140AbgEHNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FABC05BD09;
        Fri,  8 May 2020 06:46:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kj-0001mS-Qx; Fri, 08 May 2020 15:46:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 869F21C03AB;
        Fri,  8 May 2020 15:46:33 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:33 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Move kcsan_{disable,enable}_current() to
 kcsan-checks.h
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559346.8414.7806319279054539139.tip-bot2@tip-bot2>
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

Commit-ID:     01b4ff58f72dbee926077d9afa0650f6e685e866
Gitweb:        https://git.kernel.org/tip/01b4ff58f72dbee926077d9afa0650f6e685e866
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 31 Mar 2020 21:32:32 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:14 -07:00

kcsan: Move kcsan_{disable,enable}_current() to kcsan-checks.h

Both affect access checks, and should therefore be in kcsan-checks.h.
This is in preparation to use these in compiler.h.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 16 ++++++++++++++++
 include/linux/kcsan.h        | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 101df7f..ef95ddc 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -37,6 +37,20 @@
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
 /**
+ * kcsan_disable_current - disable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_disable_current(void);
+
+/**
+ * kcsan_enable_current - re-enable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_enable_current(void);
+
+/**
  * kcsan_nestable_atomic_begin - begin nestable atomic region
  *
  * Accesses within the atomic region may appear to race with other accesses but
@@ -133,6 +147,8 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
 
+static inline void kcsan_disable_current(void)		{ }
+static inline void kcsan_enable_current(void)		{ }
 static inline void kcsan_nestable_atomic_begin(void)	{ }
 static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 17ae59e..53340d8 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -50,25 +50,9 @@ struct kcsan_ctx {
  */
 void kcsan_init(void);
 
-/**
- * kcsan_disable_current - disable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_disable_current(void);
-
-/**
- * kcsan_enable_current - re-enable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_enable_current(void);
-
 #else /* CONFIG_KCSAN */
 
 static inline void kcsan_init(void)			{ }
-static inline void kcsan_disable_current(void)		{ }
-static inline void kcsan_enable_current(void)		{ }
 
 #endif /* CONFIG_KCSAN */
 
