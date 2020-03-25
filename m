Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF41C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078B72073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyrqcL2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCYQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:42:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45426 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYQmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:42:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id e11so2134490qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m4FmRkj8j7tARDEb0nuSvSohZqoEFWL11PIMBnp/yZI=;
        b=IyrqcL2WlHCRbiwtdAt8A0BaK2PZKVnJMxRzNlR8KiGxPOO38MVB/sarqImyaI/ITH
         p+TrQFLTn5VW95ksT8V4pQA5wiEyFtDrTuWFZtVBjp04MaNQu9rQXmAsGY/6RYg/Svri
         CIpbfwYfe4H1xNZwvlKDU6zM6I8DDDrJ6JAKdkxZBEHVtCkVhpnMVZZKQbqh3gjLfaJf
         eO/TsFS+oBIf4uCWZrz+AD28Y2KYHYiWqyHKeeFCYJnR0TUGnX0aJsY18F0RqZVDpdKx
         Cp3Cd0+HMI5t0pnEfKCSlEDwGNs1ykk5AfbcMnZSReUmU1EXlWbd15DfzZwFScXUddI7
         Dthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m4FmRkj8j7tARDEb0nuSvSohZqoEFWL11PIMBnp/yZI=;
        b=TDLM6taqSOXYkDo6yEQ3NdDPFZyt5HpFi1Y5j5a+pDfbVkdBUDMSBNb0q9kGytvSR3
         cmmOYLfNc8oH29JUk7KpPA/5UbwNaBcexYCQXsA1271THEUHdjL+CaLZQVF4N+vWyT46
         96L/yhA9lrZcrbQ6g7XdKC6uvz0qApKlalsWPOuxQLrTwA1gfNwqmIiFq+pO4yNkgdk7
         3cj4gPooufGK/uefyEmFClTvd6c+OujhADcE2/1/FoYbX9e5M3m3iDRYCH9Fx4A1KVV8
         7gXJhd4CGNWtCTanjdQeOaEWI+JDD6u/dBmnRRLwohgNRK7vsLcDBOhUNWApGstpyw1S
         Gjqw==
X-Gm-Message-State: ANhLgQ1CvVPD3U3i9q60wNfhvUuhkfK7c0pQhg46PfTH0it1c5hm67RT
        /yOEVO4o3+NqOB4snVHmAaebC+M3GA==
X-Google-Smtp-Source: ADFU+vsi77HFwwmwQdacNqZBuNesZ/GA6SdpEgEvEVh63HoB3Q7WX1oAc5PlqAmxUCK5Rc+7vU7LCTMphA==
X-Received: by 2002:a37:d0e:: with SMTP id 14mr3902756qkn.310.1585154535926;
 Wed, 25 Mar 2020 09:42:15 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:41:58 +0100
In-Reply-To: <20200325164158.195303-1-elver@google.com>
Message-Id: <20200325164158.195303-3-elver@google.com>
Mime-Version: 1.0
References: <20200325164158.195303-1-elver@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 3/3] kcsan: Introduce scoped ASSERT_EXCLUSIVE macros
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces ASSERT_EXCLUSIVE_*_SCOPED() which provide an intuitive
interface to use the scoped-access feature, without having to explicitly
mark the start and end of the desired scope. Basing duration of the
checks on scope avoids accidental misuse and resulting false positives,
which may be hard to debug. See added comments for usage.

The macros are implemented using __attribute__((__cleanup__(func))),
which is supported by all compilers that currently support KCSAN.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kcsan.rst |  3 +-
 include/linux/kcsan-checks.h      | 73 ++++++++++++++++++++++++++++++-
 kernel/kcsan/debugfs.c            | 16 ++++++-
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 52a5d6fb9701..f4b5766f12cc 100644
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
index b24253d3a442..101df7f46d89 100644
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
@@ -266,10 +321,26 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
 
+/**
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
 /**
  * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
  *
- * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER(var).
+ * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER().
  *
  * Assert that there are no concurrent writes to a subset of bits in @var;
  * concurrent readers are permitted. This assertion captures more detailed
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 72ee188ebc54..1a08664a7fab 100644
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
2.25.1.696.g5e7596f4ac-goog

