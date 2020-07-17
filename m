Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15103C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB58B20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lmKFm5Hb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TsSv5lLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGQHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52761 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGQHvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594972316; x=1626508316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WbUKgHLz6vh1Bwkr/pEMTlm1LxiGvGuQjHX8ZVnQtl4=;
  b=lmKFm5Hb/mq61yGP6y1ECcFRgRRqHoKYEmGtstwtqO0F/FxIrOhFJBn5
   xwbA49lmdZqf8rT+dWXHUvmW8VXnvHu5g9bme4FE0hw5wVEQ3wngWrb41
   t6HIGkwyFk9DcbTT/MARXMFtTJwYI3I5DkqKPK4kkkSTCKgKwZG0czU1B
   98OBYoBmvdRAtPAvLJ77z9ulsw7WDFqvXgnqfGaYY0ztakIQ5PriQcLg/
   350elSDt2FAU38IvxOuz5+mZ4Cj/3bvW8Fnmle4lxE9cJ7v0GtBB+PVVP
   QdFt97MTAipksWhHQgSFHt2QRTrL0V3bH0F0GfvkQ9LloojamyHWzFt/1
   A==;
IronPort-SDR: HZp2oyKdERwESoekFA1fzgMFGM/dqM7rMQH0r21O55FrciGhtcQ2sLmPFOg+uy2AOwprA+DSoe
 UvP/w750iPN7OzpBvB4sWezNQnhY30xpdp/MkRYreG06mw2MC/XuNCSXYx7YbyfxsK1vt5GXj+
 MSQ+SKDhmUrRh3f44Sh56m5DzwcxEGq8xoEzsFwsFcaBeldfzhemN8sSuVA4JXgTuAzSCkiZzI
 l09IVJOwQjK8VDLjcYbIpN/yybUgPmhkDaA/UEpsjRkI4211IUWMAT5wwl26hS3oCEvZnyOlTv
 d/E=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="147003911"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:51:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbA24+FdmhvVhg2Xg9PHvdjSDWk0qKqmPOTG3dxkamvgSQgoP7uVQy+P4o1JYzAXzF6Zr0MVZQn1t1Q+pqcQ9P+jhTPLkhqokpJyLpZMfMU8kSaDY6zbkaBBxqhdmuLqHciLGv+zah776D1qoXRXUGLbySUtNGLGHqt0AtFac1peZoLlFNWkgPc2NTfv5k7vv2VNTePhftg/PIl86aogrOFQ3RWrXaI+/5Q9ztir4IVzwbNwww0vdaHrbm2golBKdKaQyvM/StMVXpainip7ZMGHBpCnkf6ukWk4zS5lBUYH9IxiFTfEy/9kwJ6UkvPP/FOvxgQCPQBZZ+ef28rD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZQnGgScGnc9lha+M0dvQSQNMLv2mmd4IUKPUfxAerw=;
 b=ecX8eYQNETzDv09O0liyvrUSP92OIvbCwwwqrD/ECQiWqatALDdk+pH9vBr3QX31O1UyMy0ZCZVHeFnZtAVD4QHC6eWBqZAs7pV2Nu1fSshfXBQI+2pPmdUb15Yx62cQe9Zd/X2L51BEk2+fnlew1l7OUbnKtLlhrIQ+cPKGDtqiLMsIkkKHwpK3fhzHMj8+xwVOPzMWnh5hlt6AVKfA/csn3OrT8peuQz0gC0c7c7gSoEDDTN+GBcg/oKsdpobH6G/0QmaiUJECfx4zWjsuT5nxEk12HjmNbw5r6aofbwZbBfMTFaba8NJmiudTmFYVlXX+T4Vd6igxIbzOxomFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZQnGgScGnc9lha+M0dvQSQNMLv2mmd4IUKPUfxAerw=;
 b=TsSv5lLQ2xLP0qFTcxADsTjQ2y1pKq1A4i+0COozVFOqos9gUf6Tuhp325qHzYln5CQ28haR0JqFyn7WSElh4A2alKmYx8YbwA6+dbBaZ/eoiEEUfR5Y3fsSwVrCuSQzYApVKip85jLaX3rRDO1s0ghqPmrrtGmio3c4AJTojhY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 07:51:53 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:51:52 +0000
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
        Emil Renner Berhing <kernel@esmil.dk>
