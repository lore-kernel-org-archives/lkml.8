Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6903C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7346020663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WhL4ghuM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BeZd4JXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgGOHPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:15:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34248 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594797340; x=1626333340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h1jdQyc0qpyfOWfjsceeRqeIzz3oZ9kZbI7mLIKW7WM=;
  b=WhL4ghuM4e7ZLM7ctASgvZBnUOaERvUinXpdPQlkBdT3BdttrbG8ZyMT
   jlfqS6hfPPpyZSiT/VMDprFx8ZgTHVGniHlF84l6SY+v2QVfxoEX2Sj6N
   CXtv6Kobi5OA3ycwUDQ9zE5dtLJAbeYOtTOtqP22QxP9J8hWtu6EjaQxr
   TyCeYGWzGp6dUVPYtoCUF/H4NnFef8w4o22IH+W94cUvRYm5JWr4gita4
   XL6nuXVBhgxMcLz7VEq2WZYGKvRpVAVDUPsuyoDHJ517hF+0uPztaOEYB
   d0LEDBsPhOXpIJyqeEdfVyl8oflPyxHHl1dajRxIkTz7PqAAVkRO6UUDr
   Q==;
IronPort-SDR: vNBj/73jAzDD3SJmDXc7zF3y3C+G+ggk35ooklbvKZ3xNPyRp8/jRDTbzJGlvzCTOvt3eSRgS6
 XHIWPstkEoZ9mJn0qdeGav2Do2ctufE/Fu9LSnK5sQOwWt1cHUrV0GNZH2aibS+9Vpvkms8xGx
 x75YMokKm1mgnHRlONM10TMCh+FYgaPgho+mQEyiNLo0T7ZCboOext4lCUtct3PXp19Vj7fdEk
 1ux31a+Z/Bwhq/K2HnYltlyBQHhRuQbVWzm5KkCS6Q6aHlE8gtPpNx+nxXWS8EcZq/6gKOr8Cw
 Pk4=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; 
   d="scan'208";a="142495407"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 15:15:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9vt5miafQfSgAlyb1dKMc/jnWEkJ2GM1ztKi9PrXl4DDLY4DNHWENrcuBMmLyMaCKk4glszgQg14V9c2+Y1tLcoSOH4CEWCMVp4GMSDlx+1u6twE8mQdIagZPxBHO5+UCTqSEZu4DJExJWhKqYEYqWTG9eG1u1qRaW7R8JohzRSKUj1mRU2udjqcRNQqyQwhwh9k9fpEUMIZaz6RvXeJIYmdPoQEU04EMEG67c/PWhsWfYAzHfk33I6evJkNda+Q8Yq7SYy8/fj9jIx+kblQ9VFk72cBbmEyrbfszdyHIih4LcGEz+VP/ZA5W5M10cZ3UHaA4kifzrTMkOfabwGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjK6OaReuE8m9Nlpcy7spMgxdJ10Zx7GGh4+Bv9YArI=;
 b=e51D8Q3kvOzFMDDinZl5q8Oh1ZYKTRYyfkS7LRjE8nJihULmHEGMhZV5FyW06j1jHJ7G5EpwyYovGfSJfmH1OWYHAJii3bdko8TsmJ+yEKDRdEBj+p4Nwc4QmAGLvLsK1WIjs2yMY+p+AYa1G3Pi9mzjyGgWWhgkJozyfnl9uAa1tollKy7T1Shybr833vrtyAvrkUlUhIgtJi3qy3BVQRElx4zQEdm+i4AiQyibC5o5yTBBLw9xd0hp0mYvyAOToZLLdA++cNPfCkHIXZb8Wrkx0OC6YSu6QaZ3034PIF40DDPc5A3zoDxVcAD9ukTjB/9BMOOlkYLuf7l4dQZzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjK6OaReuE8m9Nlpcy7spMgxdJ10Zx7GGh4+Bv9YArI=;
 b=BeZd4JXJ96Cmj0Cm7dZ4UFC56YcnlK8YWdbVZn8BEyIqxW8GSfHDWLJc26rWn6x8c7lJyc8+ndEMEwwQwwkgX4LvaAeFbSHnqteTsieI4l8I9mBQWPY6sJq8/pbFvs4+DXEuOYXkg/BH9+sfTKvsDKq1ZmXtd0QQE82dF6hLiNQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4329.namprd04.prod.outlook.com (2603:10b6:5:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 07:15:39 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:15:39 +0000
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
Subject: [PATCH v3 1/4] RISC-V: Add mechanism to provide custom IPI operations
Date:   Wed, 15 Jul 2020 12:45:02 +0530
Message-Id: <20200715071506.10994-2-anup.patel@wdc.com>
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
Received: from wdc.com (103.15.57.135) by PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 07:15:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.57.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6c26822-57d8-4490-a96d-08d8288ee05a
X-MS-TrafficTypeDiagnostic: DM6PR04MB4329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB43291AA246D0FFC80A8798478D7E0@DM6PR04MB4329.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwGBBR6yv/a+rlk8t25Jn2HuLwBqf2wctOJcqfuzvwuXiizjvwxz6lapswrOaremLjF+vZ3V9jTGm1Iu8K+8bu5ik+X0ArByeE7wSPpGOlC8Scs9xUk2YcIzBytV23Tl8ChH1TxLV8lHqJ6YLhWhST+4cPFIwXw4zfcqw4kmIsatOaEzn01za+UPmKPqmg/anG+ANrrWoAb7d670DI8JapwE+xrBaL0+6pk11bH4eJUCJ7Ij9XoEcpUNqf/gIUxKUfV7AQRUL69efgt0skSDxbRIMGLaK1Vvu8o9yRN5cNljR3eKmuc7x4yJoNVSGgpVIvUz6nF+8tWySrV7ac5hoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(8936002)(16526019)(8886007)(186003)(44832011)(36756003)(7696005)(478600001)(26005)(66476007)(7416002)(66556008)(66946007)(54906003)(110136005)(52116002)(2616005)(316002)(956004)(6666004)(2906002)(86362001)(55016002)(1076003)(8676002)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: U4cYh6UEP0Dlo1M1Ije2xhKpb2GZTCPwnBLY5Xq7WB4ODnvo6Nz9F+VgIXFySlP+W0dN5/ZooYxH6YGSuvqTB6OkFucc+6QTf3CKfQ5TpmguG63Uv3TWVdVMZgoBfXdt1MmgCbE+29drik56qSq2K4SFqjaIVq7L+UJ/a6FFGNMa2GxL3r76ViO/eA3qOsgjuH3uMvLg9+aoLYoU4HyKB7sPUSjf7JoElmINIL7X9kt/4QRO/wQOOjFjCNncVULlv6SWa+4uAkjUqUgh6ecw7HZcYc+MjPOdy8mlwBsfu8TQ0zktLucGR62BP3jKWIa0exBIAW/GZwpuoet/3GhCU/nHJ1S8D8O02UVDMgEMZmtOA634AZYeNhvRQKfYaFxSsmvmNT3gq5d1nhZU+8KqbL9IVwnpp1MLT5azQ0qtnEatSxTTelVbRzVI2RxdfjwC3e2Ci99kajkyK3wM44vtqRrpNTFKgo97rSOm+3ul17Y=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c26822-57d8-4490-a96d-08d8288ee05a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 07:15:39.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spt6++0DKLURSB8LhCrC3DAPlhWfkGU0uYb13QAHe+ifyFBtn0fv0m3HiEqKnJJws7mL10VAm5R9l7iT9lZRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add mechanism to set custom IPI operations so that CLINT driver
from drivers directory can provide custom IPI operations.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h | 19 ++++++++++++++++
 arch/riscv/kernel/sbi.c      | 14 ++++++++++++
 arch/riscv/kernel/smp.c      | 43 ++++++++++++++++++++----------------
 arch/riscv/kernel/smpboot.c  |  3 +--
 4 files changed, 58 insertions(+), 21 deletions(-)

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

