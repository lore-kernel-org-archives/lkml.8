Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056EC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50D22314
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHYYBpDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDRVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:21:36 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:39764 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgBDRVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:21:35 -0500
Received: by mail-wr1-f74.google.com with SMTP id 90so10619113wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kiVUGxEhpAM2mYb96Fzo4yFVjkxMzxjZ34CLdXp6/BA=;
        b=iHYYBpDM23i8xlqcLxsIInOL/fqAzMaeDrcrX4teRPxJARTrbtVRCjGDA/gJgAfL4h
         MZ2dhjnjrSYp3sUY6gx9I1627RNY8IbJ4IJ1GWmtv6+lh29Sr2EPC3U/pMVVbsHhYufN
         2xls69TABg/khlp10KcCX+iFuXv5W+Q2DnKCb6993yxYnDsVZKdFGqsTEjVvluo5r+bC
         3eh0S95ih46VU0nI6Z9w8G8qlz9dF1Z1OJ5ohvoBo+AalieLzvDSn5AZbK96HLu/860l
         hh/t43jhf6GF9l8YrQdIZal2wkDszcSI9kHq+4CBGvqAijAasAoTDZdnAsPG3IVszdMz
         NQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kiVUGxEhpAM2mYb96Fzo4yFVjkxMzxjZ34CLdXp6/BA=;
        b=mjg9oMaH9YHluKR24wPxwkKI3NrJRcyXBQ2bN1eF5lFbjG+hn9encmEgYAdMGoNfWU
         +Vcaj7WiS+hJ2JMFAI6qESdLsf5gnkF8nvkIbMvMVg7vbzcKuho5XNwvwcXvUvR5eL4a
         G4soniytuK7ZEBemmVsZnrRF/9jfUhPVCExaIoH9P0+BE0Q9Qc1DzgTzEI647jXoRcqF
         8CqdrQ410Q/L66JZjRZ8nv2E0Zan0RhY+Lx5UF6wmu/FDL/VMqFKOQtRUIYiszdROlz6
         uAF0jJeLLb8v3oAoVZSgji1PvcwVhtC8cCh9ceM2xdFis8/fhqbJi6ji60F+oyY6saHB
         1Sbg==
X-Gm-Message-State: APjAAAVLTlSdstuEBrT6uxso1IXgPDgcEnrV6r9Xrc6ISCsrFYLXmsfx
        wsHal6ongMP1T9caWHdkmQdsXLUbFw==
X-Google-Smtp-Source: APXvYqwWCUDwitvhY0FZCZW08I+x93BnMVM/jpwKglWQ+MNuYP3yhrRh/OyC4AZFFjfHRZlNe7eNv/HqqA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr22040781wri.47.1580836891511;
 Tue, 04 Feb 2020 09:21:31 -0800 (PST)
Date:   Tue,  4 Feb 2020 18:21:10 +0100
Message-Id: <20200204172112.234455-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/3] kcsan: Add option to assume plain aligned writes up to
 word size are atomic
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds option KCSAN_ASSUME_PLAIN_WRITES_ATOMIC. If enabled, plain
aligned writes up to word size are assumed to be atomic, and also not
subject to other unsafe compiler optimizations resulting in data races.

This option has been enabled by default to reflect current kernel-wide
preferences.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Also check for alignment of writes.
---
 kernel/kcsan/core.c | 22 +++++++++++++++++-----
 lib/Kconfig.kcsan   | 27 ++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 64b30f7716a12..e3c7d8f34f2ff 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/random.h>
@@ -169,10 +170,20 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
-static __always_inline bool is_atomic(const volatile void *ptr)
+static __always_inline bool
+is_atomic(const volatile void *ptr, size_t size, int type)
 {
-	struct kcsan_ctx *ctx = get_ctx();
+	struct kcsan_ctx *ctx;
+
+	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
+		return true;
 
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
+	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
+	    IS_ALIGNED((unsigned long)ptr, size))
+		return true; /* Assume aligned writes up to word size are atomic. */
+
+	ctx = get_ctx();
 	if (unlikely(ctx->atomic_next > 0)) {
 		/*
 		 * Because we do not have separate contexts for nested
@@ -193,7 +204,8 @@ static __always_inline bool is_atomic(const volatile void *ptr)
 	return kcsan_is_atomic(ptr);
 }
 
-static __always_inline bool should_watch(const volatile void *ptr, int type)
+static __always_inline bool
+should_watch(const volatile void *ptr, size_t size, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -202,7 +214,7 @@ static __always_inline bool should_watch(const volatile void *ptr, int type)
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if ((type & KCSAN_ACCESS_ATOMIC) != 0 || is_atomic(ptr))
+	if (is_atomic(ptr, size, type))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -460,7 +472,7 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	if (unlikely(watchpoint != NULL))
 		kcsan_found_watchpoint(ptr, size, type, watchpoint,
 				       encoded_watchpoint);
-	else if (unlikely(should_watch(ptr, type)))
+	else if (unlikely(should_watch(ptr, size, type)))
 		kcsan_setup_watchpoint(ptr, size, type);
 }
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3552990abcfe5..66126853dab02 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -91,13 +91,13 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  limiting reporting to avoid flooding the console with reports.
 	  Setting this to 0 disables rate limiting.
 
-# Note that, while some of the below options could be turned into boot
-# parameters, to optimize for the common use-case, we avoid this because: (a)
-# it would impact performance (and we want to avoid static branch for all
-# {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
-# without real benefit. The main purpose of the below options is for use in
-# fuzzer configs to control reported data races, and they are not expected
-# to be switched frequently by a user.
+# The main purpose of the below options is to control reported data races (e.g.
+# in fuzzer configs), and are not expected to be switched frequently by other
+# users. We could turn some of them into boot parameters, but given they should
+# not be switched normally, let's keep them here to simplify configuration.
+#
+# The defaults below are chosen to be very conservative, and may miss certain
+# bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
@@ -116,6 +116,19 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	  the data value of the memory location was observed to remain
 	  unchanged, do not report the data race.
 
+config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
+	bool "Assume that plain aligned writes up to word size are atomic"
+	default y
+	help
+	  Assume that plain aligned writes up to word size are atomic by
+	  default, and also not subject to other unsafe compiler optimizations
+	  resulting in data races. This will cause KCSAN to not report data
+	  races due to conflicts where the only plain accesses are aligned
+	  writes up to word size: conflicts between marked reads and plain
+	  aligned writes up to word size will not be reported as data races;
+	  notice that data races between two conflicting plain aligned writes
+	  will also not be reported.
+
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
 	help
-- 
2.25.0.341.g760bfbb309-goog

