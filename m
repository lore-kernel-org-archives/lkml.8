Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2784C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923D120829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQCAbfAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbgGaIRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731881AbgGaIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64EFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l10so9589965qvw.22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Hs8pR7aozKTxu1D5WCBxSVPuPyLLXKSlzcEz3zNnOs=;
        b=SQCAbfAYFrSa0fVXyd3XScdlE2Na/NsrCT0PzyGuF7Kswvf92Sov342wYMix+qxuLt
         Zs9TLYZKJCdy4r8SbgGr+gioCdWyKqkGQOUN5M7UV8/dAviUqYoJz5r/Xiac1pi1quil
         db2LaenGmlbi6iKgUtttLpWazGPEXT0Qo/bYY34gDSFOSxOUkVEF18UhCWZ5xjPwMmrT
         SkAssPmKDF9+6eu34+CcAXCFNNWp5WVSZFJCyaTMUHRMv19FdzckVr4lekvOG5Q5YJW8
         rqyL8SXrtFLZvFgKzRZRDuj/NyQdEO0u41SVnx6V0Hy4+WFvMXas7YzATfM8rs9pg+bv
         Cx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Hs8pR7aozKTxu1D5WCBxSVPuPyLLXKSlzcEz3zNnOs=;
        b=Q+mgb/gB5KZYXNZ+uGFaJFskLuArosr3G3sM/q11watqqBgCm1RQlml4jUdgfdbGTf
         pRDB9UI3HmnljD9tm3uDWxjyKU6kW5lxU1+ZV960E5jTF2Oy05lXBdizZ6zniD27bnan
         MfqGFYNX+hb0fVDh6gbFjISAZsf9m2pjyvjiSa4JzfuUaPuZvZM+lGB1358iexRbTyBc
         I7YBGooHfbF39dkc/EO+CYXnSThzLGh0BBK9ICHNefRCd3jqlkiKBoV+9Ll1EIVuAo47
         HVlmgAAfXxvTSxvu38D8Bt1jXyU2QZiGgd78ynOWV+jvBvfLfGF3kmvkrkXw4Pgt3Cx+
         f7gg==
X-Gm-Message-State: AOAM533Ss9+Q1EIv6q9tTJYrG6S8hhcZMAsY+haBcsgODjXRZ3PIWjS1
        JB46ujj4JmdBGKGfdI85cmMlPWfelw==
X-Google-Smtp-Source: ABdhPJyDGWODiwpDQjj9FXsvUhOBwGRKGXzeh5BuHFdKBLgIqPra13RcxkYrBQyeeurTtAN++9x8gVmdwg==
X-Received: by 2002:a0c:f081:: with SMTP id g1mr2932894qvk.219.1596183466896;
 Fri, 31 Jul 2020 01:17:46 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:23 +0200
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
Message-Id: <20200731081723.2181297-6-elver@google.com>
Mime-Version: 1.0
References: <20200731081723.2181297-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 5/5] kcsan: Use pr_fmt for consistency
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same pr_fmt throughout for consistency. [ The only exception is
report.c, where the format must be kept precisely as-is. ]

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c  | 8 +++++---
 kernel/kcsan/selftest.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index de1da1b01aa4..6c4914fa2fad 100644
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
index d26a052d3383..d98bc208d06d 100644
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
2.28.0.163.g6104cc2f0b6-goog

