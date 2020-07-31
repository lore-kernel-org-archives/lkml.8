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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5442020829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBNkJXi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgGaIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731881AbgGaIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:44 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:43 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id l18so10796295ejn.17
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q7wuseCeY0GhAAgPgxPYT/xWCEF/meAm12cc8azYGg8=;
        b=KBNkJXi1xyvlcSbEJOtFDD9NLY+0tZN2R1jMybY7ex69isibH80B7Hw/wJ2ZmLaueI
         Nxd9A/0cOCERS6vVjDFtCnEUpLnL0f/UyvKgXGl3YbAWXPVIVJUulU4W+9WTCQmgYGdT
         +5LDOkVgnCAazL7EM6G/T7bBVh9zOzZf/DkqWWvD+ITTGb1wnxO4XJDktMvxCtbEb/zY
         JvEXwlwqae/LjoXhpzbx0CiDtFYkYDAgl1AVvROeUPP2TDgE4fuyRVh24KqE7v6bQhRi
         BTFtIw5MnFKKVf3w711viWJ382+joC/NlRy3G38U41e+AhrQOliPgfUwF/O04hOjUWZd
         5owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q7wuseCeY0GhAAgPgxPYT/xWCEF/meAm12cc8azYGg8=;
        b=qiDEFzMTot7u0q0ymfgmyThk4gbGRMgvbxBS9O9csU3bcHl4YbyAqWWQTM5W4h1Lw+
         JW92irUmOBW1Ixo7q0KsyPABcWe9Fy/BttNDK90ArTH9OtK4EEiq29CySJ60vywimpaP
         ItT9tY8usLQCIIJJbXDu/Zf5U8vhy2TLDh/T4ho3Vp3Uwx4D8Cl/R4/xUwVWm6EfIklY
         VsOsgJIvh7LcsxtvIxFja3W2xePp0Hazej0H7I4HqSlDAh+AOPnQw+55rQbYhZFErNfZ
         XjtOuZxKZYw9aREXdKxtFNHxKZBE1cUUc7VBOdujVms/4JlBlfRTXGf9/ta4rfI3QL2Q
         uy1A==
X-Gm-Message-State: AOAM532rHnGNqGLH+AqMEcsV25Fn1W2M9v4DIJXAK3e36OZ5U7LgY1Kh
        KtqKQ5CHTfEfaHIYKOXks5W+zGLoMg==
X-Google-Smtp-Source: ABdhPJzcF/W/JfmdUvVvtrkg59bTthZ38DOpssmXIQUcDVTb+O1rnLv6Bd63+vAnVMiqr9kl19Oa/SkLDw==
X-Received: by 2002:a17:906:38d8:: with SMTP id r24mr2769495ejd.341.1596183462236;
 Fri, 31 Jul 2020 01:17:42 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:21 +0200
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
Message-Id: <20200731081723.2181297-4-elver@google.com>
Mime-Version: 1.0
References: <20200731081723.2181297-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 3/5] kcsan: Remove debugfs test command
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the debugfs test command, as it is no longer needed now that we
have the KUnit+Torture based kcsan-test module. This is to avoid
confusion around how KCSAN should be tested, as only the kcsan-test
module is maintained.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 66 ------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 116bdd8f050c..de1da1b01aa4 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -98,66 +98,6 @@ static noinline void microbenchmark(unsigned long iters)
 	current->kcsan_ctx = ctx_save;
 }
 
-/*
- * Simple test to create conflicting accesses. Write 'test=<iters>' to KCSAN's
- * debugfs file from multiple tasks to generate real conflicts and show reports.
- */
-static long test_dummy;
-static long test_flags;
-static long test_scoped;
-static noinline void test_thread(unsigned long iters)
-{
-	const long CHANGE_BITS = 0xff00ff00ff00ff00L;
-	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
-	cycles_t cycles;
-
-	/* We may have been called from an atomic region; reset context. */
-	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
-
-	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
-	pr_info("test_dummy@%px, test_flags@%px, test_scoped@%px,\n",
-		&test_dummy, &test_flags, &test_scoped);
-
-	cycles = get_cycles();
-	while (iters--) {
-		/* These all should generate reports. */
-		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
-		ASSERT_EXCLUSIVE_WRITER(test_dummy);
-		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
-
-		ASSERT_EXCLUSIVE_BITS(test_flags, ~CHANGE_BITS); /* no report */
-		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
-
-		ASSERT_EXCLUSIVE_BITS(test_flags, CHANGE_BITS); /* report */
-		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
-
-		/* not actually instrumented */
-		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
-		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
-
-		test_flags ^= CHANGE_BITS; /* generate value-change */
-		__kcsan_check_write(&test_flags, sizeof(test_flags));
-
-		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
-		{
-			/* Should generate reports anywhere in this block. */
-			ASSERT_EXCLUSIVE_WRITER_SCOPED(test_scoped);
-			ASSERT_EXCLUSIVE_ACCESS_SCOPED(test_scoped);
-			BUG_ON(!current->kcsan_ctx.scoped_accesses.prev);
-			/* Unrelated accesses. */
-			__kcsan_check_access(&cycles, sizeof(cycles), 0);
-			__kcsan_check_access(&cycles, sizeof(cycles), KCSAN_ACCESS_ATOMIC);
-		}
-		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
-	}
-	cycles = get_cycles() - cycles;
-
-	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
-
-	/* restore context */
-	current->kcsan_ctx = ctx_save;
-}
-
 static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
 {
 	const unsigned long a = *(const unsigned long *)rhs;
@@ -306,12 +246,6 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
-	} else if (str_has_prefix(arg, "test=")) {
-		unsigned long iters;
-
-		if (kstrtoul(&arg[strlen("test=")], 0, &iters))
-			return -EINVAL;
-		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
 		set_report_filterlist_whitelist(true);
 	} else if (!strcmp(arg, "blacklist")) {
-- 
2.28.0.163.g6104cc2f0b6-goog

