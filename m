Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDCAC433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8192065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ii9HEdJ2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oCzKustm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGOHQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:16:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34313 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgGOHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594797367; x=1626333367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Psn2yIlpD2KVWNBMrqJPqh57Z8NfDyZUoIAT3x0wKaQ=;
  b=ii9HEdJ2uIfJYMNzgN6poN63QsjQHzYUm2ZmnKcyq80Vy7QkoYve6VFS
   /6JdXkZEhu7i7A4vKwDh5F3TNHpaEr0XdIdiO2CnGf8Iy+aEewKMVLxOL
   ujTJl3SsjnFPxt5JqKDoeIrSFQTAFiyDNUooNdE4zBs/YbUs7JwNpi3va
   upI54UpVN8vl452j49PPfj13l4bn61cBupKyLqrIrEWvWyBHDIgoksSI5
   1ZaLCGvNRIjX4Q/nIO80s1683u6Pp8N5c+FrzWFUFeokH+r5hEG4iQ+mp
   0wuLc5r7uN87qrvX0Fg6B6KGTiSmyixu9rubAcHLklcil8rB0R6bsNQ3D
   g==;
IronPort-SDR: 7nvuNnhmDYohmD64NDKPIknEOgDQOgKtQe/hcYu+HwU3B5sryA/pwpdVaIqLCPD6sbjClVidRk
 rW4DtS/X/f+MehNI7chTOiHampstLHlNb2l0smDZoXc65UxtNpteqOvvyY/VSgi9cEtQxpQ5v2
 oocX253ZIwXBAzv5N3ccLmvBSyTRobG9eZrTk6T2+pTMA/5++vGn2L48rGR/KFWShUrel5ZlbJ
 nwPByEVARXpwXPkqNAfly4RxZLvMFV3xZdp8DqYPUM1bjHDiN4Gk+PXW1n2UNXII7vOXc41Lo6
 6fw=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; 
   d="scan'208";a="142495417"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 15:15:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL6f9076nPzQlWW5r5YNW7hOqQTcORwUIAf+4tOyk8jDU4iCR9fKmkpXWOU0BKKE1CLpp65eZreIg3xLk1QC2oIgORmcnc2nzI/cR0Quuv0xKmA1afUSSLMLzNLq2Eew3EEjjqVw+kOIIYrVEg+qjNmk4HQ/5xY9C5gGE8TB1VGj6EqCe7RcaID+LF8aSEVHzmsLxL3REILVGlUiWHsYKG0Ia0Dh6cMSgyAMGDx/NBeDrDt2Z+Pr8uPd0PHaXPsourLxrZLfCeN+UqCfEIFn30alugJgM8ahuTzvqKz4WTfQYXH2DWXsYeTC2BmYu6KFhHDEy5Av1q9RYvmSTa9zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8cJoT3K4mOWnXe7fu/2byOoPfzc0fZXjumTg03NI+w=;
 b=h9zEhXiJI+1jDAgy1zijgWjDoiJ14kq9FsJfjBcqOm+bMtebm5f42hiKMrYx1mmUTmPO6jmxVGNDwXVjMsB8NheUnkflKp3K657mDIxf4MHrB1HUgveF2wGgKGtE3Oj8Few5f0e3azk08CK9Q2ZL4tykQgnaxFA8Oa7K2cTxxbLUANv2AQZo+lTd3WkXoJ5yMl9uEd22EJJWbD8eKv6p2fprRgBxpXy0rh9g/Gehm/enx0p0n3FQC5jC4C2VbueT5luwzEz/byCU04v+mXMBX0+YqoXdQbe/JRzEOTtlL3ORA/KmbpLRf+Gp9gGX0ymIxxyb+m6hv9yuLB4j3xKyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8cJoT3K4mOWnXe7fu/2byOoPfzc0fZXjumTg03NI+w=;
 b=oCzKustmsrwswU4zb39tRlhDNaNC6QlVcNN46e9v2yW2KfJrjjlGa7ODsrekS94Xj6HxNEsYnbtK2Cy4h8UTqbRHbt72fsmYFuGMyNxoRw3Nwt6agwFyB0I1A/5N6BiYfS3edB6JltykIbmjKcZZAPLZIpESmFU6DdY/ps9R3NU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4329.namprd04.prod.outlook.com (2603:10b6:5:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 07:15:50 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:15:50 +0000
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
Subject: [PATCH v3 3/4] RISC-V: Remove CLINT related code from timer and arch
Date:   Wed, 15 Jul 2020 12:45:04 +0530
Message-Id: <20200715071506.10994-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715071506.10994-1-anup.patel@wdc.com>
References: <20200715071506.10994-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.57.135) by PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 07:15:45 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.57.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8225230c-2f8a-42eb-be22-08d8288ee73f
X-MS-TrafficTypeDiagnostic: DM6PR04MB4329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB43298BC26D439AAEEDD561AE8D7E0@DM6PR04MB4329.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8BHC13ARUpogdQssKTp4o5Zm0uo3KkJO5jQmefiVER1FzKH1DhQtB6AIhv2MJFzT/OLQtRR0NPzrelOSlUYdX5Nopm1KfCVzMLLurGB4tJsJEUGJjGmEZEuh8bfDkh8IksNEEN34XzXVB56e8inj3CW8Ns+b5HbFYHuXrW+M9OPd9U00ZlmAESa97gwmz2llKLiX0YCkEeuOCtHwDjyE+nxWuoftbVeWh2mbOJedoF0MhTYnkB0ySWndUdSmUFI+vfpeKQRc894BVyrIa4CZ4OhShACO0LxwarAFoWBJmSBvw216xLcFaA0xYJAEvTQj15am8wBANk4y3ufyUZxTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(8936002)(16526019)(8886007)(186003)(44832011)(36756003)(7696005)(478600001)(26005)(66476007)(7416002)(66556008)(66946007)(54906003)(110136005)(52116002)(2616005)(316002)(956004)(6666004)(2906002)(86362001)(55016002)(1076003)(8676002)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BNMY4h7rY8jWLvdL9BkNg4PCMV8f+t1SaWKzCUDl0BfqSSdkFYGknj9WcNBo0R+78+cD/XW/5uhwnc1eNRETZjzp0CRtz1mM+O3uEMcf1J0BNS7N4Os6/9ua7yqtTalTg5OjZZpQGRNk1n2d+odYF/BIJsex7bSw1dLYPhXnn1/8XHYNH9hSTz5o3qV5kt1CaNauN+arzBj2g5IUv4HVyH3oLkQzx/TY9Nz/qT4AQa7W+h9MrE7XS9VTVebIna7SYzwqh63zACyvBRfB36k8fUyqj2luL/I1MZrysf71AiW5xRa3NlGE+BqYBcMhkDGTryJ+l5pLIr0fJX8s418jFHfFxl8pfMOAFDHdFEos2HcaDtqt4iApY/EfIZbYM6v4stt3uknQ4hOwU9lJEySpzHqzp0TonvOaRPK9JagvWlRMp/QaPmXiu1i3iryyhcfus+oZ5Svc7810eP9AZEcsCscS6JaAG1VndjDxcpU21tE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8225230c-2f8a-42eb-be22-08d8288ee73f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 07:15:50.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwqbIm1IlL8RcpB5rUXM2Zx/h96OE9tNd1dPqOUU/o9PYJZ5pSvOoPSWTHZcZnQxsOloAWFPXZ6WByvwpAJEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the RISC-V timer driver is convoluted to support:
1. Linux RISC-V S-mode (with MMU) where it will use TIME CSR for
   clocksource and SBI timer calls for clockevent device.
