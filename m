Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C0C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6A92070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgEHNqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728261AbgEHNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE26DC05BD43;
        Fri,  8 May 2020 06:46:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kn-0001mm-AE; Fri, 08 May 2020 15:46:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E490A1C0080;
        Fri,  8 May 2020 15:46:33 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:33 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce scoped ASSERT_EXCLUSIVE macros
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559387.8414.2001595372115621082.tip-bot2@tip-bot2>
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

Commit-ID:     d8949ef1d9f1062848cd068cf369a57ce33dae6f
Gitweb:        https://git.kernel.org/tip/d8949ef1d9f1062848cd068cf369a57ce33dae6f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 25 Mar 2020 17:41:58 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:13 -07:00

kcsan: Introduce scoped ASSERT_EXCLUSIVE macros

Introduce ASSERT_EXCLUSIVE_*_SCOPED(), which provide an intuitive
interface to use the scoped-access feature, without having to explicitly
mark the start and end of the desired scope. Basing duration of the
checks on scope avoids accidental misuse and resulting false positives,
which may be hard to debug. See added comments for usage.

The macros are implemented using __attribute__((__cleanup__(func))),
which is supported by all compilers that currently support KCSAN.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst |  3 +-
 include/linux/kcsan-checks.h      | 73 +++++++++++++++++++++++++++++-
 kernel/kcsan/debugfs.c            | 16 ++++++-
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 52a5d6f..f4b5766 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -238,7 +238,8 @@ are defined at the C-language level. The following macros can be used to check
 properties of concurrent code where bugs would not manifest as data races.
 
 .. kernel-doc:: include/linux/kcsan-checks.h
-    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_ACCESS
+    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
+                ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
                 ASSERT_EXCLUSIVE_BITS
 
 Implementation Details
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index b24253d..101df7f 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -234,11 +234,63 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  *		... = READ_ONCE(shared_foo);
  *	}
  *
+ * Note: ASSERT_EXCLUSIVE_WRITER_SCOPED(), if applicable, performs more thorough
+ * checking if a clear scope where no concurrent writes are expected exists.
+ *
  * @var: variable to assert on
  */
 #define ASSERT_EXCLUSIVE_WRITER(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
 
+/*
+ * Helper macros for implementation of for ASSERT_EXCLUSIVE_*_SCOPED(). @id is
+ * expected to be unique for the scope in which instances of kcsan_scoped_access
+ * are declared.
+ */
+#define __kcsan_scoped_name(c, suffix) __kcsan_scoped_##c##suffix
+#define __ASSERT_EXCLUSIVE_SCOPED(var, type, id)                               \
+	struct kcsan_scoped_access __kcsan_scoped_name(id, _)                  \
+		__kcsan_cleanup_scoped;                                        \
+	struct kcsan_scoped_access *__kcsan_scoped_name(id, _dummy_p)          \
+		__maybe_unused = kcsan_begin_scoped_access(                    \
+			&(var), sizeof(var), KCSAN_ACCESS_SCOPED | (type),     \
+			&__kcsan_scoped_name(id, _))
+
+/**
+ * ASSERT_EXCLUSIVE_WRITER_SCOPED - assert no concurrent writes to @var in scope
+ *
+ * Scoped variant of ASSERT_EXCLUSIVE_WRITER().
+ *
+ * Assert that there are no concurrent writes to @var for the duration of the
+ * scope in which it is introduced. This provides a better way to fully cover
+ * the enclosing scope, compared to multiple ASSERT_EXCLUSIVE_WRITER(), and
+ * increases the likelihood for KCSAN to detect racing accesses.
+ *
+ * For example, it allows finding race-condition bugs that only occur due to
+ * state changes within the scope itself:
+ *
+ * .. code-block:: c
+ *
+ *	void writer(void) {
+ *		spin_lock(&update_foo_lock);
+ *		{
+ *			ASSERT_EXCLUSIVE_WRITER_SCOPED(shared_foo);
+ *			WRITE_ONCE(shared_foo, 42);
+ *			...
+ *			// shared_foo should still be 42 here!
+ *		}
+ *		spin_unlock(&update_foo_lock);
+ *	}
+ *	void buggy(void) {
+ *		if (READ_ONCE(shared_foo) == 42)
+ *			WRITE_ONCE(shared_foo, 1); // bug!
+ *	}
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_WRITER_SCOPED(var)                                    \
+	__ASSERT_EXCLUSIVE_SCOPED(var, KCSAN_ACCESS_ASSERT, __COUNTER__)
+
 /**
  * ASSERT_EXCLUSIVE_ACCESS - assert no concurrent accesses to @var
  *
@@ -258,6 +310,9 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  *		release_for_reuse(obj);
  *	}
  *
+ * Note: ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
+ * checking if a clear scope where no concurrent accesses are expected exists.
+ *
  * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
  * fit to detect use-after-free bugs.
  *
@@ -267,9 +322,25 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
 
 /**
+ * ASSERT_EXCLUSIVE_ACCESS_SCOPED - assert no concurrent accesses to @var in scope
+ *
+ * Scoped variant of ASSERT_EXCLUSIVE_ACCESS().
+ *
+ * Assert that there are no concurrent accesses to @var (no readers nor writers)
+ * for the entire duration of the scope in which it is introduced. This provides
+ * a better way to fully cover the enclosing scope, compared to multiple
+ * ASSERT_EXCLUSIVE_ACCESS(), and increases the likelihood for KCSAN to detect
+ * racing accesses.
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_ACCESS_SCOPED(var)                                    \
+	__ASSERT_EXCLUSIVE_SCOPED(var, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT, __COUNTER__)
+
+/**
  * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
  *
- * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER(var).
+ * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER().
  *
  * Assert that there are no concurrent writes to a subset of bits in @var;
  * concurrent readers are permitted. This assertion captures more detailed
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 72ee188..1a08664 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -110,6 +110,7 @@ static noinline void microbenchmark(unsigned long iters)
  */
 static long test_dummy;
 static long test_flags;
+static long test_scoped;
 static noinline void test_thread(unsigned long iters)
 {
 	const long CHANGE_BITS = 0xff00ff00ff00ff00L;
@@ -120,7 +121,8 @@ static noinline void test_thread(unsigned long iters)
 	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
 
 	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
-	pr_info("test_dummy@%px, test_flags@%px\n", &test_dummy, &test_flags);
+	pr_info("test_dummy@%px, test_flags@%px, test_scoped@%px,\n",
+		&test_dummy, &test_flags, &test_scoped);
 
 	cycles = get_cycles();
 	while (iters--) {
@@ -141,6 +143,18 @@ static noinline void test_thread(unsigned long iters)
 
 		test_flags ^= CHANGE_BITS; /* generate value-change */
 		__kcsan_check_write(&test_flags, sizeof(test_flags));
+
+		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
+		{
+			/* Should generate reports anywhere in this block. */
+			ASSERT_EXCLUSIVE_WRITER_SCOPED(test_scoped);
+			ASSERT_EXCLUSIVE_ACCESS_SCOPED(test_scoped);
+			BUG_ON(!current->kcsan_ctx.scoped_accesses.prev);
+			/* Unrelated accesses. */
+			__kcsan_check_access(&cycles, sizeof(cycles), 0);
+			__kcsan_check_access(&cycles, sizeof(cycles), KCSAN_ACCESS_ATOMIC);
+		}
+		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
 	}
 	cycles = get_cycles() - cycles;
 
