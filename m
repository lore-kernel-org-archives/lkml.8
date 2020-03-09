Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE66C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298620866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DMuqnFyT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EWxU8Kok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgCILDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:03:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:16315 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583751793; x=1615287793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NuMeOAPxbIJoyU7gGtQVPdeLXEFUYW0JaOwcBAnc+8o=;
  b=DMuqnFyTjbX7tjziaYNeElNXIqiDn8LwiUjTbOs2u6Nu/nCUOdfgNIgD
   0wu6YvtOieQv3ZWn3Ggud6BJovoE92GNtdQI56B1SkBbu7YG2Zq81808g
   bzYZcCf+EVQYpQCgVQOGmEFLBWWJtg+r+Jmr245gI867bXf0xp5CewhVG
   2rTg65cYHRYJfulZ51YCs0ljFDo1ks5sPqhIhWQlTAgDACLhLvGmZCZnA
   QgY5qpwd47qGFmDN/eqFIn2R7FyjCtLWjqgekTqirUpiFxvyxjtS/hq8L
   ADs1R1nLJ9WyBetHhl7zvDVJrwMEOo/SxDCiABrz1PATdowP2p0Q0GPin
   w==;
IronPort-SDR: 0V4isYWQLbZcVOo/16Auebfh4yj2LjB1Ui3zuAarIvpuBfsoIQyTlXiBmeXQIhDIHMcqJdsshb
 yIuR/yydkjt0OJ8VMYE1Or7R2mXjONoQwZeiJqGwrmxkBkcFiHluMb6vYUR9T7gh/uQKKxIF8W
 bvCq4WOx/bSsw7/tVlY39IVjvuhKPXfgnNiBPv+J0ULkx5nn3Q2eILq3VpsHeXTFClLnD+Ju5F
 v0q97AC7wk5iC2RjY/adMNTF3j2PBCxe2K8rymhleRdtYu7xkWonZkwKcFM0nImZuMSd+p3StO
 LEE=
X-IronPort-AV: E=Sophos;i="5.70,533,1574092800"; 
   d="scan'208";a="240225753"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2020 19:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0KeQKj3XANupshtzOy7PkZM+VoaLM/DnWZg5Y8muXWrCVWGFjiG1Ro+z14Vbs90ESQCH0X+T/paZ6lK+jdoPvG8JQCKh1UtZaBJNds96SnvHjn2j3ocyV08bDthNbC3jFIU6GaLMsSrReX+yEg2TKH9Ot1Shfd0+qCJ6C9BFakSrSEQ1/TP5dTNokx/ZigBizZhp2cRCr6e88vqt2MBtYl98PXyGuYW1TfcHCydKKwtmcyrZoEWu7gTSzpCa5n3hNAdicR4prLB46bsDcSJ7LLg+fMRiOFVJfPdIB3jZMXLrctDOTRfytEAOA5Y0v1957Je7zZ244ScgIHwpAoZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95V+Mg60mrULfhAfIRSL+aVAgkMlLgSdH+mnp9pPKEI=;
 b=GmGvgTkGSjU73IdTvBPtPZd5Wt4v2h8v0FJlPsQFFcMYGQaucmwkVPM13tzpxD2lqpReXcBkWglwpdWXj9DLIqeAemD1qJQlRF6kIIh2lszwip0gX2L1/f+u2p8bAYJUKLGvTN7KxIp6Nxz2O/rbqff1c1Hk31dhUQG4IVbKc0oO40Cdl4PMs1c1JT40AJwBMU4Htk3ld9v2Gq00+sqlk7TlcbfoL21y0ect8b0h6SCl9CWqgc/GlZquoq25TiCFsB4SaSwyOHkD+R4Ia+MgaaRfWjCdtzOmcbdomlQ3rZ/xfoP0KnBpzii58xR4go/AgO43BUKDy4cLzIzxZbr3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95V+Mg60mrULfhAfIRSL+aVAgkMlLgSdH+mnp9pPKEI=;
 b=EWxU8KokmArsPvZpOsiDzjmtvPg3l5i8srTZjKMKGQqQdVlhvxEFWJxbZ2MJhNwCR7we+oB/HPhv5EtvIhITg8UCty4aUsC5z2RS/JyBGKv8wntZe5Z/cpFn53jfulQ/uGzGMlrO3iSMpyNB+/ItIRNhFQW9UesYEodLMUcefZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB6685.namprd04.prod.outlook.com (2603:10b6:208:1ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Mon, 9 Mar
 2020 11:03:07 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:03:07 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v4 3/5] irqchip: RISC-V Per-HART Local Interrupt Controller Driver
