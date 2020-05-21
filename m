Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1ABC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4553E2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X50rOvZ2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t5Hnfskv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgEUNqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50473 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgEUNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068799; x=1621604799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fS4oCx7KcForaCNkORzizTEbSAkhgZluurKXK0Ll5Bw=;
  b=X50rOvZ2SH/9oG/l3ZG2s01gvTI/dC2HWyXC6RCl03uNW32mExM0Y566
   qy5Ey/gVwfM7zKZXFDeUwkxrR1onBa4LW8yJSCIEDDDnzkUdSciE+WsdX
   oqkVmHHRbh3k8Y6AcEnjLm/ub+J6R/tlUhOj7JbhXVHwV5mBpZmBHyNbV
   lCdeoWAp23ty3XWCg/eE7rL3AdJ0NxxJZw9xL57KGkz79kZry2l3gB46k
   H2iGPc6/YAqwzspuh3Z8TuV24a+Ct+UXtMyQ2hfhUu92nDjdW6sYm8WWJ
   IzLrk5y1DtAJvO1kFAYLev/u/YYArMuAoqcBESqDxRSY4whlQpeZ69d14
   A==;
IronPort-SDR: xyDgxEugf/cbCYqymdBUC1PNC/naigwgI0JNdqzq0d4JVed0XiPtOSMgSTJwvWbiSbgxCU4KFo
 06i0Pq9i8NyB7J3lybjgtlIeqfPD37xZvHwJ5z3p7+i3ujMr7zTo17v1VNtmAnrUdHcekxOZ/H
 TG2we537YXsmL6PQAzXJfbW31UT+p0Mjtp/yJ9z3nJp7jChddwJrZgmfR1pLyymrinF+taiM8u
 U4ONJYJA6teZg9S6LM8ZqA81lj58Zvoyz7hFV87NYWufXVBZEt86YEwZOHz0Yp/I+vqD8+ATbS
 CTc=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="142554732"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:46:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0FKFYyRySe/pNUlUmOgwHm3DWjRewFu0thFDG6We46aScT02c80AT9NfMLCE83nfaTDZsF7vfii4GQd0pJ8uuBpwyvK2na0bCDZPdGaQogbPvo/6pHCXjtxkliGxGpbdhG0h3TfTwIme6LMY80HpzmtXMnAJgvKY4UxJjTZxwxPvNzHIfkNJK1iYOMEBXNZUFHIkQpgeDH2K6p6+VBAPPppGjNh6bMGvMJ/fLAmfoBv9nUQxwptxSMmwL7ufJnxFwZ8MqvW0hR+C8zHIwPAx/fkU50jmByPZqfLk1SByBWsH/Fi9js7UhvxKBTqWphjn5y1FG2iuz58R33BPmdq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw5oAfVYe8UnXA3bm1hEvT5Z0rKIubxZUloGvuw9Dyg=;
 b=FvWuPaLim4ZBUny+B3WS4tyjz8oCBWpRudmckNxWjmeGnqTDdBZh/iFLHsx4vCKZNsJnmKnlSGKOP8Tbb6pc2Wz/oCn7yUlz7hDdhTgq9Ryl6S8stD9bCIexLBPkcu9vixjbsr6u3KdpGEAAKB4Bjuxr2SskDclffJi+KQRkLD+Dpu7sgCDwNdc3u7zhF7UnUanHNlo5OgOpaiz5YNzfVT+dZPexEeNIi8U8yZyvWnvJ4+/NdjYDI4q9ZJDOriO2Kh9geYiQaE6Sw877pPGKNcP+Io+54BY+Fpd4TlGVpGTqvCKMHm5zeI+rzrgrcdgeC7q3X/CTpHW2ACbvW8AORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw5oAfVYe8UnXA3bm1hEvT5Z0rKIubxZUloGvuw9Dyg=;
 b=t5HnfskvVzb8gkWWCiPuGaRVz12CY3Z9OcNTZiuuawJBWVEVxsd3CD+qRxHMkGwcuwi/alnTn9r/4UZlwNQHxQc2ArBOk/DR2WXfZ/iJp1sbs1eXAWgjNiIsVaOjRMynd+sAL9EcguaswiMNBedn/g7wbwuc9yU2MgsWpdneD8s=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4985.namprd04.prod.outlook.com (2603:10b6:5:fe::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 21 May
 2020 13:46:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:46:36 +0000
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
Subject: [PATCH 2/5] RISC-V: Remove CLINT related code
Date:   Thu, 21 May 2020 19:15:41 +0530
Message-Id: <20200521134544.816918-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521134544.816918-1-anup.patel@wdc.com>
References: <20200521134544.816918-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:46:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae2edc1b-102b-47b1-349e-08d7fd8d5be9
X-MS-TrafficTypeDiagnostic: DM6PR04MB4985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB49856C499F5F2369E566DC4A8DB70@DM6PR04MB4985.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwEsXFtbMBcjudhEft8mE8b1zouZ1cOahCr3nfLHYXgRT1aXwFqnqX5aKTk4IqEesub5LtPvvKSOzfdfL6PhU/bnaOOPyWcR8qE2LlRxhOL72iPg6tHnOaPcofVCDtcLIxHnIHGf7AhHxavnrlZMtGMzqpr6/DA0zSxr79JQjdzJykVnyzO56WD/+MtkO/B02FVsGP/EZfclUkJ8uJal5og7QGwGhKdKCBVZVl0L6H9bO7jBksq8fu6G9gO/yK2LDd/pdONVs4c8oY7DA9IBWatABu9arcKmrdVouiSJr4DBR8YHcE4NuaGmYiAH/qPmbzQ/3eGZBI1cVES3d6cTeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(55016002)(1076003)(1006002)(7416002)(6666004)(7696005)(2906002)(86362001)(55236004)(8886007)(52116002)(4326008)(16526019)(186003)(8936002)(66556008)(66476007)(66946007)(2616005)(956004)(44832011)(36756003)(110136005)(54906003)(478600001)(5660300002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DfpAGnZNOvb1/N6I0v8NrgBgNr2IFx0lb2JgREd/79h1y+JibL7+oq4IABKpvexDWitLqAtNvkCMqEuzWOGrK4/B69aPJMRzaN6r1o9EgJ2LiOGYG7MbKSP29i2IE9mg2KqeMEEpvrqgc95AnDNu26OnXv9ON6hORxtBxjuAacnMHYBiBKlyJtrQgZQWxiZe/r5ykwtKbvCJGQCWWm7QbaDVIoSe0MoKEFE2C7Dcg5Dv928eMcgBll4G28lr/iSp1pUNozxGao6a3NYVZnzk8VBy28ujLr4tbBfUgeEKUylShMTWPNqNHrYfkX2S5FEB/5w1AeTh3FyDeTi9ij0J+moP9EsiKJQzBCsFusZlEDnSXnWQieu9Xko4KXsU32oJlK2leuLYNkdjeyErKhh6imDSOrHopKUBHuxHIf4HzKVAg1ltPXtPNaSeUy7+lLtLoqI5pgc9XxKTfA5dIcvC1QAPHnp8BUhllHJ9Qx4UjJk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2edc1b-102b-47b1-349e-08d7fd8d5be9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:46:36.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkvamQY52Qse4Di+XQczdKZn6b5KztlCNP2aCLVVu3UiSRkOSHKM2dySSZZ6/1bN4nPfwAfplsV/J86Yeyww5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be having separate CLINT timer driver which will also
provide CLINT based IPI operations so let's remove CLINT related
code from arch/riscv directory.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/clint.h | 39 ------------------------------
 arch/riscv/kernel/Makefile     |  2 +-
 arch/riscv/kernel/clint.c      | 44 ----------------------------------
 arch/riscv/kernel/setup.c      |  2 --
 arch/riscv/kernel/smp.c        |  1 -
 arch/riscv/kernel/smpboot.c    |  1 -
 6 files changed, 1 insertion(+), 88 deletions(-)
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c

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
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index d8bbd3207100..529cda705cfe 100644
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
index 145128a7e560..b07a583bf53b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -18,7 +18,6 @@
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
 
-#include <asm/clint.h>
 #include <asm/cpu_ops.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -76,7 +75,6 @@ void __init setup_arch(char **cmdline_p)
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
-	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8375cc5970f6..8a23f1eb5400 100644
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
-- 
2.25.1

