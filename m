Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606B320736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DtXEFM9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCQM52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:57:28 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:25075
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgCQM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:57:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oThj/w+miq1btOcJiv2ZqWmq4IY+SjL46/WtxhqnT6lvuXHEEErbtglpc4oADfGkypG2XJPLCK6MPUE/j+3zqlDMCg6nZXA9EJsbX+lXhYA1rICYUxRdswY0w/uhpw2Lr4ZCAgtggaO8yaiuLH+JRG2zTo56JVvlBr4AHLsqgXJ15mSZdtCYoA5bYJzl0HujAdHT8zPDi4GF6u1OAt3XvuFRfQGJV1cIk9DCdPJxaz8jh8ewr308kQELk9BwoVZzrJ81xC7uGw5DRfhMcdE+IOwiE1dmBtY8mgxVv5wT1qT0cENlQqk6qVrwt9YE6QBc1lS6PUr1G5djOGy55Q7cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L72Gtidg8CWXEyZFVE4vZ8JjcGve4yCkcZ+QY85f50=;
 b=ezCtVAjp+m/vp1UW1Mi+43+/UoZCWNVZAoknsODf9t7k7k5XSUwQGXuxDgjDcQvxcgHMO5f4rVlUsZ6rAMpnnjvALn/Ehz+YDY0nmfhvrWVT6cZgnZ+mT08ZsCnrpgaXa6507KewJfLdUSXgGqqZHAZoJFnu4s7QuzBTxBgox5lyjJXdBsy8NaY4CBMmRvXyfDZsySN7CeQPfctI+zdmIUq1eV7Z4UFWal9ZrYEm1A+TgU0IMVviIUV/r0VnCwgwdCOItd232NPSw4WigEGK9VNcpTmwEmxuG6WgFIkTHVhMIZ8qqFdr+/DrM9PDOJhvkSYJ1bmKfGwtBEw2xNHrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L72Gtidg8CWXEyZFVE4vZ8JjcGve4yCkcZ+QY85f50=;
 b=DtXEFM9gTbQBf0A5dIL7a9y2aguhKnHsQ5nmfXjwOomkBluu5/9FD2Ru03q4vfhuEHY9l5POiBg21KwQDlDEdSDcujSPxKRwkG9HT/8Z8dxGrPdIj67XSBREYgORjEllXGxGoZ+jltlIV8vm7dRSzlhpFSnwFVAdPQ+kDSEn9dI=
Received: from DM5PR18CA0055.namprd18.prod.outlook.com (2603:10b6:3:22::17) by
 CY4PR02MB3333.namprd02.prod.outlook.com (2603:10b6:910:7c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 12:57:21 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::f2) by DM5PR18CA0055.outlook.office365.com
 (2603:10b6:3:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Tue, 17 Mar 2020 12:57:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Tue, 17 Mar 2020 12:57:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBma-00020f-30; Tue, 17 Mar 2020 05:57:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBmU-0001hW-Vn; Tue, 17 Mar 2020 05:57:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02HCv6QW007565;
        Tue, 17 Mar 2020 05:57:07 -0700
Received: from [10.140.6.23] (helo=xhdmubinusm40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mubin.usman.sayyed@xilinx.com>)
        id 1jEBmM-0001dT-B1; Tue, 17 Mar 2020 05:57:06 -0700
From:   Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michals@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, sivadur@xilinx.com,
        anirudh@xilinx.com, Michal Simek <michal.simek@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH v5 2/4] irqchip: xilinx: Fill error code when irq domain registration fails
Date:   Tue, 17 Mar 2020 18:25:58 +0530
Message-Id: <20200317125600.15913-3-mubin.usman.sayyed@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200317125600.15913-1-mubin.usman.sayyed@xilinx.com>
References: <20200317125600.15913-1-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(199004)(46966005)(4744005)(4326008)(356004)(6666004)(107886003)(478600001)(8676002)(81166006)(81156014)(1076003)(26005)(2906002)(70586007)(336012)(426003)(2616005)(5660300002)(70206006)(36756003)(186003)(47076004)(9786002)(316002)(8936002)(103116003)(7696005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3333;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f0687d-e656-45eb-da31-08d7ca72bada
X-MS-TrafficTypeDiagnostic: CY4PR02MB3333:
X-Microsoft-Antispam-PRVS: <CY4PR02MB333312EE7C39F44ECD4B06B9A1F60@CY4PR02MB3333.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYASBHbdD/1s4SjNvciE3xkMkR97XG/FP9p342+Q4BqRnSRxfdzy2LcxWfMjhETyuXxswakCnDsPV5f1iIUUCdIGc3B3M611c+6MAYjaItzsK9jgGuhEVIvOdmCsRhkkOymZomJu0wGPXDsn/OLjaFUaepfsLDPmsBEelboOTbZ/hCNUK0YawEBytje8uYi38o2ryFfswNzQdhiMGtris92cITN7x+zUB6JZKo8ARC48EI6QbRDAXLWzr9iM4PjfKScazcPU7UgYcPFgQh5h1Qx4rPgFMJrrvSYi/0CM5EMqMr3MIS6Xy3KfPiejD0J8XwPUowgExp+HxMjo4xXnOcu7DudpXevVSJUgU0oSnrXQk/Og0J7B/pykf+Xpi30f5ZS6RoVWBFbFKzKcDTeccGc3aQuBPnAiZWxfwWPAEmc5ziRAA2yOojtkK0Y9O7o3xLS9TtphTnMl3DxNrePRgsNqrByqWvUpXJS36KyplwL041GxCS3zhFEokBP+xjUsKLTFh5Rn1EHM96hPye/JAA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:57:20.4880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f0687d-e656-45eb-da31-08d7ca72bada
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

There is no ret filled in case of irq_domain_add_linear() failure.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---
 drivers/irqchip/irq-xilinx-intc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 34593fa34c68..1d3d273309bd 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -228,6 +228,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 						  &xintc_irq_domain_ops, irqc);
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
+		ret = -EINVAL;
 		goto error;
 	}
 
-- 
2.25.0

