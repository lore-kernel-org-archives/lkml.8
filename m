Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C80C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4F2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qc/9JiZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBEUoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:44:25 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:49415 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgBEUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:44:24 -0500
Received: by mail-wr1-f74.google.com with SMTP id w6so2075961wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sd30aiJo7Ul/w6KJx1kKYsloupmct0RdFlLDgIoc8Tw=;
        b=Qc/9JiZYKEpzdk3Dv4/p/QZGGKufORf6dG8B4ZMwIrgHIlOhgWo6mrsNtS3vLXR2AY
         058UBjih4aBEqh2Kb4jILoVN0IpeuUtXx3+UJUqjU0/jTXuKeg1dBE9bcMERCeX/7hnU
         TdW6rI7RkI2/rggJIsSq2b2Sq3aO2GBtbwyXrJUhjmDtEnBgCw/AGaFFEVgMITLf0VjP
         7/43Qr+7upe/FvEEanOmws58UdJ6XPOB0u/WqotwosXLsLuM1mIaZze6antxZ5ekbWoD
         DKrgGeBPrwuvwyxYQETG1w4VAy3pWJsKVDXkCywThW/X/T0jnBSv0nzZMw8G6cjMdAEz
         PN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sd30aiJo7Ul/w6KJx1kKYsloupmct0RdFlLDgIoc8Tw=;
        b=UkRvnaFvmZy86bcKpzbO+AmHQSPHKzbT0xRrOSN3git/jKogGfo05UgnGmKKqTEsXg
         v3P/+3vzFIzJyT2JZLqVOP/vpwsNMEtERrsltdEDP/HD/12j8MU6XnnYNS8Kt9etfpG9
         PVHpVLJEQVof+ETPGAvmQzmhupRW2UcSbcGojWJmf220HUujhqLqETs3qoDeHTc9g6kF
         flcxlg226gYodeAfnK9YgnCy5lX91/i5bZ6Y69huawlKxeBKDnzTHkm/qOXU+YIRkauf
         qqNmm5OC4tFjA8enZTIErwedZnfBboPeFLdGT5X+po/WwuTWyu/YPAFT0yIpi8eCjKRY
         pf1Q==
X-Gm-Message-State: APjAAAWeL33haDZEjrrSSf0fbf8RFKoto92zmbQbhwAXzsbw+1ftav0k
        QGz69q4oFapk0wxI9WI3gwhsZr3cNw==
X-Google-Smtp-Source: APXvYqxYnDKV3IJ81UHxXMds5HdOFppglAg9FxSHZMSqaQHX7spZZDGthz2fNWitkFuWnIg4Y/lyYvYnUg==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr345787wrw.31.1580935461105;
 Wed, 05 Feb 2020 12:44:21 -0800 (PST)
Date:   Wed,  5 Feb 2020 21:43:33 +0100
In-Reply-To: <20200205204333.30953-1-elver@google.com>
Message-Id: <20200205204333.30953-3-elver@google.com>
Mime-Version: 1.0
References: <20200205204333.30953-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 3/3] kcsan: Add test to generate conflicts via debugfs
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

Add 'test=<iters>' option to KCSAN's debugfs interface to invoke KCSAN
checks on a dummy variable. By writing 'test=<iters>' to the debugfs
file from multiple tasks, we can generate real conflicts, and trigger
data race reports.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 51 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index bec42dab32ee8..5733f51a6e2c7 100644
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
@@ -68,9 +69,9 @@ void kcsan_counter_dec(enum kcsan_counter_id id)
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
 
@@ -80,18 +81,52 @@ static void microbenchmark(unsigned long iters)
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
@@ -241,6 +276,12 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
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
-- 
2.25.0.341.g760bfbb309-goog

