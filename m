Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF995C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7A2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCXJMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:12:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43748 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCXJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaI-0007TO-Qh; Tue, 24 Mar 2020 10:10:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B05091C0470;
        Tue, 24 Mar 2020 10:10:53 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:53 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
Cc:     John Hubbard <jhubbard@nvidia.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Qian Cai <cai@lca.pw>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105338.28353.4710253435137410438.tip-bot2@tip-bot2>
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

Commit-ID:     703b321501c95c658275fd76775282fe45989641
Gitweb:        https://git.kernel.org/tip/703b321501c95c658275fd76775282fe45989641
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 11 Feb 2020 17:04:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:44:14 +01:00

kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)

This introduces ASSERT_EXCLUSIVE_BITS(var, mask).
ASSERT_EXCLUSIVE_BITS(var, mask) will cause KCSAN to assume that the
following access is safe w.r.t. data races (however, please see the
docbook comment for disclaimer here).

For more context on why this was considered necessary, please see:

  http://lkml.kernel.org/r/1580995070-25139-1-git-send-email-cai@lca.pw

In particular, before this patch, data races between reads (that use
@mask bits of an access that should not be modified concurrently) and
writes (that change ~@mask bits not used by the readers) would have been
annotated with "data_race()" (or "READ_ONCE()"). However, doing so would
then hide real problems: we would no longer be able to detect harmful
races between reads to @mask bits and writes to @mask bits.

Therefore, by using ASSERT_EXCLUSIVE_BITS(var, mask), we accomplish:

  1. Avoid proliferation of specific macros at the call sites: by
     including a single mask in the argument list, we can use the same
     macro in a wide variety of call sites, regardless of how and which
     bits in a field each call site actually accesses.

  2. The existing code does not need to be modified (although READ_ONCE()
     may still be advisable if we cannot prove that the data race is
     always safe).

  3. We catch bugs where the exclusive bits are modified concurrently.

  4. We document properties of the current code.

Acked-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Qian Cai <cai@lca.pw>
---
 include/linux/kcsan-checks.h | 69 +++++++++++++++++++++++++++++++----
 kernel/kcsan/debugfs.c       | 15 +++++++-
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 4ef5233..8f9f6e2 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -152,9 +152,9 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #endif
 
 /**
- * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
+ * ASSERT_EXCLUSIVE_WRITER - assert no concurrent writes to @var
  *
- * Assert that there are no other threads writing @var; other readers are
+ * Assert that there are no concurrent writes to @var; other readers are
  * allowed. This assertion can be used to specify properties of concurrent code,
  * where violation cannot be detected as a normal data race.
  *
@@ -171,11 +171,11 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
 
 /**
- * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
+ * ASSERT_EXCLUSIVE_ACCESS - assert no concurrent accesses to @var
  *
- * Assert that no other thread is accessing @var (no readers nor writers). This
- * assertion can be used to specify properties of concurrent code, where
- * violation cannot be detected as a normal data race.
+ * Assert that there are no concurrent accesses to @var (no readers nor
+ * writers). This assertion can be used to specify properties of concurrent
+ * code, where violation cannot be detected as a normal data race.
  *
  * For example, in a reference-counting algorithm where exclusive access is
  * expected after the refcount reaches 0. We can check that this property
@@ -191,4 +191,61 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
 
+/**
+ * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
+ *
+ * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER(var).
+ *
+ * Assert that there are no concurrent writes to a subset of bits in @var;
+ * concurrent readers are permitted. This assertion captures more detailed
+ * bit-level properties, compared to the other (word granularity) assertions.
+ * Only the bits set in @mask are checked for concurrent modifications, while
+ * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~@mask bits
+ * are ignored.
+ *
+ * Use this for variables, where some bits must not be modified concurrently,
+ * yet other bits are expected to be modified concurrently.
+ *
+ * For example, variables where, after initialization, some bits are read-only,
+ * but other bits may still be modified concurrently. A reader may wish to
+ * assert that this is true as follows:
+ *
+ *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
+ *	foo = (READ_ONCE(flags) & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
+ *
+ *   Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is
+ *   assumed to access the masked bits only, and KCSAN optimistically assumes it
+ *   is therefore safe, even in the presence of data races, and marking it with
+ *   READ_ONCE() is optional from KCSAN's point-of-view. We caution, however,
+ *   that it may still be advisable to do so, since we cannot reason about all
+ *   compiler optimizations when it comes to bit manipulations (on the reader
+ *   and writer side). If you are sure nothing can go wrong, we can write the
+ *   above simply as:
+ *
+ *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
+ *	foo = (flags & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
+ *
+ * Another example, where this may be used, is when certain bits of @var may
+ * only be modified when holding the appropriate lock, but other bits may still
+ * be modified concurrently. Writers, where other bits may change concurrently,
+ * could use the assertion as follows:
+ *
+ *	spin_lock(&foo_lock);
+ *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
+ *	old_flags = READ_ONCE(flags);
+ *	new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
+ *	if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
+ *	spin_unlock(&foo_lock);
+ *
+ * @var variable to assert on
+ * @mask only check for modifications to bits set in @mask
+ */
+#define ASSERT_EXCLUSIVE_BITS(var, mask)                                       \
+	do {                                                                   \
+		kcsan_set_access_mask(mask);                                   \
+		__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT);\
+		kcsan_set_access_mask(0);                                      \
+		kcsan_atomic_next(1);                                          \
+	} while (0)
+
 #endif /* _LINUX_KCSAN_CHECKS_H */
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 9bbba0e..2ff1961 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -100,8 +100,10 @@ static noinline void microbenchmark(unsigned long iters)
  * debugfs file from multiple tasks to generate real conflicts and show reports.
  */
 static long test_dummy;
+static long test_flags;
 static noinline void test_thread(unsigned long iters)
 {
+	const long CHANGE_BITS = 0xff00ff00ff00ff00L;
 	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
 	cycles_t cycles;
 
@@ -109,16 +111,27 @@ static noinline void test_thread(unsigned long iters)
 	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
 
 	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+	pr_info("test_dummy@%px, test_flags@%px\n", &test_dummy, &test_flags);
 
 	cycles = get_cycles();
 	while (iters--) {
+		/* These all should generate reports. */
 		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
-		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
 		ASSERT_EXCLUSIVE_WRITER(test_dummy);
 		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
 
+		ASSERT_EXCLUSIVE_BITS(test_flags, ~CHANGE_BITS); /* no report */
+		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
+
+		ASSERT_EXCLUSIVE_BITS(test_flags, CHANGE_BITS); /* report */
+		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
+
 		/* not actually instrumented */
 		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
+		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
+
+		test_flags ^= CHANGE_BITS; /* generate value-change */
+		__kcsan_check_write(&test_flags, sizeof(test_flags));
 	}
 	cycles = get_cycles() - cycles;
 
