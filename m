Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F40C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0227B208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897977;
	bh=fQELpKvWSu8GuxhvTeoiLr/q0jaGeeTwDu9BtK/GSzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ce4wZEkME6suKNpGvkoVqLQzHuEGYqQZtCw8sGYk2neHJu1s7OM96UIphe2A/h/Vz
	 rTO9+m8XMGSiqvM1Faw2jcz1k4vqJbbxDaS3izM3mROemygItVVAS9lN536SWtwkJD
	 fHiKtATrEKHiPplNqf5IzytVqHFhDQOOd6wHG2Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgHaSTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgHaSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EDE21707;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897889;
        bh=fQELpKvWSu8GuxhvTeoiLr/q0jaGeeTwDu9BtK/GSzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNSS9nUVIswCsEdXJEUfDdS1QbQSCUWvdXfxT6GhIoG084RaCAi0WeXxeJuaWHfFd
         IEgMScbIl4CKyxLC6EEouOhck+rqKcz1wK1bVf+sZhqkXQ5DBqbva4Dc0i5Tjtcfmn
         J6uxNXKOeuCXRUtApOJCSKfbJ770fb3CZSFUIzEk=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 17/19] kcsan: Optimize debugfs stats counters
Date:   Mon, 31 Aug 2020 11:18:03 -0700
Message-Id: <20200831181805.1833-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Remove kcsan_counter_inc/dec() functions, as they perform no other
logic, and are no longer needed.

This avoids several calls in kcsan_setup_watchpoint() and
kcsan_found_watchpoint(), as well as lets the compiler warn us about
potential out-of-bounds accesses as the array's size is known at all
usage sites at compile-time.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c    | 22 +++++++++++-----------
 kernel/kcsan/debugfs.c | 21 +++++----------------
 kernel/kcsan/kcsan.h   | 12 ++++++------
 kernel/kcsan/report.c  |  2 +-
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index b176400..8a1ff605 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -367,13 +367,13 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
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
@@ -414,7 +414,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 
 	if (!check_encodable((unsigned long)ptr, size)) {
-		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_UNENCODABLE_ACCESSES]);
 		goto out;
 	}
 
@@ -434,12 +434,12 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
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
@@ -541,16 +541,16 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
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
@@ -563,7 +563,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * reused after this point.
 	 */
 	remove_watchpoint(watchpoint);
-	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
+	atomic_long_dec(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
 		local_irq_restore(irq_flags);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 6c4914f..3c8093a 100644
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
index 2948001..8d4bf34 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -8,6 +8,7 @@
 #ifndef _KERNEL_KCSAN_KCSAN_H
 #define _KERNEL_KCSAN_KCSAN_H
 
+#include <linux/atomic.h>
 #include <linux/kcsan.h>
 #include <linux/sched.h>
 
@@ -34,6 +35,10 @@ void kcsan_restore_irqtrace(struct task_struct *task);
  */
 void kcsan_debugfs_init(void);
 
+/*
+ * Statistics counters displayed via debugfs; should only be modified in
+ * slow-paths.
+ */
 enum kcsan_counter_id {
 	/*
 	 * Number of watchpoints currently in use.
@@ -86,12 +91,7 @@ enum kcsan_counter_id {
 
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
index bf1d594..d3bf87e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -559,7 +559,7 @@ static bool prepare_report_consumer(unsigned long *flags,
 		 * If the actual accesses to not match, this was a false
 		 * positive due to watchpoint encoding.
 		 */
-		kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_ENCODING_FALSE_POSITIVES]);
 		goto discard;
 	}
 
-- 
2.9.5

