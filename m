Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C708AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BA22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MHk9IjKO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lz3bBViW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHQMnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:43:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44411 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgHQMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597668208; x=1629204208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qOSlpkQ1IoXm0QsQ4IIU+O/IUb2qP9khXgmrrlbsQgU=;
  b=MHk9IjKOA5c5H6NH1LXrohaF7FcDnxqeJ6HAw2pm8SFHLL0JeLFwdH0m
   cav3gFpXzZoIqcYi9DVLYFd8Vj2JorZEo7s/izOqsmqHAponT58A8khJL
   oGOjfWQEC57h+lFn6wYnhhDtAoHFkdIz/jKvtE+u8vvm4Ficz6r2SeQ7E
   IcFgJjqJ2d9lo8KIDWIne8gQxfjx0j7C4VTifRipJaQQJQzlwwui4oI1Y
   q8JyLikctstNeDgHNd8Vd+IJ6Ew0IB1z1ryuBhlsCd8WWBU01oNx5OZFu
   N/GhSNF6LuKBk/It8IsDTnXgSV92lFQXzZS+xPQLFmCIygtDOiShUuc6s
   Q==;
IronPort-SDR: k5Wh72xBQNBo8Hlw+NLh1uCgPUpv5dY3m/UWWoerlex4a14faT8eXPQa2Bt28EhEcL/jYwIrE7
 wBkuMDA3FNpOoeyqxMcwGTG07ZZOeZbplqHXVvyaPHnFRpZP5sjjVb7i3tBBT+HU08HdXUEmNw
 IebT1LGES+hlESdRL8sKDCaFFjU/xIl9YA30tSxX29LvqB1ZKfxanvJ83jrFD0ihxNo9T5XF+B
 2H4JySixeLYxLUJBkjvB/pa3/tVdPuHW9ve95rhOUdU4W7xAgm2zJ0LJMIUldRLGuzegJ/BMLs
 vnA=
X-IronPort-AV: E=Sophos;i="5.76,322,1592841600"; 
   d="scan'208";a="145088382"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2020 20:43:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu+IpnhvCO0usBCkuQQn4xs9aqGYg26SUqwv071kl6kJmdcFmlw8UJ8NlFg4+rIQlAa3CvyCu3Tt0kuGFPZ4sGiVyLLaVyBN0FMhRFM3ONkMsck3DEP4p4r1iMOdUoBCYC03bvmzvQm9lbD7+pKmRQ6+9dkJ+iwvaJxaSvZJVeWHh/DCRRUDaBpUDl42GMJn3LQU5UFpjRyxXadei0emi3Oz2fWjtWPHcr3WS6AgrqgPYXccgvUDQXFVqN2ln8IbV/ZEmpbXxW68Mfg8RL7jHuNGqrUY6/ggKMIq8w2BAfY6gPn49mFnaornG+0I5FhSAkUZqYZniGXfi1Rm26JwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwWAnc6IvLkAnVRqMZMddCrc4lRiqJBm2/IUI6JI4Kc=;
 b=GYLY1MvhkNTORvsb5n6hxw0b+4YZtoTUJuNHj+gJQOT3GqeRhBbb7frIVTDj6pGw+CLGekbHMAELe8imdyPwMOKKSCvM4PpC6GtgRc4TPWmpq8Aw1Nha39sncZi44R5yXdAqLHbhdG4WBptfKaLL4PtHv+9kOD+GxTZf48dCNvrlaomp0aTzrdjEuux8UMwxkj2iaqPPaiAMHTtHnmngWgWqaR3zwcbtBqLEXw968cT36PXxURiwShHdmQx85AF8XpPLVnv9OtkbnOVavKnWY8VNchkE32nSzFz6mzOGw49a3nITc6qfD+/cPwbQdnTPvFz9rcsc41kMhgkYvN/cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwWAnc6IvLkAnVRqMZMddCrc4lRiqJBm2/IUI6JI4Kc=;
 b=lz3bBViWulSvxBENZ91sJAOiWdtcR6q6mCc5wTCYxA6BOEYnkHw7M4ncRa9/fSBwHdwR3BCaZkMKf63/jn98loab+GDwU9lkEijmlHY+ywfD+05Zd8D6mDx6GC5DYJdRGEInSFDl59aZC+KaAdi1eqzCCDZlOzdKAv6LTF77LoY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB3865.namprd04.prod.outlook.com (2603:10b6:5:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 12:43:25 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 12:43:25 +0000
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
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 2/4] clocksource/drivers: Add CLINT timer driver
Date:   Mon, 17 Aug 2020 18:12:49 +0530
Message-Id: <20200817124251.508183-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817124251.508183-1-anup.patel@wdc.com>
References: <20200817124251.508183-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.59.21) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 12:43:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.59.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b3569b4-bfdd-4fb3-0e2e-08d842ab220a
X-MS-TrafficTypeDiagnostic: DM6PR04MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB3865239D335FDC077F9746A38D5F0@DM6PR04MB3865.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV5Tnl1053DXjx0h+rdiWhjmTeIcYvEvDPCU26tAN1lV6nmK3579QK6ksrTxpdePgU1E5mAyKxmkn+olJfpXbnXdgjSvnBLghJ0E6x7Zq3psy/YE1jyEIpZbO4wqDxj/RpYeKcoh3Huu1MAROUNa/GF2y0y3s6Lej5dr1AOUFyVRgdjwWPPSjXrMiNYwBIafQN/o88Ds4uPgWjkCzQoDhbwubijXmGZnP38I8foSzBxAQby7da2DdXSM+pG4LlMgWi3OvmZQ9eSbc8PpSwirOA+G2I3uyuusdPQeU2SJ4ivb6HGrMhjz5JLf0G2MBbOxUPVqbub6P8gglpE/hQyFYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(36756003)(7416002)(52116002)(6666004)(66946007)(55016002)(2906002)(54906003)(83380400001)(110136005)(5660300002)(478600001)(7696005)(66556008)(66476007)(1076003)(4326008)(8886007)(186003)(16526019)(44832011)(8676002)(956004)(26005)(8936002)(86362001)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 17IgVP16e9yIEtXtzJ1gYXMzaT44LAdAj7vphiGgnehaC6zGIkkjXJfXknqqq9WVtt3FdmX2cwT1oUqY/JHsf+Q+0K6Nx8hkyv0K+edZ3o6hqKnUODMMIk8mD44ymdEFrOl1G/hckyMsQFQUldXR0F5dqJS8winEm7rtiSWU3T3FEZBKskL+URAZNAI2wB8KY3iB/QL+aaGoBjYb+20AalmFf8RlgSDCVnsN7CgBBDKXecT8B8BvwQnpHQKwdbO2pMtHMtdJq/ofP3MFL0in9GRcZfhbQe4Rgkn5n0yYJIpaE1cFHj/weaUXteAPrDwFgftnc13+TgW6i1/O5CgvROkNL0XpjasjI8vHClPO8ExCgkKaYaLn8z46YHwW98hGUBPz8/XLfuFl4DDRZOeDpiJsZ/06KaJTCYYyzhBRTe8ZEJflBaBgy5f30dTiPkEi/tcHjvFRKrkE1N4AOph4MutahZ4SmilacnzicWBID6ejaIkhgLkwZGy9YL79rpEnyFubI2KawWqdlQFwUR8EFQJqt8FDUCCYrHK8PEphHIaOQXxbZ3NR0HYMXDV2NdBlfd9o+gLotj+Dg/EzGY1mqNHMibAqgn/zf6UVEqTxBTwu9sA4MpRo1hOyOX2KvOprwDTiS3FTJTsjC0YLX4AXXQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3569b4-bfdd-4fb3-0e2e-08d842ab220a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 12:43:25.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Foe8f1gRV96eDL5vWDYbEjYmITvrtG1Vp6xN8PMik8GNDv8lEmPAWLGov1JeLleEwSO7XQGaVWcmZ8W459zTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
RISC-V NoMMU kernel).

