Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F309C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2027920748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nPOra8OC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nzIzmrBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXHTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:19:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65187 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595575164; x=1627111164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EvXa1TLM6oZb3oViCyaEkLLwh/lQtIOGkZLFWNgxQ5Q=;
  b=nPOra8OCMJ5jvhYtJKh9589/9/VlZoGi59HiutG4NXHd2/ex07YaLRgL
   sNecyCD1w92zNh6ZR/PdL/fJxxgM2x7TSpayF1PnrPD7d+BgpfsithrcJ
   9jELBB8VLnHbfxQKgNPs47YEyjrqAy8yPuTXPWfoAmki+IRie6mMwmHBI
   FZJwNzmBovNtlVTJaY342KcOikS5jKrFNnkK+kDYxCkn8v75SIZeEaWF6
   idyXdGOXgKVK8/FpuvjLYQHRr3kvnNBPVxY97f/2rGKGyRNZyfjOs2t5g
   DTvOeqN79qjkN4jWF3xvhYDpXmZ/Ofq71SmPS6M5B7eaki5Iyl/2Hm6q7
   w==;
IronPort-SDR: 7knFSJUryD58AL8LwMdzmVpmB8gUYYNFKIDfhTZ9UZwWF3sn31R4Vnb+IhrKahKOL+LWnyts0Y
 65bBcbXcIyuyNUR4v/QywNsYmzE+IYT1fROiNTGIR9HWu1YpKRz3BDjLHMvvq/tVOd4D/x+lVh
 xW4TlXHzCsvvakm1NNv7dUZmhOBoTTzrzzMoFPhID2DyzL4oE3s1X/Ur++uIiEPnyj4iKRZFz/
 XYfIctfwaz9l8q0Ue5r56LMXx/0mTiLdBvtdKHNHXQvZ2nEL3wxOSKQfgQXSkI/DXVIoKOlLV7
 Hi0=
