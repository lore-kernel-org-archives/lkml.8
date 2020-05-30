Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50BD3214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oglCsyv5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hQv9bLp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgE3KIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:08:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3426 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3KIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590833300; x=1622369300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SuGZr4GxtABjysO9g3tQV3Q6+ZZhHD1SDX0BveqqkFY=;
  b=oglCsyv58usao+/50WNgMKO7omraPXPa9WF7noJqkATHVNyHimiP0WTM
   Sbm2H+wL15arS78gsHDazq4sS4wtCMBj+qzV6GJzNtvfh/MaXkaEb6aUi
   I2ABKpTjY5kuDxlTrTkI2kGiv2fcnZiHoyFCnU+/E48L6Ey8IKXpuzyKb
   AH826q3zPS3FDiG504iwu5sZy69dxuHQ63KotwyfpYZAiYArY7LD15Qt/
   j1vVRcicA3wgEf2udYY3KX4U07z3yJKZ487xSB/mcme/pntxhv7m/+X8c
   RPuZX6w9InaD1GinTTUwgMj8F3RJpXM3jvtfSADJ/+5e/iZxndEh/8WcC
   Q==;
IronPort-SDR: MUTM3hjMH2dcCmEXGePSgWsrt3HK4HblpSH7y/VT8vmJ5ZqyWLm1OwqniCTvEuvrxt3LGsYa3m
 Up21mhWFzy0CNMP42E/vRCwk05F3ehjVrWDWq4gnL1nJgxRhr6PkLkRgPhLXYbwBHz0pN6TJIb
 SnVj+cP3nk1WUKBAPFpbT9ectMJuqxNowh2oI3rHqvUe7HRC6yPBeUWbyZX6UqCFXpEdsmJ1S7
 osRBApsiXQ3XZGjac9LVt4GnAru0jiTmN9TCB7xm6VYFuyipzu8iooOVnauKkqXjk7Zyo4sLXu
 1VI=
X-IronPort-AV: E=Sophos;i="5.73,451,1583164800"; 
   d="scan'208";a="138846365"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2020 18:08:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRAkrAZGPoW1WG9V7at1ZYNlonKikR9lWtcH63KPzbJojnsYmVOBVXAcnHYWF5oWVyh+IVTLSvURvmiV3u73r1IrjmUpfhrRPElYgj/Y34+RGyBEMmMiFC5HX66+R9Cdzmo66JgyxZe+S+fK0YOLFkxbC8rnlu3/twWImU5EKOUpuGfkDt2Z8eG0oEZ0tZO55/iV+mu9VJ6oqn1iumB0hgLCR6R6qtRUrj3E7qz5GZnBtisOFCZLup9BI2NxZmjjU5DeO0msZV0+NaJjhfgPWPX+1P2HHEhy01Q6/KhGagCn1cpJsu/r6MPK3VJ4rvNJ/p+ZkPq+w2oibZzhDiAnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=OYg/pv5Fz6k6GRxvUjLNBlyWNtbCVkpEw3kC9JlFO5acx/bq0V2Xxi0CJ/t0JaUVXcBazWHRt0YSTDTNoZJEJg2UNwqn5IHAadNTYXABh7zPloXGe3vGdur/1s1eflHb2LS6WD7UNbGRjMIk55lkpsRWnX1WEUaf5s30e892HlMV6WMjfAnIzyCsCZcJrrcucjUmUwYh+EB2KDm4mvOYAWPNTATrgRHlJdCCxA/VNulto+JJDwV/q309upf6ZA47R/d2F7F5C5T3DS+BMuE1KWmI6APp3YB/xz48Ccbrqs3IF4Md+/JIbfGHN3sY6gfrNTkN6Uo6pu0Q2us0iRUzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=hQv9bLp8X3VDvZ908e8cepEHy7uxBdHTayH7whFuo+TY4EYuPey7m44qBFz2ZgrOr1DNdeSYgc2ku1sxN7ubXUWJlaRkYyOaMuYXkd67loksGLFs8bBt5T4DEUpEpgUaFMce1x7zJogvHrCy2VXVnOBzOYE6KFcRmMyGHi8M3ac=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4314.namprd04.prod.outlook.com (2603:10b6:5:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 10:08:01 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 10:08:01 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v6 2/6] RISC-V: Rename and move plic_find_hart_id() to arch directory