The CLINT MMIO device provides three things:
1. 64bit free running counter register
2. 64bit per-CPU time compare registers
3. 32bit per-CPU inter-processor interrupt registers

Unlike other timer devices, CLINT provides IPI registers along with
timer registers. To use CLINT IPI registers, the CLINT timer driver
provides IPI related callbacks to arch/riscv.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/clocksource/Kconfig       |   9 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-clint.c | 226 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 4 files changed, 237 insertions(+)
 create mode 100644 drivers/clocksource/timer-clint.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3576ad7bd380..d95cc7234a66 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -663,6 +663,15 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CLINT_TIMER
+	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
+	depends on GENERIC_SCHED_CLOCK && RISCV
+	select TIMER_PROBE
+	select TIMER_OF
+	help
+	  This option enables the CLINT timer for RISC-V systems.  The CLINT
+	  driver is usually used for NoMMU RISC-V systems.
+
 config CSKY_MP_TIMER
 	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
 	depends on CSKY
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index eaedb7240ae7..1c444cc3bb44 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
+obj-$(CONFIG_CLINT_TIMER)		+= timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
 obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
new file mode 100644
index 000000000000..8eeafa82c03d
--- /dev/null
+++ b/drivers/clocksource/timer-clint.c
@@ -0,0 +1,226 @@
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
+static u64 notrace clint_get_cycles64(void)
+{
+	return clint_get_cycles();
+}
+#else /* CONFIG_64BIT */
+static u64 notrace clint_get_cycles64(void)
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
+static u64 clint_rdtime(struct clocksource *cs)
+{
+	return clint_get_cycles64();
+}
+
+static struct clocksource clint_clocksource = {
+	.name		= "clint_clocksource",
+	.rating		= 300,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read		= clint_rdtime,
+};
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
+	.name		= "clint_clockevent",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.set_next_event	= clint_clock_next_event,
+};
+
+static int clint_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
+
+	ce->cpumask = cpumask_of(cpu);
+	clockevents_config_and_register(ce, clint_timer_freq, 100, 0x7fffffff);
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
+		pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
+		goto fail_iounmap;
+	}
+
+	sched_clock_register(clint_get_cycles64, 64, clint_timer_freq);
+
+	rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
+				 "clint-timer", &clint_clock_event);
+	if (rc) {
+		pr_err("registering percpu irq failed [%d]\n", rc);
+		goto fail_iounmap;
+	}
+
+	rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
+				"clockevents/clint/timer:starting",
+				clint_timer_starting_cpu,
+				clint_timer_dying_cpu);
+	if (rc) {
+		pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
+		goto fail_free_irq;
+	}
+
+	riscv_set_ipi_ops(&clint_ipi_ops);
+	clint_clear_ipi();
+
+	return 0;
+
+fail_free_irq:
+	free_irq(clint_timer_irq, &clint_clock_event);
+fail_iounmap:
+	iounmap(base);
+	return rc;
+}
+
+TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index a2710e654b64..3215023d4852 100644
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

