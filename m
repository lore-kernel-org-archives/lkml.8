Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFDAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0443208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgGaMFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:05:12 -0400
Received: from foss.arm.com ([217.140.110.172]:56178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732965AbgGaMFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A07106F;
        Fri, 31 Jul 2020 05:05:06 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FD0E3F71F;
        Fri, 31 Jul 2020 05:05:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v4 02/10] ARM: Revert back to default scheduler topology.
Date:   Fri, 31 Jul 2020 12:54:54 +0100
Message-Id: <20200731115502.12954-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM-specific GMC level is meant to be built using the thread sibling
mask, but no devicetree in arch/arm/boot/dts uses the 'thread' cpu-map
binding. With SD_SHARE_POWERDOMAIN gone, this topology level can be
removed, at which point ARM no longer benefits from having a custom defined
topology table.

Delete the GMC topology level by making ARM use the default scheduler
topology table. This essentially reverts commit

  fb2aa85564f4 ("sched, ARM: Create a dedicated scheduler topology table")

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/kernel/topology.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 353f3ee660e4..ef0058de432b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -177,15 +177,6 @@ static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
-/*
- * The current assumption is that we can power gate each core independently.
- * This will be superseded by DT binding once available.
- */
-const struct cpumask *cpu_corepower_mask(int cpu)
-{
-	return &cpu_topology[cpu].thread_sibling;
-}
-
 /*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
@@ -241,20 +232,6 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }
 
-static inline int cpu_corepower_flags(void)
-{
-	return SD_SHARE_PKG_RESOURCES;
-}
-
-static struct sched_domain_topology_level arm_topology[] = {
-#ifdef CONFIG_SCHED_MC
-	{ cpu_corepower_mask, cpu_corepower_flags, SD_INIT_NAME(GMC) },
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
-
 /*
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
@@ -265,7 +242,4 @@ void __init init_cpu_topology(void)
 	smp_wmb();
 
 	parse_dt_topology();
-
-	/* Set scheduler topology descriptor */
-	set_sched_topology(arm_topology);
 }
-- 
2.27.0

