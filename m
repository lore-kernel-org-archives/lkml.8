Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95826C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75360206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgELOhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgELOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:37:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71337C061A0C;
        Tue, 12 May 2020 07:37:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1g-0005oD-RL; Tue, 12 May 2020 16:36:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 576A31C0481;
        Tue, 12 May 2020 16:36:56 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:56 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-12-will@kernel.org>
References: <20200511204150.27858-12-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421627.390.5707699650139698296.tip-bot2@tip-bot2>
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

Commit-ID:     2ab3a0a02905d9994746dc4692c010d47b2beb74
Gitweb:        https://git.kernel.org/tip/2ab3a0a02905d9994746dc4692c010d47b2beb74
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:14 +02:00

READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses

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
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200511204150.27858-12-will@kernel.org

---
 drivers/xen/time.c       |  2 +-
 include/linux/compiler.h | 40 +++++++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 0968859..108edbc 100644
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
index 1b4e64d..733605f 100644
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
@@ -365,6 +387,16 @@ static inline void *offset_to_ptr(const int *off)
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
 
