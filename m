Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25933C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A54920838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHLMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:54:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgHLMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:53:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221F51396;
        Wed, 12 Aug 2020 05:53:20 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF62D3F70D;
        Wed, 12 Aug 2020 05:53:18 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v5 05/17] sched/topology: Verify SD_* flags setup when sched_debug is on
Date:   Wed, 12 Aug 2020 13:52:48 +0100
Message-Id: <20200812125300.11889-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812125300.11889-1-valentin.schneider@arm.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have some description of what we expect the flags layout to
be, we can use that to assert at runtime that the actual layout is sane.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 865fff3ef20a..f128fcf46a41 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -29,6 +29,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 				  struct cpumask *groupmask)
 {
 	struct sched_group *group = sd->groups;
+	unsigned long flags = sd->flags;
+	unsigned int idx;
 
 	cpumask_clear(groupmask);
 
@@ -43,6 +45,21 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
 	}
 
+	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
+		unsigned int flag = BIT(idx);
+		unsigned int meta_flags = sd_flag_debug[idx].meta_flags;
+
+		if ((meta_flags & SDF_SHARED_CHILD) && sd->child &&
+		    !(sd->child->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in child\n",
+			       sd_flag_debug[idx].name);
+
+		if ((meta_flags & SDF_SHARED_PARENT) && sd->parent &&
+		    !(sd->parent->flags & flag))
+			printk(KERN_ERR "ERROR: flag %s set here but not in parent\n",
+			       sd_flag_debug[idx].name);
+	}
+
 	printk(KERN_DEBUG "%*s groups:", level + 1, "");
 	do {
 		if (!group) {
-- 
2.27.0

