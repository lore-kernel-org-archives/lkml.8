Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8618FC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72E20738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgCKSdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:33:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730641AbgCKSdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:33:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6A07FA;
        Wed, 11 Mar 2020 11:33:34 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0F613F6CF;
        Wed, 11 Mar 2020 11:33:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [RFC PATCH 3/3] sched/topology: Verify SD_* flags setup when sched_debug is on
Date:   Wed, 11 Mar 2020 18:33:20 +0000
Message-Id: <20200311183320.19186-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311183320.19186-1-valentin.schneider@arm.com>
References: <20200311183320.19186-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have some description of what we expect the flags layout to
be, we can use that to assert at runtime that the actual layout is sane.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index af30e2198b22..2e9aee29b3a6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -29,6 +29,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 				  struct cpumask *groupmask)
 {
 	struct sched_group *group = sd->groups;
+	int flags = sd->flags;
 
 	cpumask_clear(groupmask);
 
@@ -43,6 +44,21 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
 	}
 
+	for (; flags; flags &= flags - 1) {
+		unsigned int idx = __ffs(flags);
+		unsigned int flag = BIT(idx);
+		unsigned int meta_flags = sd_flag_debug[idx].meta_flags;
+
+		if ((meta_flags & SDF_SHARED_CHILD) && sd->child &&
+		    !(sd->child->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in child\n",
+			       sd_flag_debug[idx].name);
+		else if ((meta_flags & SDF_SHARED_PARENT) && sd->parent &&
+			 !(sd->parent->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in parent\n",
+			       sd_flag_debug[idx].name);
+	}
+
 	printk(KERN_DEBUG "%*s groups:", level + 1, "");
 	do {
 		if (!group) {
-- 
2.24.0

