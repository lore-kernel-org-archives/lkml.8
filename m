Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F020720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oa6u/2Ge";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mYhx97Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgF0QVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:21:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgF0QVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593274879; x=1624810879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OVAwU7gWg7VgVY9a3JnVjfAU1II8Pm1mWBzKBZ6Zj7s=;
  b=oa6u/2GeVhQt0JG2KRdyD+l1kpY+P0o7byT+ssBPSUeo/CfQovt0Q9xT
   yi89vk7TE5t+YNa3BYl1d0DwGRgNWXLvFXkGBal8ZbCVvKo1r3xcMf6jX
   FU0KNmxGarvoghNy4bYD44so4lfAr8Y5CWlF+j0DVcAh8RCGHw6+wOHIc
   JU89lQsrNIg6bzSHFnlJArA2ld1f8MXzRmI+oTcouanWlQ5BXhCjPdWKv
   OIUqxSsMfgKtUePjDibLu+rjVMAsU+TBLcl2eA0sW9xX+ZOrwhAbSwi0q
   UUMQcZUxMIRI+Nhb+KNQOgkabyAp/jYqeVq6oRApF+CTO98neo8PdOnHT
   Q==;
IronPort-SDR: CcQWkP97hmNplg9XpcgrHeQbQ8BqTkhbDKf4tD3uJO/Py6fP5RXGzY3zpJl0fqw51M1wMc3rOr
 mCvOL+DFd0kFPyOi+tuSkd3SJ82lrn2SHzk715RoOHfDKwvYvVvkXodAAGPE3MKmQsM9ftsIbD
 WnFIPUvbcMZrdTC9b32PfNmrIT/7gJhZ59yKUAjwMi07ffnosxJ5vLuHdulQqzFdgsPl5lZIUR
 E7a7O4Ub4QRcKIx7BxjI7sw6YnbIcXACDyar2BFgM+9hQhC85meh2W3Pi4tFllLls2Lu9VjEp6
 dtk=
X-IronPort-AV: E=Sophos;i="5.75,287,1589212800"; 
   d="scan'208";a="141074517"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2020 00:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gipmJ/sBpujbMRyPrRu2wJ0t6bY3tbB9eN/NFt3ijHRXPT0TLiUjYBymzl/2qlNWO1f8zdKCafVS8smFKzP9mRf5Ah1pVSIyBumKEgyRsdyRBRktIQA/5QCzbB9AXj3tmpvqkPCHRdx//9u708V3wYicO5t2BpFB32d0It/PNAqB5LPvia/nURHtDL/uRRu/L2M29kfIZFxgucLOqJ1kg31EPI37i7RmMucwkKJSH8odDNDKsbad7cWS5+DpxZpyt8GN4nt00kRl3VHj+4XT947Or77DB/zKY9wr2qMLKBOJCW6KZqZbPcr/Rew5mapcswM7OdzjTUzR9yeByPTSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbuhNv1reUHavhv6/vRogkBSfCs2qVzIgcALq9sPeM8=;
 b=AF9Dm7d9eKVhIcftRYeKGUGHRgBnwDlYWL0cuT1xl+lfmkQG1aCETdjPm/nOMsyboWNzLnBUzydyixiY4WX1KvMKptQYC2OnuHjJMtRKWZRlhLZArW+r1lBdzpNcmMtFG57k3eHq+3Y1qXLeYIK/kV/s8u5bvsEgEELL2yV0Lp0ZuFKKkffWlaaHdg26LmikjsxTUuPTBTUzQCxcBeVsK+q98oBTjyU8fzBb0dComBt9tsXrvQw1LdNe0gdC5B1sIUSYAidjXb5I9Kyzz0jfOjI6lP+xliYwXswaBiXHJG869g4+V5W0u2MyC3jRIHIoAekU9V278xYN9my7nmw7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbuhNv1reUHavhv6/vRogkBSfCs2qVzIgcALq9sPeM8=;
 b=mYhx97HzN8pOG+Blot5B2Uwq9LfHp9/+PiAKz/eBZSW+Osjroy/FiHlmPZ8lbD8sx6zCvzpDApFPlFl0q0As9enCIlYlTIILHSwQVLW6fItF61WumQJJYgKBbpZEMi5yEPrVeD/fbPMJwJx8NizAKvXLw+fpNTy9rxgT15Bpya0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32)
 by MN2PR04MB5725.namprd04.prod.outlook.com (2603:10b6:208:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Sat, 27 Jun
 2020 16:21:17 +0000
Received: from MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580]) by MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580%7]) with mapi id 15.20.3131.026; Sat, 27 Jun 2020
 16:21:17 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v2 4/5] clocksource/drivers: Add CLINT timer driver
