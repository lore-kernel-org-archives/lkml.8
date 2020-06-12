Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A592074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmKVu63i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFLPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:47:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:47:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so8601587wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=myWdkxy/VNTD5IXk6U9ubBFqqIkeCeYgwzaB6AArRVo=;
        b=dmKVu63iyFHP+fDLQvvrQlTdzou1gxZrgFx+fmU905RNOvCiPOCn8Fur+DAXJeLcJV
         p1MXcr73Unro2QOjQB7ZHIoZobSKdXzsfbBRTVBuazOYIwO9U5+3Q8yxT3AwCILHS2HX
         vMuUYR+t+DpSrhsRAzyBqN4uOV2PHLEkDtJw0e+vFJhrvbPDhgTTuDZJeZAwaJsEpy2+
         1LU++Wbt5YJdtup38BDiKUTrMgXy7SCeybRh2KFz+UhrMCbexUqlR72kbBVBF88f6W51
         NtVdPs9IVf3lU5eXUn3YAief2cB+VIWWKGhxY5lb2DifN+FM1i//zKkzN/H6F8PLBkqE
         xRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myWdkxy/VNTD5IXk6U9ubBFqqIkeCeYgwzaB6AArRVo=;
        b=PIA5FcwX1Igch3utXXCtfV/SY+4nfOFgEgs7UUmU71u9KWsGQQkHZLluH1dva5lsjk
         DWiiQzAlMjvY0mMh4QXMG9fdFtgXLve/xCk28nWTa+Za2Tr+jOUwvh8q+gX/HHJIZFpJ
         hPzl4PA1mbRlnQwMPwdlB98kyPOYEFr28QzkEaS/5vcCSfJk2GclGRmS+1X6seWH4RL3
         diQ2UaGaIkyTPROHO+bmcBxZHo587IEKwak53NIbtvBbmZebkHfgFYzeRp0u2obb+hE9
         5j4D7dD9Do3/Cm8w101IwWnSJE5gUQTIHU5a/Yhf2N10yfxwQ5lN1UEUKD5M3HEHC8kP
         bRyQ==
X-Gm-Message-State: AOAM532Js8eI51XWJe1TI+xtMsTeY7jtA8b3YzSIgvFi0Op8IdfaUEoX
        Kgjr5kfS0kRbtqZsWCqzm+3EuQ==
X-Google-Smtp-Source: ABdhPJyDWmGAt8koWCUFcHJKGjjTCoQ5x+UEqzePPhTrAVjo/JRDr2E7JqBkfuiYX3lly1Lu2GulPg==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr13193970wme.80.1591976830170;
        Fri, 12 Jun 2020 08:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b993:7972:5b8a:aacd])
        by smtp.gmail.com with ESMTPSA id k16sm11111407wrp.66.2020.06.12.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:47:08 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: cleanup pelt divider
Date:   Fri, 12 Jun 2020 17:47:03 +0200
Message-Id: <20200612154703.23555-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factorize in a single place the calculation of the divider to be used to
to compute *_avg from *_sum value

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 32 ++++++++++++++++++--------------
 kernel/sched/pelt.c |  2 +-
 kernel/sched/pelt.h |  5 +++++
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ed04d2a8959..093224bf513b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3095,7 +3095,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 #ifdef CONFIG_SMP
 	do {
-		u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
+		u32 divider = get_pelt_divider(&se->avg);
 
 		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
 	} while (0);
@@ -3441,16 +3441,18 @@ static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
-	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
-	 * See ___update_load_avg() for details.
-	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = get_pelt_divider(&cfs_rq->avg);
+
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
 	se->avg.util_sum = se->avg.util_avg * divider;
@@ -3464,16 +3466,18 @@ static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
-	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
-	 * See ___update_load_avg() for details.
-	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider;
 
 	/* Nothing to update */
 	if (!delta)
 		return;
 
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	divider = get_pelt_divider(&cfs_rq->avg);
+
 	/* Set new sched_entity's runnable */
 	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
 	se->avg.runnable_sum = se->avg.runnable_avg * divider;
@@ -3501,7 +3505,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	divider = get_pelt_divider(&cfs_rq->avg);
 
 	if (runnable_sum >= 0) {
 		/*
@@ -3647,7 +3651,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 	if (cfs_rq->removed.nr) {
 		unsigned long r;
-		u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
+		u32 divider = get_pelt_divider(&cfs_rq->avg);
 
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
@@ -3702,7 +3706,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
+	u32 divider = get_pelt_divider(&cfs_rq->avg);
 
 	/*
 	 * When we attach the @se to the @cfs_rq, we must align the decay
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b4b1ff96642f..2b607293b6ba 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -264,7 +264,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 static __always_inline void
 ___update_load_avg(struct sched_avg *sa, unsigned long load)
 {
-	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
+	u32 divider = get_pelt_divider(sa);
 
 	/*
 	 * Step 2: update *_avg.
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index eb034d9f024d..795e43e02afc 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -37,6 +37,11 @@ update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif
 
+static inline u32 get_pelt_divider(struct sched_avg *avg)
+{
+	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
+}
+
 /*
  * When a task is dequeued, its estimated utilization should not be update if
  * its util_avg has not been updated at least once.
-- 
2.17.1