Date:   Mon,  9 Mar 2020 16:32:09 +0530
Message-Id: <20200309110211.91130-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309110211.91130-1-anup.patel@wdc.com>
References: <20200309110211.91130-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.22.61) by MAXPR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 11:02:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [106.51.22.61]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a4c2e45-f943-4ed3-7e51-08d7c4197292
X-MS-TrafficTypeDiagnostic: MN2PR04MB6685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB6685EFFDF8A213A8862ADDA78DFE0@MN2PR04MB6685.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(16526019)(5660300002)(186003)(1076003)(36756003)(2906002)(966005)(478600001)(26005)(8886007)(4326008)(55236004)(7696005)(30864003)(52116002)(8936002)(316002)(81156014)(8676002)(44832011)(81166006)(55016002)(956004)(1006002)(110136005)(86362001)(54906003)(66556008)(66476007)(2616005)(66946007)(6666004)(7416002)(32040200004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6685;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXn0yhcjrL93fTnUa1wyCI49RC+HumMZfNcMbN3nY6mQTBnbiikf2zvNmTtinm9iysDSlMBacW8ojZInOmBhZ437bVHthymNp/nJakGqRFqd9wnBBooao4/IQal+ZMqIaXWmY5yypjVRXELu8Oyy4wbKr5QainCRqdkBeMTqOzEpY5WH4NgJgwz44u/vtntOnuYSgqDobAroMZr/c8XjkD3q4lpbB6VhunueZ0QvOGmWnr7ubrLZPNrfBqonCgl8Luubpyc86vfC22KAGSIITzpQzaL3/uoR+m423uThvm1cqEGhMdIA+fH/ChaqENcHlq2ub+HR1qRYXJyBEM/kTnDEZf6H7y2lSGgZsLJUjZHNhZ78ZTNLNLN7s/tJhgbRca77LXHKRIz5n2YdcVzSEhuv4gyOTaSPysdligZmKe7X49YiHO/8NcyFuOR6dI+b61ryc/8H/li+UAbtGVecZy7GzCmlCw7sAqtdef3wGl16vcIPWlB1/PjVbvUEKFtYBgSt6xxmC8PSZ2yWSfjtCBLNGzqEsK+ep4hMBpOg/zpQKc5nwf/uA7n/+Rc2t2JTDC8ehu2pGbD2PNfuruWJrA==
X-MS-Exchange-AntiSpam-MessageData: CWoGO4GUUWyhd6grg6VhgjGHot8q7AVKqvGfVDdyF6yr/j6EQ89MU6FKdZYkAaRiDaiIxt8ewsiwKCst82BG4V/aNjjV4espit3IAvxJ2wPUZpEBHuhzw733jnNWdzf3y06kDwFoHA5Vfw3MEJWtsw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c2e45-f943-4ed3-7e51-08d7c4197292
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 11:03:07.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJQOMFWDDFsNLYCysiqu+vUiqi7VA1cBwkYIASWNbNXHtz8d+SSS7HsdMGaRDLOO8gb5RNpksffef0DJ5owY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V per-HART local interrupt controller manages software
interrupts, timer interrupts, external interrupts (which are routed
via the platform level interrupt controller) and other per-HART
local interrupts.

This patch add a driver for the RISC-V local interrupt controller.
It is a major re-write over perviously submitted version.
(Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

Few advantages of this new driver over previous one are:
1. It registers all local interrupts as per-CPU interrupts
2. The KVM RISC-V can use this driver to implement interrupt
   handler for per-HART guest external interrupt defined by
   the RISC-V H-Extension
3. In future, we can develop drivers for devices with per-HART
   interrupts without changing arch code or this driver

The RISC-V INTC driver is compliant with RISC-V Hart-Level Interrupt
Controller DT bindings located at:
Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/irq.h      |   2 -
 arch/riscv/kernel/irq.c           |  33 +------
 arch/riscv/kernel/traps.c         |   2 -
 drivers/irqchip/Kconfig           |  13 +++
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-riscv-intc.c  | 142 ++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c |  26 ++++--
 include/linux/cpuhotplug.h        |   1 +
 9 files changed, 181 insertions(+), 40 deletions(-)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8027261584f7..c255ca3f454f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 0183e15ace66..a9e5f07a7e9c 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/linkage.h>
 
-#define NR_IRQS         0
-
 void riscv_timer_interrupt(void);
 
 #include <asm-generic/irq.h>
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index bb0bfcd537e7..eb8777642ce6 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,7 +7,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
-#include <linux/irqdomain.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 
@@ -19,39 +18,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
-
-	switch (regs->cause & ~CAUSE_IRQ_FLAG) {
-	case RV_IRQ_TIMER:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
-		riscv_timer_interrupt();
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
-#ifdef CONFIG_SMP
-	case RV_IRQ_SOFT:
-		/*
-		 * We only use software interrupts to pass IPIs, so if a non-SMP
-		 * system gets one, then we don't know what to do.
-		 */
-		handle_IPI(regs);
-		break;
-#endif
-	case RV_IRQ_EXT:
-		old_regs = set_irq_regs(regs);
-		irq_enter();
+	if (handle_arch_irq)
 		handle_arch_irq(regs);
-		irq_exit();
-		set_irq_regs(old_regs);
-		break;
-	default:
-		pr_alert("unexpected interrupt cause 0x%lx", regs->cause);
-		BUG();
-	}
 }
 
 void __init init_IRQ(void)
 {
 	irqchip_init();
+	if (!handle_arch_irq)
+		panic("No interrupt controller found.");
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 16c59807da6a..dd709ef535ec 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -156,6 +156,4 @@ void trap_init(void)
 	csr_write(CSR_SCRATCH, 0);
 	/* Set the exception vector address */
 	csr_write(CSR_TVEC, &handle_exception);
-	/* Enable interrupts */
-	csr_write(CSR_IE, IE_SIE);
 }
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6d397732138d..cf7a4ce2f121 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -493,6 +493,19 @@ config TI_SCI_INTA_IRQCHIP
 	  If you wish to use interrupt aggregator irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
+config RISCV_INTC
+	bool "RISC-V Local Interrupt Controller"
+	depends on RISCV
+	default y
+	help
+	   This enables support for the per-HART local interrupt controller
+	   found in standard RISC-V systems.  The per-HART local interrupt
+	   controller handles timer interrupts, software interrupts, and
+	   hardware interrupts. Without a per-HART local interrupt controller,
+	   a RISC-V system will be unable to handle any interrupts.
+
+	   If you don't know what to do here, say Y.
+
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index eae0d78cbf22..31ba55d2b6fb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
+obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
new file mode 100644
index 000000000000..e8f7af6dd3c2
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017-2018 SiFive
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "riscv-intc: " fmt
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/cpu.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+static struct irq_domain *intc_domain;
+
+static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
+
+	if (unlikely(cause >= BITS_PER_LONG))
+		panic("unexpected interrupt cause");
+
+	switch (cause) {
+	case RV_IRQ_TIMER:
+		old_regs = set_irq_regs(regs);
+		irq_enter();
+		riscv_timer_interrupt();
+		irq_exit();
+		set_irq_regs(old_regs);
+		break;
+#ifdef CONFIG_SMP
+	case RV_IRQ_SOFT:
+		/*
+		 * We only use software interrupts to pass IPIs, so if a
+		 * non-SMP system gets one, then we don't know what to do.
+		 */
+		handle_IPI(regs);
+		break;
+#endif
+	default:
+		handle_domain_irq(intc_domain, cause, regs);
+		break;
+	}
+}
+
+/*
+ * On RISC-V systems local interrupts are masked or unmasked by writing
+ * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
+ * on the local hart, these functions can only be called on the hart that
+ * corresponds to the IRQ chip.
+ */
+
+static void riscv_intc_irq_mask(struct irq_data *d)
+{
+	csr_clear(sie, 1 << (long)d->hwirq);
+}
+
+static void riscv_intc_irq_unmask(struct irq_data *d)
+{
+	csr_set(sie, 1 << (long)d->hwirq);
+}
+
+static int riscv_intc_cpu_starting(unsigned int cpu)
+{
+	csr_write(sie, 1UL << RV_IRQ_SOFT);
+	csr_write(sip, 0);
+	return 0;
+}
+
+static int riscv_intc_cpu_dying(unsigned int cpu)
+{
+	csr_clear(sie, 1UL << RV_IRQ_SOFT);
+	return 0;
+}
+
+static struct irq_chip riscv_intc_chip = {
+	.name = "RISC-V INTC",
+	.irq_mask = riscv_intc_irq_mask,
+	.irq_unmask = riscv_intc_irq_unmask,
+};
+
+static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+	return 0;
+}
+
+static const struct irq_domain_ops riscv_intc_domain_ops = {
+	.map	= riscv_intc_domain_map,
+	.xlate	= irq_domain_xlate_onecell,
+};
+
+static int __init riscv_intc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	int hartid;
+
+	/*
+	 * RISC-V device trees have one INTC DT node under each
+	 * CPU/HART DT node so INTC init function will be called
+	 * once for each INTC DT node. We only need to do INTC
+	 * init once for the boot CPU/HART.
+	 */
+	hartid = riscv_of_parent_hartid(node);
+	if (hartid < 0)
+		return 0;
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+		return 0;
+
+	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
+					    &riscv_intc_domain_ops, NULL);
+	if (!intc_domain)
+		goto error_add_linear;
+
+	set_handle_irq(&riscv_intc_irq);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
+			  "irqchip/riscv/intc:starting",
+			  riscv_intc_cpu_starting,
+			  riscv_intc_cpu_dying);
+
+	pr_info("%lu local interrupts mapped\n", (long)BITS_PER_LONG);
+
+	return 0;
+
+error_add_linear:
+	pr_warn("unable to add IRQ domain\n");
+	return -ENXIO;
+}
+
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index be05d13e30e8..803db7e9ccfb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -60,6 +61,7 @@
 #define	PLIC_ENABLE_THRESHOLD		0
 
 struct plic_priv {
+	int parent_irq;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -215,15 +217,17 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
  * that source ID back to the same claim register.  This automatically enables
  * and disables the interrupt, so there's nothing else to do.
  */
-static void plic_handle_irq(struct pt_regs *regs)
+static void plic_handle_irq(struct irq_desc *desc)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
 
-	csr_clear(CSR_IE, IE_EIE);
+	chained_irq_enter(chip, desc);
+
 	while ((hwirq = readl(claim))) {
 		int irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
 
@@ -233,7 +237,8 @@ static void plic_handle_irq(struct pt_regs *regs)
 		else
 			generic_handle_irq(irq);
 	}
-	csr_set(CSR_IE, IE_EIE);
+
+	chained_irq_exit(chip, desc);
 }
 
 static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
