Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B69C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD22820720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J6RRzdAW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZOlZ8mAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgF0QUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:20:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19189 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgF0QUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593274849; x=1624810849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VfdsVYIuzBq+Zk7kLmGAbs7adiXXCL7v+wVUU0txo3k=;
  b=J6RRzdAWtrsFIqE2Ye/S1qSJjNMjKHV4E7w4oFVi6LyWyRJHZ0BKJbR5
   kQA15DbLSOym94fXXuHsLRDQuCvT/rJynmb0BmmC+Sk0kRZskXXQi83eQ
   0B6Kc4iY7nmx+G8i90wvHn58x8Jn/iKp9o+3mGurdnpWbKv8hG3mQGJ1q
   /R3Ny4iH+QMXsZseAbEEJCf8PStXeFvIwrHW5gU/HJgVMmP2rOqr8q5Ov
   eKqtrwmjSPO3PtqieA4ALktDXl8bTWjo76EcSaGHrIg7oVww+oHG8P6bB
   kUhLF0QG8cMkorr8YqvSLw+VQearlVSDvXX1N77XtNb1Hv+MdW66h9nPJ
   g==;
IronPort-SDR: rwE626qmoZCuYXM1Fh1PPb2GfOAA8A7VkvzI8kyAZFfcCrBKs8q7dc1mNeMfwvXO6f+ZIXZebq
 KoTf4ypckCmp2eQRxbwE+KP+0PRxG0/G+ChHm1OWmw1jQpttJvEU+N+x0u5f+WU43+OHdDZZ/S
 IAzo9SH/vN0vAZZEIXryYu/dVI42JUy5sAAC9gg6RR/JKkYnwHjDp7yBiKWkLvU090kmcLDdjz
 bY8H0jlMH4htSU8L1YGK9Ff+znNRa/NBZKb/VeP5e214Sn7pkMNCxS1xgQh/rLUfEicjnNaeH7
 OIk=
