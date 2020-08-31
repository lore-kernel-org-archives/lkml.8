Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77254C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AED22071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897984;
	bh=67qnnSgzEc/n95ikPaFZAfAOBG8sPrR44Ixh1WTkcJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0VmIhw8FpcqpnSIDljtbA16SgjPl+KRpBLSfAE0IgiBWfpaPvZeIVGLDdoSMwZMM
	 Zc2218PYixeIRyluwFXImlZeE+jh2dcTypr1/5U6OYAF44Eb0dNgaVCsOMkyLiIZIq
	 4Zow+TMQPZ5I+odb/uPtnhW3QxjZ0zDct4UrRvmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgHaSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgHaSSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:09 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1FC2166E;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=67qnnSgzEc/n95ikPaFZAfAOBG8sPrR44Ixh1WTkcJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpLApWVQO/skhvpq19A3b7rkWpsBWbaya3CcrV9odOs547a+52DjVe7/UlmmGf6td
         BtkDQLX8fXxu90I5uOYEI/oe4qfbzX4tfL+x3YQ6r3167l+/buHtQwzZzqEYPQNb83
         MvbKnBUJWKVqmP/ZYaHYJ1WFrGrxu+MzoLf12bko=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 14/19] kcsan: Remove debugfs test command
Date:   Mon, 31 Aug 2020 11:18:00 -0700
Message-Id: <20200831181805.1833-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Remove the debugfs test command, as it is no longer needed now that we
have the KUnit+Torture based kcsan-test module. This is to avoid
confusion around how KCSAN should be tested, as only the kcsan-test
module is maintained.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 66 --------------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 116bdd8..de1da1b01 100644
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
2.9.5

