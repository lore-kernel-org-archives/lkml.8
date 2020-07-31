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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44887C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224B620829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzPCA8cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgGaIRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgGaIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:39 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED60C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:39 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id f14so8813887wrm.22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xl2dBv96+m8d7hzKFanUDmjJZM8uPb0EPNFmjdms4A=;
        b=tzPCA8cbWnXegw9VILxXK/QZtsyH1DHhi/tNR75WvKQTh9g2aGpSmxbpK8/kvxalaf
         j8wjqp5UdbidiB56p8w1xvCwsYbcwk7Tll74phR/vkrLHM9Vw/3os0vxHL2g9sKnfhHu
         bZyLnRrs6kO5dCNSRe4cqrxCRkRxdjjZyVp3ulAQHxFjGRiGcR7IVMUip4yyiUTOLDoS
         aBKyBEpzKyJrz/fCy+Tk+fsx23oE1JYcMS7VVBA8ICgTAiswSh8oi8+u3JVQK4uEcd7q
         yNAXoCxaeLT+kpqBtwp22ViNqqediPBF5e6faejPr2KIcm1FC6dYiiN733+h3UGpD6te
         1xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xl2dBv96+m8d7hzKFanUDmjJZM8uPb0EPNFmjdms4A=;
        b=RkZRCCoKWc57Mmlvot/zA7s/f5448Q9y3+U5sz9+jiBA1IiGHoEEMkuyoOelJ0nFVl
         jMzdlfGbZBu2FJJI6IzuI0RzETF+/QxeS2ZNbcPMLONnDeW1FQ+lAL4Ae06t/RVoRgCX
         qTxz16LHOHz3ZsnmLbJNfNoT+Xz/McG0nS0TnN1yjH3f7LJMK2Hweqo1FGqrNiJUeTQj
         PGdMWlTo6euA70onfjdn7TzHEfJsKrPkMHuQuHI0hvMg/67u/yM0zZQGZytaSMGHQttm
         w7Vhwa3zRTdFFrNNHMp8BuMniHc5/o3sV+Ixuk3jGWpPqOaZc2FSbl8QXr5mDZX2ryRU
         CrpA==
X-Gm-Message-State: AOAM533Z1vx1UhSNtF6BQ6PIueCdSGCAZ2WqtQxn377/wJ8PKCsfmPuH
        w5b67ZaxMUK8trniNfhONSWQ4suc+g==
X-Google-Smtp-Source: ABdhPJyhbAjMHh9qUcABy/ESAddLoONWL6F2fU+N2Qn8p4ylDbQObA5EMmxJt6/MkXRYlItvO43Bsz07+Q==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr2912866wmd.80.1596183457812;
 Fri, 31 Jul 2020 01:17:37 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:19 +0200
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
Message-Id: <20200731081723.2181297-2-elver@google.com>
Mime-Version: 1.0
References: <20200731081723.2181297-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/5] kcsan: Simplify debugfs counter to name mapping
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify counter ID to name mapping by using an array with designated
inits. This way, we can turn a run-time BUG() into a compile-time static
assertion failure if a counter name is missing.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 023e49c58d55..3a9566addeff 100644
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
2.28.0.163.g6104cc2f0b6-goog

