Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5932C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC5F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgGaMFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbgGaMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA7F1FB;
        Fri, 31 Jul 2020 05:05:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23DF83F71F;
        Fri, 31 Jul 2020 05:05:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v4 10/10] sched/topology: Use prebuilt SD flag degeneration mask
Date:   Fri, 31 Jul 2020 12:55:02 +0100
Message-Id: <20200731115502.12954-11-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage SD_DEGENERATE_GROUPS_MASK in sd_degenerate() and
sd_parent_degenerate(). The negation of SD_DEGENERATE_GROUPS_MASK is used
as the mask of flags not requiring groups, which is equivalent to
SD_WAKE_AFFINE, IOW is the same as what we have now.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c6ecc395c76c..0cc5ce5cd034 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -160,22 +160,12 @@ static int sd_degenerate(struct sched_domain *sd)
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
-		if (sd->groups != sd->groups->next)
-			return 0;
-	}
+	if ((sd->flags & SD_DEGENERATE_GROUPS_MASK) &&
+	    (sd->groups != sd->groups->next))
+		return 0;
 
 	/* Following flags don't use groups */
-	if (sd->flags & (SD_WAKE_AFFINE))
+	if (sd->flags & ~SD_DEGENERATE_GROUPS_MASK)
 		return 0;
 
 	return 1;
@@ -193,18 +183,9 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 		return 0;
 
 	/* Flags needing groups don't count if only 1 group in parent */
-	if (parent->groups == parent->groups->next) {
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
-	}
+	if (parent->groups == parent->groups->next)
+		pflags &= ~SD_DEGENERATE_GROUPS_MASK;
+
 	if (~cflags & pflags)
 		return 0;
 
-- 
2.27.0

