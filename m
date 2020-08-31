Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1B72071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897981;
	bh=izEuFm0CkLqGqGuRdf3iNukr6k4QThi2QPdPfv3Qaug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GholeineNHTFN/Q8NIItZqFh7XRjqu5fYAshWhU+ZZ8RZ6bmNcbXmSNQbLD0hb4/p
	 7R4AQrnbpVE7tekeywi5ebZxy8zIEqPhk3FmjJJCYxSvt/HmEE7nPp0G2FpicoEhHK
	 OTHIV/DLUARh6f3oTMcuWytIzbKEQNThlN2d/vv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgHaSTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgHaSSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:09 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85A921532;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=izEuFm0CkLqGqGuRdf3iNukr6k4QThi2QPdPfv3Qaug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcS1arZWhZvrVD/XM0GuwQdtw/STQJh5y10qK2cSfT0vAfJY6h5qJvOnf5a602em8
         fH79vpk5Wr0fQaPQD5CbNe+AqJGMpd433huEA0Muo4I4lYhzcl69z3/FVaYLAr1IwA
         fO0skXu4dsnhmHH5GbiyflKZVM1Xz/heob2lMyV4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 16/19] kcsan: Use pr_fmt for consistency
Date:   Mon, 31 Aug 2020 11:18:02 -0700
Message-Id: <20200831181805.1833-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Use the same pr_fmt throughout for consistency. [ The only exception is
report.c, where the format must be kept precisely as-is. ]

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c  | 8 +++++---
 kernel/kcsan/selftest.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index de1da1b01..6c4914f 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/atomic.h>
 #include <linux/bsearch.h>
 #include <linux/bug.h>
@@ -80,7 +82,7 @@ static noinline void microbenchmark(unsigned long iters)
 	 */
 	WRITE_ONCE(kcsan_enabled, false);
 
-	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+	pr_info("%s begin | iters: %lu\n", __func__, iters);
 
 	cycles = get_cycles();
 	while (iters--) {
@@ -91,7 +93,7 @@ static noinline void microbenchmark(unsigned long iters)
 	}
 	cycles = get_cycles() - cycles;
 
-	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+	pr_info("%s end   | cycles: %llu\n", __func__, cycles);
 
 	WRITE_ONCE(kcsan_enabled, was_enabled);
 	/* restore context */
@@ -154,7 +156,7 @@ static ssize_t insert_report_filterlist(const char *func)
 	ssize_t ret = 0;
 
 	if (!addr) {
-		pr_err("KCSAN: could not find function: '%s'\n", func);
+		pr_err("could not find function: '%s'\n", func);
 		return -ENOENT;
 	}
 
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index d26a052..d98bc20 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
@@ -116,16 +118,16 @@ static int __init kcsan_selftest(void)
 		if (do_test())                                                 \
 			++passed;                                              \
 		else                                                           \
-			pr_err("KCSAN selftest: " #do_test " failed");         \
+			pr_err("selftest: " #do_test " failed");               \
 	} while (0)
 
 	RUN_TEST(test_requires);
 	RUN_TEST(test_encode_decode);
 	RUN_TEST(test_matching_access);
 
-	pr_info("KCSAN selftest: %d/%d tests passed\n", passed, total);
+	pr_info("selftest: %d/%d tests passed\n", passed, total);
 	if (passed != total)
-		panic("KCSAN selftests failed");
+		panic("selftests failed");
 	return 0;
 }
 postcore_initcall(kcsan_selftest);
-- 
2.9.5