2. Linux RISC-V M-mode (without MMU) where it will use CLINT MMIO
   counter register for clocksource and CLINT MMIO compare register
   for clockevent device.

We now have a separate CLINT timer driver which also provide CLINT
based IPI operations so let's remove CLINT MMIO related code from
arch/riscv directory and RISC-V timer driver.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |  2 +-
 arch/riscv/include/asm/clint.h    | 39 ---------------------------
 arch/riscv/include/asm/timex.h    | 28 +++++---------------
 arch/riscv/kernel/Makefile        |  2 +-
 arch/riscv/kernel/clint.c         | 44 -------------------------------
 arch/riscv/kernel/setup.c         |  2 --
 arch/riscv/kernel/smp.c           |  1 -
 arch/riscv/kernel/smpboot.c       |  1 -
 drivers/clocksource/Kconfig       |  2 +-
 drivers/clocksource/timer-riscv.c | 17 ++----------
 10 files changed, 12 insertions(+), 126 deletions(-)
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fedb4a72b29a..57a72ae23d10 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -74,7 +74,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_INTC
-	select RISCV_TIMER
+	select RISCV_TIMER if RISCV_SBI
 	select SPARSEMEM_STATIC if 32BIT
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
deleted file mode 100644
index a279b17a6aad..000000000000
--- a/arch/riscv/include/asm/clint.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_RISCV_CLINT_H
-#define _ASM_RISCV_CLINT_H 1
-
-#include <linux/io.h>
-#include <linux/smp.h>
-
-#ifdef CONFIG_RISCV_M_MODE
-extern u32 __iomem *clint_ipi_base;
-
-void clint_init_boot_cpu(void);
-
-static inline void clint_send_ipi_single(unsigned long hartid)
-{
-	writel(1, clint_ipi_base + hartid);
-}
-
-static inline void clint_send_ipi_mask(const struct cpumask *mask)
-{
-	int cpu;
-
-	for_each_cpu(cpu, mask)
-		clint_send_ipi_single(cpuid_to_hartid_map(cpu));
-}
-
-static inline void clint_clear_ipi(unsigned long hartid)
-{
-	writel(0, clint_ipi_base + hartid);
-}
-#else /* CONFIG_RISCV_M_MODE */
-#define clint_init_boot_cpu()	do { } while (0)
-
-/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
-void clint_send_ipi_single(unsigned long hartid);
-void clint_send_ipi_mask(const struct cpumask *hartid_mask);
-void clint_clear_ipi(unsigned long hartid);
-#endif /* CONFIG_RISCV_M_MODE */
-
-#endif /* _ASM_RISCV_CLINT_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index bad2a7c2cda5..a3fb85d505d4 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -7,41 +7,27 @@
 #define _ASM_RISCV_TIMEX_H
 
 #include <asm/csr.h>
