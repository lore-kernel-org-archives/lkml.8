Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD32A2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598898004;
	bh=2RZpqf2ZGCxO2YXofpLTsUTyzZLebZ3Yth4DKgYwxHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STETZiPTqezFUF4hCcBlkRXphXQxspLAMHu9Dmin6ViB+Cc2edXCzBgIGozsLYuyR
	 qKZgt9ArXtX6xisGVaB5LQRkkWex2JZ5h0UsbiK2bqz2lWx/7nEnNdv5xFUw51ASsr
	 GOp5KbsMs/jSDUZ3tS2aRgi/gs3g8WcxcRmUMdfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgHaSUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgHaSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23683215A4;
        Mon, 31 Aug 2020 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897888;
        bh=2RZpqf2ZGCxO2YXofpLTsUTyzZLebZ3Yth4DKgYwxHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxSc8+pgv/Btanp5JusLRnwOLXsQ4lo3MQ1HPXyykUcFh3UKTL9trjm3SxlJEkb0E
         9tbqkO343mpLflGeh+uPqjNbyo0Gsgo4AslU/IgFwZrsYeM0ivjUxtzXkKNJaF/ZG+
         YuhsUFi4pw0NWHLMoLmAYpxXpVzFjKf4ib1x8fso=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 12/19] kcsan: Simplify debugfs counter to name mapping
Date:   Mon, 31 Aug 2020 11:17:58 -0700
Message-Id: <20200831181805.1833-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Simplify counter ID to name mapping by using an array with designated
inits. This way, we can turn a run-time BUG() into a compile-time static
assertion failure if a counter name is missing.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/debugfs.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 023e49c..3a9566a 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -19,6 +19,18 @@
  * Statistics counters.
  */
 static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+static const char *const counter_names[] = {
+	[KCSAN_COUNTER_USED_WATCHPOINTS]		= "used_watchpoints",
+	[KCSAN_COUNTER_SETUP_WATCHPOINTS]		= "setup_watchpoints",
+	[KCSAN_COUNTER_DATA_RACES]			= "data_races",
+	[KCSAN_COUNTER_ASSERT_FAILURES]			= "assert_failures",
+	[KCSAN_COUNTER_NO_CAPACITY]			= "no_capacity",
+	[KCSAN_COUNTER_REPORT_RACES]			= "report_races",
+	[KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN]		= "races_unknown_origin",
+	[KCSAN_COUNTER_UNENCODABLE_ACCESSES]		= "unencodable_accesses",
+	[KCSAN_COUNTER_ENCODING_FALSE_POSITIVES]	= "encoding_false_positives",
+};
+static_assert(ARRAY_SIZE(counter_names) == KCSAN_COUNTER_COUNT);
 
 /*
  * Addresses for filtering functions from reporting. This list can be used as a
@@ -39,24 +51,6 @@ static struct {
 };
 static DEFINE_SPINLOCK(report_filterlist_lock);
 
-static const char *counter_to_name(enum kcsan_counter_id id)
-{
-	switch (id) {
-	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
-	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
-	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
-	case KCSAN_COUNTER_ASSERT_FAILURES:		return "assert_failures";
-	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
-	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
-	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
-	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:	return "unencodable_accesses";
-	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:	return "encoding_false_positives";
-	case KCSAN_COUNTER_COUNT:
-		BUG();
-	}
-	return NULL;
-}
-
 void kcsan_counter_inc(enum kcsan_counter_id id)
 {
 	atomic_long_inc(&counters[id]);
@@ -271,8 +265,7 @@ static int show_info(struct seq_file *file, void *v)
 	/* show stats */
 	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
 	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
-		seq_printf(file, "%s: %ld\n", counter_to_name(i),
-			   atomic_long_read(&counters[i]));
+		seq_printf(file, "%s: %ld\n", counter_names[i], atomic_long_read(&counters[i]));
 
 	/* show filter functions, and filter type */
 	spin_lock_irqsave(&report_filterlist_lock, flags);
-- 
2.9.5

