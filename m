Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13E120663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgGaMFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:17 -0400
Received: from foss.arm.com ([217.140.110.172]:56238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732965AbgGaMFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A66106F;
        Fri, 31 Jul 2020 05:05:13 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 173113F71F;
        Fri, 31 Jul 2020 05:05:11 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v4 07/10] sched/topology: Add more flags to the SD degeneration mask
Date:   Fri, 31 Jul 2020 12:54:59 +0100
Message-Id: <20200731115502.12954-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it is going to change much in practice, but we were missing
those:

o SD_BALANCE_WAKE: Used just like the other SD_BALANCE_* flags, so also
  needs > 1 group.
o SD_ASYM_PACKING: Hinges on load balancing (periodic / wakeup), thus needs
  > 1 group to happen
o SD_OVERLAP: Describes domains with overlapping groups; can't have
  overlaps with a single group.

SD_PREFER_SIBLING is as always the odd one out: we currently consider it
in sd_parent_degenerate() but not in sd_degenerate(). It too hinges on load
balancing, and thus won't have any effect when set on a domain with a
single group. Add it to the sd_degenerate() groups mask.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cda02507aebf..93a7ff52335b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -161,11 +161,15 @@ static int sd_degenerate(struct sched_domain *sd)
 
 	/* Following flags need at least 2 groups */
 	if (sd->flags & (SD_BALANCE_NEWIDLE |
+			 SD_BALANCE_WAKE |
 			 SD_BALANCE_FORK |
 			 SD_BALANCE_EXEC |
+			 SD_ASYM_PACKING |
 			 SD_SHARE_CPUCAPACITY |
 			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES)) {
+			 SD_SHARE_PKG_RESOURCES |
+			 SD_OVERLAP |
+			 SD_PREFER_SIBLING)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -191,11 +195,14 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
 		pflags &= ~(SD_BALANCE_NEWIDLE |
+			    SD_BALANCE_WAKE |
 			    SD_BALANCE_FORK |
 			    SD_BALANCE_EXEC |
+			    SD_ASYM_PACKING |
 			    SD_ASYM_CPUCAPACITY |
 			    SD_SHARE_CPUCAPACITY |
 			    SD_SHARE_PKG_RESOURCES |
+			    SD_OVERLAP |
 			    SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
-- 
2.27.0

