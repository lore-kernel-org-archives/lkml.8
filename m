Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3770620734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZWy+XPlz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OOXTdk0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgFAJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:16:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33265 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591002999; x=1622538999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SuGZr4GxtABjysO9g3tQV3Q6+ZZhHD1SDX0BveqqkFY=;
  b=ZWy+XPlzVo8/pZ9TUh6hWSQ2h+cRDUo/15b0GkBrmYSjvRDYgBhIeWnt
   xnbSYWe/k7J3s8mukR6IADDIY7FHhH8LrZPHmvd87ZOQrF1azqAG/N1Uq
   UOF0ElUEm/7jcBZBiRnwcIo7gqn7nvC1Sb3/RVsqs5L5euw51E2PXTVSd
   eKbOxMlgYdvpBnKxapE4dvaWzWYfdHMhBtmRDKMIyQiehaKB98o30CoBu
   ilbeYxHRFqjtknot+Ni59zDl0SzQ0mXpOMtXY4lWxwMnhCiAMNr6NWumV
   zi2wiAr7PBvOckmPQ/oa1a8YDYFgE5TTzsf7fU7tskN5O1VBs2SKGe0vK
   w==;
IronPort-SDR: oUxd6oFysRkj5S4z73+Li5uNgNJGC3gkcyptlIHxFT8d0In5Fz63qRCeNn7PYobiJMSLf2vb92
 WsmE3Txw/iK0idr1yli+aNbO6XnIPVhhOQo/nL3hFfV590zJFJAuDv8iVj9zNC51jnl9Mhj5O2
 5AzGXa1QWZ1nGUeNuaC1aPiYh96qD6cEAHk5hTblYcKhSwcuu22riomjYPSSVlTAVn5PMT9QOY
 +Q7FX0PSe/H9Qz/voWBNRjqp1PTsnq16KVS5WqsBFJ1l7WMG5Id5kEZ4pwty/oU2qLOVIDywvD
 PUs=
X-IronPort-AV: E=Sophos;i="5.73,460,1583164800"; 
   d="scan'208";a="241785965"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2020 17:16:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiuUYoVNvfJeUdBZlvDaA1xQrPQZqk3M38c2tr8MUKp2hBslhxf2sRFvozUloWehf/Y4tpc3UUd0odoj2RzbmsWWK2E3/Msqy/W8TrQaeyPQOWHwV/0Qv4KTgpZ+nqnl92LXA+M02ZD70TNDU2nGrHL+BWgS0OLWd4o5LClScoP/MfoV3jncctMsde8RqXAZ78Q3IPEMQPG2RHWlqbTOeRt65BOyBkEk1kwHJq1M07uvQ69JDI5zbh39dhODQGS9uIrEoG/y2tbukJmDjk2Cv1elmQn+D/497Dt2HxfqEsMuq4Zfcg0R5+/+cMZzxFKc1dn3kCG26TC0qNl53GslUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=azHbuxbO1UNl1SANQjh0AfcshkQFc+qS8t+qohg2gM4qDldK8viQAPQaBE2CygDdrlccgc2Xgujq67U0u+Knyk7Ws55oJ7yfHGv4ggh/nIoxZZ6aryZvjbFvnX+gwi8jQi+jjEbfxEBfhw8YaYZlToL48jhzE7HEjYHNhNKnfi9j47FkhGTuSqFQ8z+xzcvS77BEL5Edq/UjWbzoGH12lsG/OTIvtxMwzQdmw/u1w9+HMEX8mEvSddgsBsTIRhD3aqgwrCgHGFtkwa2F5OIr4/+aLWD4jAsNl//tLWQp87HFE6hxXIwnUiWxW3ewzCWu6HhwIWPBwK+dRoI95F512g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=OOXTdk0LiyyYRkfmVf4rzHfh6BvYsDPx82r0soSZ90Gtg9mnLx0I//7mjnHCiSM/CmZPN2r0pf1AzhK6LZrDNeK5ziPyPXO0akJZBgm7UkmUaIlIs9jnQowYM+QkU0LpLVVU3gMpQgjoISAQsDVU0oB18ZPXc3gCfSHd2MvBN5Y=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6955.namprd04.prod.outlook.com (2603:10b6:5:240::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 09:16:16 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 09:16:16 +0000
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
Subject: [PATCH v7 2/6] RISC-V: Rename and move plic_find_hart_id() to arch directory
Date:   Mon,  1 Jun 2020 14:45:39 +0530
Message-Id: <20200601091543.943678-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601091543.943678-1-anup.patel@wdc.com>
References: <20200601091543.943678-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.23.166) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 09:16:11 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.23.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b65d666-3bc2-4466-ac1d-08d8060c6faa
X-MS-TrafficTypeDiagnostic: DM6PR04MB6955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6955E0FF927802AC1C6756708D8A0@DM6PR04MB6955.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLnKL1emSXAFWlMpm5qOlDs4hC+Oig0wTxfnvzyOJ8jd1afRlpjq2VyPGaYzvUVH5yY5yzs0W+npw5r1wn+03O8YAYQM+RmGcbsVMSNpcV0LiSsvENH3L4ML3MdDVBJLMarDHCVI8QBiAoT5sTekx/CsbH6Ih9S3j1kDADyknejGhi8zSjDnS/Xr7YnnHn1dxRZ1AwTPKufUKm+UYBeOYm1+jxn63nCT3eK0lTv5LDn/NOTZ4F2xompiGt6/PNHMqpa2XdzsgCg+nI5TgvSqtxf4x0d+GrnS/8bDFbZq+4GbQKGnJnW3/yrgrfUp+wGi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(2906002)(8676002)(5660300002)(956004)(2616005)(44832011)(7416002)(1076003)(55236004)(16526019)(55016002)(86362001)(186003)(66476007)(66556008)(66946007)(8936002)(26005)(6666004)(7696005)(4326008)(83380400001)(110136005)(1006002)(316002)(8886007)(478600001)(36756003)(52116002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: a1Vekgx97efoOT2cnhO45Os5W5GbTzcRGzdN2sVyMDba1N/7XquEfGfiUcRA8WM4RRyFhROxteQ3fRw4gFspr0nuwtd45NfCt8PEQhOk/xVjw/ZZJR8cUjMP4fkiwn+CMs+F5xVEwOv3+CGPB2Z5rDGFCng4ANu3GLKkCb8G3UFU7HicSoFm3cIVswUEukhqapOso6bkFPJj4OaNYy8hByYGFo2/r2vWErURbn1MvwwUBBPK0IioOxsEkz+f3dgizbyXL7rth3+fB++EIbcLQPYbuvqEYVh8HJzMIHkBIwJy1ZD0iBFd5g1EzATNG3WguYIFtV+xLl3PmizKmWFmJJUwhx2APP292tYOTPzc5bVQE5aGKkGv6Muoc5xBYbexo2WuVitdbDAXgfBMYgqvl3wCru5cGhe16t94x8XzWGGxnGOxWgNfLIjsu11siDyhxBbdcIpvRvGyhYjAFfWCqIa9iyfvz7PIjtlkMoolA7o=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b65d666-3bc2-4466-ac1d-08d8060c6faa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 09:16:15.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr4YXpfrVkSqkVFbIoKEAjQ6/RDy3ynMnTbGXpvQsPOF0btxrcgQXtVAxiLpfxyLmLt46CIqKTJ2dV2T3usLoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6955
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