X-IronPort-AV: E=Sophos;i="5.75,287,1589212800"; 
   d="scan'208";a="145398677"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2020 00:20:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG6lF/dRf4esCp6ZB7cwkyNix3k9EwJq2DIG/YddnQ6uMVQViWFPP07bOrVcdVk1EQofSf3Fqy/L18U3u7vLsuV0AL5v9HcRAryqrMIlUIttkXhZhr/BJ2Ob/rBgS+PyYtfq0lt+CTWivDpB97E8AJEXBqdujk0OCFE8cunanIeZSRC4YirUBqpY6Ey6Rc0UpIlrf3mFOeyHgcJMoYkQk3UAMOkHEhldOsf0Zpl/9CEkYAUB1+F681wy/QjGtqauor++NH6KQGnAd806eXHVDGv2IyFds1Vh3hcGTjvPmBFoOtv4BSaJQ1PeB0wmrurtJK0s21R3P+MTN1h1/fGNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU1D/UR4nJNf6YZpTAtLGc0nVWBetCC2pRQE5dJkNyA=;
 b=mpeXskAbEoCXT1nxgdvWrfM2BjHoRSv+oQ1eKlHi3f8SYEQfpj7++ip5DQoHzyOJriul6x+QZLtyAZ0fpLfZEmal1eq+GmADL7xVpsL7m7JU2r6rbyC6+LNibFNFyFo32FkDzHk/pT0rhhFZkYqAdp1j1XBFaRaaKdsIuAI8R20gbqKHNaYzSAJiPUrD+G7+hId9rBaIda5dQBapj6+3ro73DMBStWIEv4wJ9VHsvurAG1Mv/LswPdlAMuGUIGYYgkAkSB/aweR1qqa+o4UHoIGHN+8GB/NaqoOSosiDMeH2nhNlvOk8x6S4Y31fI1BUcC35WLaNBBCw4yztleOukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU1D/UR4nJNf6YZpTAtLGc0nVWBetCC2pRQE5dJkNyA=;
 b=ZOlZ8mASsyHe3cO2MFWJg2M/0PPkPbkqnX9d9B5DCc+iyqERpbsq8lh8ppS/Immpwkr02lTplMAQkKok3opjU6989SNADuEDPFFKQq07LOhidhBb4RHxMHllFh9vUQJE0+Z6CwwkYcWjQgcMXZF0WlyHKdgodmf7GF5iiLOcH28=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32)
 by MN2PR04MB5599.namprd04.prod.outlook.com (2603:10b6:208:fe::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Sat, 27 Jun
 2020 16:20:47 +0000
Received: from MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580]) by MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580%7]) with mapi id 15.20.3131.026; Sat, 27 Jun 2020
 16:20:47 +0000
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
Subject: [PATCH v2 1/5] RISC-V: Add mechanism to provide custom IPI operations
Date:   Sat, 27 Jun 2020 21:49:53 +0530
Message-Id: <20200627161957.134376-2-anup.patel@wdc.com>
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
Received: from wdc.com (42.109.128.251) by MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Sat, 27 Jun 2020 16:20:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [42.109.128.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfe2680b-c558-4188-42b6-08d81ab60c3d
X-MS-TrafficTypeDiagnostic: MN2PR04MB5599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB559923810B3C31D742645B1D8D900@MN2PR04MB5599.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0447DB1C71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1zyUTjnj+CyQojkDNZ19GSZeRK1y/LBr1msuVr5zL4V2ciyVxB9foRA2N4x0Wof5ZagEGP9D8/1RwrNlJ2RZ54N69pQTai5SzrVHR6dCaE/xg19cybmH701I+BC9mPd6wjbbYqpqhg/T+RBr6XId2JZ5uTljLoDlY9RP/7GyfFS5DToZgpuOtH8d0bb0buAWlRDuO9SGZvgehiu/A64k6clfEEGraL0sOYbcIsm+GvgAuKYUZ9A9MF/ZIEYbZPY+ylerRS8NBxlhuYvmowRfNKaGGBun3aVr7s7FA2GRjaxmxq23LrYJdv2HZx44oQeOAJrZA+EIuxMirur295WRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6207.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(5660300002)(8936002)(86362001)(186003)(16526019)(7416002)(1076003)(8676002)(956004)(2616005)(8886007)(110136005)(36756003)(54906003)(83380400001)(26005)(55016002)(316002)(44832011)(66946007)(52116002)(1006002)(478600001)(2906002)(7696005)(66556008)(6666004)(66476007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bxS8QswaBlw+aoRioS/WiPILQ1ghR3Y0qy58PE5sompHnq0EeZtfybi6wWBRQX6r6rAZfmcKfn7j+t5ZRhFUOjEeR9ALeKUh8L3tVYzHvEZPF0Kygxo4bMH8V16dmN3Rorl/A5FVXHTuzzoeSGip7JjB/cByXUVh7TIuvFkOtffV1JJHKafPKBmUT6OIa4CzOIkFbBufV/1MT3r+QO4GRwDxnArOw4nSUJcvnce4VTIJ/XbKy1rnTcYoOH28hdXxsS7jFpx+IPMFl6CujPBGirTPVsKodRoWYKuPM0ECNtnD5PekbKnXuRqVRKVNScNU2hfKk4siWsUHV3AVip2mcCqh1cIjSsbRl2DQKx42VrdRHanWyiBUToyoplVC0MyfBt+YMf+nLmGxo+g/I8jo2/A3qYKiHPPdwPBBMRnwp0KC7uq1XfPh8M75x+7E84psMlWvVYIeMrzFzvRbbW8YxBowRbdYvlj8CqgDsNBueoHTbMwZq+kiyGOQ9fSCeUhT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe2680b-c558-4188-42b6-08d81ab60c3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6207.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2020 16:20:47.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlQ8W6ksLG3Jp7byXtLF04gX3uNKE2FegYYYAU5H9u0+SvUV8FrSPAlgGCm+YrdfgLkmtuL7QPFlUDtgjEeftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h | 11 +++++++++
 arch/riscv/kernel/sbi.c      | 14 ++++++++++++
 arch/riscv/kernel/smp.c      | 43 ++++++++++++++++++++----------------
 arch/riscv/kernel/smpboot.c  |  3 +--
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 40bb1c15a731..c6acd44767c1 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -40,6 +40,17 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+struct riscv_ipi_ops {
+	void (*ipi_inject)(const struct cpumask *target);
+	void (*ipi_clear)(void);
+};
+
+/* Set custom IPI operations */
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
+
+/* Clear IPI for current CPU */
+void riscv_clear_ipi(void);
+
 /*
  * Obtains the hart ID of the currently executing task.  This relies on
  * THREAD_INFO_IN_TASK, but we define that unconditionally.
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

