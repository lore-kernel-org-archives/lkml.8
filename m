Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C82C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5B920715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB5OY1dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBJSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:43:46 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:32795 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBJSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:43:44 -0500
Received: by mail-wr1-f73.google.com with SMTP id z15so5510738wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ekjMPPG/6GfXWp+1AYZk+dASF82ToWENMAHOLhIQ8HA=;
        b=sB5OY1dUAY6w/DOaHiBN/NQh34OPaV1v03DnsVr0fNUOrqK5ZedcOBq06BqHZNa4pn
         d8cVPVDTeqnZl9PN889u7727UEzxPphAb449mGGzTgfzzPhdF/dPfTAvgefJat21XIyR
         uk93ukqE9pWNtGFUoHejIXQaRp3sB6Dd04b2HxMNj1+T9Cecl+o2UeYURuJ2I9vi9Sgq
         4/msxHBgRwKD/nMJEqlzhCrAtHn3uyB22dhf+N2yz6Jcj9fu1wNMwcj8YUjhuZ8Pb84L
         5MY9towVbKOSdUasFDSuIl9iLOwdHUNca9xW6HV0Ep0fOWZIxNSXMEVKfEYVtRgSPI0w
         HUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ekjMPPG/6GfXWp+1AYZk+dASF82ToWENMAHOLhIQ8HA=;
        b=G4fPH0kIfHZcp/M6MuDowqk4nGyBIL94oT19ZECYEoCTiNol4zI7DdgKCl07mqFk+i
         ii+C3i9OyaATAQcbNmEMRAytvxxTAe+NvxHWGOAE4fkC4gBc4C37XVQTuQcp8m2SA+m5
         qes3n1wtWOuC8NiTHCZn7iNQcbAO257TD7a2rXfHPH/HkgshXdpzRpns9vgwsUeIpmqS
         TIhOT+N6vanrsUDqgMI+UDrKnarGg1ObLUz2a+kqUgdxJNaNqRbqwsyfSZunBKYFkoIW
         IhLpilZKOu03iig6myNrFWlfwVFhCCR8e21YGUfRQyyMXINvAy/lXtgfPQmjVtCE3krZ
         VlTQ==
X-Gm-Message-State: APjAAAVHHt/E5zsaSHoUO1weSZp6wZ6/VmRgGauDDedK07xpIk0F8EI4
        HIJatuQ1U6/Aio1Uv3tf9r7rQz9JLg==
X-Google-Smtp-Source: APXvYqyVuBGG5ZkyvwzvcqaEpNIc1NCbRuLRrZa7Vu1WNCvBXB2zQx15k6Hg5syLYFuUINoWWsz6LyPPNw==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr3276542wrt.253.1581360221843;
 Mon, 10 Feb 2020 10:43:41 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:43:17 +0100
In-Reply-To: <20200210184317.233039-1-elver@google.com>
Message-Id: <20200210184317.233039-5-elver@google.com>
Mime-Version: 1.0
References: <20200210184317.233039-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
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

In particular, data races between reads (that use @mask bits of an
access that should not be modified concurrently) and writes (that change
~@mask bits not used by the read) should ordinarily be marked. After
marking these, we would no longer be able to detect harmful races
between reads to @mask bits and writes to @mask bits.

Therefore, by using ASSERT_EXCLUSIVE_BITS(var, mask), we accomplish:

  1. No new macros introduced elsewhere; since there are numerous ways in
     which we can extract the same bits, a one-size-fits-all macro is
     less preferred.

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
 include/linux/kcsan-checks.h | 57 ++++++++++++++++++++++++++++++++----
 kernel/kcsan/debugfs.c       | 15 +++++++++-
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 4ef5233ff3f04..eae6030cd4348 100644
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
@@ -191,4 +191,49 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
 
+/**
+ * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
+ *
+ * [Bit-granular variant of ASSERT_EXCLUSIVE_WRITER(var)]
+ *
+ * Assert that there are no concurrent writes to a subset of bits in @var;
+ * concurrent readers are permitted. Concurrent writes (or reads) to ~@mask bits
+ * are ignored. This assertion can be used to specify properties of concurrent
+ * code, where marked accesses imply violations cannot be detected as a normal
+ * data race.
+ *
+ * For example, this may be used when certain bits of @var may only be modified
+ * when holding the appropriate lock, but other bits may still be modified
+ * concurrently. Writers, where other bits may change concurrently, could use
+ * the assertion as follows:
+ *
+ *	spin_lock(&foo_lock);
+ *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
+ *	old_flags = READ_ONCE(flags);
+ *	new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
+ *	if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
+ *	spin_unlock(&foo_lock);
+ *
+ * Readers, could use it as follows:
+ *
+ *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
+ *	foo = (READ_ONCE(flags) & FOO_MASK) >> FOO_SHIFT;
+ *
+ * NOTE: The access that immediately follows is assumed to access the masked
+ * bits only, and safe w.r.t. data races. While marking this access is optional
+ * from KCSAN's point-of-view, it may still be advisable to do so, since we
+ * cannot reason about all possible compiler optimizations when it comes to bit
+ * manipulations (on the reader and writer side).
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
2.25.0.341.g760bfbb309-goog

