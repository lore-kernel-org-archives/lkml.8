Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69518207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgCaJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:56:01 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:51616 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730217AbgCaJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:56:01 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 05:56:00 EDT
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 31 Mar
 2020 17:40:50 +0800
Received: from zx.zhaoxin.com (10.28.64.103) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 31 Mar
 2020 17:40:48 +0800
From:   CodyYao-oc <CodyYao-oc@zhaoxin.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cooperyan@zhaoxin.com>, CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: [PATCH] x86/perf: Add hardware performance events support for Zhaoxin CPU.
Date:   Tue, 31 Mar 2020 17:39:59 +0800
Message-ID: <1585647599-6649-1-git-send-email-CodyYao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.64.103]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoxin CPU has provided facilities for monitoring performance
via PMU(Performance Monitor Unit), but the functionality is unused so far.
Therefore, add support for zhaoxin pmu to make performance related
hardware events available.

Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
---
 arch/x86/events/Makefile               |   2 +
 arch/x86/events/core.c                 |   4 +
 arch/x86/events/perf_event.h           |   9 +
 arch/x86/events/zhaoxin/Makefile       |   2 +
 arch/x86/events/zhaoxin/core.c         | 618 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/perfctr-watchdog.c |   6 +
 6 files changed, 641 insertions(+)
 create mode 100644 arch/x86/events/zhaoxin/Makefile
 create mode 100644 arch/x86/events/zhaoxin/core.c

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9e07f55..6f1d1fd 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -3,3 +3,5 @@ obj-y					+= core.o probe.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
+obj-$(CONFIG_CPU_SUP_CENTAUR)		+= zhaoxin/
+obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin/
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bb738f..e76048e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1839,6 +1839,10 @@ static int __init init_hw_perf_events(void)
 		err = amd_pmu_init();
 		x86_pmu.name = "HYGON";
 		break;
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		err = zhaoxin_pmu_init();
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f1cd1ca..f6bbdca 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1133,3 +1133,12 @@ static inline int is_ht_workaround_enabled(void)
 	return 0;
 }
 #endif /* CONFIG_CPU_SUP_INTEL */
