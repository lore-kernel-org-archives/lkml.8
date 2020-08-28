Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D1EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5C62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648187;
	bh=6Y9FQy2gkr1wlQIry7m0Tr+ZJEYfl/keMal96M5+Co8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rRh/BfmBT+ONifh1gmDQDqT12DOcTxEzJ9mju+cwRIzz66XeRreHc/GfCDArfg7n+
	 7eSrVsxXWPeN7szLAJ1TPDT6l3JGSkeX22j9P8/iR6C5dfuUVXXJABFR04vgq26H3D
	 XM9LopJ1FY6Wzu8n5flxZX48uIv1Uzd9LajW/pQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgH1U4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45319 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1U4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:20 -0400
Received: by mail-io1-f67.google.com with SMTP id u126so372048iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9z3VR6zD4FpK2wX25Sr8AogKHA4TBLm2zvFT7kdd5s=;
        b=jE6sYdaVZjDxE1Ig6SHnkOrsLCWGsdbOmmD0BQSLCeVZQ0X/reoCehML3lnAkgO3Yg
         qAiKwQyHryQeSNGmDnS040acyaoBV8I+U4hz/B1ymYybCSlnwvLRhwFnsaFRmZm7sT3J
         exshUbMlKz9aHikaQuT76TgMms1EXAm6cKEV+Gbnf4U3R6WCKemzPVz2pVGxVw6HR1nJ
         Ck4ep10otVM5w64cgLahPaOgaZnuZnsBUK/H6clmH0P1Uj4hbnkpOOD/dCsD2fbc2B13
         a+VlBrdABD+lTNT7EWhRdcJww95dFV4o9yXLMZmd4l0Mvwf7GD/0pnDCGYxhTpT0Tnj4
         iGvQ==
X-Gm-Message-State: AOAM5338LLDAf0e0Qn1UkCN8/EVIfXB2FD7DKY27xKXfb3DRGBT4LqEz
        xoZv0X7nJIwT7DoIqkXO1A==
X-Google-Smtp-Source: ABdhPJzP8WExZ75Y0WDb21p745r6kjxEkhwFK5rZL6G5aFJRZnLtGy9/1Zrj4J8+Df9GoO9K7Rca7w==
X-Received: by 2002:a05:6602:584:: with SMTP id v4mr472293iox.195.1598648180025;
        Fri, 28 Aug 2020 13:56:20 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:19 -0700 (PDT)
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
Subject: [PATCH v2 1/9] arm64: pmu: Add hook to handle pmu-related undefined instructions
Date:   Fri, 28 Aug 2020 14:56:06 -0600
Message-Id: <20200828205614.3391252-2-robh@kernel.org>
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

This patch introduces a protection for the userspace processes which are
trying to access the registers from the pmu registers on a big.LITTLE
environment. It introduces a hook to handle undefined instructions.

The goal here is to prevent the process to be interrupted by a signal
when the error is caused by the task being scheduled while accessing
a counter, causing the counter access to be invalid. As we are not able
to know efficiently the number of counters available physically on both
pmu in that context we consider that any faulting access to a counter
which is architecturally correct should not cause a SIGILL signal if
the permissions are set accordingly.

This commit also modifies the mask of the mrs_hook declared in
arch/arm64/kernel/cpufeatures.c which emulates only feature register
access. This is necessary because this hook's mask was too large and
thus masking any mrs instruction, even if not related to the emulated
registers which made the pmu emulation inefficient.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix warning for set but unused sys_reg
---
 arch/arm64/kernel/cpufeature.c |  4 +--
 arch/arm64/kernel/perf_event.c | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a389b999482e..00bf53ffd9b0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2811,8 +2811,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
 }
 
 static struct undef_hook mrs_hook = {
-	.instr_mask = 0xfff00000,
-	.instr_val  = 0xd5300000,
+	.instr_mask = 0xffff0000,
+	.instr_val  = 0xd5380000,
 	.pstate_mask = PSR_AA32_MODE_MASK,
 	.pstate_val = PSR_MODE_EL0t,
 	.fn = emulate_mrs,
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9cc44b..70538ae684da 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -8,9 +8,11 @@
  * This code is based heavily on the ARMv7 perf event code.
  */
 
+#include <asm/cpu.h>
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -1016,6 +1018,58 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static int emulate_pmu(struct pt_regs *regs, u32 insn)
+{
+	u32 rt;
+	u32 pmuserenr;
+
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	pmuserenr = read_sysreg(pmuserenr_el0);
+
+	if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
+	    (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
+		return -EINVAL;
+
+
+	/*
+	 * Userspace is expected to only use this in the context of the scheme
+	 * described in the struct perf_event_mmap_page comments.
+	 *
+	 * Given that context, we can only get here if we got migrated between
+	 * getting the register index and doing the MSR read.  This in turn
+	 * implies we'll fail the sequence and retry, so any value returned is
+	 * 'good', all we need is to be non-fatal.
+	 *
+	 * The choice of the value 0 is comming from the fact that when
+	 * accessing a register which is not counting events but is accessible,
+	 * we get 0.
+	 */
+	pt_regs_write_reg(regs, rt, 0);
+
+	arm64_skip_faulting_instruction(regs, 4);
+	return 0;
+}
+
+/*
+ * This hook will only be triggered by mrs
+ * instructions on PMU registers. This is mandatory
+ * in order to have a consistent behaviour even on
+ * big.LITTLE systems.
+ */
+static struct undef_hook pmu_hook = {
+	.instr_mask = 0xffff8800,
+	.instr_val  = 0xd53b8800,
+	.fn = emulate_pmu,
+};
+
+static int __init enable_pmu_emulation(void)
+{
+	register_undef_hook(&pmu_hook);
+	return 0;
+}
+
+core_initcall(enable_pmu_emulation);
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 			  int (*map_event)(struct perf_event *event),
 			  const struct attribute_group *events,
-- 
2.25.1

