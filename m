Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19DC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF5B206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZiEnsKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCLJJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:09:24 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:18400
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgCLJJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHutbVr1fWH6q7/19Uhg4gCleWlOLzQ9oha903x9L3Y55zwBESSZ5A0DTWuo+bovbOgBNzxN2xq8siOfFiV8Ka5acvxQTL3DrdQGqNrQAAF/lmZ5iZS9RDKPQRIdT9/3iRe1ebM3ncvd4Na97uDAC6COhuhiAbJbbM2cjXMD9xINtW1/+x/otTkTvDbGwvTX3P/ors6PH6kCxS125CpKM8eU648Oq5lD//bP2cuMQjqKERtchnpsMWVLar2/MjrDyWcYH6FRUjG+HQOZClkWyYVzQIEegAH+VmUsJuuYfNZihzPQECdSPiz7nB9qdkkU55x7XD2DOeXXaClmMaolLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPQs2wkeiSzmKMw2pH6hf0VH29Cipc9SiiW50GGBG68=;
 b=JQJzrIVjNOrvFb0MQE+COcIxyAVaSFIZu2wImDdoICLGEuaZm31cCDbzC3oT5VKX4XBlTY7gMI/4XYfeXUz51F1Q1ee0ACl/PneHKW0ARhWHbp9xxqTV6pWhf0sq9oOoJKWrx/Hta16NxWWrqhcsCXJGCa1Qlwk7d1QD3R6b7WHNuCenVKZzVgxgJeUeWMe3Haecb3p3KVCKA2MQAV6nnmSX4qlRfcrxoqOckA5q5I9rvISAgHjDuz3eEQELBl+37yMZrtp71/H3uCnqbaATwX2AGQ7iqDu5Avg13hAUOKsQDUBoFH7E8edIrK3bnyCfHgNNx1bpp0cLzFRR7rnB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPQs2wkeiSzmKMw2pH6hf0VH29Cipc9SiiW50GGBG68=;
 b=FZiEnsKnEkuRHeXOZFGTDQZ+s4+rx5Q4Jd+TJJrESm2gVfX5HM0HWDAuElg0p5dg/tU5+GYvwrTlya57bT1Ni7PPQBKzu5nR7Atru02PDSOHZviE7o9YtH4prU6fadAnV09DvHIpcypwQRE7tBlcpyeTfivIpwppma8ThkQWTCE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 09:09:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:09:17 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        leonard.crestez@nxp.com, sboyd@kernel.org, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anson.Huang@nxp.com, daniel.baluta@nxp.com, aford173@gmail.com,
        ping.bai@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, agx@sigxcpu.org, angus@akkea.ca,
        heiko@sntech.de, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/10] clk: imx8mp: mark memrepair clock as critical
Date:   Thu, 12 Mar 2020 17:01:32 +0800
Message-Id: <1584003692-25523-11-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
References: <1584003692-25523-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2814.14 via Frontend Transport; Thu, 12 Mar 2020 09:09:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 338e8d1d-58dd-4dc7-069b-08d7c6650acf
X-MS-TrafficTypeDiagnostic: AM0PR04MB5795:|AM0PR04MB5795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5795748EBD8097ADF0EF579388FD0@AM0PR04MB5795.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(6666004)(52116002)(66946007)(6506007)(9686003)(6486002)(86362001)(66476007)(66556008)(6512007)(5660300002)(4326008)(956004)(36756003)(16526019)(26005)(186003)(478600001)(7416002)(2906002)(316002)(81166006)(2616005)(81156014)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8YGy9LdqLlUtKWBCxySuEXuCP64hGVe8CDYl7sAVSmodBHGiuk6TPbvj7iX0gUP/lOa1jXOUpqQkQkwvGOO/spJT1ZHE9qfq3B9k/+z0traDbtmurgy0AtkUwdA+Cz3Tt9J39l+rI3ygLQM5cO/5z9lQKzpwEU83RmgZPm5/9GdiYMkToYyJ9sUfel8Awdj0RdaaCS1g+lqKrHCTkpKU9Z4VbGoH8gI1r4fucPSdbSiIwSpViKqanqnQg9jH5GKnYjT115jY7GMvR5MgBCHrFrKAopWWG91hxbKgsXqNTngvJCURMl/Dk5MA4q5IB4e1l9f1uT8vaGwvaeBem5SEsNje3xyjEWevOXfAqs9OXtkHRSCtOjuRKZgKCC69LwqJOLNZpo/dv3N0izWnB3ds/SklHF6MkIvBqOozSslArmCCYdyXm5pkjgZNHo10RdeOwGoDXVoUO6nc9WlOARMjWwjMc15cOjPgTycnGB7zVw2QVPqujfz/3BQHjooJFZj
X-MS-Exchange-AntiSpam-MessageData: ZUCWsO8ZoWjxxgdhmwAMHOyZNzu7aG2XLDypNv+fZtM3LhUzEt6eqEjxQSU7keVIOJGPDLxqfvXxggeMLubrIZUyPIgsBV6aH9rDhx6/8gMeP4gcnKTnj0X14uZgn1e6fm6TKFxsAWnwpa+TxIQLuQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338e8d1d-58dd-4dc7-069b-08d7c6650acf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:09:17.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxM6b9cvd3TDlJfb2bWNbiuu47fXTmeIIYHIdPNdr9ijqXrrS3k9id48paJK4Q+rmF9DiZp0Dj/W2k6MRnMbMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If memrepair root clock in CCM is disabled, the memory repair logic
in HDMIMIX can’t work. So let's mark it as critical clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index b4d9db9d5bf1..a7c59d7a40de 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -590,7 +590,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
 	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
-	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite("memrepair", imx8mp_memrepair_sels, ccm_base + 0xa300);
+	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("memrepair", imx8mp_memrepair_sels, ccm_base + 0xa300);
 	hws[IMX8MP_CLK_PCIE_PHY] = imx8m_clk_hw_composite("pcie_phy", imx8mp_pcie_phy_sels, ccm_base + 0xa380);
 	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
 	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
-- 
2.16.4