+
+#if ((defined CONFIG_CPU_SUP_CENTAUR) || (defined CONFIG_CPU_SUP_ZHAOXIN))
+int zhaoxin_pmu_init(void);
+#else
+static inline int zhaoxin_pmu_init(void)
+{
+	return 0;
+}
+#endif /*CONFIG_CPU_SUP_CENTAUR or CONFIG_CPU_SUP_ZHAOXIN*/
diff --git a/arch/x86/events/zhaoxin/Makefile b/arch/x86/events/zhaoxin/Makefile
new file mode 100644
index 0000000..642c1174
--- /dev/null
+++ b/arch/x86/events/zhaoxin/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= core.o
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
new file mode 100644
index 0000000..442251a
--- /dev/null
+++ b/arch/x86/events/zhaoxin/core.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Per cpu state
+ *
+ * Used to coordinate shared registers among events on a single PMU.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include <linux/nmi.h>
+
+#include <asm/cpufeature.h>
+#include <asm/hardirq.h>
+#include <asm/apic.h>
+
+#include "../perf_event.h"
+
+/*
+ * Zhaoxin PerfMon, used on zxc and later.
+ */
+static u64 zx_pmon_event_map[PERF_COUNT_HW_MAX] __read_mostly = {
+
+	[PERF_COUNT_HW_CPU_CYCLES]        = 0x0082,
+	[PERF_COUNT_HW_INSTRUCTIONS]      = 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]  = 0x0515,
+	[PERF_COUNT_HW_CACHE_MISSES]      = 0x051a,
+	[PERF_COUNT_HW_BUS_CYCLES]        = 0x0083,
+};
+
+static struct event_constraint zxc_event_constraints[] __read_mostly = {
+
+	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
+	EVENT_CONSTRAINT_END
+};
+
+static struct event_constraint zxd_event_constraints[] __read_mostly = {
+
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* retired instructions */
+	FIXED_EVENT_CONSTRAINT(0x0082, 1), /* unhalted core clock cycles */
+	FIXED_EVENT_CONSTRAINT(0x0083, 2), /* unhalted bus clock cycles */
+	EVENT_CONSTRAINT_END
+};
+
+static __initconst const u64 zxd_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0042,
+		[C(RESULT_MISS)] = 0x0538,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0043,
+		[C(RESULT_MISS)] = 0x0562,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0300,
+		[C(RESULT_MISS)] = 0x0301,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x030a,
+		[C(RESULT_MISS)] = 0x030b,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0042,
+		[C(RESULT_MISS)] = 0x052c,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0043,
+		[C(RESULT_MISS)] = 0x0530,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0564,
+		[C(RESULT_MISS)] = 0x0565,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x00c0,
+		[C(RESULT_MISS)] = 0x0534,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0700,
+		[C(RESULT_MISS)] = 0x0709,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+};
+
+static __initconst const u64 zxe_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0568,
+		[C(RESULT_MISS)] = 0x054b,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0669,
+		[C(RESULT_MISS)] = 0x0562,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0300,
+		[C(RESULT_MISS)] = 0x0301,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x030a,
+		[C(RESULT_MISS)] = 0x030b,
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0,
+		[C(RESULT_MISS)] = 0x0,
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0568,
+		[C(RESULT_MISS)] = 0x052c,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = 0x0669,
+		[C(RESULT_MISS)] = 0x0530,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = 0x0564,
+		[C(RESULT_MISS)] = 0x0565,
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x00c0,
+		[C(RESULT_MISS)] = 0x0534,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(BPU)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = 0x0028,
+		[C(RESULT_MISS)] = 0x0029,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+[C(NODE)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)] = -1,
+		[C(RESULT_MISS)] = -1,
+	},
+},
+};
+
+static void zhaoxin_pmu_disable_all(void)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+}
+
+static void zhaoxin_pmu_enable_all(int added)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
+}
+
+static inline u64 zhaoxin_pmu_get_status(void)
+{
+	u64 status;
+
+	rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
+
+	return status;
+}
+
+static inline void zhaoxin_pmu_ack_status(u64 ack)
+{
+	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
+}
+
+static void zhaoxin_pmu_disable_fixed(struct hw_perf_event *hwc)
+{
+	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	u64 ctrl_val, mask;
+
+	mask = 0xfULL << (idx * 4);
+
+	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	wrmsrl(hwc->config_base, ctrl_val);
+}
+
+static void zhaoxin_pmu_disable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+		zhaoxin_pmu_disable_fixed(hwc);
+		return;
+	}
+
+	x86_pmu_disable_event(event);
+}
+
+static void zhaoxin_pmu_enable_fixed(struct hw_perf_event *hwc)
+{
+	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+	u64 ctrl_val, bits, mask;
+
+	/*
+	 * Enable IRQ generation (0x8),
+	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
+	 * if requested:
+	 */
+	bits = 0x8ULL;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
+		bits |= 0x2;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
+		bits |= 0x1;
+
+	bits <<= (idx * 4);
+	mask = 0xfULL << (idx * 4);
+
+	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val &= ~mask;
+	ctrl_val |= bits;
+	wrmsrl(hwc->config_base, ctrl_val);
+}
+
+static void zhaoxin_pmu_enable_event(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+		zhaoxin_pmu_enable_fixed(hwc);
+		return;
+	}
+
+	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+}
+
+/*
+ * This handler is triggered by the local APIC, so the APIC IRQ handling
+ * rules apply:
+ */
+static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct perf_sample_data data;
+	struct cpu_hw_events *cpuc;
+	int bit;
+	u64 status;
+	bool is_zxc;
+	int handled = 0;
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	zhaoxin_pmu_disable_all();
+	status = zhaoxin_pmu_get_status();
+	if (!status)
+		goto done;
+
+	if (boot_cpu_data.x86 == 0x06 &&
+		(boot_cpu_data.x86_model == 0x0f ||
+			boot_cpu_data.x86_model == 0x19))
+		is_zxc = true;
+again:
+
+	/*Clearing status works only if the global control is enable on zxc.*/
+	if (is_zxc)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, x86_pmu.intel_ctrl);
+
+	zhaoxin_pmu_ack_status(status);
+
+	if (is_zxc)
+		wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+
+	inc_irq_stat(apic_perf_irqs);
+
+	/*
+	 * CondChgd bit 63 doesn't mean any overflow status. Ignore
+	 * and clear the bit.
+	 */
+	if (__test_and_clear_bit(63, (unsigned long *)&status)) {
+		if (!status)
+			goto done;
+	}
+
+	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
+		struct perf_event *event = cpuc->events[bit];
+
+		handled++;
+
+		if (!test_bit(bit, cpuc->active_mask))
+			continue;
+
+		x86_perf_event_update(event);
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+
+		if (!x86_perf_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
+	}
+
+	/*
+	 * Repeat if there is more work to be done:
+	 */
+	status = zhaoxin_pmu_get_status();
+	if (status)
+		goto again;
+
+done:
+	zhaoxin_pmu_enable_all(0);
+	return handled;
+}
+
+static u64 zhaoxin_pmu_event_map(int hw_event)
+{
+	return zx_pmon_event_map[hw_event];
+}
+
+static struct event_constraint *
+zhaoxin_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			struct perf_event *event)
+{
+	struct event_constraint *c;
+
+	if (x86_pmu.event_constraints) {
+		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			if ((event->hw.config & c->cmask) == c->code)
+				return c;
+		}
+	}
+
+	return &unconstrained;
+}
+
+PMU_FORMAT_ATTR(event,	"config:0-7");
+PMU_FORMAT_ATTR(umask,	"config:8-15");
+PMU_FORMAT_ATTR(edge,	"config:18");
+PMU_FORMAT_ATTR(inv,	"config:23");
+PMU_FORMAT_ATTR(cmask,	"config:24-31");
+
+static struct attribute *zx_arch_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_cmask.attr,
+	NULL,
+};
+
+static ssize_t zhaoxin_event_sysfs_show(char *page, u64 config)
+{
+	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT);
+
+	return x86_event_sysfs_show(page, config, event);
+}
+
+static const struct x86_pmu zhaoxin_pmu __initconst = {
+	.name			= "zhaoxin",
+	.handle_irq		= zhaoxin_pmu_handle_irq,
+	.disable_all		= zhaoxin_pmu_disable_all,
+	.enable_all		= zhaoxin_pmu_enable_all,
+	.enable			= zhaoxin_pmu_enable_event,
+	.disable		= zhaoxin_pmu_disable_event,
+	.hw_config		= x86_pmu_hw_config,
+	.schedule_events	= x86_schedule_events,
+	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
+	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.event_map		= zhaoxin_pmu_event_map,
+	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
+	.apic			= 1,
+	/*
+	 * For zxd/zxe, read/write operation for PMCx MSR is 48 bits.
+	 */
+	.max_period		= (1ULL << 47) - 1,
+	.get_event_constraints	= zhaoxin_get_event_constraints,
+
+	.format_attrs		= zx_arch_formats_attr,
+	.events_sysfs_show	= zhaoxin_event_sysfs_show,
+};
+
+static const struct { int id; char *name; } zx_arch_events_map[] __initconst = {
+	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
+	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
+	{ PERF_COUNT_HW_BUS_CYCLES, "bus cycles" },
+	{ PERF_COUNT_HW_CACHE_REFERENCES, "cache references" },
+	{ PERF_COUNT_HW_CACHE_MISSES, "cache misses" },
+	{ PERF_COUNT_HW_BRANCH_INSTRUCTIONS, "branch instructions" },
+	{ PERF_COUNT_HW_BRANCH_MISSES, "branch misses" },
+};
+
+static __init void zhaoxin_arch_events_quirk(void)
+{
+	int bit;
+
+	/* disable event that reported as not presend by cpuid */
+	for_each_set_bit(bit, x86_pmu.events_mask,
+			ARRAY_SIZE(zx_arch_events_map)) {
+
+		zx_pmon_event_map[zx_arch_events_map[bit].id] = 0;
+		pr_warn("CPUID marked event: \'%s\' unavailable\n",
+				zx_arch_events_map[bit].name);
+	}
+}
+
+__init int zhaoxin_pmu_init(void)
+{
+	union cpuid10_edx edx;
+	union cpuid10_eax eax;
+	union cpuid10_ebx ebx;
+	struct event_constraint *c;
+	unsigned int unused;
+	int version;
+
+	pr_info("Welcome to zhaoxin pmu!\n");
+
+	/*
+	 * Check whether the Architectural PerfMon supports
+	 * hw_event or not.
+	 */
+	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+
+	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT - 1)
+		return -ENODEV;
+
+	version = eax.split.version_id;
+	if (version == 2) {
+		x86_pmu = zhaoxin_pmu;
+		pr_info("Version check pass!\n");
+	} else
+		return -ENODEV;
+
+	x86_pmu.version			= version;
+	x86_pmu.num_counters		= eax.split.num_counters;
+	x86_pmu.cntval_bits		= eax.split.bit_width;
+	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
+	x86_pmu.events_maskl		= ebx.full;
+	x86_pmu.events_mask_len		= eax.split.mask_length;
+
+	x86_pmu.num_counters_fixed = edx.split.num_counters_fixed;
+	x86_add_quirk(zhaoxin_arch_events_quirk);
+
+	switch (boot_cpu_data.x86) {
+	case 0x06:
+		if (boot_cpu_data.x86_model == 0x0f ||
+			boot_cpu_data.x86_model == 0x19) {
+
+			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
+
+			x86_pmu.event_constraints = zxc_event_constraints;
+			zx_pmon_event_map[PERF_COUNT_HW_INSTRUCTIONS] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_REFERENCES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_CACHE_MISSES] = 0;
+			zx_pmon_event_map[PERF_COUNT_HW_BUS_CYCLES] = 0;
+
+			pr_cont("ZXC events, ");
+		} else
+			return -ENODEV;
+		break;
+	case 0x07:
+		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+		X86_CONFIG(.event = 0x01, .umask = 0x01, .inv = 0x01, .cmask = 0x01);
+
+		zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
+		X86_CONFIG(.event = 0x0f, .umask = 0x04, .inv = 0, .cmask = 0);
+
+		switch (boot_cpu_data.x86_model) {
+		case 0x1b:
+			memcpy(hw_cache_event_ids, zxd_hw_cache_event_ids,
+				sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = zxd_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
+				= 0x0700;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
+				= 0x0709;
+
+			pr_cont("ZXD events, ");
+			break;
+		case 0x3b:
+			memcpy(hw_cache_event_ids, zxe_hw_cache_event_ids,
+				sizeof(hw_cache_event_ids));
+
+			x86_pmu.event_constraints = zxd_event_constraints;
+
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]
+				= 0x0028;
+			zx_pmon_event_map[PERF_COUNT_HW_BRANCH_MISSES]
+				= 0x0029;
+
+			pr_cont("ZXE events, ");
+			break;
+		default:
+			return -ENODEV;
+		}
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	x86_pmu.intel_ctrl = (1 << (x86_pmu.num_counters)) - 1;
+	x86_pmu.intel_ctrl |=
+		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+
+	if (x86_pmu.event_constraints) {
+		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			c->weight += x86_pmu.num_counters;
+		}
+	}
+
+	return 0;
+}
+
diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index 9556930..63a5828 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -63,6 +63,9 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BPU_PERFCTR0;
 		}
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		return msr - MSR_ARCH_PERFMON_PERFCTR0;
 	}
 	return 0;
 }
@@ -92,6 +95,9 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		case 15:
 			return msr - MSR_P4_BSU_ESCR0;
 		}
+	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
+		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
 	}
 	return 0;
 
-- 
2.7.4