-#include <asm/mmio.h>
 
 typedef unsigned long cycles_t;
 
-extern u64 __iomem *riscv_time_val;
-extern u64 __iomem *riscv_time_cmp;
-
-#ifdef CONFIG_64BIT
-#define mmio_get_cycles()	readq_relaxed(riscv_time_val)
-#else
-#define mmio_get_cycles()	readl_relaxed(riscv_time_val)
-#define mmio_get_cycles_hi()	readl_relaxed(((u32 *)riscv_time_val) + 1)
-#endif
-
 static inline cycles_t get_cycles(void)
 {
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		return csr_read(CSR_TIME);
-	return mmio_get_cycles();
+	return csr_read(CSR_TIME);
 }
 #define get_cycles get_cycles
 
+static inline u32 get_cycles_hi(void)
+{
+	return csr_read(CSR_TIMEH);
+}
+#define get_cycles_hi get_cycles_hi
+
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
 {
 	return get_cycles();
 }
 #else /* CONFIG_64BIT */
-static inline u32 get_cycles_hi(void)
-{
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		return csr_read(CSR_TIMEH);
-	return mmio_get_cycles_hi();
-}
-
 static inline u64 get_cycles64(void)
 {
 	u32 hi, lo;
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index b355cf485671..7edf15643146 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -31,7 +31,7 @@ obj-y	+= cacheinfo.o
 obj-y	+= patch.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_M_MODE)	+= clint.o traps_misaligned.o
+obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
deleted file mode 100644
index 3647980d14c3..000000000000
--- a/arch/riscv/kernel/clint.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Christoph Hellwig.
- */
-
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/types.h>
-#include <asm/clint.h>
-#include <asm/csr.h>
-#include <asm/timex.h>
-#include <asm/smp.h>
-
-/*
- * This is the layout used by the SiFive clint, which is also shared by the qemu
- * virt platform, and the Kendryte KD210 at least.
- */
-#define CLINT_IPI_OFF		0
-#define CLINT_TIME_CMP_OFF	0x4000
-#define CLINT_TIME_VAL_OFF	0xbff8
-
-u32 __iomem *clint_ipi_base;
-
-void clint_init_boot_cpu(void)
-{
-	struct device_node *np;
-	void __iomem *base;
-
-	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
-	if (!np) {
-		panic("clint not found");
-		return;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base)
-		panic("could not map CLINT");
-
-	clint_ipi_base = base + CLINT_IPI_OFF;
-	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
-	riscv_time_val = base + CLINT_TIME_VAL_OFF;
-
-	clint_clear_ipi(boot_cpu_hartid);
-}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f04373be54a6..2c6dd329312b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -18,7 +18,6 @@
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
 
-#include <asm/clint.h>
 #include <asm/cpu_ops.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -79,7 +78,6 @@ void __init setup_arch(char **cmdline_p)
 #else
 	unflatten_device_tree();
 #endif
-	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8b85683ce203..07626be78c23 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 
-#include <asm/clint.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 5fe849791bf0..a6cfa9842d4b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
-#include <asm/clint.h>
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eabcf1cfb0c0..d3bf66123c4e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -649,7 +649,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
-	depends on GENERIC_SCHED_CLOCK && RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV_SBI
 	default y
 	select TIMER_PROBE
 	select TIMER_OF
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 9de1dabfb126..c51c5ed15aa7 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -19,26 +19,13 @@
 #include <linux/of_irq.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
-
-u64 __iomem *riscv_time_cmp;
-u64 __iomem *riscv_time_val;
-
-static inline void mmio_set_timer(u64 val)
-{
-	void __iomem *r;
-
-	r = riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id());
-	writeq_relaxed(val, r);
-}
+#include <asm/timex.h>
 
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
 	csr_set(CSR_IE, IE_TIE);
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_set_timer(get_cycles64() + delta);
-	else
-		mmio_set_timer(get_cycles64() + delta);
+	sbi_set_timer(get_cycles64() + delta);
 	return 0;
 }
 
-- 
2.25.1

