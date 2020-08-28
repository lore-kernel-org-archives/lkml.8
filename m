Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D615E2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648196;
	bh=P7/GZ4fMNXQM9Y4eRU9RQsPhzj7G7Mxw57zr0wb6x/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EX3TRaIBIKs2BtBDPZ7kQAJHb8REaaPnhLp/Hq4y0mmm95+3RoogA9WV85/2Nmsk0
	 jEpQCk//uXK1kqLwknLOoJ3eQmqaL+UxQ8VEbKjaB5vJzW7QVm+molF5QnNt0nPIpr
	 n6AhxL2XuiLLO8uQQklA4JaXKIPjQh+X4rP/k7zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgH1U4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46728 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1U40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:26 -0400
Received: by mail-il1-f193.google.com with SMTP id c6so1792988ilo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV/NJwKiI4ho72v7Wl7XJgGkuK2ZmPRXa/ZcvRowyvA=;
        b=IrmJ0iwDDmZtVnR1ECjKi0XafI+rJ5pn4/CSX1dyaGY99JDL9/XpVSAERAVvWAEhet
         yGPjuWFa2SBTP+KII+epxd4rBHjzuYicOYh4gcfSYOtGmWAjmxSPcwCJmHrMjLMhziBh
         aHvxkeJKWyDcXp4mDAQKoTuja5WWdF4V4OJ+ChTuvv3T67UABSuL8a4S2ykzWSeD4rHB
         oWszO3qkxaU7SnzFldmx/+hwedwzvR1BbUd65sBtQNolL8cue9RiWXezYmTY+HpuzkuW
         73oiLA3Pvi45l3ew5k+QHn+p3p7wZ5o3NDwdPrJmzqMBcePzKA8czlsPfN4hSq2BXTkX
         5lUA==
X-Gm-Message-State: AOAM533ZyGp7r2sWMN9CehL6u7UyRVoVOA6QmyjZEEM2Hgfz5fbwyFv8
        ty1vz6h7GyOQ3rYguBUYUQ==
X-Google-Smtp-Source: ABdhPJxeyzFQbIEPzgdKe3IQHVj4oqKwQlWYU1KbBXmt1r7n3YD7Cg3Dkt75pGMYCugHG/G3suIeFQ==
X-Received: by 2002:a05:6e02:ef2:: with SMTP id j18mr642058ilk.2.1598648185312;
        Fri, 28 Aug 2020 13:56:25 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 3/9] arm64: perf: Enable pmu counter direct access for perf event on armv8
Date:   Fri, 28 Aug 2020 14:56:08 -0600
Message-Id: <20200828205614.3391252-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
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
v2:
 - Move mapped/unmapped into arm64 code. Fixes arm32.
 - Rebase on cap_user_time_short changes

Changes from Raphael's v4:
  - Drop homogeneous check
  - Disable access for chained counters
  - Set pmc_width in user page
---
 arch/arm64/include/asm/mmu.h         |  5 ++++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
 arch/arm64/kernel/perf_event.c       | 41 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index a7a5ecaa2e83..52cfdb676f06 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,11 @@
 
 typedef struct {
 	atomic64_t	id;
+	/*
+	 * non-zero if userspace have access to hardware
+	 * counters directly.
+	 */
+	atomic_t	pmu_direct_access;
 #ifdef CONFIG_COMPAT
 	void		*sigpage;
 #endif
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f2d7537d6f83..d24589ecb07a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -21,6 +21,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
+#include <asm/perf_event.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
@@ -224,6 +225,7 @@ static inline void __switch_mm(struct mm_struct *next)
 	}
 
 	check_and_switch_context(next);
+	perf_switch_user_access(next);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 2c2d7dbe8a02..a025d9595d51 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -8,6 +8,7 @@
 
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
+#include <linux/mm_types.h>
 
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -251,4 +252,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
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
index 2727d126cecd..cf44591f5be1 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -836,6 +836,41 @@ static int armv8pmu_access_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void refresh_pmuserenr(void *mm)
+{
+	perf_switch_user_access(mm);
+}
+
+static void armv8pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
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
+	 * For now, this can't happen because all callers hold mmap_lock
+	 * for write.  If this changes, we'll need a different solution.
+	 */
+	lockdep_assert_held_write(&mm->mmap_lock);
+
+	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
+		on_each_cpu(refresh_pmuserenr, mm, 1);
+}
+
+static void armv8pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
+		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1112,6 +1147,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_access_event_idx;
+	cpu_pmu->pmu.event_mapped	= armv8pmu_event_mapped;
+	cpu_pmu->pmu.event_unmapped	= armv8pmu_event_unmapped;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
@@ -1272,6 +1309,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_time_short = 0;
+	userpg->cap_user_rdpmc = !!(event->hw.flags & ARMPMU_EL0_RD_CNTR);
+
+	if (userpg->cap_user_rdpmc)
+		userpg->pmc_width = armv8pmu_event_is_64bit(event) ? 64 : 32;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
-- 
2.25.1

