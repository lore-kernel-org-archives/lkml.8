Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2EAC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E293920848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kgp0g39R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgBKQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:06:04 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:35113 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbgBKQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:06:03 -0500
Received: by mail-vk1-f202.google.com with SMTP id e25so3637125vkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2lszCI7b1dFvBYcYwKVuzOflaaeTIqON317waSS3RBU=;
        b=Kgp0g39R/8I5OizbrigGD2uhf+p0x/4OlNacqu0rRFK0PJetxIlNTWsvxUnHWScfCw
         Ow+zoM47HoYPY1r6Cb/8XqjXcIVp0VEoVe8/cT6mX9LlOy2h0F5k0vKN7LWR9luPvqIR
         VN1jRiJK9B/xmrmFxI/mfojFIa53JYc8YPhsH9xO4nAEI34MuZqj1rGKVug+qMRa4j9E
         dtvwuhX3hktgZX2Lym1PPF4jmCgkMos6fZiPdlDn37yPxi+GK9hncVgU6E8SkRMafOBT
         USXr9SzX27k/ms4NS+qylIBO+v9EtbcXPAIYLD0Sj9s1bT/XmEk/KxUYwTtnbzQOr7ok
         +JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2lszCI7b1dFvBYcYwKVuzOflaaeTIqON317waSS3RBU=;
        b=dclTLtHQUKE+kvFJIWx2/+8sXHHBriodO3kWhYJsSK7NQYticXJdNdvB6QdciNqho9
         9FryQSwa1U/iMbaWOnE0XChQY1gmB3O0zKQ3BQPQVaxFCeX8xOV6slO7tIy5DY2V4L0j
         U6RNs4b6olgoXDCrCEoBIpyMqYNgfr5YslOXDuVRhEmECltTi23kcTYUvh72SZqUfY42
         mz0p2dCnYyLBw0PcGsMxvAOvnuAf06ArJUI0XrDxrjA117pWxSRHuGwJlb7OP04BReLo
         6vWCJt3oKtcwxYTQlOztY6DcJr2gOUItJc9C65Txbou9D5eexGh+OX21/oC9EUMvsGfY
         oYOA==
X-Gm-Message-State: APjAAAWiweVZbsKc63tpWTpoc7yJq8E/SGHf3b+nYCZh3SAh5ACy8pnh
        7qxrVIpx0yT0E/5hC3Xc2GCO4ZvCww==
X-Google-Smtp-Source: APXvYqzJTPKd8JKXuA1w1yH831mE7qFGQggUTfudp6GF9nO8UgD2sgqsMMDjnMG0zHsGWRYBmbGL5jkP7g==
X-Received: by 2002:ac5:c844:: with SMTP id g4mr5107364vkm.25.1581437161869;
 Tue, 11 Feb 2020 08:06:01 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:04:23 +0100
In-Reply-To: <20200211160423.138870-1-elver@google.com>
Message-Id: <20200211160423.138870-5-elver@google.com>
Mime-Version: 1.0
References: <20200211160423.138870-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Qian Cai <cai@lca.pw>
---
v2:
* Update API documentation to be clearer about how this compares to the
  existing assertions, and update use-cases. [Based on suggestions from
  John Hubbard]
* Update commit message. [Suggestions from John Hubbard]
---
 include/linux/kcsan-checks.h | 69 ++++++++++++++++++++++++++++++++----
 kernel/kcsan/debugfs.c       | 15 +++++++-
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 4ef5233ff3f04..1b8aac5d6a0b5 100644
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
+ * 	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
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
index 9bbba0e57c9b3..2ff1961239778 100644
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
 
-- 
2.25.0.225.g125e21ebc7-goog

