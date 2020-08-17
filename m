Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478A1207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgHQLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:31:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgHQLaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A2D031B;
        Mon, 17 Aug 2020 04:30:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25CE73F66B;
        Mon, 17 Aug 2020 04:30:28 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 11/17] sched/topology: Mark SD_PREFER_SIBLING as SDF_NEEDS_GROUPS
Date:   Mon, 17 Aug 2020 12:29:57 +0100
Message-Id: <20200817113003.20802-12-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_PREFER_SIBLING is currently considered in sd_parent_degenerate() but not
in sd_degenerate(). It too hinges on load balancing, and thus won't have
any effect when set on a domain with a single group. Add it to
SD_DEGENERATE_GROUPS_MASK.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 4 +++-
 kernel/sched/topology.c        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 4f07b405564e..75c9749a6e2d 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -131,8 +131,10 @@ SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD)
  *
  * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
  * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ *
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_PREFER_SIBLING, 0)
+SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
 
 /*
  * sched_groups of this level overlap
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 02fd8db747b2..8064f495641b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -184,7 +184,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next)
-		pflags &= ~(SD_DEGENERATE_GROUPS_MASK | SD_PREFER_SIBLING);
+		pflags &= ~SD_DEGENERATE_GROUPS_MASK;
 
 	if (~cflags & pflags)
 		return 0;
-- 
2.27.0

