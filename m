Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1AAC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D33120704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EA+il1Ty";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PFR/V95K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGQHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52761 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGQHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594972310; x=1626508310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pG8bCz9+/e+jWuzWwu9t/Y88g7Nc5amFW6Xix3ZBG8Y=;
  b=EA+il1TyEC8hq1LjxtnZnMHQP4C1oZs3NT+OyIGawpVmKhEn60z8wNRD
   W7JZPVQMlSRPpF5Rx3RasF7Y9Xt9SDLI72VXSRX0HJzBo8B4S94QjalWW
   hgMAnIDhC0vmmZb7nPT1MdSFpg0rqqnxwZp23MC5li9oXjhINgb1EH6lu
   IwI8yFJw11M9zQhwoNWt/sXhMApGKV7q2dJe6SIqRcVijDgiVQ6jR9Wvx
   QuL2do5U1f+iK9fl1y+bNB5qnMtGRkyXhbRxMVMts1MdUiRHdtNOP6n8j
   dWcp4XVDd+fVCBorRSOiyFZotMdepG3qPYI1XN3of2YpPrk/FcyEa/CRr
   A==;
IronPort-SDR: Um3LmM8CPlhUhp4ab6GmGs3HCAsBM0flQIRkqYxXXz25OLZXnE/EjoBu/DlFjNwWOrV5AbmZyP
 X/5XH33CKlQq4yu9J4PyZgJUhIYs/PyfCMXAqNj37lZxmO3tJMNpmclw8K7F5wSLqxbsaozgFh
 ycLrm6R0vYsgWYSCc1p0SBmGFhXjfcdsXXsboAZoqU5lZuLMCDpV61SxYptqO/vVG2sXsdihhD
 1FgdG/wH1XzNnFpvWXfbMO7zOPC4AGDk10GCOyvskbiVrgLwuXrFEBiMOZtw/5IufGAGNe46uQ
 7ec=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="147003902"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:51:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRYWy4Eia1ujU998NAJ2JjyNTEDu97xzoNSLWdJte0wpA4GZtzqwT1wmLlFpy0s0KyhjVK/8HNaV4ie3/ZinRaH1zSgNPcT8VHuZ3JG/UoBJTliky06lsFlYsBH0O388zLOHjUvgX0i2yVjM6XYsjK6p8xGHsuG/+KJmclOF3X6DEaSqFkMCcqoWLktMuWDgD3xuKu4A84eaqxFtDGa2Wc/rjhDGagKsPibqmMaGQynZlg2cGiITRJxNt72ZhH0A67GNd1hllQu4ukQHJkJbXC8IB5oz6T5seZIRGSJqnFkJWLfGIF5wIbAlyQGP4L6SshrHJyyQShoF1MvNemsDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwkPSLvyGF5ZqV4schIGK+dJieFCLVT35Luu+bVZrRo=;
 b=EZ1GRIoZZfmahVfARvht+CotevpEvbTJ+PR2xqFR52zMhd0BIOo3uu3B9o823CXMDYRP/rKz3OBgLbQtXc1aIvp8dm6j7ddgcUpnTzia5wblVe5+8bENkLr+6JDvgcnZzKKxV+SwlHZYe7ewF6GXg4QSaEb72JLB1juWcjLQm5OQUczJuc9aZ5P2KuTeMmTXNrl0z6Y8VW8fon9xMRUnPOcjQbnjjHpRc9RSZtiimtMZk/C02DKTWM2fAxo0BktrsX8+b7ZMIvvEFBfsAKqF21/mIO8H7YueuoFMTLxNv+s06ly0d4LXPBRnSxu27t0wpKv53NI0bxCUAblvuRiCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwkPSLvyGF5ZqV4schIGK+dJieFCLVT35Luu+bVZrRo=;
 b=PFR/V95KERzwCtdCeaW8mx78B0sqsAcKMaPIho+6hN+KVrOevyFHbatoaKvNw01lk6BkDD6A7dEB675shzp4OQWdJonDSuOYol4r1hk2tTVkI/SKvQlG+oHmHbVqg/FyLQsD+37+TqpWaJ5wUG8gBWDhMG8ehHD/G7YAuZ4qUHA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 07:51:47 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:51:47 +0000
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
Subject: [PATCH v4 1/4] RISC-V: Add mechanism to provide custom IPI operations
Date:   Fri, 17 Jul 2020 13:20:58 +0530
Message-Id: <20200717075101.263332-2-anup.patel@wdc.com>
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
Received: from wdc.com (103.56.182.72) by BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 07:51:41 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.182.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 280ae4d5-ceae-462f-6f79-08d82a26414b
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6331A69D08E59BAC1BEB5A298D7C0@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbICQPPQ+saDsUjL0awS6ZxFmzUeSoWwcjwlPxeLKQXk+p5sArUh0tq2OSeKj75NfMrMzF+6uLb/tKcoLoGuHj4G2u5RYncb6XJ7ucz1kdy+7nKWCGUPdtCcXwQT11E1g6Me94F8YEa6VA1OWzPKbhnBGOLCtA3ZeFw6LhsOLrHA9LWwWeoXDtBJelzkJtRXSKMhpXtTE10xv44VHHPdBl3/8Cl5VVUVie6tl+gLRZFw4cs8kAW0d5XeBvNfcTXyINV6iA0lDukoc8HPvTLtoFuFydb3PUOHL50eJ3Ob4IFRwphpea7fEx972rb6cRFGm5Pc7tmkCOQ+A80SmFDmTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8886007)(8936002)(66946007)(83380400001)(66476007)(66556008)(1076003)(4326008)(5660300002)(86362001)(36756003)(44832011)(316002)(186003)(110136005)(7416002)(54906003)(478600001)(2616005)(956004)(8676002)(6666004)(26005)(7696005)(55016002)(16526019)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NOrQNqft8V9E2W3jLhW1jctblXHHWm82MMXGa1JhFG989PsFBTQFxQ01oHL8wa21Y9I6YzrADoqE96pTWPVFhBxCFdDvtuKJMTn3UWiWgiblN6+E/1kyp10RRh7pNuHauwpAex6UnKtKxbDLv3g/WJAVDJp95oCZ3UvAiG/MT8nzuwWNO/wCFxEw4qL+KiSUVlAiLiskKFSyfEjHG2Y3AA7GG3ECnNeAKFshTnPmDExcHjURv8iWQIbzVCn1AxyOtOf6fRckUyV8ej/8tcFU7nzHGsXKKFAgDvZN+/jPJMKrU8Z0XMw1XoIvpKfpUUBIvYkIzJ1YlKkfstjGx+IR+RhUHSw2602yjPaURbJy5lTSFj1dM6385cdkIMPT1Tzxdsm0JjUqfYD0m7eWMgLFViRDRSX82jMllTyEiDnnRmMbOad5biXyDC+EENz8WUuLm1m3pPY2nB9YwlvJMZR4+H3Vo2QN6+nTxeiSPNfjUwU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280ae4d5-ceae-462f-6f79-08d82a26414b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:51:46.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k21jJQ/h7IZaO7C8ZV60ECKRNFZBGBfSuS0qzbtpZDeb1Gh1ZyscXEva+UxLCWQRZM8QfouhfmvQ7KIqJeVkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
---
 arch/riscv/include/asm/clint.h | 25 --------------------
 arch/riscv/include/asm/smp.h   | 19 +++++++++++++++
 arch/riscv/kernel/clint.c      | 23 ++++++++++++++++--
 arch/riscv/kernel/sbi.c        | 14 +++++++++++
 arch/riscv/kernel/smp.c        | 43 +++++++++++++++++++---------------
 arch/riscv/kernel/smpboot.c    |  3 +--
 6 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
