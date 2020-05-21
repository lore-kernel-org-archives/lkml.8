Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54611C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354F72072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aIGyKxxt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S94dDfV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEUNqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62798 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgEUNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068782; x=1621604782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FnsdyhVeqo92V2RIXNUZaMxHd1s0zWpgfOvl9sEpfso=;
  b=aIGyKxxtF37E995OMOmiNGXzZA4JcR32OX3YgGk2cqKzMthbb8nsvdIq
   qLSMEsvFQhPoZF5ZEsuI3EV9Gz4hyEM/sC3yTyyGKNy3/ePLFIDcer3KN
   H4AVdWOScPDQv7i/gygOW99qAG9MkYl7WT/CIxMLTcRIttuxApTTsAYvA
   Tm+ASWzMhdlZqNO/Usp6Plt5qX6DQoFVWuzlHtWqmK5UystJ2XwEDkNjx
   Hqvfhe8SQMNH57Ejz9pC12XV+6woSr4CeKbbWMtqr1abta6ZDwQldfjEF
   Q3VFZVY4kQiT9/ocZljO2hGMy+IhQZESZ4bSKMK+1yamBFiF2RrOoFM41
   g==;
IronPort-SDR: Z66Y+j5R0mG1Mksvodkm4y8LHtMcOCfDFYTlJk5f21DTTRMbkDZcrHt6SXysDTzMDO5HtWGWJH
 gh6E8Thvph2xat3tb+7QmCoLUxSek3r8ZOqrrdARo70A+5skXR1tTnIsgEHnHOOl51kRhUQlX9
 TtY4HKDjOY8bRAyu69iL6x2GLsOFVVZuznjHxqwicUxeCzz/XWTcavxXpcjM491530N5zLLJMc
 9WS4Ppdif+GWiAF/x6dzgukd3tFPu3sDPiiACfwT9dSDbb4fMll01sk1I2YE8oKpm2Koh1qQf9
 4zo=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="247223283"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:46:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIOjt8aBeVDlzPZaoCWoK1/d0CGNxFURSmSX3Fzu8p1NtmcSHa3yaKPyj2cslqbDrSqgxeC0X1LCAaPQnYUERUuGpuV5oFVRxKh9rBdasHrLk12bYXTuXQ19vA8DFvwRZwqO45bCkpR4yXxppAolTqRH3zMTWMr/MwOKKNGYDchbD2s8sI7QdU0bzeIWk99tEVzpuVeC0iVSqgkJhuy7VEU46jnd3RFSHBP/PqHVmVrVxnspslkatpZenI+gtxEAIcq8lnQOt3FvTxfOLajMSgMv2pkmRj8tW7QUjy+/yhZep4IVD3bFeAuDfOJ0j4z9wjPyyO0wOuaRIqs4yjvzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULOMQmn866GxUYZk+/86KshV0TBAMHGXSlBD0GOLKg=;
 b=FhZ8tiY83c/JoYBPaauI3uEvKrnDTdjdNAxtvc8w0N5xvYo9fOE0l3j780JKrWFsl2x6QGXdzbDtCuTb8RWPni9Epu8qS5epoFYenIGUcnmw4f8r5S4M3wTb2dz35ek/WnwpwdbG0sIR0vVfpede2Qprl/Io6NHKX7wwjcrGMdV7UgoWlQoVqVqPlP6JzgUkCSw116cetkZWdJ+ByIgsz631Kjjzm4lv0tC5fYX4bUoqZzRjBQ1Bvb4wtZt4DrzHmhJJCvs+sl8Bm4TlrzZWYAZNYoTJ5fBGzOTTUDKXXBKWaIJWiHFJCJYo/+z3bV5Ydz0l4TKj6TwP3/Io32+SvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULOMQmn866GxUYZk+/86KshV0TBAMHGXSlBD0GOLKg=;
 b=S94dDfV39R1YDks1LAEfkrDfEiVr1kKgiAc88P7H2DHcysUmPqqlJJi1uXNZdiF38ccDc1fwp41ZnnPrO40EsaIyFBvDx8ubCSYgePe83JJ+fCRpcwFaJpXOHv5fba8RFnykzhF/yA0ZI6uUnx8HUa1W9aB4nzh7/u/P+iXX9p8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4985.namprd04.prod.outlook.com (2603:10b6:5:fe::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 21 May
 2020 13:46:20 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:46:20 +0000
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
Subject: [PATCH 1/5] RISC-V: Add mechanism to provide custom IPI operations
Date:   Thu, 21 May 2020 19:15:40 +0530
Message-Id: <20200521134544.816918-2-anup.patel@wdc.com>
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
Received: from wdc.com (106.51.30.72) by MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:46:14 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9eeaa869-3566-47e8-768e-08d7fd8d57ad
X-MS-TrafficTypeDiagnostic: DM6PR04MB4985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4985642D9FC4C4156FD9BFF88DB70@DM6PR04MB4985.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJdPbTWkiE1NhnK1TlJQWlr+4fiLOxVLnyDnfUPm/rAEBLaOVV2Wdt4nz+2/8SkbFrM5z1GMZZRqu3lpHDA/dP+dJeYMEoOQNKCwLeo3Vi/W3nk4hUaDMZD7J57nkCNATwO8KkUxVutbSIQZQLT4mLou4w29z7WVHqvnb+2hPrmTWUvrFllCTwXx56+ry1NEI9a7XFNpux4cnEFgyOe7KhyQsOqcE4F2qvn77Ht0dReg0QHF6m5FXe7k7WS12zmdy+i2A5cn39ZP/U0J2svSEa+7dD0ywLMcnyumyZTJ8tntuVMhEMbPkvpOUQ5yJCTKQq/82n9l03Q+Z8/JgJACjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(55016002)(1076003)(1006002)(7416002)(6666004)(7696005)(2906002)(86362001)(55236004)(8886007)(52116002)(4326008)(16526019)(186003)(8936002)(66556008)(66476007)(66946007)(2616005)(956004)(44832011)(36756003)(110136005)(54906003)(478600001)(5660300002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6ZICduAB0aU5bESF26lkycb/5eF3WFBvqw/kBaFFUZjnhzdhYssh6SCuxdGSs0quv0yyU0AiddBTLd+J/m4T9Kw2o0NvBXy2ZFoMMG6FKigvk+L9Q6YIuYRV0zXJu7VGqROAuBiJbQJV5nSWSusTlcCfjmIZuNMbCsJ84YjRH8PgsXfTBhns7bJNdo7YeETSLnykMp/e8CpZPijdXf6NUczXRDDGU+JgZIuOuE7EecjbzfSMrTdMwqgnoSYibylPrTUFPgaVB86roTGYwh1ZXxduob9XrEAGmwWXdp1PPyE8GRC9yu0EoWATyyP2EMA8ARnQ7rHYsxe24/HsnLcQMosz7JGDAAQmUmKrNqpBeQgULrAngUsnzD2/dWcR5PJx72Gpsp7lReicSXXtq4otrSfbPvU7IaJQ8PDLkIyiqaiV2wIVW5u8pNWwYq5dcS6+tk15OKsMN25ZMk8O94oeTfSXPypeL+YAnx4CvJ9W2hs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeaa869-3566-47e8-768e-08d7fd8d57ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:46:20.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhbgmWAAJw1axPfIlrO5WGg7ECIZA4c9e26Yc4KFMS/LbWF902u4v2Cs0skcPxZYXajAJVqaOODWt+nHO7ZGDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h | 11 ++++++++
 arch/riscv/kernel/smp.c      | 52 ++++++++++++++++++++++++------------
 arch/riscv/kernel/smpboot.c  |  3 +--
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 40bb1c15a731..ad0601260cb1 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -40,6 +40,17 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+struct riscv_ipi_ops {
+	void (*ipi_inject)(const unsigned long *hart_mask);
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
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b1d4f452f843..8375cc5970f6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -84,6 +84,35 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+static void clear_ipi(void)
+{
+	csr_clear(CSR_IP, IE_SIE);
+}
+
+static struct riscv_ipi_ops sbi_ipi_ops = {
+	.ipi_inject = sbi_send_ipi,
+	.ipi_clear = clear_ipi,
+};
+
+static struct riscv_ipi_ops *ipi_ops = &sbi_ipi_ops;
+#else
+static struct riscv_ipi_ops *ipi_ops;
+#endif
+
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
+{
+	ipi_ops = ops;
+}
+EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
+
+void riscv_clear_ipi(void)
+{
+	if (ipi_ops)
+		ipi_ops->ipi_clear();
+}
+EXPORT_SYMBOL_GPL(riscv_clear_ipi);
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
 	struct cpumask hartid_mask;
@@ -95,10 +124,9 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 	smp_mb__after_atomic();
 
 	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_send_ipi(cpumask_bits(&hartid_mask));
-	else
-		clint_send_ipi_mask(mask);
+
+	if (ipi_ops)
+		ipi_ops->ipi_inject(cpumask_bits(&hartid_mask));
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
@@ -109,18 +137,8 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
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
-	else
-		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
+	if (ipi_ops)
+		ipi_ops->ipi_inject(cpumask_bits(cpumask_of(hartid)));
 }
 
 void handle_IPI(struct pt_regs *regs)
@@ -131,7 +149,7 @@ void handle_IPI(struct pt_regs *regs)
 
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

