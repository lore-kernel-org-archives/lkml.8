Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2151FC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB57D20787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977741;
	bh=UOJOxWwyXWocVHprVIvpZsimQr/NrZkLdqj7PmHmguA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDq7RIuDPVvtZf1FyLzqOBsilyY0tgKlyXKmB68wUdFtHvBirEBe6n4x8cn6nDQVr
	 VKlbAvTyEFTVHyttv8d6aWLx7PjNNwHE5pi39o6VEUhFCG6A6q+E4/G8e8nVTVf0QK
	 wR0a1O08jNLm2xiMxIzAemwzHQmlo0FoRFAaBk98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436649AbgDOTI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416821AbgDOSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED5321775;
        Wed, 15 Apr 2020 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975656;
        bh=UOJOxWwyXWocVHprVIvpZsimQr/NrZkLdqj7PmHmguA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7TzypjbcVuSvkESx8la7Jg9T/BNNg1bAl4oPDyzLQ1O21PshKqUusDv26ILgj+Zz
         RDD7v36P+Wxeyc6FX0SnJ1izUCPbyMD+3Migy3kiJp+JgqlCZ2Tkyh2UCbqV+nZ71Q
         bjx+EcgyjhGdDNpfruee3mBv49IpXx6uxIKfIJI4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 11/15] kcsan: Introduce scoped ASSERT_EXCLUSIVE macros
Date:   Wed, 15 Apr 2020 11:34:07 -0700
Message-Id: <20200415183411.12368-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
 include/linux/kcsan-checks.h      | 73 ++++++++++++++++++++++++++++++++++++++-
 kernel/kcsan/debugfs.c            | 16 ++++++++-
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
 
-- 
2.9.5

