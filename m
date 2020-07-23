Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D0C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEAB20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ulmnau0D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="idGVOOCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgGWOYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:24:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36978 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595514286; x=1627050286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6T/7hY07o22Q0syrS8BdMcfzg9rtHPy9RCJAhrJx1/k=;
  b=Ulmnau0DMEp9emEQoU4uwhbrrrTfAX72qOZZJMuspAp7vn3auZUB9sh7
   Hp9t3dvzkFY9zNa/i4hpGwGLtno79yVBQwpMF5CjxSs5Y4OBe8PJ8rJJx
   zVYEfKbRaljsHwHHJ3t63hWx7WPACESQ/iK4+Gar6n+47ycb2whcxT9gA
   8+/TxIY7nrHjQv3TDfW5snZuAxz7Uw0kLfLGnvgLtI+LrxyCubhEkT0/s
   VVk+UMYGgEysS4EwQgoQqHivWrxElh3OTiUolKe/JmCRMVrv2UOYiedph
   oAdflk4woXkABiRDf+XkjebHhMHnFmBuW7zG9jz/g4YPe9Aws5ogpQBPF
   A==;
IronPort-SDR: YBoVCFSsgx/guyd7zeppUvW0lJBL7r5mHWsavAk6V43JHv9VNdWF26pbkI7nU+96UgDGKxYLtc
 +KTx/loVnUXovlxaymmKBnhdJAQvdOJaSY1ko6LJqTsEJ2vMNioSfPRfZ+nMxvbkZb4jN2kh/b
 Qop8A2rVaz6GsxE3awNHAf3fToqq/LUETPqfNmqGZFWL+/F7y5W2ve5EIv2OpEyYZXrthxTrcb
 xw6ID66EKvFLFb/n/Rr9TayaXDn7TOCq1URqQVkhHFfnaayLy63S+f9250TCqNoYZGblg2WhwO
 8rA=
X-IronPort-AV: E=Sophos;i="5.75,386,1589212800"; 
   d="scan'208";a="143302660"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 22:24:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdvQHtqCpHQvpasOcQNLLMD/lLVRvxOWziEn/Kh8R0tL0yQlL3a9aoURl/c4+m8orecq+CSmbgcIfPfTWUhBoIkU8YRLXS+Xl+jUa0fnpVsSXYP+faqowNGxIXHP9vwC2/HHcXsKHmCJ3PA7FBabIXgyITWoFZs2Y3CiJ2BeSAYooFZZgblsY024kitBroUNAUXraDYsAjVzlf/qruaZLCUC/Urs5oq+c62wlKWY0CIpGdhU7Fo9k8SkyEhHWLnBN5k2qGKGvmi7tRYQbgArC4OqQxdVPiBAUPDMBnFy3nichaR+WV7Kt85OIbc/8DEwYC8DvEoseGVjuc+on/b2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmXMm/nYWer0/e9YTk9xwJKxvcgW8xzlVA2YtFotjDk=;
 b=iFjF6x6WsXFC5bCSFJaYZx4pXWnlhFUgPzpBOBYxVg0AkP5D90eHury4fgZE53RCGsDQu33L6b2YDRW5dN/WbV6hjRCZFqhMrGAAxOyoAAF4jWH3L13oytBxxBQRdRDl4olNgohFNtVMlAzJ/QGWVj1txFZ2FF9WcuuwuDETgpOjjTDMAfgVlal7pd40Ecu6mtg2ZH8LWa2JRV0OLPiIYRnvb4bdb+Jad3fgs3a9KWwlkscU3rCIsnvkKhbugCQcTh+fybCLIx5QQei1cVX/D2snT3ErjRUvWsXxvhBX7sxuszyxvsP+fPBqW3o66lY0OnD7dsMequLFblU2axummA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmXMm/nYWer0/e9YTk9xwJKxvcgW8xzlVA2YtFotjDk=;
 b=idGVOOCgZA5FdUharrJiESLc34DDWO8qGIEKQogsV+aQnMN5lOwm7EAt5PIOZSoc1ibSeRuULtXkBXhxFhwMFTeUZFBwUuoV/dqEp0WpZvPhOSiEFHFHLXjtgZOP/q549jVQVS4vFQW6ITol4yOB21cJo7xyLy6Xm7RCADfrybI=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6682.namprd04.prod.outlook.com (2603:10b6:5:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 14:24:43 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 14:24:43 +0000
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
Subject: [PATCH v5 1/4] RISC-V: Add mechanism to provide custom IPI operations
Date:   Thu, 23 Jul 2020 19:54:06 +0530
Message-Id: <20200723142409.47057-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723142409.47057-1-anup.patel@wdc.com>
References: <20200723142409.47057-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.183.159) by BMXPR01CA0068.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Thu, 23 Jul 2020 14:24:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.183.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd44ca07-656c-44d4-d4ba-08d82f1424b1
X-MS-TrafficTypeDiagnostic: DM6PR04MB6682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB66829D01902CB2BBB199F46D8D760@DM6PR04MB6682.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pTpEbpJQHLOSsVMfyH1IAixTPrmexsoYeC8Wyq1Jh8PIBv4EQtExuhf8MfxQWvCCWK2rog3ivtEeyc1itlFr6PFywWG4HIWw6VRcaeT2zUYeBlXUTgmWI8UXLhQFrF53WBp+xdEBxsM0DrHdce2vBdoVt18d357M1I+FyhdLcc7Pd0uPtdUzRFQm0nXxtHYyfCD6lEyfcb9qnQHOaTxg+5fGepioQ+1m0svkV8psNMtdPMeXmc3Lhc7Ff0nKKoywAyddJqFefW0+PxD2RdHsJ/4vBSPweYiNDZz2XPUvKRgp8K7bZcprejjcO2V4fzBX6GLFijiI9w/dJjk5DyuCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(4326008)(5660300002)(36756003)(478600001)(7416002)(83380400001)(44832011)(55016002)(956004)(2616005)(2906002)(316002)(16526019)(8886007)(6666004)(52116002)(7696005)(66556008)(66946007)(66476007)(26005)(8676002)(54906003)(86362001)(186003)(8936002)(1076003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8YUlIsOINZOmfB+KnGda4TusOlKCpm34KcEqDp8LKOmAJy9yM0xWCIG136oeFu8AMyA6oI+b+DOLp0OjmfgkkO/y20xAvmCEE4LNF5Kcu6Gc0NXfhBLDfHndbO38HMIot6lsqNfbSQ/+0KKfuHgrYK6xvwogODzckzUOtx6OzXMX3jNVnFrICSrT/ghHzJm6VCIP6Sh4ouSr4FLKiCQgaU0tHyTDkTQT92e9hGmbEeQzV3LprPORELiyUfVxGpFztqBv+WrpNp0XVSVJOs7CIlPXrdRoNpmXBNshMAz6HLLTb9Ro+Mqif8DJki9AdcoiU0+KiArJzlWYLMRqRBM7WbwB4KGWYP0fV198hLEsKkhgFW/1ILypeV8vuUFSgIj94pSi7ugX4Z48YGs4TfSDrRto3n7FZ+sOsrIZ9vPhmy2U+sa3a7TG9pBqHiJMIQnQ2umKtFly+bl/0Uk25+WTJNEi/iW+THPGFdXziNnlJdc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd44ca07-656c-44d4-d4ba-08d82f1424b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 14:24:43.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpoWumJwk16SYba7+l+gRrpXa/2UtnRlNYsOcII8EWNhvI5oM8/i3OtxBcs8T/JoCpvHNc46UvcZtyIlnQ2Yrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
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

