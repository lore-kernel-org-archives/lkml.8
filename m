Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0FB20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH/5Wblj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEFPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgEFPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:53:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E38C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:53:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so1969261wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8//eqF1JWXprgzhz6XBWBM0AQKhUhWW/NjTGeEFAIJg=;
        b=PH/5Wblj21DUbaq1bEpmFX+8SK7KBnHEHS+0WSuIOEUUkgEWhmiv1Rwkl+mzIx7Rnm
         5AWIhR896G2BvzRQvFzyaB0/+cqPviNJhzHcvGCT+0cucZcWOnOfFGbGJMBMeBnc6AAd
         7vYmzvAlyuD9KCxVey/PcURJLONM+Q8hM/cu+d3TTJp76GKN0DBpBQfvZSeMGqDYnnjm
         7ouN6uwFpM7k/ZGbOHU0KruIRLJU0lz19ZkKHAmoTSjxyNMggEkl8bKiDG5HalqJkmvS
         faopkn7G9CJ8IG2WJ2Zo4Heae47txTbgMiRWpF95oW1jICtRw8AnnJSgKxTV6sV6hKjd
         d93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8//eqF1JWXprgzhz6XBWBM0AQKhUhWW/NjTGeEFAIJg=;
        b=N0gfESHiya0CSoxD4aET7BvRqtne6mocEem8UBANDtxxKuk60FIbxyveyKzpTwWWFR
         rcsWcDTia33ya2vzz92qHmjglpjnyh07fPGgvzlapd1O4dlgN/moXmwfOIKZfz2moFy0
         AYU5t/bQ70smkdrpqMCRiXA77/qDZLOOAiqx7Qps1KDqyykX39NaahfzkVOWNmS8EGTK
         nkxusPX0T4Z26wXfTcSOIWV09AD7Nrm7mX6rU8Vgs4F1y/izUAn3K7RlgaGKHDZIo3LL
         NvE0HLfYqxhjyWZbXS7solNBlfINhL0ZSIaJ+SWP++FnHSdQ0sqx5Bpli3Rp4DEZCMrQ
         XHaQ==
X-Gm-Message-State: AGi0PubDS3Fthb/sORLcxeGoQ6nsPeQgM/8Xm+JKAUpL3uRo0AnuqzAH
        NjMpMD31xVXWMH8XCvKCfB9J5g==
X-Google-Smtp-Source: APiQypJqS6ZJWcfW5Oqk00gBdJ8oUo1dW3lpj+NW1dTL7Cs7e60cqLPrbeOWN12rmT6nGq0J3lKuJA==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr9757803wrp.28.1588780385808;
        Wed, 06 May 2020 08:53:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58ab:1b89:a35a:3acb])
        by smtp.gmail.com with ESMTPSA id k6sm3677512wma.19.2020.05.06.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:53:04 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/pelt: sync util/runnable_sum with PELT window when propagating
Date:   Wed,  6 May 2020 17:53:01 +0200
Message-Id: <20200506155301.14288-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_tg_cfs_*() propagate the impact of the attach/detach of an entity
down into the cfs_rq hierarchy and must keep the sync with the current pelt
window.

Even if we can't sync child cfs_rq and its group se, we can sync the group
se and its parent cfs_rq with current position in the PELT window. In fact,
we must keep them sync in order to stay also synced with others entities
and group entities that are already attached to the cfs_rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I have added update_tg_cfs_load() because there is no reason that we don't
sync load_avg with load_sum even if the impact is probably less obvious
because it's not simple propagation of the diff.

 kernel/sched/fair.c | 49 +++++++++++++++++++++++++--------------------
 kernel/sched/pelt.c | 24 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..df3923a65162 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3441,52 +3441,46 @@ static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
-	se->avg.util_sum = se->avg.util_avg * LOAD_AVG_MAX;
+	se->avg.util_sum = se->avg.util_avg * divider;
 
 	/* Update parent cfs_rq utilization */
 	add_positive(&cfs_rq->avg.util_avg, delta);
-	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
+	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
 }
 
 static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
-	/*
-	 * The relation between sum and avg is:
-	 *
-	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
-	 *
-	 * however, the PELT windows are not aligned between grq and gse.
-	 */
-
 	/* Set new sched_entity's runnable */
 	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+	se->avg.runnable_sum = se->avg.runnable_avg * divider;
 
 	/* Update parent cfs_rq runnable */
 	add_positive(&cfs_rq->avg.runnable_avg, delta);
-	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 }
 
 static inline void
@@ -3496,19 +3490,26 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	unsigned long load_avg;
 	u64 load_sum = 0;
 	s64 delta_sum;
+	u32 divider;
 
 	if (!runnable_sum)
 		return;
 
 	gcfs_rq->prop_runnable_sum = 0;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+
 	if (runnable_sum >= 0) {
 		/*
 		 * Add runnable; clip at LOAD_AVG_MAX. Reflects that until
 		 * the CPU is saturated running == runnable.
 		 */
 		runnable_sum += se->avg.load_sum;
-		runnable_sum = min(runnable_sum, (long)LOAD_AVG_MAX);
+		runnable_sum = min_t(long, runnable_sum, divider);
 	} else {
 		/*
 		 * Estimate the new unweighted runnable_sum of the gcfs_rq by
@@ -3533,7 +3534,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	runnable_sum = max(runnable_sum, running_sum);
 
 	load_sum = (s64)se_weight(se) * runnable_sum;
-	load_avg = div_s64(load_sum, LOAD_AVG_MAX);
+	load_avg = div_s64(load_sum, divider);
 
 	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
 	delta_avg = load_avg - se->avg.load_avg;
@@ -3697,6 +3698,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  */
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
 	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
 	/*
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b647d04d9c8b..1feff80e7e45 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -237,6 +237,30 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	return 1;
 }
 
+/*
+ * When syncing *_avg with *_sum, we must take into account the current
+ * position in the PELT segment otherwise the remaining part of the segment
+ * will be considered as idle time whereas it's not yet elapsed and this will
+ * generate unwanted oscillation in the range [1002..1024[.
+ *
+ * The max value of *_sum varies with the position in the time segment and is
+ * equals to :
+ *
+ *   LOAD_AVG_MAX*y + sa->period_contrib
+ *
+ * which can be simplified into:
+ *
+ *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+ *
+ * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
+ *
+ * The same care must be taken when a sched entity is added, updated or
+ * removed from a cfs_rq and we need to update sched_avg. Scheduler entities
+ * and the cfs rq, to which they are attached, have the same position in the
+ * time segment because they use the same clock. This means that we can use
+ * the period_contrib of cfs_rq when updating the sched_avg of a sched_entity
+ * if it's more convenient.
+ */
 static __always_inline void
 ___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
-- 
2.17.1

