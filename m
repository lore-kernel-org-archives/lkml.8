Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F19CC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD37320787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qQ+CjxG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEAXnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:43:53 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:22727
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgEAXnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Gg8DFOUEQFCP+EQHAuaghFdNFYZTev+xJtWA/eTLu8MKSg4L2MgyCVZgx106wgBt45g92QzG99AanBy5wFRAFJIxar1uHMCUZYOgT/QQk0i/P6VH6gb3eQ3dtMdLHBqzfT0cxb9dlSxv1x4P9uu7k7DuxYRFm1/Aljaea4SFxMjsvHh6VcTb9IKUjjjDf5fKirVLO1U2dHQXNkGcpyt0jA11vYwXfCsL/CYKQNnzYjzKD1R3jrZ/kX1aUDIensHJ8oObmuSIlHyvq8uZojIJ2ek2O1BvKViBfQ8/CxFAbrmgMvRfOC9WhztG9duD/5WxjuZCWsVxV5tL5pnDoEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PC7PliTX3bo/m9tPyJRBqcDTrRdVemB+XWNYr9hFhQ=;
 b=iIb+tE9HVtJBFvXmzi/ON4ysbYJEo5xt7/lJCAamlopPu4TeK+Lp+yi5KwcvQAgJMwozZ84t5O3kidOjdrFGZpmRxRomfMorWPr63jThdW1RDRBFWP+H2TlapmR6tiktsLj1J1HaIA8Nzv4VV/kLUA8DmOyxrtCnai/OiTWRrs6EwTZMTN9ogrzqg+4bCOuIxmT3dqvuv8DIpzbLI9PFysq7RneIwOvq5mnBb1FKdhUNP9i8QQ5vkVgxx4JMKRiTIUeFClC1bXsrJjtvk6o8yEVt5AkHdrsQJFvQfdGdRJh1PO9RsQbrVqj6rqwAtAg5bEtMWTMx8orrtaJyKr2a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PC7PliTX3bo/m9tPyJRBqcDTrRdVemB+XWNYr9hFhQ=;
 b=qQ+CjxG4tD6lPr3COb6DdfCQ8ykqvmUpq5uB+mHx4ZxVR9Px3sSh1NtrUOughNjsguDdHRqZRi5J2loeZU1f0zHKEMbz7VPYTSQZqo+c8EY8dP8dsNERwY0lfujj3AXPIS5VV/181f3Tgu+sIDdPVvbunTXJGTOv8ajjBDMBdEg=
Received: from CY4PR18CA0036.namprd18.prod.outlook.com (2603:10b6:903:9a::22)
 by BYAPR02MB4775.namprd02.prod.outlook.com (2603:10b6:a03:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 1 May
 2020 23:43:48 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:9a:cafe::c8) by CY4PR18CA0036.outlook.office365.com
 (2603:10b6:903:9a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Fri, 1 May 2020 23:43:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Fri, 1 May 2020 23:43:48
 +0000
Received: from [149.199.38.66] (port=36394 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJp-0005UO-Jy; Fri, 01 May 2020 16:43:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJr-0001S2-Rj; Fri, 01 May 2020 16:43:47 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJn-0001RY-3j; Fri, 01 May 2020 16:43:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tejas Patel <tejas.patel@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 2/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Fri,  1 May 2020 16:43:30 -0700
Message-Id: <1588376610-253693-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588376610-253693-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588376610-253693-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(47076004)(2616005)(5660300002)(8936002)(9786002)(426003)(336012)(7696005)(82740400003)(81166007)(26005)(107886003)(478600001)(316002)(2906002)(54906003)(8676002)(82310400002)(186003)(15650500001)(356005)(70586007)(6666004)(36756003)(4326008)(70206006);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aadf1de7-c10a-46a7-f122-08d7ee297e9b
X-MS-TrafficTypeDiagnostic: BYAPR02MB4775:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4775ADFD905C98C4B840A7BCA7AB0@BYAPR02MB4775.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKD3A2g2pbzrMtqO3xLOFJIbypjMpg1yB9IGR1LFs/Ilx1iArjMxbH/PNKw9B+YkuYqnR5g7duTpMDzI89svmveFOjiwGcEw/zaR4lBRTTipGsTUk8pv5I7QmivVdZGIm/oIptXCKpA9nJjbAQgyb81uMn+qUu0roEI3Ual0V6E8wTczsvpciAE+mquXtmwchO3F3WUJHUkj56J3uVmRJYIUlAutF4gnmgopNDeyZA+u4TXlIqrRA6farZIbSzc6Ir2p7Pq3h3c90hn16TVMSHBx/HmABrZBrvO3jsVcin/Lg1xI1e38xFUJhTBUTkU2cxV+MMm54UjrI9zBmrawnOG6iukwAID/I81/3vsd9cJgZUPogSwVU8LiVEU9QjsUKcMDFWo2rt5VMp6YJBefFEhTkWYYiMKaFFxfgSf2lm1G0GP67n4aEThW/cq/U47tL2PcOaXCePz63sSZM0DnFjOBGeMD2mGhZ1P/217o3onmBT/YGi/XW/yQtTF7XoKiz6jjGPRg2W7C9Ovt1tX8tQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:43:48.1333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadf1de7-c10a-46a7-f122-08d7ee297e9b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4775
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
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc7..d43c9dd 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -25,7 +25,8 @@
 #define to_zynqmp_clk_divider(_hw)             \
        container_of(_hw, struct zynqmp_clk_divider, hw)

-#define CLK_FRAC       BIT(13) /* has a fractional parent */
+#define CLK_FRAC               BIT(13) /* has a fractional parent */
+#define CUSTOM_FLAG_CLK_FRAC   BIT(0) /* has a fractional parent in custom=
 type flag */

 /**
  * struct zynqmp_clk_divider - adjustable divider clock
@@ -311,7 +312,8 @@ struct clk_hw *zynqmp_clk_register_divider(const char *=
name,
        init.num_parents =3D 1;

        /* struct clk_divider assignments */
-       div->is_frac =3D !!(nodes->flag & CLK_FRAC);
+       div->is_frac =3D !!((nodes->flag & CLK_FRAC) |
+                         (nodes->custom_type_flag & CUSTOM_FLAG_CLK_FRAC))=
;
        div->flags =3D nodes->type_flag;
        div->hw.init =3D &init;
        div->clk_id =3D clk_id;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
