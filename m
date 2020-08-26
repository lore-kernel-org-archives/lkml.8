Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BBF20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgHZNEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730185AbgHZNEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880C81045;
        Wed, 26 Aug 2020 06:04:07 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 185193F68F;
        Wed, 26 Aug 2020 06:04:05 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: implement CPPC FFH support using AMUs
Date:   Wed, 26 Aug 2020 14:03:09 +0100
Message-Id: <20200826130309.28027-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826130309.28027-1-ionela.voinescu@arm.com>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Activity Monitors (AMUs) are present, two of the counters can be used
to implement support for CPPC's (Collaborative Processor Performance
Control) delivered and reference performance monitoring functionality
using FFH (Functional Fixed Hardware).

Given that counters for a certain CPU can only be read from that CPU,
while FFH operations can be called from any CPU for any of the CPUs, use
smp_call_function_single() to provide the requested values.

Therefore, depending on the register addresses, the following values
are returned:
 - 0x0 (DeliveredPerformanceCounterRegister): AMU core counter
 - 0x1 (ReferencePerformanceCounterRegister): AMU constant counter

The use of Activity Monitors is hidden behind the generic
{read,store}_{corecnt,constcnt}() functions.

Read functionality for these two registers represents the only current
FFH support for CPPC. Read operations for other register values or write
operation for all registers are unsupported. Therefore, keep CPPC's FFH
unsupported if no CPUs have valid AMU frequency counters.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/topology.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index edc44b46e34f..cb0372de9aa9 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -326,3 +326,65 @@ void topology_scale_freq_tick(void)
 	this_cpu_write(arch_core_cycles_prev, core_cnt);
 	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+
+static inline
+int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
+{
+	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
+
+	if (!cnt_cpu_mask || !cpumask_test_cpu(cpu, cnt_cpu_mask))
+		return -EOPNOTSUPP;
+
+	smp_call_function_single(cpu, func, val, 1);
+
+	return 0;
+}
+
+/*
+ * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
+ * below.
+ */
+bool cpc_ffh_supported(void)
+{
+	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
+	int cpu = nr_cpu_ids;
+
+	if (cnt_cpu_mask)
+		cpu = cpumask_any_and(cnt_cpu_mask, cpu_present_mask);
+
+	if ((cpu >= nr_cpu_ids) || !freq_counters_valid(cpu))
+		return false;
+
+	return true;
+}
+
+int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch ((u64)reg->address) {
+	case 0x0:
+		ret = counters_read_on_cpu(cpu, store_corecnt, val);
+		break;
+	case 0x1:
+		ret = counters_read_on_cpu(cpu, store_constcnt, val);
+		break;
+	}
+
+	if (!ret) {
+		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+				    reg->bit_offset);
+		*val >>= reg->bit_offset;
+	}
+
+	return ret;
+}
+
+int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
-- 
2.17.1

