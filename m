Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81479C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B61206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8Su/tcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCLK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:27:46 -0400
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:10028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbgCLK1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxV5FEApz1XrXI1md5+wzFspZ+t4yvcrxipl/fuVsiSXQdSMQJiv0cnnrnTTzBbY7H4kW9AzkYkgpUOcp6/lpFN3/QY+FUaPwrASQvxGkwtKbynOszyvZ48KtGjCRdNjfqQ6h+KHD0I5C/sn25cWz4svtjgJV729muUdPxwynCWxAHi8XzypVMKDIybJOw972BTVrQSCcsIYCDNlb2+39HruDfhHCha8+SSpLUkbKBr80XIKcPYiQ34GSSH4uD3ySuNfb2h5D7T/T42Ta8IsprvLOwglU8rtStFhXaDYqtCE19WiaJWr9e6Cdv7zTbHlt/KnRyKsNxe+ordcpbAvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPQs2wkeiSzmKMw2pH6hf0VH29Cipc9SiiW50GGBG68=;
 b=ZURQB+7/gihdxsuHI6rN0KmnPMl9Zu+yBt/WS/1o9VqU/zbBvnv4+3iWBwSxByD6g1hsbIKlCZFCd1PVYr9GfQ1f59xzrV116mCv9l/5Gupw+eTO/16MNxuzVGrpE7OolJdzHhQtPUVbHFWqbxronDvxThHx4S3whrGeyhWHHOqDNiuyTIQKrAlyboNvq0qoG3E3otrP5/pJvrrkgwItwh2bQsOngDWmfT0WGNMTpdHv7hgHMblmmAWXhy/Lyk7WeI6xq2z+DSsUC51+hhMFCdM71jn6WD/EIns62vfPM8LaKDVDZcDe1pOkTVyP3jPzeUXILHx0et5s/xCNsXIaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPQs2wkeiSzmKMw2pH6hf0VH29Cipc9SiiW50GGBG68=;
 b=n8Su/tcln+vOP/Zo3A8bsCt03SLL/JPWD6pDm7o3+FA3Frr08CU4f2IcCF4YK3BzdKWJipGtUkEvrQ5+VeKV5xyNt3Vhdvx3sHI78yyRiEa0kDgqRdW+OkXHz+Y8DXCJ1Ycx06wwR5ZroVsfLCIxnaLDwtFFzuwQvfgFGxHN8Jw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7171.eurprd04.prod.outlook.com (10.186.130.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Thu, 12 Mar 2020 10:27:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 10:27:41 +0000
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
Subject: [PATCH V2 10/10] clk: imx8mp: mark memrepair clock as critical
Date:   Thu, 12 Mar 2020 18:19:44 +0800
Message-Id: <1584008384-11578-11-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0113.apcprd03.prod.outlook.com (2603:1096:4:91::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2835.7 via Frontend Transport; Thu, 12 Mar 2020 10:27:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ab6af42-76b3-4761-6352-08d7c66ffe52
X-MS-TrafficTypeDiagnostic: AM0PR04MB7171:|AM0PR04MB7171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB71711DC3A0794DBD1BA6425188FD0@AM0PR04MB7171.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(478600001)(4326008)(8676002)(5660300002)(956004)(6506007)(7416002)(2616005)(16526019)(6486002)(186003)(2906002)(9686003)(86362001)(6666004)(36756003)(81166006)(26005)(66476007)(8936002)(6512007)(81156014)(66946007)(66556008)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7171;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOGNcfY14SOpYhIKUUC7Y1k+A2hWHrn7EjkxcZlGPLQIAgO6eBhUuRgv13dteuhh6xKQWfOsTYjbqLMyw51tpexY54fh7XtNpNMfHeMt42+ywq2qYTfye+gqrOpv4zuwSl7Ms7weDPHMLkukrXqyO54rn64tzL5yIz0HIDPg/8nwm9UF4UX7gAup1DcrWErYVQM55SckVp+ckP44MNLwCo8GHOM8hmy2nNv9Kf0/glxvJK+BDS3mMU7kk1XXSMoYEnJMT4OGGHAfX5d+55Ylij8marjLQmDfLJR/+1gQbANfKzLZyxSRHc8FJuQjPLqasg4idTg0E3RGNqeyxPRHOs3Hs/F54KDEVIYQ8B7fYIjd+hPLlNGTyZdtqTWnMNINLgKP/XYVxgI7rMzMAjPvHwYZTkg3/D0g+0QXLReoakue2NR1yvtfiRSVOR0HkKGMODpRHpuvjlOpkIUCrYDqxeH1sMuco1V58KSlhgST5Xb1HidYl/EPkP+kTGIZElVf
X-MS-Exchange-AntiSpam-MessageData: E9PH0mvqdzB3t9Bmmr3yzMpAC6EIxzrqnu91Z+nykx0BQB3zrC6UvSDMQUoErqsbPU4QeMGhmcL+GQJk/YkQli0TrG3mljfyXo7LI28/rY/E0Vnk0C84oNiHJ7qT8GwDs0Z1ttz4rBMXF6EOGG5Ghw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab6af42-76b3-4761-6352-08d7c66ffe52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 10:27:40.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rERLun6ZDH1LpVGtNvBLp9xjvTypaOlN2Xq26dBLQB+C21cbEnBwlVSuRp2xxJwwIyzFyDQmVR6BmpzTJPoLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171
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

