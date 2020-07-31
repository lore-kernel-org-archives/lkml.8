Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F87A22CAE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbgGaMFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:10 -0400
Received: from foss.arm.com ([217.140.110.172]:56192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbgGaMFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D918D1FB;
        Fri, 31 Jul 2020 05:05:07 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF1A73F71F;
        Fri, 31 Jul 2020 05:05:06 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Quentin Perret <qperret@google.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v4 03/10] sched/topology: Propagate SD_ASYM_CPUCAPACITY upwards
Date:   Fri, 31 Jul 2020 12:54:55 +0100
Message-Id: <20200731115502.12954-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 865fff3ef20a..42b89668e1e4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1985,11 +1985,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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

