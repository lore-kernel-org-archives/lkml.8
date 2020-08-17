Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D982067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgHQLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:31:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgHQLa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E42D21045;
        Mon, 17 Aug 2020 04:30:27 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AECD43F66B;
        Mon, 17 Aug 2020 04:30:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com
Subject: [PATCH v6 10/17] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
Date:   Mon, 17 Aug 2020 12:29:56 +0100
Message-Id: <20200817113003.20802-11-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently set this flag *only* on domains whose topology level exactly
match the level where we detect asymmetry (as returned by
asym_cpu_capacity_level()). This is rather problematic.

Say there are two clusters in the system, one with a lone big CPU and the
other with a mix of big and LITTLE CPUs (as is allowed by DynamIQ):

DIE [                ]
MC  [             ][ ]
     0   1   2   3  4
     L   L   B   B  B

asym_cpu_capacity_level() will figure out that the MC level is the one
where all CPUs can see a CPU of max capacity, and we will thus set
SD_ASYM_CPUCAPACITY at MC level for all CPUs.

That lone big CPU will degenerate its MC domain, since it would be alone in
there, and will end up with just a DIE domain. Since the flag was only set
at MC, this CPU ends up not seeing any SD with the flag set, which is
broken.

Rather than clearing dflags at every topology level, clear it before
entering the topology level loop. This will properly propagate upwards
flags that are set starting from a certain level.

Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 4 +++-
 kernel/sched/topology.c        | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 21a43ad6f26a..4f07b405564e 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -83,9 +83,11 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 /*
  * Domain members have different CPU capacities
  *
+ * SHARED_PARENT: Set from the topmost domain down to the first domain where
+ *                asymmetry is detected.
  * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
  */
-SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_NEEDS_GROUPS)
+SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU capacity (i.e. SMT)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 00ad7cef2ec1..02fd8db747b2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1988,11 +1988,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
 		struct sched_domain_topology_level *tl;
+		int dflags = 0;
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			int dflags = 0;
-
 			if (tl == tl_asym) {
 				dflags |= SD_ASYM_CPUCAPACITY;
 				has_asym = true;
-- 
2.27.0

