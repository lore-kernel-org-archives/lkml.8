Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EDA2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCZFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:53:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:24516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCZFxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:53:07 -0400
IronPort-SDR: IpqVKyYP5+2EddAv3A7QlF/dlHhfBpvsWtF4qysRuHUttd1/bF2sUDLHc53b4OtloPoDvHkvt0
 6VXV8o3KCdEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 22:53:06 -0700
IronPort-SDR: 1Xzkm47HHv8vFco/3O8phmKYaO3oY+BCjzVOdL+0aY4OFPQjDxsgzY8CMpgzDd7RBWbOlvP6/t
 a4bzIyCpomFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="358041731"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.16])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2020 22:53:03 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@linux.intel.com, vpillai@digitalocean.com,
        joel@joelfernandes.org, Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH] sched/fair: Fix negative imbalance in imbalance calculation
Date:   Thu, 26 Mar 2020 13:42:29 +0800
Message-Id: <1585201349-70192-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A negative imbalance value was observed after imbalance calculation,
this happens when the local sched group type is group_fully_busy,
and the average load of local group is greater than the selected
busiest group. Fix this problem by comparing the average load of the
local and busiest group before imbalance calculation formula.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Phil Auld <pauld@redhat.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1217bf..4a2ba3f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8761,6 +8761,14 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
 				sds->total_capacity;
+		/*
+		 * If the local group is more loaded than the selected
+		 * busiest group don't try to pull any tasks.
+		 */
+		if (local->avg_load >= busiest->avg_load) {
+			env->imbalance = 0;
+			return;
+		}
 	}
 
 	/*
-- 
2.7.4

