Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D4C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE0208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229776;
	bh=92HF0FimiAJjjuIEmP6wOelaKX1yjJmRhc/i80wKB5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8x9xYIQfxHW7xHqa7SIhqMfAcXXNFq/hlHKaW4c6VlRzk8BtEVYf+lYToazoNbgP
	 eEgvgUt2Jo6tz3SE0cN3zWZAb+yZqBdvB8BA0TPs7uz3g0dmCvXK2BEBlHeAjmnN8J
	 aKIXl8ZbEuDbskJS1TJgw3NyFrxG3V8XP35VkMGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgEKUmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7982078E;
        Mon, 11 May 2020 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229770;
        bh=92HF0FimiAJjjuIEmP6wOelaKX1yjJmRhc/i80wKB5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0BzibzYIsRp4TQxsyRN5IsQWfCgS2nZM3qNGCS/5XMy2IzKBQCQ3gPxhDE6ujVhh
         SF57ISdEONGxql6GEjEyV0DHCd1A4X5jufSyh+nWwEP26iVt9gfW3tHS121X5F+x84
         gRsy0kCh82KU787QAa9bGdBANAsLwjW/Rqg0qXh0=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 11/18] READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
Date:   Mon, 11 May 2020 21:41:43 +0100
Message-Id: <20200511204150.27858-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

{READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
This can be surprising to callers that might incorrectly be expecting
atomicity for accesses to aggregate structures, although there are other
callers where tearing is actually permissable (e.g. if they are using
something akin to sequence locking to protect the access).

Linus sayeth:

  | We could also look at being stricter for the normal READ/WRITE_ONCE(),
  | and require that they are
  |
  | (a) regular integer types
  |
  | (b) fit in an atomic word
  |
  | We actually did (b) for a while, until we noticed that we do it on
  | loff_t's etc and relaxed the rules. But maybe we could have a
  | "non-atomic" version of READ/WRITE_ONCE() that is used for the
  | questionable cases?

The slight snag is that we also have to support 64-bit accesses on 32-bit
architectures, as these appear to be widespread and tend to work out ok
if either the architecture supports atomic 64-bit accesses (armv7) or if
the variable being accessed represents a virtual address and therefore
only requires 32-bit atomicity in practice.

Take a step in that direction by introducing a variant of
'compiletime_assert_atomic_type()' and use it to check the pointer
argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE}_ONCE() variants
which are allowed to tear and convert the one broken caller over to the
new macros.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/xen/time.c       |  2 +-
 include/linux/compiler.h | 40 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859c29d0..108edbcbc040 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -64,7 +64,7 @@ static void xen_get_runstate_snapshot_cpu_delta(
 	do {
 		state_time = get64(&state->state_entry_time);
 		rmb();	/* Hypervisor might update data. */
-		*res = READ_ONCE(*state);
+		*res = __READ_ONCE(*state);
 		rmb();	/* Hypervisor might update data. */
 	} while (get64(&state->state_entry_time) != state_time ||
 		 (state_time & XEN_RUNSTATE_UPDATE));
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index fe739850e7c9..e1b839e42563 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -199,9 +199,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 
-#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
+/*
+ * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+ * atomicity or dependency ordering guarantees. Note that this may result
+ * in tears!
+ */
+#define __READ_ONCE(x)	(*(const volatile typeof(x) *)&(x))
 
-#define READ_ONCE(x)							\
+#define __READ_ONCE_SCALAR(x)						\
 ({									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_read(__xp, sizeof(*__xp));			\
@@ -214,15 +219,32 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	});								\
 })
 
-#define WRITE_ONCE(x, val)						\
+#define READ_ONCE(x)							\
+({									\
+	compiletime_assert_rwonce_type(x);				\
+	__READ_ONCE_SCALAR(x);						\
+})
+
+#define __WRITE_ONCE(x, val)						\
+do {									\
+	*(volatile typeof(x) *)&(x) = (val);				\
+} while (0)
+
+#define __WRITE_ONCE_SCALAR(x, val)					\
 do {									\
 	typeof(x) *__xp = &(x);						\
 	kcsan_check_atomic_write(__xp, sizeof(*__xp));			\
 	__kcsan_disable_current();					\
-	*(volatile typeof(x) *)__xp = (val);				\
+	__WRITE_ONCE(*__xp, val);					\
 	__kcsan_enable_current();					\
 } while (0)
 
+#define WRITE_ONCE(x, val)						\
+do {									\
+	compiletime_assert_rwonce_type(x);				\
+	__WRITE_ONCE_SCALAR(x, val);					\
+} while (0)
+
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address conflicts
@@ -366,6 +388,16 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+/*
+ * Yes, this permits 64-bit accesses on 32-bit architectures. These will
+ * actually be atomic in many cases (namely x86), but for others we rely on
+ * the access being split into 2x32-bit accesses for a 32-bit quantity (e.g.
+ * a virtual address) and a strong prevailing wind.
+ */
+#define compiletime_assert_rwonce_type(t)					\
+	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
+		"Unsupported access size for {READ,WRITE}_ONCE().")
+
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
-- 
2.26.2.645.ge9eca65c58-goog

