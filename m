Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A1220776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW0y382o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDVPOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:14:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9EC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:14:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so2827315wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mKRg0t/XVvzZRZvxdCba8JTVT+Vu4PrV36ELCiNsVPA=;
        b=PW0y382owp8KdhdvJsq2R4FP4vJ8DIh5QcyP6WQXy2jIs4JKkR6ZJYUqvkzO2q746F
         zKJPkRJSQ7ulCXaq2VrK5/5RrDwme0t25rNDlel9p5ZciJwVhTfTQNcFG85F2ESX0uZI
         EONpAehtR0m3W6Y27mrXOWDwDUKKPDsOKhTVrPLhNxh71c3or2SVIl2EojZ5fPbHogV7
         gi8T7gToDzxGkTJ9D8VhZt+W5THoSWJxgyXhAmuQmytjRJf0ZIDcBWh5aX4DHoR5G3cZ
         Woe72OVkUDwfNDOuaYYiq/qa4Tdc4UWS1IPIy6QiXaC82V45fiorp49OPQq1HtBskUyY
         jgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mKRg0t/XVvzZRZvxdCba8JTVT+Vu4PrV36ELCiNsVPA=;
        b=gjZgKQgRVKVsI42swjhc1+MYRQz/MZ4WN8eqHygT0Abhq7daJz9yv/4kiQ8ZAKfd08
         G9WBv12pfIX7ANiOxeeaV+QhosM9KfzU0vL7XbJgi5DPprB1uQSNneFmNAWYXjpus4CK
         7dNSSdl/9Y+8RhF8Y/mE/nkgDLWc7PeUtBcfX/QNnNXxvi0IpRYhBjFhwHyu0TIBNjTX
         JcaZTaHnEF+pCPQ7t7vvRS5vi+zGEsil1nvnX/AKLsdu5TEUEj1rz7SlJK0YgFRKfoBF
         uuUzBkG4R7tqyFVrapwKNo/do2sFQk0T9rjEriOfkid88XFARKk5+W3XYVYEnhBXvYaJ
         h3Aw==
X-Gm-Message-State: AGi0PubCt4u8Ebj1k+fOsHG+g/qCLPn8OQ1fezM8tJ32QLUPyw+CQ+03
        pou7XbY4RHKsTWueviqryBLkcNb2ipI=
X-Google-Smtp-Source: APiQypLjn15sn+7UTJpsVf9Hs8irRVj7LLlkoZoWoztWP2yLU1O66vbQic4346zttzT/DeytpUM91A==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr29291581wrn.89.1587568445225;
        Wed, 22 Apr 2020 08:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:54f7:b326:db86:b83a])
        by smtp.gmail.com with ESMTPSA id n7sm8137687wmd.11.2020.04.22.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:14:04 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: sync util/runnable_sum with PELT window when propagating
Date:   Wed, 22 Apr 2020 17:14:01 +0200
Message-Id: <20200422151401.9147-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_tg_cfs_util/runnable() propagate the impact of the attach/detach of
an entity down into the cfs_rq hierarchy which must keep the sync with
the current pelt window.

Even if we can't sync child rq and its group se, we can sync the group se
and parent cfs_rq with current PELT window. In fact, we must keep them sync
in order to stay also synced with others se and group se that are already
attached to the cfs_rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..ca6aa89c88f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3441,52 +3441,38 @@ static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
 	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
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
-- 
2.17.1