index a279b17a6aad..adaba98a7d6c 100644
--- a/arch/riscv/include/asm/clint.h
+++ b/arch/riscv/include/asm/clint.h
@@ -6,34 +6,9 @@
 #include <linux/smp.h>
 
 #ifdef CONFIG_RISCV_M_MODE
-extern u32 __iomem *clint_ipi_base;
-
 void clint_init_boot_cpu(void);
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
 #else /* CONFIG_RISCV_M_MODE */
 #define clint_init_boot_cpu()	do { } while (0)
-
-/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
-void clint_send_ipi_single(unsigned long hartid);
-void clint_send_ipi_mask(const struct cpumask *hartid_mask);
-void clint_clear_ipi(unsigned long hartid);
 #endif /* CONFIG_RISCV_M_MODE */
 
 #endif /* _ASM_RISCV_CLINT_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 40bb1c15a731..68de78a8eba6 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,6 +15,11 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
+struct riscv_ipi_ops {
+	void (*ipi_inject)(const struct cpumask *target);
+	void (*ipi_clear)(void);
+};
+
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
@@ -40,6 +45,12 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+/* Set custom IPI operations */
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
+
+/* Clear IPI for current CPU */
+void riscv_clear_ipi(void);
+
 /*
  * Obtains the hart ID of the currently executing task.  This relies on
  * THREAD_INFO_IN_TASK, but we define that unconditionally.
@@ -78,6 +89,14 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(boot_cpu_hartid, out);
 }
 
+static inline void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
+{
+}
+
+static inline void riscv_clear_ipi(void)
+{
+}
+
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
index 3647980d14c3..a9845ee023e2 100644
--- a/arch/riscv/kernel/clint.c
+++ b/arch/riscv/kernel/clint.c
@@ -5,11 +5,11 @@
 
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 #include <asm/clint.h>
 #include <asm/csr.h>
 #include <asm/timex.h>
-#include <asm/smp.h>
 
 /*
  * This is the layout used by the SiFive clint, which is also shared by the qemu
@@ -21,6 +21,24 @@
 
 u32 __iomem *clint_ipi_base;
 
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
 void clint_init_boot_cpu(void)
 {
 	struct device_node *np;
@@ -40,5 +58,6 @@ void clint_init_boot_cpu(void)
 	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
 	riscv_time_val = base + CLINT_TIME_VAL_OFF;
 
-	clint_clear_ipi(boot_cpu_hartid);
+	clint_clear_ipi();
+	riscv_set_ipi_ops(&clint_ipi_ops);
 }
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f383ef5672b2..226ccce0f9e0 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -547,6 +547,18 @@ static inline long sbi_get_firmware_version(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
 }
 
+static void sbi_send_cpumask_ipi(const struct cpumask *target)
+{
+	struct cpumask hartid_mask;
+
+	riscv_cpuid_to_hartid_mask(target, &hartid_mask);
+
+	sbi_send_ipi(cpumask_bits(&hartid_mask));
+}
+
+static struct riscv_ipi_ops sbi_ipi_ops = {
+	.ipi_inject = sbi_send_cpumask_ipi
+};
 
 int __init sbi_init(void)
 {
@@ -587,5 +599,7 @@ int __init sbi_init(void)
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
 
+	riscv_set_ipi_ops(&sbi_ipi_ops);
+
 	return 0;
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b1d4f452f843..8b85683ce203 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -84,9 +84,25 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+static struct riscv_ipi_ops *ipi_ops;
+
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
+{
+	ipi_ops = ops;
+}
+EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
+
+void riscv_clear_ipi(void)
+{
+	if (ipi_ops && ipi_ops->ipi_clear)
+		ipi_ops->ipi_clear();
+
+	csr_clear(CSR_IP, IE_SIE);
+}
+EXPORT_SYMBOL_GPL(riscv_clear_ipi);
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
-	struct cpumask hartid_mask;
 	int cpu;
 
 	smp_mb__before_atomic();
@@ -94,33 +110,22 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 		set_bit(op, &ipi_data[cpu].bits);
 	smp_mb__after_atomic();
 
-	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_send_ipi(cpumask_bits(&hartid_mask));
+	if (ipi_ops && ipi_ops->ipi_inject)
+		ipi_ops->ipi_inject(mask);
 	else
-		clint_send_ipi_mask(mask);
+		pr_warn("SMP: IPI inject method not available\n");
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	int hartid = cpuid_to_hartid_map(cpu);
-
 	smp_mb__before_atomic();
 	set_bit(op, &ipi_data[cpu].bits);
 	smp_mb__after_atomic();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
-	else
-		clint_send_ipi_single(hartid);
-}
-
-static inline void clear_ipi(void)
-{
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		csr_clear(CSR_IP, IE_SIE);
+	if (ipi_ops && ipi_ops->ipi_inject)
+		ipi_ops->ipi_inject(cpumask_of(cpu));
 	else
-		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
+		pr_warn("SMP: IPI inject method not available\n");
 }
 
 void handle_IPI(struct pt_regs *regs)
@@ -131,7 +136,7 @@ void handle_IPI(struct pt_regs *regs)
 
 	irq_enter();
 
-	clear_ipi();
+	riscv_clear_ipi();
 
 	while (true) {
 		unsigned long ops;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e9922790f6e..5fe849791bf0 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -147,8 +147,7 @@ asmlinkage __visible void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
-	if (!IS_ENABLED(CONFIG_RISCV_SBI))
-		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
+	riscv_clear_ipi();
 
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
-- 
2.25.1

