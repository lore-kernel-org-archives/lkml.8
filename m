Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81959C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C7B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SBnAtZ/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgCPNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:55:49 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:48577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731110AbgCPNzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5JOLpafivqyKCv360sRSIZNHiX5LBQm/jO8FNAYsdJuVjO50oxQlP7IA3x3gDWKThUEmSobQIWYAtIPSSep3GorWuUAW50C+qEIq3bPUXmvq8JEC05+ZqmOhGFlfd88DXpDMHV2cwm8Vj0Wt0VntYb34N5VeGuDfVKS24ZkEsjGZbtCFywio2qL6xYB3KeLS41z6w2oQPqE29pU/pMuiraxSScdrkJsP9dYia4i/zkafQYekBHKCzCZQ3xEV5taZ/AX2DyHtMdjlSWI1mC8qYIfebu3Z6ayJfotAnlUXAF1mxHV5Sryl3/plSWYpUZeB7Nr8IavP64fwRkbnn8n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c9FJdUWAQIhX4eABbbIpwM7kuroKBQ4y9kv0SPLcU0=;
 b=EvCjRe0t7zQnH6k0P2zkf6AlFV+ijw3haumTs8OOXK5l9Bq94S9rz1DLJ2TDPMlXiQGk2+GXldGBitovVcFLizN0j1U0VtKj07jqvssF8a0XQUJdw92M0LOyKbZ6cUyN7Lqqj081TvydhvVX7BIlRPyS9A/s+q6v6A134JvaivdrNhqXawz75d3qTPCh21nJA9Tl782IPlCt3gzx+hnAiRgbVWpBwOQl5GXcdYFAkCNc4mkzU5pzeY73IunZFK+zxC0Bbp920jmUw6Jq8KtNg6Syuxenhkl0JUDd/q4nF9uluO+Xd3J8A4/MY04huKIQyIAjFusVqgRFns/mNd2Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c9FJdUWAQIhX4eABbbIpwM7kuroKBQ4y9kv0SPLcU0=;
 b=SBnAtZ/iVbd3H8hXSf7HjoH2ohyPNvXUvijn/d+j7ozTSvB4UwILrmpBOQ2VJGk7ZGJTfCHHe8PfwUq5+Sse38z0owDXud5Yls4RcCoY4+iP9JlmpW7qj7qB/aE1d49kJ4NWSjN1Dddlc83LTJq4zZkXFXc93dG390OJcZ6WEU4=
Received: from MN2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:fc::38)
 by CH2PR02MB6508.namprd02.prod.outlook.com (2603:10b6:610:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Mon, 16 Mar
 2020 13:55:44 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::21) by MN2PR02CA0025.outlook.office365.com
 (2603:10b6:208:fc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Mon, 16 Mar 2020 13:55:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Mon, 16 Mar 2020 13:55:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqDV-00041c-E8; Mon, 16 Mar 2020 06:55:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqDQ-0003zh-At; Mon, 16 Mar 2020 06:55:36 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02GDtOAv027807;
        Mon, 16 Mar 2020 06:55:25 -0700
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jDqDE-0003l2-DF; Mon, 16 Mar 2020 06:55:24 -0700
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michals@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, sivadur@xilinx.com,
        anirudh@xilinx.com, Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH v4 3/3] irqchip: xilinx: Enable generic irq multi handler
