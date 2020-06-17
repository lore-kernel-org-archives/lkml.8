Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF71C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557F5207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFQLid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:38:33 -0400
Received: from foss.arm.com ([217.140.110.172]:56256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgFQLi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59AB1045;
        Wed, 17 Jun 2020 04:38:26 -0700 (PDT)
Received: from monolith.arm.com (unknown [10.37.8.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6640B3F71F;
        Wed, 17 Jun 2020 04:38:24 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v5 3/7] arm64: perf: Remove PMU locking
Date:   Wed, 17 Jun 2020 12:38:47 +0100
Message-Id: <20200617113851.607706-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617113851.607706-1-alexandru.elisei@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

The PMU is disabled and enabled, and the counters are programmed from
contexts where interrupts or preemption is disabled.

The functions to toggle the PMU and to program the PMU counters access the
registers directly and don't access data modified by the interrupt handler.
That, and the fact that they're always called from non-preemptible
contexts, means that we don't need to disable interrupts or use a spinlock.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
[Explained why locking is not needed, removed WARN_ONs]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e95b5ca70a53..a6195022be7d 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -647,15 +647,10 @@ static inline u32 armv8pmu_getreset_flags(void)
 
 static void armv8pmu_enable_event(struct perf_event *event)
 {
-	unsigned long flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
 	/*
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -678,21 +673,10 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter
 	 */
 	armv8pmu_enable_event_counter(event);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
 {
-	unsigned long flags;
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	/*
-	 * Disable counter and interrupt
-	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-
 	/*
 	 * Disable counter
 	 */
@@ -702,30 +686,18 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 * Disable interrupt for this counter
 	 */
 	armv8pmu_disable_event_irq(event);
-
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
-	unsigned long flags;
-	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
-- 
2.27.0