Date:   Sat, 30 May 2020 15:37:21 +0530
Message-Id: <20200530100725.265481-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200530100725.265481-1-anup.patel@wdc.com>
References: <20200530100725.265481-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.131) by MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend Transport; Sat, 30 May 2020 10:07:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.61.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 129c80e4-1a17-4ad3-3fcc-08d8048155c3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4314F51B6E03351E2EBEB6558D8C0@DM6PR04MB4314.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041963B986
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVHdMmV083ylnRB0NQG9rGPKVdIgJG0NFyR34Hv48o6C7VZBqqSzNk6ARW5QrUsYaIZK3YbCCCAIKYCUqTWsWtvc1S40+YTJBJpTWpjmt1v5k9B3bvtRqa5499jhMt+tIPl32DX5WCZ4AmOyOd/VFsMbezwkKaXHVHVY/Sa8TMODoBzqGSNWRRIYKwPYUoZOYoAiBMlw++eCwA2o96UcSwOK8xvVQD8RBErqWOy7XLD973enDP+XXNPEkIV8zx5SZvqr4kP/mlKB0Z6gV6iAuB6ztJk86xms4MRboCBsYBzNCVP1SDSP1h9E99Yru+jz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(26005)(1006002)(186003)(1076003)(6666004)(55236004)(4326008)(956004)(8886007)(16526019)(5660300002)(2616005)(8676002)(8936002)(478600001)(36756003)(44832011)(2906002)(55016002)(7696005)(52116002)(7416002)(54906003)(110136005)(66476007)(66556008)(66946007)(86362001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2tVAvkMFr1XLvTJYNqVAsLLJPBqhsqTLq4NieKLgI4MkC3EMkFlxzoNnZr4OdBYEYqqV7YjGmHDSg95Hpyb5JmbKqOj9ht6Pw3haqEBFSLURVSy0W123piOsUxgVHiNr8Pxj756YH8dZdLdAIbEvNvXqPZNDIkNbWNlbtYYFuPAX5ywd2ZH8VzmdkVD/4C6kutSsjpWZxBalvJfUJXTKJcRfvokv9ovoYQl3XROueOK/SyaaRZXiztkxPJGbQXzdLkPtr5Oh2irLvPeGyEr+vQ/jPmjWOKdBlX0grc7Mu1PVkpGFMLz0muRjewWOZUPXS3DJ35ZPJ/tAZsDFrJFEBnETfKndDfH8tRwIGqH69+LJ6mUqiytv1Qo5S48seewd+YS2XHgGOK3Xq9tZzZDWisOuecNPolfYYGugFm/Dgm0WNMPre/zaZUTDm3KxGNxV5pwirgo3237K7bxtPDASI+nxh9JLmp6Ruo/aM3ubBGcRTFvENVY+tlOQOmeUa7yi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129c80e4-1a17-4ad3-3fcc-08d8048155c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2020 10:08:01.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adwlD5Uym8X3mRjOErIA9/xYJkrgQV0EqDhCbkIrpWZ6ds5ycra/MCzLLLfC93qW4BdqTxlJ6AgncpAUEozg1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plic_find_hart_id() can be useful to other interrupt controller
drivers (such as RISC-V local interrupt driver) so we rename this
function to riscv_of_parent_hartid() and place it in arch directory
along with riscv_of_processor_hartid().

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/processor.h |  1 +
 arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c  | 16 +---------------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3ddb798264f1..b1efd840003c 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -75,6 +75,7 @@ static inline void wait_for_interrupt(void)
 
 struct device_node;
 int riscv_of_processor_hartid(struct device_node *node);
+int riscv_of_parent_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 40a3c442ac5f..6d59e6906fdd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -44,6 +44,22 @@ int riscv_of_processor_hartid(struct device_node *node)
 	return hart;
 }
 
+/*
+ * Find hart ID of the CPU DT node under which given DT node falls.
+ *
+ * To achieve this, we walk up the DT tree until we find an active
+ * RISC-V core (HART) node and extract the cpuid from it.
+ */
+int riscv_of_parent_hartid(struct device_node *node)
+{
+	for (; node; node = node->parent) {
+		if (of_device_is_compatible(node, "riscv"))
+			return riscv_of_processor_hartid(node);
+	}
+
+	return -1;
+}
+
 #ifdef CONFIG_PROC_FS
 
 static void print_isa(struct seq_file *f, const char *isa)
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d9c53f85a68e..16d31d114c30 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -240,20 +240,6 @@ static void plic_handle_irq(struct pt_regs *regs)
 	csr_set(CSR_IE, IE_EIE);
 }
 
-/*
- * Walk up the DT tree until we find an active RISC-V core (HART) node and
- * extract the cpuid from it.
- */
-static int plic_find_hart_id(struct device_node *node)
-{
-	for (; node; node = node->parent) {
-		if (of_device_is_compatible(node, "riscv"))
-			return riscv_of_processor_hartid(node);
-	}
-
-	return -1;
-}
-
 static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
 {
 	/* priority must be > threshold to trigger an interrupt */
@@ -330,7 +316,7 @@ static int __init plic_init(struct device_node *node,
 		if (parent.args[0] != RV_IRQ_EXT)
 			continue;
 
-		hartid = plic_find_hart_id(parent.np);
+		hartid = riscv_of_parent_hartid(parent.np);
 		if (hartid < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
 			continue;
-- 
2.25.1

