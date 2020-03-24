Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A4208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCXJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgCXJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaM-0007V0-FW; Tue, 24 Mar 2020 10:10:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 82DE81C0475;
        Tue, 24 Mar 2020 10:10:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:56 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Add test to generate conflicts via debugfs
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105622.28353.4207063450407939838.tip-bot2@tip-bot2>
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

Commit-ID:     a312013578e4775003689e31c1f487df11f362a3
Gitweb:        https://git.kernel.org/tip/a312013578e4775003689e31c1f487df11f362a3
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 06 Feb 2020 16:46:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:43:30 +01:00

kcsan: Add test to generate conflicts via debugfs

Add 'test=<iters>' option to KCSAN's debugfs interface to invoke KCSAN
checks on a dummy variable. By writing 'test=<iters>' to the debugfs
file from multiple tasks, we can generate real conflicts, and trigger
data race reports.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kcsan/debugfs.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index a9dad44..9bbba0e 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -69,9 +70,9 @@ void kcsan_counter_dec(enum kcsan_counter_id id)
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
  * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
- * debugfs file.
+ * debugfs file. This will not generate any conflicts, and tests fast-path only.
  */
-static void microbenchmark(unsigned long iters)
+static noinline void microbenchmark(unsigned long iters)
 {
 	cycles_t cycles;
 
@@ -81,18 +82,52 @@ static void microbenchmark(unsigned long iters)
 	while (iters--) {
 		/*
 		 * We can run this benchmark from multiple tasks; this address
-		 * calculation increases likelyhood of some accesses overlapping
-		 * (they still won't conflict because all are reads).
+		 * calculation increases likelyhood of some accesses
+		 * overlapping. Make the access type an atomic read, to never
+		 * set up watchpoints and test the fast-path only.
 		 */
 		unsigned long addr =
 			iters % (CONFIG_KCSAN_NUM_WATCHPOINTS * PAGE_SIZE);
-		__kcsan_check_read((void *)addr, sizeof(long));
+		__kcsan_check_access((void *)addr, sizeof(long), KCSAN_ACCESS_ATOMIC);
 	}
 	cycles = get_cycles() - cycles;
 
 	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
 }
 
+/*
+ * Simple test to create conflicting accesses. Write 'test=<iters>' to KCSAN's
+ * debugfs file from multiple tasks to generate real conflicts and show reports.
+ */
+static long test_dummy;
+static noinline void test_thread(unsigned long iters)
+{
+	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
+	cycles_t cycles;
+
+	/* We may have been called from an atomic region; reset context. */
+	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
+
+	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+
+	cycles = get_cycles();
+	while (iters--) {
+		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
+		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
+		ASSERT_EXCLUSIVE_WRITER(test_dummy);
+		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
+
+		/* not actually instrumented */
+		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
+	}
+	cycles = get_cycles() - cycles;
+
+	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+
+	/* restore context */
+	current->kcsan_ctx = ctx_save;
+}
+
 static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
 {
 	const unsigned long a = *(const unsigned long *)rhs;
@@ -242,6 +277,12 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
+	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+		unsigned long iters;
+
+		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+			return -EINVAL;
+		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
 		set_report_filterlist_whitelist(true);
 	} else if (!strcmp(arg, "blacklist")) {
