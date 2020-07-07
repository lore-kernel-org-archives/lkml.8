Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBC5206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155232;
	bh=xJolK0a9Z53WodIu2B1PUZ6FStSIhgITxUIQWq8f02k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ABGIRqmhOqgbsDQ0ERL50m6HH71q3PQw4PFCFs1SjvpbFJFM1rzIVQru5vGl8Hmfd
	 c22+EWLCsY7jxw0XY41vZDGhGArmYkuXOsKBy4IHYDURfsECHwQpXJ+z+opmr39Bnw
	 8xMAeBTG0V52+ISB1ZXXgzAEg/1qrxBxACLVbq5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgGGUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40922 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgGGUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:42 -0400
Received: by mail-io1-f65.google.com with SMTP id q8so44702139iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MJVEV7Cc73iH9jWoT+nouPpY4EFOK2eJCHimu/Xr9g=;
        b=sicecIRdPGYk9fZx0OuR13/n05f1KAFU9X6zrXd/TBPIGfv/fuqDM0/5rds2PCHP+W
         /6uxh0VDA4fOftXpFY8EfAuOkBxtD9lh90VYuuH8QRwPm14QPOb/VgSSYlSU7GRxiZ3V
         O47S77zs+ZVLpoc9qU1CtpQHQ2yrA7uhhns3EcKbkUeE/dxOxstp2ZPbjApbq4Gq2P89
         WOXg4qU0vhxm3NZIRQCxvJAqSM/Lms/5v8seTXoa+7rYou6FaDQn613gP6UzSNjJG8gj
         x/4V4zlr4sko8ZeFXvxFLKN3JeyQQPmU060Kp6SaxfxWG0BUtUqio3DpX/LpCyaI6ICk
         i67Q==
X-Gm-Message-State: AOAM533o76G5qRx70G9/CO4KijCwJG+nto0HNxyvV6yrJxk1M8vRVblm
        LP19eVJMUSfQywIbyf5TkQ==
X-Google-Smtp-Source: ABdhPJzpJzVGfY0b+APYDnSwYQjc9bF9NoyfT27dIgTEwL14LViwiJWsKiqD9Y4MqZOkRIMoA6kG5w==
X-Received: by 2002:a6b:d31a:: with SMTP id s26mr33382023iob.48.1594155220682;
        Tue, 07 Jul 2020 13:53:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/5] arm64: perf: Enable pmu counter direct access for perf event on armv8
Date:   Tue,  7 Jul 2020 14:53:32 -0600
Message-Id: <20200707205333.624938-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707205333.624938-1-robh@kernel.org>
References: <20200707205333.624938-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Keep track of event opened with direct access to the hardware counters
and modify permissions while they are open.

The strategy used here is the same which x86 uses: everytime an event
is mapped, the permissions are set if required. The atomic field added
in the mm_context helps keep track of the different event opened and
de-activate the permissions when all are unmapped.
We also need to update the permissions in the context switch code so
that tasks keep the right permissions.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes:
 - Drop homogeneous check
 - Disable access for chained counters
 - Set pmc_width in user page
---
 arch/arm64/include/asm/mmu.h         |  6 +++++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
 arch/arm64/kernel/perf_event.c       |  4 +++
 drivers/perf/arm_pmu.c               | 38 ++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 68140fdd89d6..420938fe4982 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,12 @@

 typedef struct {
 	atomic64_t	id;
+
+	/*
+	 * non-zero if userspace have access to hardware
+	 * counters directly.
+	 */
+	atomic_t	pmu_direct_access;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b0bd9b55594c..b6c5a8df36ba 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -21,6 +21,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
+#include <asm/perf_event.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>

@@ -226,6 +227,7 @@ static inline void __switch_mm(struct mm_struct *next)
 	}

 	check_and_switch_context(next, cpu);
+	perf_switch_user_access(next);
 }

 static inline void
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index e7765b62c712..65d47a7106db 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -8,6 +8,7 @@

 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
+#include <linux/mm_types.h>

 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -224,4 +225,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }

+static inline void perf_switch_user_access(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return;
+
+	if (atomic_read(&mm->context.pmu_direct_access)) {
+		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
+			     pmuserenr_el0);
+	} else {
+		write_sysreg(0, pmuserenr_el0);
+	}
+}
+
 #endif
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 6c12a6ad36f5..93975ea0ec1a 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1250,6 +1250,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 	 */
 	freq = arch_timer_get_rate();
 	userpg->cap_user_time = 1;
+	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);
+
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = armv8pmu_event_is_64bit(event) ? 64 : 32;

 	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
 			NSEC_PER_SEC, 0);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index df352b334ea7..7a3263a09b34 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -25,6 +25,7 @@
 #include <linux/irqdesc.h>

 #include <asm/irq_regs.h>
+#include <asm/mmu_context.h>

 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
@@ -778,6 +779,41 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 					    &cpu_pmu->node);
 }

+static void refresh_pmuserenr(void *mm)
+{
+	perf_switch_user_access(mm);
+}
+
+static void armpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	/*
+	 * This function relies on not being called concurrently in two
+	 * tasks in the same mm.  Otherwise one task could observe
+	 * pmu_direct_access > 1 and return all the way back to
+	 * userspace with user access disabled while another task is still
+	 * doing on_each_cpu_mask() to enable user access.
+	 *
+	 * For now, this can't happen because all callers hold mmap_sem
+	 * for write.  If this changes, we'll need a different solution.
+	 */
+	lockdep_assert_held_write(&mm->mmap_lock);
+
+	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
+		on_each_cpu(refresh_pmuserenr, mm, 1);
+}
+
+static void armpmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
+		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
+}
+
 static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 {
 	struct arm_pmu *pmu;
@@ -799,6 +835,8 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
+		.event_mapped	= armpmu_event_mapped,
+		.event_unmapped	= armpmu_event_unmapped,
 		.add		= armpmu_add,
 		.del		= armpmu_del,
 		.start		= armpmu_start,
--
2.25.1
