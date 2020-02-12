Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2693C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A912073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgBLPpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:45:36 -0500
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:52504 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbgBLPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:45:35 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 93E741C2A1C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:45:33 +0000 (GMT)
Received: (qmail 28195 invoked from network); 12 Feb 2020 15:45:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 15:45:33 -0000
Date:   Wed, 12 Feb 2020 15:45:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] sched/fair: Split out helper to adjust imbalances
 between domains
Message-ID: <20200212154531.GN3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200212093654.4816-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "sched/fair: Allow a small load imbalance between low utilisation
SD_NUMA domains" allows an imbalance when the busiest group has very
few tasks. Move the check to a helper function as it is needed by a later
patch.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24fc90b8036a..b2476ef0b056 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8758,6 +8758,21 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
+static inline long adjust_numa_imbalance(int imbalance, int src_nr_running)
+{
+	unsigned int imbalance_min;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the source domain is almost idle.
+	 */
+	imbalance_min = 2;
+	if (src_nr_running <= imbalance_min)
+		return 0;
+
+	return imbalance;
+}
+
 /**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
@@ -8854,18 +8869,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
-		if (env->sd->flags & SD_NUMA) {
-			unsigned int imbalance_min;
-
-			/*
-			 * Allow a small imbalance based on a simple pair of
-			 * communicating tasks that remain local when the
-			 * source domain is almost idle.
-			 */
-			imbalance_min = 2;
-			if (busiest->sum_nr_running <= imbalance_min)
-				env->imbalance = 0;
-		}
+		if (env->sd->flags & SD_NUMA)
+			env->imbalance = adjust_numa_imbalance(env->imbalance,
+						busiest->sum_nr_running);
 
 		return;
 	}
-- 
2.16.4