Date:   Sat, 27 Jun 2020 21:49:56 +0530
Message-Id: <20200627161957.134376-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627161957.134376-1-anup.patel@wdc.com>
References: <20200627161957.134376-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MN2PR04MB6207.namprd04.prod.outlook.com
 (2603:10b6:208:de::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (42.109.128.251) by MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Sat, 27 Jun 2020 16:21:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [42.109.128.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d716cff8-6879-4473-a23c-08d81ab61df8
X-MS-TrafficTypeDiagnostic: MN2PR04MB5725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB572589582AA6CF72A79C3B448D900@MN2PR04MB5725.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0447DB1C71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mki6a4lwMnOOmj6DNVXcy8ETm/WrIfsKUeiJe6IbUsPcm3EuNyiUL17UQ2O1+MCQ3kI8RyeIec/0bVSfIeJwWazOWPchDip4000P/2RFIYoHaEbSN/R5hfCrTuuHnR2Sv2JTE7UKciTqJuf5y6GcJesF5es/FOinkcmEOB/oPX6tLhidxbXFuqIvGWOQG8yBH0SVqeiTDhYP0cvIm9+PaEkyoYyULJOGaz1+bneS8PNNM/u1pAViUavXl1ysMi9L5V7+pPHM64G4F7YkxlsTlwXIPryzCaJM36+u1otsvYNYLHQWvWUvX43DqrZPdcXWlZkqT/fWgHr7bW6fXP5tdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6207.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(1076003)(8886007)(186003)(16526019)(52116002)(86362001)(55016002)(6666004)(1006002)(36756003)(7696005)(66946007)(5660300002)(83380400001)(26005)(66556008)(66476007)(110136005)(2616005)(4326008)(54906003)(478600001)(44832011)(8676002)(8936002)(2906002)(316002)(7416002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rs3JjvgAOTcrIb90A3JEohyzEQARVxENwxJnL3+XEG7oJshasjR3z5hYIwIEV0VCfPNEzL9Rf7dwJNzmsVyltbocE8rD0jdhKTK8N1PQ8gfNre8J9Lkd7uVPj3EFXQEm+06gUXnb1qN8CjYhvoiR/4LD3l9vJXLqoKYApl/fH71s6t8/wfF26aD0z7YJJ3dM4zGxem1oPZI1VOSyXPhtnuGmSGi2ahySzWD+DuddxOsnXy2DoC5yrzDXps2bkiQRHsCZD12kZIIUedNdBUGMwR6YXsnq/GqtNidV+LBmPPuNCEDmxl2/I1jiICbQfa/+UXROE3XK7/BTe1+sqGqKdMmUDokwvrUHryVaXg9XN5itrw53N8kWW5Xl6i9l1QfrpjFJVB6UTHw4dF2Ozq0b9X0o3QwwHuwdRdY1/eephNHjklcei3qJap+ZOH6Lh2pXPVxV/h9FznQ6rcHu1hf2najrnLNe6hql95QURQnJbdo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d716cff8-6879-4473-a23c-08d81ab61df8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6207.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2020 16:21:17.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ/P3cn08SWydNrjFREOasy2nqWRZbxhlePE2BJmI+1AMW2rWJuy4Kf4UBjSNcfAQCvadwaF4XNC/LFt9Px47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIME CSR and SBI calls are not available in RISC-V M-mode so we
add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU kernel).

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/clocksource/Kconfig       |  10 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-clint.c | 229 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 4 files changed, 241 insertions(+)
 create mode 100644 drivers/clocksource/timer-clint.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8c6a0f1274af..d3bf66123c4e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -658,6 +658,16 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CLINT_TIMER
+	bool "Timer for the RISC-V platform"
+	depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
+	default y
+	select TIMER_PROBE
+	select TIMER_OF
+	help
+	  This option enables the CLINT timer for RISC-V systems. The CLINT
+	  driver is usually used for NoMMU RISC-V systems.
+
 config CSKY_MP_TIMER
 	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
 	depends on CSKY
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index bdda1a2e4097..18e700e703a0 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
+obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
new file mode 100644
index 000000000000..e5c36d49bfdd
--- /dev/null
+++ b/drivers/clocksource/timer-clint.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ *
+ * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
+ * CLINT MMIO timer device.
+ */
+
+#define pr_fmt(fmt) "clint: " fmt
+#include <linux/bitops.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/sched_clock.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/smp.h>
+
+#define CLINT_IPI_OFF		0
+#define CLINT_TIMER_CMP_OFF	0x4000
+#define CLINT_TIMER_VAL_OFF	0xbff8
+
+/* CLINT manages IPI and Timer for RISC-V M-mode  */
+static u32 __iomem *clint_ipi_base;
+static u64 __iomem *clint_timer_cmp;
+static u64 __iomem *clint_timer_val;
+static unsigned long clint_timer_freq;
+static unsigned int clint_timer_irq;
+
+static void clint_send_ipi(const struct cpumask *target)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, target)
+		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
+}
+
+static void clint_clear_ipi(void)
+{
+	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
+}
+
+static struct riscv_ipi_ops clint_ipi_ops = {
+	.ipi_inject = clint_send_ipi,
+	.ipi_clear = clint_clear_ipi,
+};
+
+#ifdef CONFIG_64BIT
+#define clint_get_cycles()	readq_relaxed(clint_timer_val)
+#else
+#define clint_get_cycles()	readl_relaxed(clint_timer_val)
+#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
+#endif
+
+#ifdef CONFIG_64BIT
+static u64 clint_get_cycles64(void)
+{
+	return clint_get_cycles();
+}
+#else /* CONFIG_64BIT */
+static u64 clint_get_cycles64(void)
+{
+	u32 hi, lo;
+
+	do {
+		hi = clint_get_cycles_hi();
+		lo = clint_get_cycles();
+	} while (hi != clint_get_cycles_hi());
+
+	return ((u64)hi << 32) | lo;
+}
+#endif /* CONFIG_64BIT */
+
+static int clint_clock_next_event(unsigned long delta,
+				   struct clock_event_device *ce)
+{
+	void __iomem *r = clint_timer_cmp +
+			  cpuid_to_hartid_map(smp_processor_id());
+
+	csr_set(CSR_IE, IE_TIE);
+	writeq_relaxed(clint_get_cycles64() + delta, r);
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
+	.name			= "clint_clockevent",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.set_next_event	= clint_clock_next_event,
+};
+
+static u64 clint_rdtime(struct clocksource *cs)
+{
+	return readq_relaxed(clint_timer_val);
+}
+
+static u64 notrace clint_sched_clock(void)
+{
+	return readq_relaxed(clint_timer_val);
+}
+
+static struct clocksource clint_clocksource = {
+	.name		= "clint_clocksource",
+	.rating	= 300,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= clint_rdtime,
+};
+
+static int clint_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
+
+	ce->cpumask = cpumask_of(cpu);
+	clockevents_config_and_register(ce, clint_timer_freq, 200, ULONG_MAX);
+
+	enable_percpu_irq(clint_timer_irq,
+			  irq_get_trigger_type(clint_timer_irq));
+	return 0;
+}
+
+static int clint_timer_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(clint_timer_irq);
+	return 0;
+}
+
+static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evdev = this_cpu_ptr(&clint_clock_event);
+
+	csr_clear(CSR_IE, IE_TIE);
+	evdev->event_handler(evdev);
+
+	return IRQ_HANDLED;
+}
+
+static int __init clint_timer_init_dt(struct device_node *np)
+{
+	int rc;
+	u32 i, nr_irqs;
+	void __iomem *base;
+	struct of_phandle_args oirq;
+
+	/*
+	 * Ensure that CLINT device interrupts are either RV_IRQ_TIMER or
+	 * RV_IRQ_SOFT. If it's anything else then we ignore the device.
+	 */
+	nr_irqs = of_irq_count(np);
+	for (i = 0; i < nr_irqs; i++) {
+		if (of_irq_parse_one(np, i, &oirq)) {
+			pr_err("%pOFP: failed to parse irq %d.\n", np, i);
+			continue;
+		}
+
+		if ((oirq.args_count != 1) ||
+		    (oirq.args[0] != RV_IRQ_TIMER &&
+		     oirq.args[0] != RV_IRQ_SOFT)) {
+			pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
+			       np, i, oirq.args[0]);
+			return -ENODEV;
+		}
+
+		/* Find parent irq domain and map timer irq */
+		if (!clint_timer_irq &&
+		    oirq.args[0] == RV_IRQ_TIMER &&
+		    irq_find_host(oirq.np))
+			clint_timer_irq = irq_of_parse_and_map(np, i);
+	}
+
+	/* If CLINT timer irq not found then fail */
+	if (!clint_timer_irq) {
+		pr_err("%pOFP: timer irq not found\n", np);
+		return -ENODEV;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%pOFP: could not map registers\n", np);
+		return -ENODEV;
+	}
+
+	clint_ipi_base = base + CLINT_IPI_OFF;
+	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
+	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	clint_timer_freq = riscv_timebase;
+
+	pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
+
+	rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
+	if (rc) {
+		iounmap(base);
+		pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
+		return rc;
+	}
+
+	sched_clock_register(clint_sched_clock, 64, clint_timer_freq);
+
+	rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
+				 "clint-timer", &clint_clock_event);
+	if (rc) {
+		iounmap(base);
+		pr_err("registering percpu irq failed [%d]\n", rc);
+		return rc;
+	}
+
+	rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
+				"clockevents/clint/timer:starting",
+				clint_timer_starting_cpu,
+				clint_timer_dying_cpu);
+	if (rc) {
+		free_irq(clint_timer_irq, &clint_clock_event);
+		iounmap(base);
+		pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
+		return rc;
+	}
+
+	riscv_set_ipi_ops(&clint_ipi_ops);
+	clint_clear_ipi();
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer1, "sifive,clint-1.0.0", clint_timer_init_dt);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 191772d4a4d7..1451f4625833 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -132,6 +132,7 @@ enum cpuhp_state {
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
+	CPUHP_AP_CLINT_TIMER_STARTING,
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
-- 
2.25.1

