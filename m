Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7579C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD8820702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGATHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:39848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgGATH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE04D6E;
        Wed,  1 Jul 2020 12:07:28 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF1CB3F68F;
        Wed,  1 Jul 2020 12:07:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: [PATCH v3 7/7] sched/topology: Use prebuilt SD flag degeneration mask
Date:   Wed,  1 Jul 2020 20:06:55 +0100
Message-Id: <20200701190656.10126-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701190656.10126-1-valentin.schneider@arm.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
sd_degenerate_parent().

Note that this changes sd_degenerate() somewhat: I'm using the negation of
SD_DEGENERATE_GROUPS_MASK as the mask of flags not requiring groups, which
is equivalent to:

SD_WAKE_AFFINE | SD_SERIALIZE | SD_NUMA

whereas the current mask for that is simply

SD_WAKE_AFFINE

I played with a few toy NUMA topologies on QEMU and couldn't cause a
different degeneration than what mainline does currently. If that is deemed
too risky, we can go back to using SD_WAKE_AFFINE explicitly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index fe393b295444..a135a0c99b16 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -160,22 +160,13 @@ static int sd_degenerate(struct sched_domain *sd)
 		return 1;
 
 	/* Following flags need at least 2 groups */
-	if (sd->flags & (SD_BALANCE_NEWIDLE |
-			 SD_BALANCE_WAKE |
-			 SD_BALANCE_FORK |
-			 SD_BALANCE_EXEC |
-			 SD_ASYM_PACKING |
-			 SD_SHARE_CPUCAPACITY |
-			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES |
-			 SD_OVERLAP |
-			 SD_PREFER_SIBLING)) {
+	if (sd->flags & SD_DEGENERATE_GROUPS_MASK) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
 
 	/* Following flags don't use groups */
-	if (sd->flags & (SD_WAKE_AFFINE))
+	if (sd->flags & ~SD_DEGENERATE_GROUPS_MASK)
 		return 0;
 
 	return 1;
@@ -194,16 +185,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
-		pflags &= ~(SD_BALANCE_NEWIDLE |
-			    SD_BALANCE_WAKE |
-			    SD_BALANCE_FORK |
-			    SD_BALANCE_EXEC |
-			    SD_ASYM_PACKING |
-			    SD_ASYM_CPUCAPACITY |
-			    SD_SHARE_CPUCAPACITY |
-			    SD_SHARE_PKG_RESOURCES |
-			    SD_OVERLAP |
-			    SD_PREFER_SIBLING);
+		pflags &= ~SD_DEGENERATE_GROUPS_MASK;
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
-- 
2.27.0