@@ -246,7 +251,8 @@ static int plic_dying_cpu(unsigned int cpu)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
 
-	csr_clear(CSR_IE, IE_EIE);
+	if (handler->priv->parent_irq)
+		disable_percpu_irq(handler->priv->parent_irq);
 	plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 
 	return 0;
@@ -255,8 +261,10 @@ static int plic_dying_cpu(unsigned int cpu)
 static int plic_starting_cpu(unsigned int cpu)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	int pirq = handler->priv->parent_irq;
 
-	csr_set(CSR_IE, IE_EIE);
+	if (pirq)
+		enable_percpu_irq(pirq, irq_get_trigger_type(pirq));
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
@@ -314,6 +322,13 @@ static int __init plic_init(struct device_node *node,
 		if (parent.args[0] != RV_IRQ_EXT)
 			continue;
 
+		if (irq_find_host(parent.np)) {
+			priv->parent_irq = irq_of_parse_and_map(node, i);
+			if (priv->parent_irq)
+				irq_set_chained_handler(priv->parent_irq,
+							plic_handle_irq);
+		}
+
 		hartid = riscv_of_parent_hartid(parent.np);
 		if (hartid < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
@@ -357,7 +372,6 @@ static int __init plic_init(struct device_node *node,
 				  plic_starting_cpu, plic_dying_cpu);
 	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
 		nr_irqs, nr_handlers, nr_contexts);
-	set_handle_irq(plic_handle_irq);
 	return 0;
 
 out_iounmap:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 77d70b633531..57b1f8f777d9 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -102,6 +102,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
-- 
2.17.1

