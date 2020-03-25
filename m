Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8282076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYM5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:57:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:6136 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgCYM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:57:46 -0400
IronPort-SDR: 4FrkzzbLkQwDfl1W+AyDcJWUozG8uyG1yFs/EH86hEz2ge/GOjDZGre3CNMVIhtCII7bBBd/S+
 s+xBh0BZodcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 05:57:45 -0700
IronPort-SDR: ud2Jc42Q5Pw832YR1IM/USQWfvP2pWxpKtjoKRvxzjZl85Pv5lrjYPQZo3X0lEcKNjeNobve/h
 qu31qXwY5YiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="393617837"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.16])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 05:57:42 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@linux.intel.com, vpillai@digitalocean.com,
        joel@joelfernandes.org, Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH] sched/fair: Don't pull task if local group is more loaded than busiest group
Date:   Wed, 25 Mar 2020 20:46:28 +0800
Message-Id: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A huge number of load imbalance was observed when the local group
type is group_fully_busy, and the average load of local group is
greater than the selected busiest group, so the imbalance calculation
returns a negative value actually. Fix this problem by comparing the
average load before local group type check.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bf..c524369 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8862,17 +8862,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto out_balanced;
 
 	/*
+	 * If the local group is more loaded than the selected
+	 * busiest group don't try to pull any tasks.
+	 */
+	if (local->avg_load >= busiest->avg_load)
+		goto out_balanced;
+
+	/*
 	 * When groups are overloaded, use the avg_load to ensure fairness
 	 * between tasks.
 	 */
 	if (local->group_type == group_overloaded) {
-		/*
-		 * If the local group is more loaded than the selected
-		 * busiest group don't try to pull any tasks.
-		 */
-		if (local->avg_load >= busiest->avg_load)
-			goto out_balanced;
-
 		/* XXX broken for overlapping NUMA groups */
 		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
 				sds.total_capacity;
-- 
2.7.4

