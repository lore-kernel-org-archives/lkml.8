Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC81C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025872467E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kjYpl6I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCBVn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:43:58 -0500
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:42817
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgCBVn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:43:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuLTwU6pR0MZRWSjIMvtlbDlHCo/dTl6BnynCJVS3IEc8S6ubsoIRzoGOQ40pT0Dj3gFZMOLOgYjRCk+VxCjNAmKffdJ5I0lcAAAQjO7r6spsY45ezepALBUAa/LfTTOPmBPsRyXP5jdHDy0WHsmVgfKloJwqMq4sdB1GJQLPahVs9hhIZwaG359nRoU8rn1VVcfnGnh7sQgfx+cKG30k1Z9VyPyTbwUC0kYtVMutysdYPPWP0UGSYTzQno8QrFmXLbftEolA9AwIeExbzPZREaEcIKIQfj1F3w7WI5xKOQ1b1fFGNGUnZ+SZZjHYzI+ihPcyeOf4VEe7Btgfl551g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/xVlYc/R+TRQOYmwrrZgcBT+Cj5ANkycUcVaN5jcRg=;
 b=kSecku/J1nhmfixbj4mYQSyrcFiNj8kiJqnfTX83yrStHtQcwuGM95NtGteW1TCQRZrPCPgJwb3v502Co84yq0wnXWVzJ8uyyAdavYa5U0P/aiATH7oVUY3Pb0mCFC6/YFDl7IADHni2NzVSDihMw5FAgF683XOxwBCi+XyNBKV6sQbwvM2azjLMZg6Q8xNGj4Z9NsZB016myXk6/65x5TSuQTWuj2ASaRY0YTddL6zNBBOaPzHm860vSIg/lZpgAReC9k7om61ZB+0qG8LpJ+vU++WdIV5Lk4IYC0mLWlFgMwF1umrviRRMpiESmHjsaug0wV7fg6fArmPObATuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/xVlYc/R+TRQOYmwrrZgcBT+Cj5ANkycUcVaN5jcRg=;
 b=kjYpl6I2OJvalXvHjSkZA28ZoCpZA8U24dGdgAjxLedyi32hbjS59OI2qFBqHVrueoDVu8eyA7rCo/vluJ1amdqsFVHeN8o05nVHGcOz1iZO0PShBGC2+fz9howHFBX7mtLw3vSdt3woFFFB77/Nt1lkKOv/yEBhleV+Di+TOw0=
Received: from DM5PR19CA0013.namprd19.prod.outlook.com (2603:10b6:3:151::23)
 by SN6PR02MB5663.namprd02.prod.outlook.com (2603:10b6:805:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Mon, 2 Mar
 2020 21:43:53 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::b7) by DM5PR19CA0013.outlook.office365.com
 (2603:10b6:3:151::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 21:43:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.14
 via Frontend Transport; Mon, 2 Mar 2020 21:43:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8squ-00020D-CV; Mon, 02 Mar 2020 13:43:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqp-00033f-9W; Mon, 02 Mar 2020 13:43:47 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 022Lhi69006055;
        Mon, 2 Mar 2020 13:43:45 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j8sqm-00032V-Mq; Mon, 02 Mar 2020 13:43:44 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     olof@lixom.net, mturquette@baylibre.com, sboyd@kernel.org,
        michal.simek@xilinx.com, arm@kernel.org, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 1/4] clk: zynqmp: Limit bestdiv with maxdiv
Date:   Mon,  2 Mar 2020 13:43:31 -0800
Message-Id: <1583185414-20106-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
References: <1583185414-20106-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(4744005)(26005)(5660300002)(426003)(2616005)(356004)(6666004)(81166006)(8676002)(44832011)(81156014)(70206006)(316002)(54906003)(186003)(70586007)(336012)(478600001)(7696005)(4326008)(36756003)(8936002)(2906002)(107886003)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5663;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce618c3-c5d0-4a1a-dd59-08d7bef2cd24
X-MS-TrafficTypeDiagnostic: SN6PR02MB5663:
X-Microsoft-Antispam-PRVS: <SN6PR02MB56630F8F82D78F2B8FF7F66CB8E70@SN6PR02MB5663.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ctZSpmuxmPSZzeNbDOEyXIdi4zVeEMVFGb+yTVC4yDUUor1/bbT8fS027bQkxbbWslFoM4Y2zeZ9ctGvbmw5tbIIfUQ3uWY27bbgyH+Nh1t2O/TnHNzrK0cssZTqv3y208jmee6d5M31ujSAyK0q5sCFjs7+Hi69Odlxg3h7AK8dK6JfLiql/ilfBY3ow6+ykLiPqvnNFE0AUB4VbJLuQZnGmqrDfRIqwtSse8WQdaYM/OIZMl+gMqRR/uk0fR5xSVeni/HXSQ+Y+Ft2a5jAYA8mt3C7UUne4RoZ0LZ6XM6mfGxzD1E1uG5YdfkW7a5048FZQDnbUMBiNSv5r2oDdm/NO9PZbbkI+nqmCivLzW0+AEaWiXWR80IBj1jesMOnNKPkTU3ZQtmTrM7an45+g3blDCHdmKVgHS98H7yAbtqQwRSABUvXXv5dtxNGJyb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:43:52.8031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce618c3-c5d0-4a1a-dd59-08d7bef2cd24
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Clock divider value should not be greater than maximum divider value.
So use minimum of best divider or maximum divider value.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 973cdf0..7d2cb61 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -198,6 +198,8 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 
 	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
 		bestdiv = rate % *prate ? 1 : bestdiv;
+
+	bestdiv = min_t(u32, bestdiv, divider->max_div);
 	*prate = rate * bestdiv;
 
 	return rate;
-- 
2.7.4

