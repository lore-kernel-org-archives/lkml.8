Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9552073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWDXFnBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHJIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:06:32 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E151C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:06:32 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z7so3892577wrw.21
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GRkzPey+vf5ZdYTLVvZRABQWI4Soo5smNIo1Ur+XGto=;
        b=lWDXFnBxku0QUcNbWf8j7awXHg984fXj+EcKbYgW19TmbAiUCqhRaOO2OP6lB1jCOA
         OoDczs6Z41oZ0WAAd0EtiK5PK8sQYNwBe/2QqyqMVbkLrtRpdYjUP8wraYm8WRIk55TT
         GNYLcfz+wmU6kkfzA1vmGWTlgdM5NL39FmX57qJMxUYgIot4Wwvx2gGaTVTf/BBOln5Y
         9Rk+kG/ztfaG3TD4SC6JoawXFzvm+6sV4kpDgJRZykblUJIZew7InbR1B10cOZ44IfhV
         njrSo6UDwrpRwbCHa/SvQBuGHHk0JfFwiyoYWN4MbOxAgbw1ChZ31h5Hkva36ioIvphi
         aPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GRkzPey+vf5ZdYTLVvZRABQWI4Soo5smNIo1Ur+XGto=;
        b=Wm+pcXW2aqZ0EQTFM1gBkY90weXd6yu/Olm6ADswHrdT3HjoGb838KUYdl1MR5ZWAh
         qGjJ1I8rftLALNQhkuudfVKn/Lpd3metdqYAz6yPIU0w1mCUQyAxLWaWQzUod47G+cWB
         zBtRDIUEr1ZZOLRFc3tLpzsLazACnhN5UHnnw7wqidiQS6Mcm9YRqgITEzsnrJzwrhPu
         edw5xXJFMFkVUanEj5jAt8DAFQbYFj80mgEn38t7UkyY1pRzTNJXauwOXW7IApEqR/ns
         RvtIXoCCvKGxYAnH1mhiRZqiJMjN3gBswtvFRoCSN4v5lVkgKA/z4fpxZ5bEjPo75+SC
         ciwQ==
X-Gm-Message-State: AOAM532iyZapjb//WUd2lYUji/EDXXIND82yQKBgiZN1LKg5mHGVqmFw
        nMNbuuCWKb9UtjNOraow7tAjscMBWg==
X-Google-Smtp-Source: ABdhPJwOFzpwjBFL3nu4o6K35h5hk1430zzjcvlUb5Ppzl0JaN9hlUFZGaA2g2taWEArip6MlgpD8wDwEQ==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr24640106wmb.67.1597046790842;
 Mon, 10 Aug 2020 01:06:30 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:06:25 +0200
Message-Id: <20200810080625.1428045-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH] kcsan: Optimize debugfs stats counters
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kcsan_counter_inc/dec() functions, as they perform no other
logic, and are no longer needed.

This avoids several calls in kcsan_setup_watchpoint() and
kcsan_found_watchpoint(), as well as lets the compiler warn us about
potential out-of-bounds accesses as the array's size is known at all
usage sites at compile-time.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c    | 22 +++++++++++-----------
 kernel/kcsan/debugfs.c | 21 +++++----------------
 kernel/kcsan/kcsan.h   | 12 ++++++------
 kernel/kcsan/report.c  |  2 +-
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 23d0c4e4cd3a..c3b19e4a089a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -351,13 +351,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 		 * already removed the watchpoint, or another thread consumed
 		 * the watchpoint before this thread.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_REPORT_RACES]);
 	}
 
 	if ((type & KCSAN_ACCESS_ASSERT) != 0)
-		kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 	else
-		kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_DATA_RACES]);
 
 	user_access_restore(flags);
 }
@@ -398,7 +398,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 
 	if (!check_encodable((unsigned long)ptr, size)) {
-		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_UNENCODABLE_ACCESSES]);
 		goto out;
 	}
 
