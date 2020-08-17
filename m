Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C252072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d75haQY4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ntAU1op/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgHQMnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:43:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44398 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHQMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597668203; x=1629204203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gxOtuHk7FATfahi9WqIQg7Y1jEp69GaReooQoNi9avI=;
  b=d75haQY46JMjtVePdgNqQF9C7v+B+IuMq4S0ebLoTdQ2NurCUGwuy0uX
   KT89lCfJxIRLRUYru6qdInXlnOQRgvqXss8CPSqlms5BscYkhB0/ho3K2
   qf45UBpHg8Zb8P337gqKUyKnSRZIqn0apmns4QQqnbsmtmlJhY09WBR3s
   nUaoG+HIOmvvlOjx0jchiJGkN9Mz2RhIHBfzCEIpcpuIR9vLOcZjUie0v
   H4dJc4Fw/5QylTNx/mKsh847qzDqWiPH6cglOfa85QoOHRP6+4sdVbQrP
   6QI7CIlNAUtMv8XSnKA1+6+zCTN/2WHj72JFPGxRuoVFVjWpSZYhZHR9g
   g==;
IronPort-SDR: cgcSRCiQbFyrLcriyRc+WOjuUAlAodbZzAf/oCHQMX8HwFqgaGPD84ZDPzRNLv4NPvjLVAjWxk
 5+g7hHizHIhQikDzo7n4d5sKNW398aGK97lrZBIN7N2RV9BIWcQIm4jQKDUqKsRUpMaqlyagcG
 cLxxOt+asvoo6ORbEXOC3i0iNLDqBeVMqOfZIFSu+nsOV8AnIkKKqHgGTK5qWP/a6iqR7CzajI
 /z6CP775sMJWXHt8uQxEn522NZ4yNPRHYG3KKq4CLdUA4Ef55gkEkBiy229HR9ecf2xvHsYw5X
 GzU=
