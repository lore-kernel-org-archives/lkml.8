Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4612070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 12:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgAXMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:43:18 -0500
Received: from foss.arm.com ([217.140.110.172]:51268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbgAXMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:43:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39681045;
        Fri, 24 Jan 2020 04:43:15 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E2623F68E;
        Fri, 24 Jan 2020 04:43:14 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: [PATCH 2/3] sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems
Date:   Fri, 24 Jan 2020 12:42:54 +0000
Message-Id: <20200124124255.1095-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200124124255.1095-1-valentin.schneider@arm.com>
References: <20200124124255.1095-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

SD_BALANCE_WAKE was previously added to lower sched_domain levels on
asymmetric CPU capacity systems by commit 9ee1cda5ee25 ("sched/core: Enable
SD_BALANCE_WAKE for asymmetric capacity systems") to enable the use of
find_idlest_cpu() and friends to find an appropriate CPU for tasks.

That responsibility has now been shifted to select_idle_sibling() and
friends, and hence the flag can be removed. Note that this causes
asymmetric CPU capacity systems to no longer enter the slow wakeup path
(find_idlest_cpu()) on wakeups - only on execs and forks (which is aligned
with all other mainline topologies).

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
[Changelog tweaks]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dfb64c08a407a..00911884b7e7a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1374,18 +1374,9 @@ sd_init(struct sched_domain_topology_level *tl,
 	 * Convert topological properties into behaviour.
 	 */
 
-	if (sd->flags & SD_ASYM_CPUCAPACITY) {
-		struct sched_domain *t = sd;
-
-		/*
-		 * Don't attempt to spread across CPUs of different capacities.
-		 */
-		if (sd->child)
-			sd->child->flags &= ~SD_PREFER_SIBLING;
-
-		for_each_lower_domain(t)
-			t->flags |= SD_BALANCE_WAKE;
-	}
+	/* Don't attempt to spread across CPUs of different capacities. */
+	if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
+		sd->child->flags &= ~SD_PREFER_SIBLING;
 
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->imbalance_pct = 110;
-- 
2.24.0

