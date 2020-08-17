Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB0EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F728204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHQLcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:32:00 -0400
Received: from foss.arm.com ([217.140.110.172]:53516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgHQLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0666513D5;
        Mon, 17 Aug 2020 04:30:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C621F3F66B;
        Mon, 17 Aug 2020 04:30:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v6 08/17] sched/topology: Use prebuilt SD flag degeneration mask
Date:   Mon, 17 Aug 2020 12:29:54 +0100
Message-Id: <20200817113003.20802-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
sd_parent_degenerate().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f128fcf46a41..5f2bc99ff659 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -160,15 +160,9 @@ static int sd_degenerate(struct sched_domain *sd)
 		return 1;
 
 	/* Following flags need at least 2 groups */
-	if (sd->flags & (SD_BALANCE_NEWIDLE |
-			 SD_BALANCE_FORK |
-			 SD_BALANCE_EXEC |
-			 SD_SHARE_CPUCAPACITY |
-			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES)) {
-		if (sd->groups != sd->groups->next)
-			return 0;
-	}
+	if ((sd->flags & SD_DEGENERATE_GROUPS_MASK) &&
+	    (sd->groups != sd->groups->next))
+		return 0;
 
 	/* Following flags don't use groups */
 	if (sd->flags & (SD_WAKE_AFFINE))
@@ -190,13 +184,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
-		pflags &= ~(SD_BALANCE_NEWIDLE |
-			    SD_BALANCE_FORK |
-			    SD_BALANCE_EXEC |
-			    SD_ASYM_CPUCAPACITY |
-			    SD_SHARE_CPUCAPACITY |
-			    SD_SHARE_PKG_RESOURCES |
-			    SD_PREFER_SIBLING);
+		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
-- 
2.27.0

