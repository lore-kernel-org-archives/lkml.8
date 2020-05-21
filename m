Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C382FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF3B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e2ooHXQz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oIs73KfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgEUNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:33:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61769 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgEUNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068025; x=1621604025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=S1b36p02cSwnUtlEy0TuBRB1sDC6K5s4EWPDv4UR5KQ=;
  b=e2ooHXQzB6DT3MNYt1JlF/yWyBTZEky1Cr2+GlE6RvU1nIXtLyAIa3yU
   7K0OPFwkOHzI4UgyCyMGDnEU6zhMpSDrAhZVL1LI66oK5ku8Y17sHAzIs
   sPNerQuawjDC6mjn5WSNbpEryH4G+VjBp0skV+LOGwDRYX1NZeXgp2jAi
   6Up55753QQesWmiipce4gtMjQ6DFJSauYfHXXE/G1eHgzlsEKDKcXBev/
   UBkIRtUVhhdTt/1tXdjl/bwQgymrU4NkJTLDJqncutD3q5LYNtwC36ZCm
   adqF3DidzaFPtT7GCBSt8VbldLRNoiMAsIWkgQa24SQenT/vjLorP+RJj
   w==;
IronPort-SDR: M86uoskcf8vKZwSN0GxsuXwKn5Xr1THXq+RmWDkLgv66oxg8sd5ExXjepaPYYks5HAtbSGHrRU
 Q1IwU7IZLx+nA6CCcivS2/TyBBXfQ1tKdHFZKt/wv0FkYPv+6a6COgi5RMh594SwcB6k/yVSmY
 4AvNxnavFeAjcjyH/CkTprmttVBNM8mZ2b5eRafuQeES2Extg3P2lyCZnzZgsX9DJZqJ/yk5Tg
 2+NJMI3uAo3K5UluVb+eWjABMwejAFbZwHNxY/XQ0xIYHmPMOd19H44n40HfH/NMUGal7Uv8PG
 H4s=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="247222585"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:33:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPajDwVhyp6odVtDHbSxQYk5vW+3xxTikRFcaM0iXEZ3+iV7l2M+a01mHPmhsVbRW8uU2XHPNOTn2t5hQPcJEJRDnUFiDpS0df5jSdMU0VngT2++GwicFmuws/EmyvwLk9d123chogP5zxQRkWBBNfjKHlkk1MAkq62H8xJ5aa1ygotdfb3sNQp20PKpoqllT56OcypxilGhRUYuz6xhnLSnp9gYhzXkAYHfO3YiAp183WA2RmnXV5PwoOQBLDASSX28CE2ETgxsILq/ZS53kwOXrwq50x+qEW6Jl0dEfrm7vmjZCA5yt5/08OHTF2qXBLxwDe5oiOKovKyY65LiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE2W9DLlKdGilXoKWil4+pDPIMKsBgbm4cT6I6B7Gbk=;
 b=g+AWvkYEDy77bMztKfc2cdUKkzSmSgia3omF1hBQ+fYYj6Gg8iGrnx/BDR2niXW6smvzEkocEQ1GYT8JUEhHHJKaDqE2JsjSNaQb1JNKTxwnx3ag7njGlFwfAsC4YRjZhdI519eN8b2NWWwcJpaOql/qbXYq7y25620OWRfJV03EU8wzOX2NgPpMp6nH2l9OE0n4tBqbcJVE65LflmmAo33ZZoxmN1m0B7DzMB855gpVZGWqRxKVwfh2749IYYo+wnu7etF7AS10e/pxaShOXrSO7mrIY9GvzppLesncfqZh9Lty8ttk8tq6NG0u61sGEbab6QAfcX8HBgd2Qawgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE2W9DLlKdGilXoKWil4+pDPIMKsBgbm4cT6I6B7Gbk=;
 b=oIs73KfWFA8rLRTWHGjXgi33Zaw3I5yaE9wPV7DNjf/OG51XSaxz6Yc3qmX0nzjdGsc6QEliiS9HPAgRbrUgwPFmj6W7272LN5vCjgiu3nGomYrUyjqJP+Un0nWsfC1kpEI+PqnJf1xm/1sqmcWbFDDZEAZ3NyLhBbaaPwX+UPk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5292.namprd04.prod.outlook.com (2603:10b6:5:107::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 13:33:44 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:33:44 +0000
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
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v5 2/6] RISC-V: Rename and move plic_find_hart_id() to arch directory
Date:   Thu, 21 May 2020 19:02:57 +0530
Message-Id: <20200521133301.816665-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521133301.816665-1-anup.patel@wdc.com>
References: <20200521133301.816665-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:33:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7d0748a-7ad9-4701-ee17-08d7fd8b9527
X-MS-TrafficTypeDiagnostic: DM6PR04MB5292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5292BAA61D8F206D813366938DB70@DM6PR04MB5292.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p938/xmYXCk2FBuOkjT6oezuthJBHhk8EsAFYoEsKzDsfNU6dSiZG0I4sHQMruPFMXXoNyMtKcRQTdVp7HCYCRKijBDCB7EEm9hsRFqo7VHnW6VzMM5HxT11qmMg2EsRjpZFQY1s0Goj4XwSCCDmfj1GiOM5xBfrXRU/cS7nNfU+Fa1a/6zDRZmaqVC2wu548IK14tBzybPi3gpe4zQXb2YjjwGs7dxZFCtyl3YRfu5kU3UzPAfa5lazsByRqn1y6wxMu5kSvpDZRt8N51r7WQyLHIFzV1WbTsu9h9MHG2+ZQQjUBKWz+qfViVX2gT3M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(478600001)(7416002)(5660300002)(8936002)(86362001)(8676002)(4326008)(8886007)(55016002)(26005)(7696005)(186003)(1006002)(1076003)(6666004)(66946007)(2616005)(2906002)(66556008)(956004)(54906003)(66476007)(52116002)(36756003)(44832011)(16526019)(55236004)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zOFjmYBqTs5lqOa01XZrBBLeNcnF2br4qofskPkuTBEmTK5NbVySfEhydJOwMDZ4E7FVnN2j71qqLWruk2rJ4GQrrdNUnWKpMij6ADAPbzZamcQqJePhCsDkLqq8KdKwi3EkoIjEW8CUiW8akwVLlJScGGd5bOCvYnhTIT3T79xlKOaiJ6R4n3umgabCxnhLugXE/T/kcUzxM3SFRWQp7NOr/iK+E5iAV86RBd8gHgT9PvVCqDieICNJgQFhb5l8hUVNkJf5owmoGKNLVqGwl6Kr3Vv6kexXttXwc5xn6MQcil/esmKd6ZCwT8EHl6dzsIruE4zB/mDO1w2B94P3lmppxn3cWWgVFX/VoNlOxqKAWOWsSDKPEh3J1B+LAxRkZNnrWJn/E4bmpXCWDjoNjxxNCtb0yv4Fa7pLthsxbbehbbUYNERsNaVDEilu9Pu9jcUCx8gjdF8pmSX2I1umHyRdoMUNIZ6w2MzOPt/sFpA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d0748a-7ad9-4701-ee17-08d7fd8b9527
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:33:44.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0lSxjUINoMsepxIQCI6kG/m75xm6DiAChJog4iS/agv5MmunDwWYV7H4AKr2H/VwtDn8CQxUlr8iF8jZC8lRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plic_find_hart_id() can be useful to other interrupt controller
drivers (such as RISC-V local interrupt driver) so we rename this
function to riscv_of_parent_hartid() and place it in arch directory
along with riscv_of_processor_hartid().

Signed-off-by: Anup Patel <anup.patel@wdc.com>
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

