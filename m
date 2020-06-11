Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3AA20812
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TzUhIzT8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ivCSAYG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFKGOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:14:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22169 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKGOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591856075; x=1623392075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SuGZr4GxtABjysO9g3tQV3Q6+ZZhHD1SDX0BveqqkFY=;
  b=TzUhIzT8MqfIkMNDulqr7A0MPHPdM3oveWiOpJpzI86nCRtddrsVTOqM
   p6uObU9QwnqY1Io//XlUO0DPhAYGeB3Jbu3MzA+LzxVCsn0BABMApiVkK
   VVLFb+JfBtGFr/MX5jUsF3CYd0anlmLtmFqfX604xZM7+89XMRoGjzliU
   iknNzhitvTpc8iOjuMzdZXQ2vm+eKoz2FdiS7MDf50ZT45KopnrphmwRB
   6yQQIfj4Hk+NIJ9mdlbpkP8RIBt39Y1luC0DoFq/I2uledgmMZSJPgwav
   iA6VPPmXJkaSljJz/4GL+O8fafov9+s89V9al4mCaAX6kD9PvK17tezpz
   A==;
IronPort-SDR: PyS54Nrkp5giQoJ9AQX8llsomDhcBtRFFwa/XrgwXnf0witaRIDNEDg7peS1F0twE/n7IBrr/G
 YJzX2B5oJnGf2dR3FzeT5+rTBLChgRDc2of03ky3eV1rJaVyCvDsZFIdq4d/8P6nH7Bb9ZBk9g
 Tg4wKN9I3c9F1TOE4mlLKA2Kahz6SrKCWg2Prz5kY46O4KxsJm86r+Hj/0A60Dq+3WzleXS/rU
 8Wjx+ujorNhIg7ecMide4JsFozez+1bpa/0kd7Rkezah2iQLcvSrGLLyTTCaWUlovBGf24blPH
 sHg=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="141117314"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 14:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuyoHrSczlbEzClbukVQYgZeD2tADmtGXkmHYQsKaX1BrAQZK1haC1dWAwB7RJrKN1+utn9lEMmryIbMOjg3OEEzhzCfJ6RxKTnCodvNafCmH5TozUauXuzAdnkRQAH8sCEGhFvPorWUJvgMSiaeQruBkBb/Cg1YGWVLhPMTH/zIeqbv3zfIWK8vLtFLOxu4ARuS61FZJk6NJQi2GZfonZ8ZIHk9MddsFGOKCaBvEIQqjrQ6sAbMgzXZ1hB1Ge9WexlZRiLrg1eLgIZRnTs5XlHFu1wPNAS3NtZ11lGFgRQGn1NLc9WgRa8IZ4ho6SmuT/C9TrCaY79yRMlgWkOTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=kli4L5egV4RXFb1DytB5kfQumjRgbwpmb3SexPl95Mxo4M7iVBajgioEnX1JjejTCjWNtacJrzlOkhQ3TGJXt4yVCNkp87ecrHY0tkgfcwILRdwAEB9KlulV+aN+fyl6SuYmJNSeEUCln+5EQ1e3leVu6z9qGweQ1cZy2+NFTYvoQpOUtGm8hb0I0h6nB2qyvWYOcKGZK2BQUNSngae5etaB1GH4S8Vs3cpwpQpbxhadfDgOW0KEPDJ/+AO95WWomyoccmXmGgNILVD+lDpnk11Wm5Qzn4fv/sCupWyxtt/NIPuWXba5venncaXOR1c2eIVr+2f1o2fNVjWh3evLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tYfhSbPBVGtiPY+QOhMkAN0w2Rz//SnplTpbzNy8=;
 b=ivCSAYG+um1mVsOBJVGkxgiHraoGFFUUkH1BNSuAfXuRgcuftJ7QGT9rR5GPFI5UXCM4GlyY6RbvW0sLMc2zAbDYCLvV+9D008gqkFehk7/648XWJBmPFxduZO+kfWv9c2SwvxKgHmE+H6QjAmqtVQQVP4z8ydq86XTi9ZnCkoc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 06:14:33 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:33 +0000
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
Subject: [PATCH v8 2/6] RISC-V: Rename and move plic_find_hart_id() to arch directory
Date:   Thu, 11 Jun 2020 11:43:46 +0530
Message-Id: <20200611061350.434293-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611061350.434293-1-anup.patel@wdc.com>
References: <20200611061350.434293-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.246.89) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:28 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.182.246.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a64177e-a435-4d69-9581-08d80dceb576
X-MS-TrafficTypeDiagnostic: DM6PR04MB6332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6332413297CB0DF9735572078D800@DM6PR04MB6332.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgKNly+BXorHn811Ch5qA04HbVKGY/jTLI2tcUCyH/EpuGWGeJtDIY9EK4kAVZ1A4WsyALV408IhP8mcKMd41vJEbmxclyh//rdPBEDSqSJYHx7CrNj9X9U7FkFbqCfyPEsBDqfi9vBhLTRaj/OCEVUgMVS4GYEP5tnzIl7mZEOQFfjwExxsYvOduoddUXGJFUIltPC3B7GDz3w0WXuYj/0yiDol2JKTimZej2tjObZAGeJ5XQ8rKYaqWYfc2ipVIaaZ1PlKTU6uLTDh/zLhvRa27CkDS9+3yY4fIl21Kzpv/kkHOVVVuPStq67v3W5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(36756003)(16526019)(4326008)(186003)(44832011)(2616005)(55016002)(8936002)(1076003)(5660300002)(956004)(7696005)(110136005)(7416002)(83380400001)(478600001)(52116002)(8886007)(86362001)(316002)(6666004)(54906003)(66556008)(2906002)(8676002)(26005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZxIsVC7/OIux1Kne/ksajxudF7zGWFcbYDJtUReG3wlzUCOpTgnx42q4y+Xf5QX65vrfwl5BAAyzYIUIgi4aBvlFG8dhNkLwIq3P4f1R0HyVtvuyRPyaTBWKgLivoeV6eiQe9NFmrVcsVgg6jNrH4hGg3l0/yxMVSgUXd9btByoKlR5b3hL44v4N5iVKyrCIZmtWpLtlC0RrHSUdGrfUjVaPwYmVIRLQMqJFQsWj14Utl3wavCA7r9njrY3avyfAnS6fmstTe8bYDHQ/fTzCygayfykdsvLy+s1B4dCwDS04kPBRYgWN/gFcVw8p0oI4BapCQAdEfXCh3PBE7BUXZQCYfj/57yi3yp501DUMQ+PLqLlhLWinWNNKRxLp3P4mNM7wc+hAFGWBRG0Tzm+BZ1UzcFJpD/FopfqIlvaMFMipxRGpc9x5UuQdai7YTYpVy4Kkpc00GniM+d5dT4dpEywZUQouFFEMaEm8E0+DX0NUxv2r9tqvUzkpT51+Xfjy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a64177e-a435-4d69-9581-08d80dceb576
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:33.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCfFMrT7Fcr1FWIJ9TVDx/Eof6TEaPhLdfnLJCk9E3hk4B3sTE769vUaAWM83E4hF4MK3z8mquylVILSs6l1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
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

