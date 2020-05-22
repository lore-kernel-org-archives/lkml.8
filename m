Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8AAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2450120723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEVQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgEVQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:08:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716DC061A0E;
        Fri, 22 May 2020 09:08:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcAE4-0000Au-OW; Fri, 22 May 2020 18:08:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CD341C0095;
        Fri, 22 May 2020 18:08:48 +0200 (CEST)
Date:   Fri, 22 May 2020 16:08:48 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Support distinguishing volatile accesses
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521142047.169334-4-elver@google.com>
References: <20200521142047.169334-4-elver@google.com>
MIME-Version: 1.0
Message-ID: <159016372833.17951.9917625724796055665.tip-bot2@tip-bot2>
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

Commit-ID:     4e23395b9e97562d12b87a330a2fca3bf10c8663
Gitweb:        https://git.kernel.org/tip/4e23395b9e97562d12b87a330a2fca3bf10c8663
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 21 May 2020 16:20:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 14:46:02 +02:00

kcsan: Support distinguishing volatile accesses

In the kernel, the "volatile" keyword is used in various concurrent
contexts, whether in low-level synchronization primitives or for
legacy reasons. If supported by the compiler, it will be assumed
that aligned volatile accesses up to sizeof(long long) (matching
compiletime_assert_rwonce_type()) are atomic.

Recent versions of Clang [1] (GCC tentative [2]) can instrument
volatile accesses differently. Add the option (required) to enable the
instrumentation, and provide the necessary runtime functions. None of
the updated compilers are widely available yet (Clang 11 will be the
first release to support the feature).

[1] https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be361137efd705e05814
[2] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html

This change allows removing of any explicit checks in primitives such as
READ_ONCE() and WRITE_ONCE().

 [ bp: Massage commit message a bit. ]

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200521142047.169334-4-elver@google.com
---
 kernel/kcsan/core.c    | 43 +++++++++++++++++++++++++++++++++++++++++-
 scripts/Makefile.kcsan |  5 ++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index a73a66c..15f6794 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -790,6 +790,49 @@ void __tsan_write_range(void *ptr, size_t size)
 EXPORT_SYMBOL(__tsan_write_range);
 
 /*
+ * Use of explicit volatile is generally disallowed [1], however, volatile is
+ * still used in various concurrent context, whether in low-level
+ * synchronization primitives or for legacy reasons.
+ * [1] https://lwn.net/Articles/233479/
+ *
+ * We only consider volatile accesses atomic if they are aligned and would pass
+ * the size-check of compiletime_assert_rwonce_type().
+ */
+#define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
+	void __tsan_volatile_read##size(void *ptr)                             \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
+	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
+		__alias(__tsan_volatile_read##size);                           \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
+	void __tsan_volatile_write##size(void *ptr)                            \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size,                                        \
+			     KCSAN_ACCESS_WRITE |                              \
+				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
+	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
+		__alias(__tsan_volatile_write##size);                          \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
+
+DEFINE_TSAN_VOLATILE_READ_WRITE(1);
+DEFINE_TSAN_VOLATILE_READ_WRITE(2);
+DEFINE_TSAN_VOLATILE_READ_WRITE(4);
+DEFINE_TSAN_VOLATILE_READ_WRITE(8);
+DEFINE_TSAN_VOLATILE_READ_WRITE(16);
+
+/*
  * The below are not required by KCSAN, but can still be emitted by the
  * compiler.
  */
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 20337a7..75d2942 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -9,7 +9,10 @@ else
 cc-param = --param -$(1)
 endif
 
+# Keep most options here optional, to allow enabling more compilers if absence
+# of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
-	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls)
+	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
