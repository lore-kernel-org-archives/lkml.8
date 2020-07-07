Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD99C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F49206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155223;
	bh=zkFjkplM0GDkYO9QlX2A0qg7HKN/F+qnN/YManly1L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7E95hqhD+etxsAzUVzESpO5kIGpb8bswG512gqn5+ncwTXOsgMYraNdI7nVi+IwQ
	 wWTrKQy1EFidT+0le7sASkPEtsHk+xcR381JA0Yq2hltudOsGh4IUvyi6+UN6l/zkc
	 WRtGzLzHhIUPEIGhyxNwcnVFnaWbtOdt07kk3CTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgGGUxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgGGUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:39 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so44625405iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MutG5e0ak9+mnQszlEcX011m8VM8IwdPrWKEFzeJcKg=;
        b=VaPf1+aFKZfWasmTGBBYJjI8DFYqvl34d1yth1NCAMiD5H2vvj9mExkaXrbSN16PEA
         1PmEfFxQ2lgV0ni0YLqVzR9j+T2WCCgntxxBA0z/6ckSP+FAlwC798CZ1Srkm+ywNNHg
         rTGZiSq1pKbN2Vi0fzqZhjL5utN8yR+C4rwhYftACrkfYNj86fkjoqS/9mBL30QDpSIm
         XlVeYVlYksFcFcfmzKa6e+fVEH5IVb922MvYX70UVWgn00qFETg/wblmDVRq0sqBJmo4
         QTPnYHBRE1FZd5M4nmvCt9GvGI7zZEktCI1okmJouoqYctc8S45vBxbyJkkhNXUlZlgg
         7+fw==
X-Gm-Message-State: AOAM532Oy11DbQp4Etbpv5Lkp2kBbueHPp+tcaXeQjautMJ1cO31i7cn
        k1jBwlH9CCGDcdeeU4h2eg==
X-Google-Smtp-Source: ABdhPJwfNIlmhSEBsPu6mZcdiF3gwDsJlyvfkbi1HICFy/WuYQawQxuYTX43Lww3xbuf+BVN2+w8Aw==
X-Received: by 2002:a02:cd06:: with SMTP id g6mr30640822jaq.37.1594155218139;
        Tue, 07 Jul 2020 13:53:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:37 -0700 (PDT)
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
Subject: [PATCH 2/5] arm64: pmu: Add hook to handle pmu-related undefined instructions
Date:   Tue,  7 Jul 2020 14:53:30 -0600
Message-Id: <20200707205333.624938-3-robh@kernel.org>
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
 arch/arm64/kernel/cpufeature.c |  4 +--
 arch/arm64/kernel/perf_event.c | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4ae41670c2e6..2a34adac86c6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2744,8 +2744,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
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
index 4d7879484cec..d4b4fe69fe2c 100644
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

 #include <linux/acpi.h>
@@ -991,6 +993,59 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }

+static int emulate_pmu(struct pt_regs *regs, u32 insn)
+{
+	u32 sys_reg, rt;
+	u32 pmuserenr;
+
+	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
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
