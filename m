Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD55C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530552071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897999;
	bh=/HE/fGcqYX59CrpNFV584u9l8p/t5BIN7wRnHk0mx8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RA0GQcerEq2C8z7XDKgjVJzeu6/KTJuRE99RSmM2LUthbqNzi2nxfprWYQeGL/c6+
	 4XMxwtfpDCNvt5nmIiPRvDF1q+FKjsZ5aA0leHOdyceFdPH+XTd3ZoXxWDVwN4n+ip
	 NrnH0Zg7gQTqtQYhdpMBUSthof5rdA/UXLzZqCmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgHaST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbgHaSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A73A20EDD;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=/HE/fGcqYX59CrpNFV584u9l8p/t5BIN7wRnHk0mx8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJyQwhZJs46i1XKW/wpy2EY0vrhrEiDYRytPGST34m7zm8u5KB/4YfFTamU//VMoA
         8NJnuZZH8Wv3x4jluzelWX+UbSt4fRj392UFjRXva0JTrKqFlzeGqEG3gI008wfqyi
         UzXOM+Llr8b8bQmob9ZyoFybwPO5YsGP43whskxc=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 13/19] kcsan: Simplify constant string handling
Date:   Mon, 31 Aug 2020 11:17:59 -0700
Message-Id: <20200831181805.1833-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Simplify checking prefixes and length calculation of constant strings.
For the former, the kernel provides str_has_prefix(), and the latter we
should just use strlen("..") because GCC and Clang have optimizations
that optimize these into constants.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 8 ++++----
 kernel/kcsan/report.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 3a9566a..116bdd8 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -300,16 +300,16 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		WRITE_ONCE(kcsan_enabled, true);
 	} else if (!strcmp(arg, "off")) {
 		WRITE_ONCE(kcsan_enabled, false);
-	} else if (!strncmp(arg, "microbench=", sizeof("microbench=") - 1)) {
+	} else if (str_has_prefix(arg, "microbench=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
-	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+	} else if (str_has_prefix(arg, "test=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("test=")], 0, &iters))
 			return -EINVAL;
 		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 3e83a69..bf1d594 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -279,8 +279,8 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 
 		cur = strnstr(buf, "kcsan_", len);
 		if (cur) {
-			cur += sizeof("kcsan_") - 1;
-			if (strncmp(cur, "test", sizeof("test") - 1))
+			cur += strlen("kcsan_");
+			if (!str_has_prefix(cur, "test"))
 				continue; /* KCSAN runtime function. */
 			/* KCSAN related test. */
 		}
-- 
2.9.5