Date:   Mon, 16 Mar 2020 19:24:47 +0530
Message-Id: <20200316135447.30162-4-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200316135447.30162-1-mubin.usman.sayyed@xilinx.com>
References: <20200316135447.30162-1-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(199004)(46966005)(356004)(6666004)(70206006)(5660300002)(4326008)(2906002)(107886003)(47076004)(1076003)(70586007)(36756003)(103116003)(9786002)(7696005)(81166006)(81156014)(54906003)(8676002)(316002)(186003)(26005)(426003)(8936002)(2616005)(478600001)(336012)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6508;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04311a5-1e80-4527-f27a-08d7c9b1b790
X-MS-TrafficTypeDiagnostic: CH2PR02MB6508:
X-Microsoft-Antispam-PRVS: <CH2PR02MB650819BC425FFA17FA1559EAA1F90@CH2PR02MB6508.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0M7hJPcxgMuucF8J5C8yA3B5IUzJhrnVwh5QXdg41mq/bEZW4DmvVVUI9AGHPxaN37cbvgo0tik5na9cILsCbPxj3iGA5Z7pAxftva2MfVgoKj8CmkQrp6MAXLBAWzqjtKJUYFcQQylE3nWqiJpVjxyJth54N2yDdVFkNNTAc3QNAoVw9moS4RfO4iUmKUALOMUWhs5kwKqh+QTKU7viKjTE+6B8EaDD7eM3pHqqsRW41OA1DQ0FMHAs5JQXU1PcOXBd5JL/Y8wwZ3wrt4VBATvY9nZI09qBc8NIkd2RWqkethKGY8Cd9KHBtAzEO6eE/oY6ejTQKWf5Zmz3ynH548a4YyS7QXeJPlrd7+oS9lnsInWmGEsk5HW16xaP/DwfJ6EbHwyPFf+m755ILD6znbBisnSC/REh7jB96t8sg/NXZ6/JA5dplrscmmpAo7Wy98TJd6ktKHVjSsN4YFDdZAUc12mlYTDhf+Fl+ip7fSBiBHIXt7CF0XhrEN7nQbCRrHHGhlp0PH6KRJQm55NXbFKDWJ0ojhAHFD+ZigzngU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:55:41.9936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04311a5-1e80-4527-f27a-08d7c9b1b790
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Register default arch handler via driver instead of directly pointing to
xilinx intc controller. This patch makes architecture code more generic.

Driver calls generic domain specific irq handler which does the most of
things self. Also get rid of concurrent_irq counting which hasn't been
exported anywhere.
Based on this loop was also optimized by using do/while loop instead of
goto loop.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---
 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 21 +------------------
 drivers/irqchip/irq-xilinx-intc.c | 34 ++++++++++++++++++-------------
 4 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index a75896f18e58..b5a87c294925 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -47,6 +47,8 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
+	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index eac2fb4b3fb9..5166f0893e2b 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -14,7 +14,4 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
-/* should be defined in each interrupt controller driver */
-extern unsigned int xintc_get_irq(void);
-
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 903dad822fad..0b37dde60a1e 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,29 +20,10 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
-
-	irq_enter();
-	irq = xintc_get_irq();
-next_irq:
-	BUG_ON(!irq);
-	generic_handle_irq(irq);
-
-	irq = xintc_get_irq();
-	if (irq != -1U) {
-		pr_debug("next irq: %d\n", irq);
-		++concurrent_irq;
-		goto next_irq;
-	}
-
-	irq_exit();
-	set_irq_regs(old_regs);
+	handle_arch_irq(regs);
 	trace_hardirqs_on();
 }
 
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index f2a359e2feaa..390476b8d719 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -125,20 +125,6 @@ static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
 	return irq;
 }
 
-unsigned int xintc_get_irq(void)
-{
-	unsigned int irq = -1;
-	u32 hwirq;
-
-	hwirq = xintc_read(primary_intc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct xintc_irq_chip *irqc = d->host_data;
@@ -178,6 +164,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+	struct xintc_irq_chip *irqc = primary_intc;
+
+	do {
+		hwirq = xintc_read(irqc, IVR);
+		if (likely(hwirq != -1U)) {
+			int ret;
+
+			ret = handle_domain_irq(irqc->root_domain, hwirq, regs);
+			WARN_ONCE(ret, "Unhandled HWIRQ %d\n", hwirq);
+			continue;
+		}
+
+		break;
+	} while (1);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -248,6 +253,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
-- 
2.25.0

