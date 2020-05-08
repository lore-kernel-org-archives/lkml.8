Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF35C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6249208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEHNrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgEHNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02CFC05BD43;
        Fri,  8 May 2020 06:46:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kr-0001nn-NM; Fri, 08 May 2020 15:46:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 268571C04CD;
        Fri,  8 May 2020 15:46:36 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:36 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Update API documentation in kcsan-checks.h
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559607.8414.2896424559533886809.tip-bot2@tip-bot2>
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

Commit-ID:     1443b8c9e712ef8914a2cab9ae7ce133229ed96c
Gitweb:        https://git.kernel.org/tip/1443b8c9e712ef8914a2cab9ae7ce133229ed96c
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 05 Mar 2020 15:21:09 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 25 Mar 2020 09:56:00 -07:00

kcsan: Update API documentation in kcsan-checks.h

Update the API documentation for ASSERT_EXCLUSIVE_* macros and make them
generate readable documentation for the code examples.

All @variable short summaries were missing ':', which was updated for
the whole file.

Tested with "make htmldocs".

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 98 +++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 8f9f6e2..3cd8bb0 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -26,9 +26,9 @@
 /**
  * __kcsan_check_access - check generic access for races
  *
- * @ptr address of access
- * @size size of access
- * @type access type modifier
+ * @ptr: address of access
+ * @size: size of access
+ * @type: access type modifier
  */
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
@@ -64,7 +64,7 @@ void kcsan_flat_atomic_end(void);
  * Force treating the next n memory accesses for the current context as atomic
  * operations.
  *
- * @n number of following memory accesses to treat as atomic.
+ * @n: number of following memory accesses to treat as atomic.
  */
 void kcsan_atomic_next(int n);
 
@@ -74,7 +74,7 @@ void kcsan_atomic_next(int n);
  * Set the access mask for all accesses for the current context if non-zero.
  * Only value changes to bits set in the mask will be reported.
  *
- * @mask bitmask
+ * @mask: bitmask
  */
 void kcsan_set_access_mask(unsigned long mask);
 
@@ -106,16 +106,16 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 /**
  * __kcsan_check_read - check regular read access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
 
 /**
  * __kcsan_check_write - check regular write access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define __kcsan_check_write(ptr, size)                                         \
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
@@ -123,16 +123,16 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 /**
  * kcsan_check_read - check regular read access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
 
 /**
  * kcsan_check_write - check regular write access for races
  *
- * @ptr address of access
- * @size size of access
+ * @ptr: address of access
+ * @size: size of access
  */
 #define kcsan_check_write(ptr, size)                                           \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
@@ -158,14 +158,26 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * allowed. This assertion can be used to specify properties of concurrent code,
  * where violation cannot be detected as a normal data race.
  *
- * For example, if a per-CPU variable is only meant to be written by a single
- * CPU, but may be read from other CPUs; in this case, reads and writes must be
- * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
- * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
- * race condition. Using this macro allows specifying this property in the code
- * and catch such bugs.
+ * For example, if we only have a single writer, but multiple concurrent
+ * readers, to avoid data races, all these accesses must be marked; even
+ * concurrent marked writes racing with the single writer are bugs.
+ * Unfortunately, due to being marked, they are no longer data races. For cases
+ * like these, we can use the macro as follows:
  *
- * @var variable to assert on
+ * .. code-block:: c
+ *
+ *	void writer(void) {
+ *		spin_lock(&update_foo_lock);
+ *		ASSERT_EXCLUSIVE_WRITER(shared_foo);
+ *		WRITE_ONCE(shared_foo, ...);
+ *		spin_unlock(&update_foo_lock);
+ *	}
+ *	void reader(void) {
+ *		// update_foo_lock does not need to be held!
+ *		... = READ_ONCE(shared_foo);
+ *	}
+ *
+ * @var: variable to assert on
  */
 #define ASSERT_EXCLUSIVE_WRITER(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
@@ -177,16 +189,22 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * writers). This assertion can be used to specify properties of concurrent
  * code, where violation cannot be detected as a normal data race.
  *
- * For example, in a reference-counting algorithm where exclusive access is
- * expected after the refcount reaches 0. We can check that this property
- * actually holds as follows:
+ * For example, where exclusive access is expected after determining no other
+ * users of an object are left, but the object is not actually freed. We can
+ * check that this property actually holds as follows:
+ *
+ * .. code-block:: c
  *
  *	if (refcount_dec_and_test(&obj->refcnt)) {
  *		ASSERT_EXCLUSIVE_ACCESS(*obj);
- *		safely_dispose_of(obj);
+ *		do_some_cleanup(obj);
+ *		release_for_reuse(obj);
  *	}
  *
- * @var variable to assert on
+ * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
+ * fit to detect use-after-free bugs.
+ *
+ * @var: variable to assert on
  */
 #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
 	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
@@ -200,7 +218,7 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * concurrent readers are permitted. This assertion captures more detailed
  * bit-level properties, compared to the other (word granularity) assertions.
  * Only the bits set in @mask are checked for concurrent modifications, while
- * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~@mask bits
+ * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~mask bits
  * are ignored.
  *
  * Use this for variables, where some bits must not be modified concurrently,
@@ -210,17 +228,21 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * but other bits may still be modified concurrently. A reader may wish to
  * assert that this is true as follows:
  *
+ * .. code-block:: c
+ *
  *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
  *	foo = (READ_ONCE(flags) & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
  *
- *   Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is
- *   assumed to access the masked bits only, and KCSAN optimistically assumes it
- *   is therefore safe, even in the presence of data races, and marking it with
- *   READ_ONCE() is optional from KCSAN's point-of-view. We caution, however,
- *   that it may still be advisable to do so, since we cannot reason about all
- *   compiler optimizations when it comes to bit manipulations (on the reader
- *   and writer side). If you are sure nothing can go wrong, we can write the
- *   above simply as:
+ * Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is assumed
+ * to access the masked bits only, and KCSAN optimistically assumes it is
+ * therefore safe, even in the presence of data races, and marking it with
+ * READ_ONCE() is optional from KCSAN's point-of-view. We caution, however, that
+ * it may still be advisable to do so, since we cannot reason about all compiler
+ * optimizations when it comes to bit manipulations (on the reader and writer
+ * side). If you are sure nothing can go wrong, we can write the above simply
+ * as:
+ *
+ * .. code-block:: c
  *
  *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
  *	foo = (flags & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
@@ -230,15 +252,17 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
  * be modified concurrently. Writers, where other bits may change concurrently,
  * could use the assertion as follows:
  *
+ * .. code-block:: c
+ *
  *	spin_lock(&foo_lock);
  *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
- *	old_flags = READ_ONCE(flags);
+ *	old_flags = flags;
  *	new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
  *	if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
  *	spin_unlock(&foo_lock);
  *
- * @var variable to assert on
- * @mask only check for modifications to bits set in @mask
+ * @var: variable to assert on
+ * @mask: only check for modifications to bits set in @mask
  */
 #define ASSERT_EXCLUSIVE_BITS(var, mask)                                       \
 	do {                                                                   \