Subject: [PATCH v4 2/4] clocksource/drivers: Add CLINT timer driver
Date:   Fri, 17 Jul 2020 13:20:59 +0530
Message-Id: <20200717075101.263332-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717075101.263332-1-anup.patel@wdc.com>
References: <20200717075101.263332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.182.72) by BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 07:51:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.182.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0426f8b-38f1-41cf-ba82-08d82a2644f3
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB633181EF8B0E4D984EC714168D7C0@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RO3G/Nn143TgwIRmmXfcwBzeFB72pw/6R5J4s+NyXna2aAgGbsL1igmtJjhpcF64Zg4wYfg0Qae5u3WXfxh01PLZGkb9QEX8OYLdFE4y8v3n/4PUtb/qDJ+6Xxt1d40FIxl5bYRa+fZcVaKyvatBi7IFu89CcBuxIW53z/aWznFiz2nIEJkdVQ4QHd5RcBcdlpGDBIwIsTjOd39iOAp7k1SZk7prDTSwlPJ3vXLmnM4pFT0IsfztLPPBDaWTpTPwtIfarv3vAwQGVOkctQ0BsmkQLPsem9lVgkp2Xapez+QPP1YNP9+AZHoeh6jwawshUhdmxji0vcU4kPLi8aCtzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8886007)(8936002)(66946007)(83380400001)(66476007)(66556008)(1076003)(4326008)(5660300002)(86362001)(36756003)(44832011)(316002)(186003)(110136005)(7416002)(54906003)(478600001)(2616005)(956004)(8676002)(6666004)(26005)(7696005)(55016002)(16526019)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MwCuwU0JKW2xa8r9U10tHsN07r7uTAgr6KR2BaKaETHMzX4W0jWPY8iCDRnoLQwdPzZHcck39fIHHcLeu/tmKh6AP0FcWr0WgP1UGb2LO6IOzkHcACzr4/IeB4q2ETjmBMeXrLuR/oybnuMzMLttq8zv9w71kR1Mb+vUN4sMpsYLK8FWx3GdHQ0XDdSEKVowKnwBHb2CrNDwMq/nkgeAdzwKTJZN18zI7MN6U166v7a3gxogUyaUQrUZ9gAb/dwv8rsPY8a0zJ9/LdHNaBWYRRG4smfl7Y0UXYaIisAeCdE7Qm06wYQidgcs03h8qjW7SxRi8xaw+hyNMoYL7zTyRlXLrrDkL3GTqZWuK2ILPMi4/7DWmPteaaix0XRHI81LpEhKvgjJMOq4hRYRJbhVq45lkuR4QT6JuLqx/nC1OD1K2MyA0zgkC2CI8jUZkeMlgwiRkD6Yn5woIyLlTQELSwZNNP27C9Bc1QKEutMII2s=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0426f8b-38f1-41cf-ba82-08d82a2644f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:51:52.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgEPd0KuhG7C7sGZt8K/nsLNqtlKJe/MTl0KsPdSBRc69jKCt5ioAdo5+ykvCK9nmv/i0dbzx5K7zvYDKdO4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
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
---
 drivers/clocksource/Kconfig       |   9 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 4 files changed, 242 insertions(+)
 create mode 100644 drivers/clocksource/timer-clint.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 91418381fcd4..e1ce0d510a03 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -658,6 +658,15 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CLINT_TIMER
+	bool "Timer for the RISC-V platform"
+	depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
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
index 000000000000..e1698efa73a1
--- /dev/null
+++ b/drivers/clocksource/timer-clint.c
@@ -0,0 +1,231 @@
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
+	.rating	= 300,
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
+	.name			= "clint_clockevent",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.set_next_event	= clint_clock_next_event,
+};
+
+static DEFINE_PER_CPU(bool, clint_clock_event_registered);
+
+static int clint_timer_starting_cpu(unsigned int cpu)
+{
+	bool *registered = per_cpu_ptr(&clint_clock_event_registered, cpu);
+	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
+
+	if (!(*registered)) {
+		ce->cpumask = cpumask_of(cpu);
+		clockevents_config_and_register(ce, clint_timer_freq, 200,
+						 ULONG_MAX);
+		*registered = true;
+	}
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
+	sched_clock_register(clint_get_cycles64, 64, clint_timer_freq);
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
+TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
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