@@ -413,12 +413,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * with which should_watch() returns true should be tweaked so
 		 * that this case happens very rarely.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_NO_CAPACITY);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_NO_CAPACITY]);
 		goto out_unlock;
 	}
 
-	kcsan_counter_inc(KCSAN_COUNTER_SETUP_WATCHPOINTS);
-	kcsan_counter_inc(KCSAN_COUNTER_USED_WATCHPOINTS);
+	atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_SETUP_WATCHPOINTS]);
+	atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
 
 	/*
 	 * Read the current value, to later check and infer a race if the data
@@ -520,16 +520,16 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		 * increment this counter.
 		 */
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
-			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
 			     watchpoint - watchpoints);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
 
-		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN]);
 		if (is_assert)
-			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+			atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ASSERT_FAILURES]);
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
@@ -542,7 +542,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * reused after this point.
 	 */
 	remove_watchpoint(watchpoint);
-	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
+	atomic_long_dec(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
 		raw_local_irq_restore(irq_flags);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 6c4914fa2fad..3c8093a371b1 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -17,10 +17,7 @@
 
 #include "kcsan.h"
 
-/*
- * Statistics counters.
- */
-static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+atomic_long_t kcsan_counters[KCSAN_COUNTER_COUNT];
 static const char *const counter_names[] = {
 	[KCSAN_COUNTER_USED_WATCHPOINTS]		= "used_watchpoints",
 	[KCSAN_COUNTER_SETUP_WATCHPOINTS]		= "setup_watchpoints",
@@ -53,16 +50,6 @@ static struct {
 };
 static DEFINE_SPINLOCK(report_filterlist_lock);
 
-void kcsan_counter_inc(enum kcsan_counter_id id)
-{
-	atomic_long_inc(&counters[id]);
-}
-
-void kcsan_counter_dec(enum kcsan_counter_id id)
-{
-	atomic_long_dec(&counters[id]);
-}
-
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
  * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
@@ -206,8 +193,10 @@ static int show_info(struct seq_file *file, void *v)
 
 	/* show stats */
 	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
-	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
-		seq_printf(file, "%s: %ld\n", counter_names[i], atomic_long_read(&counters[i]));
+	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i) {
+		seq_printf(file, "%s: %ld\n", counter_names[i],
+			   atomic_long_read(&kcsan_counters[i]));
+	}
 
 	/* show filter functions, and filter type */
 	spin_lock_irqsave(&report_filterlist_lock, flags);
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 763d6d08d94b..7619c245e080 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -8,6 +8,7 @@
 #ifndef _KERNEL_KCSAN_KCSAN_H
 #define _KERNEL_KCSAN_KCSAN_H
 
+#include <linux/atomic.h>
 #include <linux/kcsan.h>
 
 /* The number of adjacent watchpoints to check. */
@@ -27,6 +28,10 @@ extern bool kcsan_enabled;
  */
 void kcsan_debugfs_init(void);
 
+/*
+ * Statistics counters displayed via debugfs; should only be modified in
+ * slow-paths.
+ */
 enum kcsan_counter_id {
 	/*
 	 * Number of watchpoints currently in use.
@@ -79,12 +84,7 @@ enum kcsan_counter_id {
 
 	KCSAN_COUNTER_COUNT, /* number of counters */
 };
-
-/*
- * Increment/decrement counter with given id; avoid calling these in fast-path.
- */
-extern void kcsan_counter_inc(enum kcsan_counter_id id);
-extern void kcsan_counter_dec(enum kcsan_counter_id id);
+extern atomic_long_t kcsan_counters[KCSAN_COUNTER_COUNT];
 
 /*
  * Returns true if data races in the function symbol that maps to func_addr
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 15add93ff12e..3add0d9b252c 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -556,7 +556,7 @@ static bool prepare_report_consumer(unsigned long *flags,
 		 * If the actual accesses to not match, this was a false
 		 * positive due to watchpoint encoding.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ENCODING_FALSE_POSITIVES]);
 		goto discard;
 	}
 
-- 
2.28.0.236.gb10cc79966-goog