X-IronPort-AV: E=Sophos;i="5.75,389,1589212800"; 
   d="scan'208";a="246341026"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 15:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWLQ3eAC6moCB5zsQMgbW5GKXiSDErahsKRvkGONskzUUrXxGTjC8RxmuwcKeu5boOShP3lsMdph7KvJ7wjBUeUPETGNRadbsCQUJjp0qKwshGlGvXFt2vGLYQyr0Vu8StbiuYWmKH4LnDm5qf0BTY2+g8rTFV/P+IclcGkZN6JMfQxwaqLCzh3B2tFx3RnKt+IUrLNkglYwZl/IMy64vXnZBo9jbPP+08ArOIClES8R0xXCKu4aNsQcybukkbJYs35/MjkfmJhMD12K/X+kHp7c6wHhFjgKck3ajawIJCI0RCTkc5pOaE8q0G511Go02+fKrmkNsTlSRSpL1o7FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KotOPHFRuaRYl5SnFE58SsXoJ3BoabLTG4YfvC5Y/h8=;
 b=ofrjIa9fz5aLU8WZ7nOPWjeLdAe1IxTsZnf4+QqTWjSOdqYfz2PSfeJ0WhoeeSHQA7a2PJs+AK2OiUFOPWvDmyrrwaSGBPzVIqBM3nb+4gw4U1Jymc+AXxHGMEEiyqjKWo8FIgui+QEaXihv8wbzR55jdya6zaSVcgO4rk0m0OLgwzF4q68/X+1vwC5Jo8n57eYgQhvwf2OmGjw4/fTmwBcwGAdjo8lHYVfDBgPn1VHMKGNQWE2ttkwafzc9d5sBQlplF8i6POEWrN0ZWt95rs2BS1FGeGkPYjF4S4kbmCEW+M+DdHotesqTmvwytnPavIx8VXQusU4OHl6ibezTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KotOPHFRuaRYl5SnFE58SsXoJ3BoabLTG4YfvC5Y/h8=;
 b=nzIzmrBWPm2i06dyIu3dJx+FVn9Re27hQGMEE1X9QUsczxZsLIN3S1UWi1cHRJBxPJwb5Im/danFmZiWo4CK3QQFuJu9wH+6vT8IWCMdpWPqXXS1ymc9vz6o0cXz47MpC3MliCz3O/qXnW6YWGIrLR8CYDKo22fmPyizk+Vnfhk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5131.namprd04.prod.outlook.com (2603:10b6:5:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:18:59 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 07:18:59 +0000
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
Subject: [PATCH v6 2/4] clocksource/drivers: Add CLINT timer driver
Date:   Fri, 24 Jul 2020 12:48:20 +0530
Message-Id: <20200724071822.126758-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724071822.126758-1-anup.patel@wdc.com>
References: <20200724071822.126758-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.20.29.132) by BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 07:18:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.20.29.132]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75f68e67-fdb0-4825-05d8-08d82fa1d53e
X-MS-TrafficTypeDiagnostic: DM6PR04MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5131831497580FE417D64B6A8D770@DM6PR04MB5131.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlPaaTeIOAu7FIQXQDRHK1QYjhR8hKWbDTat7snN6J3bqAbIrBVo2eKi4HS9zHzbZRNplW/nFhX1jKJs2SgoTkCMupAZJb1eT4CLX2R1mv87rQoafm0+qKNut1sdPyZMD6So7xfAGihe9ORGmXq2iWpHHm3xjnZUat628T5RDfGdfgKCGuVf2ltF9RfcqY2j7FoatU1OLcIX7e/MxZHmIhNC7qkLs6uItWgcNSLsVLcvqNHPTEHlgo7o+7yYkoytduhd7GY/pBPDLHKaZtYIyVqt9ZPuuVgWZD095Vvv47GuP1u1+a3PooJ17/J3HzIuLAHuLPokkrY0YGzYIytoyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(7416002)(55016002)(186003)(478600001)(2616005)(52116002)(26005)(956004)(7696005)(110136005)(66476007)(44832011)(36756003)(66946007)(83380400001)(1076003)(316002)(54906003)(6666004)(4326008)(16526019)(5660300002)(8936002)(66556008)(2906002)(8676002)(8886007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Ylnk2t4F8zOkLUW1X9RUYg6vVrNwyl3y1iqwmS38FwZCe8hbaHbzDoqxc4lfa4QCgjze/bZ8jTICwQsCmaO9XvoHH4gPfJVOq9aUM/+XAHqP4WLIxpju2COTn1mxuG6xdE2GhAyrMVhbInCaCYHGjAsnCxpOMXvnB+JcIT9/F4UZrq+S09Xsua3NxgppBACa+KyA0xLRyz5e7KDZerhVB+Wic4Nhv7hEFpml8S/mpM9SetRPYZMzfgH/7Um7+HMsUAq7wYnARzcTWfB2UtgvJ7zno2btnaICq8WIorQt8vc9EeGxcsZ2Ybklk6ANBpAlNsIbAEr5fpGmM8wXNWcTEAGCV1O5CEpyif9tlg44x7q+k55WiIyd3wH8gBd4t/3lqoQglySNx2KP8W+1NQ2drHquDS+i/2COg2BYPlgp+mewR9C0vh2paofn+jIFILeEIPpy2A17rVW2hoYg26h/Z00pl0NTer5m5NwSN7VQ4aJefYlwSD9Sfh6ZBFvfQ3ev
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f68e67-fdb0-4825-05d8-08d82fa1d53e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:18:58.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/6NRHRGBz0ncqweQ9EOHr/Tnnenu1Ju5Z8SlgMytJbHljCjQhCtqHfy6ulBD+wVAl8IhTKmM3cPzbnpap/j3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5131
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
---
 drivers/clocksource/Kconfig       |   9 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/timer-clint.c | 226 ++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h        |   1 +
 4 files changed, 237 insertions(+)
 create mode 100644 drivers/clocksource/timer-clint.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 91418381fcd4..41f1c147c178 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -658,6 +658,15 @@ config RISCV_TIMER
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