X-IronPort-AV: E=Sophos;i="5.76,322,1592841600"; 
   d="scan'208";a="145088374"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2020 20:43:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7qxxAjAKRwhdpWptnFjJwc95FO0EsC25GAsMucw6LCeTkphXDcZ1lAGhUqjPPVIV0Ddch6g3wmKNUGNTT1vKkPx76ExOA7ZRds0ZVfiJVvejO6/RnQiLvfcnvL+BBNsPrnF31Gz7kwmbSRhTgpWQE+L0W84NqarcsU+qGYpxsy8HjAuic/5upuOV4OE6V9Zhvaz5b5vUC65xu3V2Rgdr1Bm1Zmvr6pY1C3PZSiPMpFRnvDETCgiPi23uT1fWVW9WxhGxEwpSN1TSLVxLhsjBbIIu30GE0rhlorxvGeVZfDQ2R8sDWgtzPBL8b0VpUalDsE6r2upyhUjShQp6ADWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91xDH6SZgdVLYax+m7wZ0oqPZSNNZm8sOmhgPUpiEuk=;
 b=OzVd86EheJ90utGwhDVE9iANZ+S3h1QVpvFOm8K0vH9Fsc0zOpMQDSxrElwhbvhz7wKHU0kmvHHO+/tpcZacQDpftE/2yKCY06pjZTymQyfCPsbd+jeuljzUWQWKjAGlxspYcyNEc3bom7XjyVWtZsDr6LTVxAVldMg+21GyrYDysOyBQXLIURjAr4Ka3TQNvr4rnkfU8ihDDD775D1n8P9B0FH0DIxk1iezY3KuTxN+hpnSvfUEjnUo9Z5Lbi1ME8K1KwSr2bOfVlcH+XsNo5dpeHgKJSOn8MpthyE7dCeARw/JKOjy50lzA5yJ+Dyl11LxMI7NGt46vnqPbLEYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91xDH6SZgdVLYax+m7wZ0oqPZSNNZm8sOmhgPUpiEuk=;
 b=ntAU1op/dCfh6PX3oPuNZ05N82ZHcoWNed1YwORnqkkVaxb3LiUGsVXfpgx0Ou4twMPnlU1iQGhtriocSa1iBwHkIljZGkWXYnSh5DPPS4QK26cG5Jg7YB2zSLzcXvQVEDzy/xpLSQ9ZP0my6VhI3DTid+TcduD/1e59F8+menA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB3865.namprd04.prod.outlook.com (2603:10b6:5:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 12:43:20 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 12:43:20 +0000
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
Subject: [PATCH v7 1/4] RISC-V: Add mechanism to provide custom IPI operations
Date:   Mon, 17 Aug 2020 18:12:48 +0530
Message-Id: <20200817124251.508183-2-anup.patel@wdc.com>
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
Received: from wdc.com (103.15.59.21) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 12:43:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.59.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ba2e782-09f3-42fe-6aa3-08d842ab1ef8
X-MS-TrafficTypeDiagnostic: DM6PR04MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB386559C61E58464E68723C0E8D5F0@DM6PR04MB3865.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c8+ooadgBUPvOi7MQ2ehVdGrBlufjM/UyTf8RmV+Mwq0QC7E4CaCrcfTNhUht4UXnhhK5B2JL0BQyTfpY0+gSxLaaeDtV9ke4lpaNgrMhOgFLc0PklFY9ruR1hWacgXvie8kgw9nUuV0MceDLhCc+tDm68DWJzBQzzfgP5KQbAjCjKN82BmSqgrV0GNVMvudbyRuyOthybwB6rV/hMwNe4x1rN5Lv5JV0fQ7rKHl5g60AAdzni3nTXIsljtfZGXGbi7FTgE+AUtux/4fki7xWx+AIIMk61XhTZYegCjAHvUp5vAu5lonUu/c+A4L14pHufNuGl5x0JiiUS1HI2RJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(36756003)(7416002)(52116002)(6666004)(66946007)(55016002)(2906002)(54906003)(83380400001)(110136005)(5660300002)(478600001)(7696005)(66556008)(66476007)(1076003)(4326008)(8886007)(186003)(16526019)(44832011)(8676002)(956004)(26005)(8936002)(86362001)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: B0WvIUF9iJ8Yy9kUb3p9u4qY1s2qiqwmX5Y7rU38vnAy8C3bsmbz22SLRACtq4fu7nHJLq4gYmMe5ZtfPRirEbyknDzJ/f550+9rTdMGApVBXDGXsMwHAIrmyTEZN0LDHkhOSIVc4wd1PlyjPApcfoImES+IR44zbXHrKBD1dVYbg1dAfkMRHjIGyBFVb57QiqdXerBEdZjXtq8OBf994YdnJE6PMYAkcTXeOM0Dp72voJ+W6KIygTDvX/GxJul4HJiJ3m9rV3Dks30cEItK5ZZVjb2aS8mTU4up4rbhWXaTCD3xbHsOgEMmm8qsgYW9iRxj+hmwMmxZF/IiUZRPTl7jKF1nX5jtd8QvV4py05kL/a7vyQQ+HzeW0PdX7kgWnZ/wbSEdf+NzWyXMFb2fJ7kFExJvhMl019b3dGNj32bmeyL04xNjzVUJOP+pffq0ssnf5wQQ87fA/6iceIHjjKXAg0rcrSV/m4fKEP6Wo5ZNJTjZioP8aq++T5b1r5QK62y9TJmNExnjAXbX+qhYMfv5tH8ZqLP2pPVliO0DNWATbJ288FJlzf6kKo8x2k0JsOZhfXyX3wKtF3kh7hYGil/tkDKT7gEELMbDPWO9N66Ye/XoAeuG0QdaDMVKhqdXGzS8aKuf8DLFlFCypHOkFw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba2e782-09f3-42fe-6aa3-08d842ab1ef8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 12:43:20.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Deq/CfFbe2dV2Ejum8GY/cThvnPB44uiswAi98e5IrhIDkLuq2IgAO9R+1DOMIUE6vRzQ6rxAOu49rSYliz8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
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
index 6dfd2a1446d5..df1f7c4cd433 100644
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
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
 
@@ -81,6 +92,14 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
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
index 554b0fb47060..cf9acb43604c 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -86,9 +86,25 @@ static void ipi_stop(void)
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
@@ -96,33 +112,22 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
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
 
 #ifdef CONFIG_IRQ_WORK
@@ -140,7 +145,7 @@ void handle_IPI(struct pt_regs *regs)
 
 	irq_enter();
 
-	clear_ipi();
+	riscv_clear_ipi();
 
 	while (true) {
 		unsigned long ops;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 356825a57551..12033d71ba0c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -147,8 +147,7 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
-	if (!IS_ENABLED(CONFIG_RISCV_SBI))
-		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
+	riscv_clear_ipi();
 
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
-- 
2.25.1

