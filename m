Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1AC205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FY0EDykj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgCLVcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:32:16 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:51040
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbgCLVcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:32:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSLSB6QVmsq/2to+gJj/Awxl8rhLuRvSaf2VgayQXbPVtGaI0X8zXvvfEqnwvyNWC2KJmeQeKUWJVOE8qnkzT6wPDtUzUVr3yUxC+NqZ2nrVvUnR31lOvnn0h33jCRyplKTS2VMG3BbfK1nxUIYHv528LW4ru5Y7EFiD4TTyQ85WYfvToOvo/Z/FvBlJYjufFsHerN6/68iK5+mMR0+ug+uHGPixqNsEytrGkAC7CF7ziZ+dZbJzj8osCV8yFzXQqj8vV1y+WOJpB6P5hY3Wpy4+DFhZvpKLwZ8JEW7h/YYJFGXOsA+Zk61gNsbOrpTZ/A/0UyR3rrJCY9vpz/DfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBHeGX19n9xnM5jqHBWiC1hhg2R7qXvx6xByDvNDHx4=;
 b=NgdQ+Fv37wrTduFqqNO/iDwNP6NWRl+6+0AbuJqrUBP1du9JR73DH4LYRCw/dMvFdNyFTLPqJcq6buBXw9huuKdUr5LqzWimdz01f1Fb0P+Dpl0a6Fr1jxckBcUCBwRZy5aPDpe+bRgynTFowNKq7fXdCrV9IJp9Jzr9kzNWp75R8nxnu+BtuyRPgF5TWg+IEA9It34XSUSygi82J3f3kwWKlCpVmq3Zkg4oIrQXiwsY7XyMeY9OA9ySs3noh+AVWtnCokNZylEGx0gtWmHktfsLMNtWZzzsDo2QPjyMLwFqAUoc2WPuyY3pko6NE2OQH/mrxd32sFuNlw3hDa2bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lixom.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBHeGX19n9xnM5jqHBWiC1hhg2R7qXvx6xByDvNDHx4=;
 b=FY0EDykjBZjV9oA+65FXAdpPsJfJ6fqBqRXSm6v7d4RAUjf31UEKx0kv1U2e417UrBjvHjQU6ygH+unPaEAhh6Rcv4ABGEp2IavhG/kycdDhTzf5jlnI4Gob2EHdQLJMmALz2M66L/IkplclXjNDKApC3yu81ujfzeZXjstLHHg=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by DM6PR02MB7033.namprd02.prod.outlook.com (2603:10b6:5:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 21:32:08 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:239:cafe::4e) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 12 Mar 2020 21:32:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2814.13
 via Frontend Transport; Thu, 12 Mar 2020 21:32:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVR1-0001nD-0j; Thu, 12 Mar 2020 14:32:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVQv-0006jp-QH; Thu, 12 Mar 2020 14:32:01 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jCVQn-0006iZ-14; Thu, 12 Mar 2020 14:31:53 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Thu, 12 Mar 2020 14:31:39 -0700
Message-Id: <1584048699-24186-3-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
References: <1584048699-24186-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(199004)(356004)(9786002)(54906003)(336012)(36756003)(316002)(426003)(107886003)(186003)(2616005)(4326008)(26005)(81156014)(15650500001)(81166006)(7696005)(5660300002)(6666004)(8936002)(70586007)(8676002)(44832011)(70206006)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB7033;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd8371e-8da9-44e9-4264-08d7c6ccd10b
X-MS-TrafficTypeDiagnostic: DM6PR02MB7033:
X-Microsoft-Antispam-PRVS: <DM6PR02MB70333B2BBD4FE1D061CBE0BFB8FD0@DM6PR02MB7033.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0340850FCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+Mv1G2tLiRIyRtLaTMhxb5yrYad5tBECOSV11T4kGryS/7F/J53q9rkkHQ9zJP2asa2INkw5w6HHj8X8Wuw7VA5iVPtu+/qKTEbl/Pa7ubgEnCxDZI/WhkT8Iuos0dEHunEM2Q7NFMKbdam3nCSfr4ly2HfUtni0atfdJ3UWgA4xYFeL9b2sPegTrdWo49Qy6DiG8ySYsyeUB2BTdiMkQ4kB4vjuaMXpgCmlzA9VYdIhtAULVINOBxmcpYKOIyRd4zdub26Q/G3DndNfxocydbBj/uQZydtW3XNkCIqOERUf7qsVleg1o8oDW2t1IHgETtkU1fxMBH99wT/t9xf+tgbs0gBE935Ms+3GdTlxQ9j3FnK1VEqHCRBC+sTsO70aTFKcdvErLqkDZeQtqgAVnWHBI9QDUDtv8DBNr5QyqpDyo99vHogW8RuRhGOxtYo
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 21:32:07.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd8371e-8da9-44e9-4264-08d7c6ccd10b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Older firmware version sets BIT(13) in clkflag to mark a
divider as fractional divider. Updated firmware version sets BIT(4)
in type flags to mark a divider as fractional divider since
BIT(13) is defined as CLK_DUTY_CYCLE_PARENT in the common clk
framework flags.

To support both old and new firmware version, consider BIT(13) from
clkflag and BIT(4) from type_flag to check if divider is fractional
or not.

To maintain compatibility BIT(13) of clkflag in firmware will not be
used in future for any purpose and will be marked as unused.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 8eed715..efe2ed6 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -25,7 +25,8 @@
 #define to_zynqmp_clk_divider(_hw)		\
 	container_of(_hw, struct zynqmp_clk_divider, hw)
 
-#define CLK_FRAC	BIT(13) /* has a fractional parent */
+#define CLK_FRAC		BIT(13) /* has a fractional parent */
+#define CUSTOM_FLAG_CLK_FRAC	BIT(0) /* has a fractional parent in custom type flag */
 
 /**
  * struct zynqmp_clk_divider - adjustable divider clock
@@ -307,7 +308,8 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	init.num_parents = 1;
 
 	/* struct clk_divider assignments */
-	div->is_frac = !!(nodes->flag & CLK_FRAC);
+	div->is_frac = !!((nodes->flag & CLK_FRAC) |
+			  (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC));
 	div->flags = nodes->type_flag;
 	div->hw.init = &init;
 	div->clk_id = clk_id;
-- 
2.7.4

