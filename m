Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5397DC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3386C206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgELOg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgELOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:36:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FDBC061A0E;
        Tue, 12 May 2020 07:36:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1e-0005lm-2i; Tue, 12 May 2020 16:36:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A495F1C0475;
        Tue, 12 May 2020 16:36:53 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:53 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-18-will@kernel.org>
References: <20200511204150.27858-18-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
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

Commit-ID:     cdd28ad2d8110099e43527e96d059c5639809680
Gitweb:        https://git.kernel.org/tip/cdd28ad2d8110099e43527e96d059c5639809680
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:17 +02:00

READ_ONCE: Use data_race() to avoid KCSAN instrumentation

Rather then open-code the disabling/enabling of KCSAN across the guts of
{READ,WRITE}_ONCE(), defer to the data_race() macro instead.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-18-will@kernel.org

---
 include/linux/compiler.h | 54 +++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index cb2e3b3..741c93c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -199,6 +199,26 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design.
+ *
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.
+ */
+#define data_race(expr)							\
+({									\
+	__kcsan_disable_current();					\
+	({								\
+		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
+		__kcsan_enable_current();				\
+		__v;							\
+	});								\
+})
+
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
  * atomicity or dependency ordering guarantees. Note that this may result
@@ -209,14 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
+	__unqual_scalar_typeof(x) __x = data_race(__READ_ONCE(*__xp));	\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
-	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(x) __x = __READ_ONCE(*__xp);	\
-		__kcsan_enable_current();				\
-		smp_read_barrier_depends();				\
-		(typeof(x))__x;						\
-	});								\
+	smp_read_barrier_depends();					\
+	(typeof(x))__x;							\
 })
 
 #define READ_ONCE(x)							\
@@ -234,9 +250,7 @@ do {									\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
-	__kcsan_disable_current();					\
-	__WRITE_ONCE(*__xp, val);					\
-	__kcsan_enable_current();					\
+	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
@@ -304,26 +318,6 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-/**
- * data_race - mark an expression as containing intentional data races
- *
- * This data_race() macro is useful for situations in which data races
- * should be forgiven.  One example is diagnostic code that accesses
- * shared variables but is not a part of the core synchronization design.
- *
- * This macro *does not* affect normal code generation, but is a hint
- * to tooling that data races here are to be ignored.
- */
-#define data_race(expr)							\
-({									\
-	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
-		__kcsan_enable_current();				\
-		__v;							\
-	});								\
-})
-
 #endif /* __KERNEL__ */
 
 /*
