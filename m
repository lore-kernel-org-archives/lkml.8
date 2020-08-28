Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8695C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A629D20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSNP/df+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH1Gxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:53:37 -0400
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:35264
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbgH1Gxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSHV4yZeSN8/ZXTBxIiXOYJYfxSDl7CDsqzw4FSzMcwxZgt7/VhTSv4px4PiJi5djkZvwSbQpSdhAaoxGwDGA9hbhRHIYBc+9s3zSn2CBk8uZwKk2qzKRi9WqOYcSqiAwO0486UPQfTkHes8vxw35qF6gNtu27R2AUsYpfctVBpwXkqs3DGMVZ4rYqHZXNwR1/mlB7Pyag1tiuHSijrTvpUjzUjYE7NHkudeqXRNkiFmfDCQ4w/0Odln0uaN2g5WjJysDOdZhQ2+ckIqQSnJQWj1lgOeKJlqLnrPnzAW27GgQPAqxdBo84VrXf96TA9xeMNh+YonFdyY9el170murA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQDZY2vJHEH6YpaVHf2PiUaIqZhmzi2j6jd83QELNbU=;
 b=CdQquqOP1YvWKtB3KGCAlQIKa2RwRBKYcNCb4qmiNgsvdDJqRr4CZmeSTtPwoMWytgrpFIyQxfnmFkSy3Nz8ZHuKZGas1RU6yDUXhH42LnL+H7a4XGrzZsK262qHRd3+7+m4/7H92eJqBYnyKSVi9R67ittCTF8X368BXkIEkgrqUq04+967VFE/zG4ncpx7LktlzSzXR2eICMrcgCiY3YJ0dnGBVmss9jG9iLQyOMShIqrDSIlEf0rKXZ3YNbZQl608N3uKG5HfvkMRSIEkxu8s90nFKvuEnOgY1tRqF5xxgTk40VrGBfTb1S3CKcnvcXDuny/wEpDnD41PjWb7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQDZY2vJHEH6YpaVHf2PiUaIqZhmzi2j6jd83QELNbU=;
 b=jSNP/df+Trkz9cdrHmAyhCqiob9DcxVW5HRHvaOM8l7p57Pg07+oKftxYnw55eksM7pXv2GfuXKim5mMQdLt3QkqdnrfO40B2V2GfWBVnSB38bqBL975KwjdyFTs4QwgYqLoe6TEkWpAkQCRCDxQveORc73t68fcfqcY1ITtE6M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3127.eurprd04.prod.outlook.com (2603:10a6:6:c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Fri, 28 Aug 2020 06:53:26 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 06:53:26 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        abel.vesa@nxp.com, Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: fix i.MX7D peripheral clk mux flags
Date:   Fri, 28 Aug 2020 15:18:50 +0800
Message-Id: <20200828071850.24945-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.3 via Frontend Transport; Fri, 28 Aug 2020 06:53:22 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e14831ea-5eeb-4758-7c92-08d84b1f106c
X-MS-TrafficTypeDiagnostic: DB6PR04MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3127CAC1A4EE893526FB275888520@DB6PR04MB3127.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baGMV/HHaLuMrMaDuZzeAg3KMi9wFlgcqKiabn+h0WAlhUCMSWJbXi9tckXx0BY8PI2ZAKcEg4sJ8lDDUMZ1aX8tijyYZqTZyV0a06UFTOFaqn4HBJlaCzCN2IYm/7uEKEUi6pED1kJdv23BywaRKFU+UWjgYEIOtLrymmfrC+Z5y41df+LExbCo2Hw5tRQVdLx8KFhBr2acgGHz7uyVXhy0SH76Oak4OvSmGuATeF6Uuy0qeVG9ekZGOgW9nD+cYXievXlj5bAveA6j6OgZ1Ciwzf0Lxcjq17Blv7a8Vf9Ensd2ytglU4x4FSTQCqTL6RMF9ofnE0clg6zk+DO+cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6666004)(2906002)(86362001)(6486002)(8936002)(83380400001)(36756003)(2616005)(52116002)(1076003)(16526019)(66476007)(316002)(5660300002)(8676002)(30864003)(478600001)(66556008)(956004)(4326008)(6512007)(26005)(6506007)(186003)(9686003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3bZSyo4nUeuAG41+XRhMsSIcZUUY/5O1h6AOcKO/UHM+AYzEadyH3C9ZifrNbagrBzM34cfnyat5zhdxeGC4/ejEmWPSthf3QwEngVfyfipGlawi88EUCbJd5fJeQIzRvhBvcEb6klD7DEBTKY2RfZ3K+UQAysPORFM9OJtL9UJKiO49BhZG8FTuTYVQVQ1p7uxyZmPeOmqP30oaTxysTVQLdxfsSiMrLoou7+VF0wdmUOJKEVSW85az1Ib+22X0DrtF47Two3RniCJiKXwD56tf8a3gNL793qf2aAE9nXB02oGf/1ClrKbH8cEHx4+RdTrc7lX2GU53gfTNWaY0TTyAGBfQfCvD3YM0xHbZv8mch93Qcn3J7LMO3Z0WWeSzT4bsFRAeDt6PLaZV1Jd9Ue4DS/kKjzo8MWPKI9rfsuyPlK6LIpgJmQCFO9vujHDASWFanQA48k0KgRx8w/aqCSQFvjUUf2soQLAtvJf/UdLJbh3mbpUKEWVyrQG9Ggt5c+FL8SLUnpiRNsipJW2kgIsJzkzNM2/TK8/LpMClXFp9gmg3oepU8XNi1wVFAKnx5dlowLx2WTsE/g/Igy3b8Q6Px26xCYv0ahUA2iyG/c7l2/HsxdaIZqDMMz/tfsNcwYW9Ej1WwgVCY54IgwmkIw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14831ea-5eeb-4758-7c92-08d84b1f106c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 06:53:26.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npkmsUwpjM3SpDioQaURHpVjHYN5TCRap3XTqkqFVlwUhQuEqfot6vYZ3mS9hOHnjZbcRlX8V7XueUSTfV4W5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM, Page 574, Chapter 5.2.6.4.3 Peripheral clock slice,
"IP clock slices must be stopped to change the clock source.".

So we must have CLK_SET_PARENT_GATE flag to avoid glitch.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 131 ++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 6197710ee8c5..22d24a6a05e7 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -506,72 +506,73 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_ARM_M4_ROOT_SRC] = imx_clk_hw_mux2("arm_m4_src", base + 0x8080, 24, 3, arm_m4_sel, ARRAY_SIZE(arm_m4_sel));
 	hws[IMX7D_MAIN_AXI_ROOT_SRC] = imx_clk_hw_mux2("axi_src", base + 0x8800, 24, 3, axi_sel, ARRAY_SIZE(axi_sel));
 	hws[IMX7D_DISP_AXI_ROOT_SRC] = imx_clk_hw_mux2("disp_axi_src", base + 0x8880, 24, 3, disp_axi_sel, ARRAY_SIZE(disp_axi_sel));
-	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel));
-	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel));
 	hws[IMX7D_AHB_CHANNEL_ROOT_SRC] = imx_clk_hw_mux2("ahb_src", base + 0x9000, 24, 3, ahb_channel_sel, ARRAY_SIZE(ahb_channel_sel));
-	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel));
-	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel));
-	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel));
-	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
-	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel));
-	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel));
-	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel));
-	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_hw_mux2("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel));
-	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel));
-	hws[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_hw_mux2("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel));
-	hws[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_hw_mux2("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel));
-	hws[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_hw_mux2("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel));
-	hws[IMX7D_SAI1_ROOT_SRC] = imx_clk_hw_mux2("sai1_src", base + 0xa500, 24, 3, sai1_sel, ARRAY_SIZE(sai1_sel));
-	hws[IMX7D_SAI2_ROOT_SRC] = imx_clk_hw_mux2("sai2_src", base + 0xa580, 24, 3, sai2_sel, ARRAY_SIZE(sai2_sel));
-	hws[IMX7D_SAI3_ROOT_SRC] = imx_clk_hw_mux2("sai3_src", base + 0xa600, 24, 3, sai3_sel, ARRAY_SIZE(sai3_sel));
-	hws[IMX7D_SPDIF_ROOT_SRC] = imx_clk_hw_mux2("spdif_src", base + 0xa680, 24, 3, spdif_sel, ARRAY_SIZE(spdif_sel));
-	hws[IMX7D_ENET1_REF_ROOT_SRC] = imx_clk_hw_mux2("enet1_ref_src", base + 0xa700, 24, 3, enet1_ref_sel, ARRAY_SIZE(enet1_ref_sel));
-	hws[IMX7D_ENET1_TIME_ROOT_SRC] = imx_clk_hw_mux2("enet1_time_src", base + 0xa780, 24, 3, enet1_time_sel, ARRAY_SIZE(enet1_time_sel));
-	hws[IMX7D_ENET2_REF_ROOT_SRC] = imx_clk_hw_mux2("enet2_ref_src", base + 0xa800, 24, 3, enet2_ref_sel, ARRAY_SIZE(enet2_ref_sel));
-	hws[IMX7D_ENET2_TIME_ROOT_SRC] = imx_clk_hw_mux2("enet2_time_src", base + 0xa880, 24, 3, enet2_time_sel, ARRAY_SIZE(enet2_time_sel));
-	hws[IMX7D_ENET_PHY_REF_ROOT_SRC] = imx_clk_hw_mux2("enet_phy_ref_src", base + 0xa900, 24, 3, enet_phy_ref_sel, ARRAY_SIZE(enet_phy_ref_sel));
-	hws[IMX7D_EIM_ROOT_SRC] = imx_clk_hw_mux2("eim_src", base + 0xa980, 24, 3, eim_sel, ARRAY_SIZE(eim_sel));
-	hws[IMX7D_NAND_ROOT_SRC] = imx_clk_hw_mux2("nand_src", base + 0xaa00, 24, 3, nand_sel, ARRAY_SIZE(nand_sel));
-	hws[IMX7D_QSPI_ROOT_SRC] = imx_clk_hw_mux2("qspi_src", base + 0xaa80, 24, 3, qspi_sel, ARRAY_SIZE(qspi_sel));
-	hws[IMX7D_USDHC1_ROOT_SRC] = imx_clk_hw_mux2("usdhc1_src", base + 0xab00, 24, 3, usdhc1_sel, ARRAY_SIZE(usdhc1_sel));
-	hws[IMX7D_USDHC2_ROOT_SRC] = imx_clk_hw_mux2("usdhc2_src", base + 0xab80, 24, 3, usdhc2_sel, ARRAY_SIZE(usdhc2_sel));
-	hws[IMX7D_USDHC3_ROOT_SRC] = imx_clk_hw_mux2("usdhc3_src", base + 0xac00, 24, 3, usdhc3_sel, ARRAY_SIZE(usdhc3_sel));
-	hws[IMX7D_CAN1_ROOT_SRC] = imx_clk_hw_mux2("can1_src", base + 0xac80, 24, 3, can1_sel, ARRAY_SIZE(can1_sel));
-	hws[IMX7D_CAN2_ROOT_SRC] = imx_clk_hw_mux2("can2_src", base + 0xad00, 24, 3, can2_sel, ARRAY_SIZE(can2_sel));
-	hws[IMX7D_I2C1_ROOT_SRC] = imx_clk_hw_mux2("i2c1_src", base + 0xad80, 24, 3, i2c1_sel, ARRAY_SIZE(i2c1_sel));
-	hws[IMX7D_I2C2_ROOT_SRC] = imx_clk_hw_mux2("i2c2_src", base + 0xae00, 24, 3, i2c2_sel, ARRAY_SIZE(i2c2_sel));
-	hws[IMX7D_I2C3_ROOT_SRC] = imx_clk_hw_mux2("i2c3_src", base + 0xae80, 24, 3, i2c3_sel, ARRAY_SIZE(i2c3_sel));
-	hws[IMX7D_I2C4_ROOT_SRC] = imx_clk_hw_mux2("i2c4_src", base + 0xaf00, 24, 3, i2c4_sel, ARRAY_SIZE(i2c4_sel));
-	hws[IMX7D_UART1_ROOT_SRC] = imx_clk_hw_mux2("uart1_src", base + 0xaf80, 24, 3, uart1_sel, ARRAY_SIZE(uart1_sel));
-	hws[IMX7D_UART2_ROOT_SRC] = imx_clk_hw_mux2("uart2_src", base + 0xb000, 24, 3, uart2_sel, ARRAY_SIZE(uart2_sel));
-	hws[IMX7D_UART3_ROOT_SRC] = imx_clk_hw_mux2("uart3_src", base + 0xb080, 24, 3, uart3_sel, ARRAY_SIZE(uart3_sel));
-	hws[IMX7D_UART4_ROOT_SRC] = imx_clk_hw_mux2("uart4_src", base + 0xb100, 24, 3, uart4_sel, ARRAY_SIZE(uart4_sel));
-	hws[IMX7D_UART5_ROOT_SRC] = imx_clk_hw_mux2("uart5_src", base + 0xb180, 24, 3, uart5_sel, ARRAY_SIZE(uart5_sel));
-	hws[IMX7D_UART6_ROOT_SRC] = imx_clk_hw_mux2("uart6_src", base + 0xb200, 24, 3, uart6_sel, ARRAY_SIZE(uart6_sel));
-	hws[IMX7D_UART7_ROOT_SRC] = imx_clk_hw_mux2("uart7_src", base + 0xb280, 24, 3, uart7_sel, ARRAY_SIZE(uart7_sel));
-	hws[IMX7D_ECSPI1_ROOT_SRC] = imx_clk_hw_mux2("ecspi1_src", base + 0xb300, 24, 3, ecspi1_sel, ARRAY_SIZE(ecspi1_sel));
-	hws[IMX7D_ECSPI2_ROOT_SRC] = imx_clk_hw_mux2("ecspi2_src", base + 0xb380, 24, 3, ecspi2_sel, ARRAY_SIZE(ecspi2_sel));
-	hws[IMX7D_ECSPI3_ROOT_SRC] = imx_clk_hw_mux2("ecspi3_src", base + 0xb400, 24, 3, ecspi3_sel, ARRAY_SIZE(ecspi3_sel));
-	hws[IMX7D_ECSPI4_ROOT_SRC] = imx_clk_hw_mux2("ecspi4_src", base + 0xb480, 24, 3, ecspi4_sel, ARRAY_SIZE(ecspi4_sel));
-	hws[IMX7D_PWM1_ROOT_SRC] = imx_clk_hw_mux2("pwm1_src", base + 0xb500, 24, 3, pwm1_sel, ARRAY_SIZE(pwm1_sel));
-	hws[IMX7D_PWM2_ROOT_SRC] = imx_clk_hw_mux2("pwm2_src", base + 0xb580, 24, 3, pwm2_sel, ARRAY_SIZE(pwm2_sel));
-	hws[IMX7D_PWM3_ROOT_SRC] = imx_clk_hw_mux2("pwm3_src", base + 0xb600, 24, 3, pwm3_sel, ARRAY_SIZE(pwm3_sel));
-	hws[IMX7D_PWM4_ROOT_SRC] = imx_clk_hw_mux2("pwm4_src", base + 0xb680, 24, 3, pwm4_sel, ARRAY_SIZE(pwm4_sel));
-	hws[IMX7D_FLEXTIMER1_ROOT_SRC] = imx_clk_hw_mux2("flextimer1_src", base + 0xb700, 24, 3, flextimer1_sel, ARRAY_SIZE(flextimer1_sel));
-	hws[IMX7D_FLEXTIMER2_ROOT_SRC] = imx_clk_hw_mux2("flextimer2_src", base + 0xb780, 24, 3, flextimer2_sel, ARRAY_SIZE(flextimer2_sel));
-	hws[IMX7D_SIM1_ROOT_SRC] = imx_clk_hw_mux2("sim1_src", base + 0xb800, 24, 3, sim1_sel, ARRAY_SIZE(sim1_sel));
-	hws[IMX7D_SIM2_ROOT_SRC] = imx_clk_hw_mux2("sim2_src", base + 0xb880, 24, 3, sim2_sel, ARRAY_SIZE(sim2_sel));
-	hws[IMX7D_GPT1_ROOT_SRC] = imx_clk_hw_mux2("gpt1_src", base + 0xb900, 24, 3, gpt1_sel, ARRAY_SIZE(gpt1_sel));
-	hws[IMX7D_GPT2_ROOT_SRC] = imx_clk_hw_mux2("gpt2_src", base + 0xb980, 24, 3, gpt2_sel, ARRAY_SIZE(gpt2_sel));
-	hws[IMX7D_GPT3_ROOT_SRC] = imx_clk_hw_mux2("gpt3_src", base + 0xba00, 24, 3, gpt3_sel, ARRAY_SIZE(gpt3_sel));
-	hws[IMX7D_GPT4_ROOT_SRC] = imx_clk_hw_mux2("gpt4_src", base + 0xba80, 24, 3, gpt4_sel, ARRAY_SIZE(gpt4_sel));
-	hws[IMX7D_TRACE_ROOT_SRC] = imx_clk_hw_mux2("trace_src", base + 0xbb00, 24, 3, trace_sel, ARRAY_SIZE(trace_sel));
-	hws[IMX7D_WDOG_ROOT_SRC] = imx_clk_hw_mux2("wdog_src", base + 0xbb80, 24, 3, wdog_sel, ARRAY_SIZE(wdog_sel));
-	hws[IMX7D_CSI_MCLK_ROOT_SRC] = imx_clk_hw_mux2("csi_mclk_src", base + 0xbc00, 24, 3, csi_mclk_sel, ARRAY_SIZE(csi_mclk_sel));
-	hws[IMX7D_AUDIO_MCLK_ROOT_SRC] = imx_clk_hw_mux2("audio_mclk_src", base + 0xbc80, 24, 3, audio_mclk_sel, ARRAY_SIZE(audio_mclk_sel));
-	hws[IMX7D_WRCLK_ROOT_SRC] = imx_clk_hw_mux2("wrclk_src", base + 0xbd00, 24, 3, wrclk_sel, ARRAY_SIZE(wrclk_sel));
-	hws[IMX7D_CLKO1_ROOT_SRC] = imx_clk_hw_mux2("clko1_src", base + 0xbd80, 24, 3, clko1_sel, ARRAY_SIZE(clko1_sel));
-	hws[IMX7D_CLKO2_ROOT_SRC] = imx_clk_hw_mux2("clko2_src", base + 0xbe00, 24, 3, clko2_sel, ARRAY_SIZE(clko2_sel));
+
+	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2_flags("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2_flags("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SAI1_ROOT_SRC] = imx_clk_hw_mux2_flags("sai1_src", base + 0xa500, 24, 3, sai1_sel, ARRAY_SIZE(sai1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SAI2_ROOT_SRC] = imx_clk_hw_mux2_flags("sai2_src", base + 0xa580, 24, 3, sai2_sel, ARRAY_SIZE(sai2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SAI3_ROOT_SRC] = imx_clk_hw_mux2_flags("sai3_src", base + 0xa600, 24, 3, sai3_sel, ARRAY_SIZE(sai3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SPDIF_ROOT_SRC] = imx_clk_hw_mux2_flags("spdif_src", base + 0xa680, 24, 3, spdif_sel, ARRAY_SIZE(spdif_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ENET1_REF_ROOT_SRC] = imx_clk_hw_mux2_flags("enet1_ref_src", base + 0xa700, 24, 3, enet1_ref_sel, ARRAY_SIZE(enet1_ref_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ENET1_TIME_ROOT_SRC] = imx_clk_hw_mux2_flags("enet1_time_src", base + 0xa780, 24, 3, enet1_time_sel, ARRAY_SIZE(enet1_time_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ENET2_REF_ROOT_SRC] = imx_clk_hw_mux2_flags("enet2_ref_src", base + 0xa800, 24, 3, enet2_ref_sel, ARRAY_SIZE(enet2_ref_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ENET2_TIME_ROOT_SRC] = imx_clk_hw_mux2_flags("enet2_time_src", base + 0xa880, 24, 3, enet2_time_sel, ARRAY_SIZE(enet2_time_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ENET_PHY_REF_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_phy_ref_src", base + 0xa900, 24, 3, enet_phy_ref_sel, ARRAY_SIZE(enet_phy_ref_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_EIM_ROOT_SRC] = imx_clk_hw_mux2_flags("eim_src", base + 0xa980, 24, 3, eim_sel, ARRAY_SIZE(eim_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_NAND_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_src", base + 0xaa00, 24, 3, nand_sel, ARRAY_SIZE(nand_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_QSPI_ROOT_SRC] = imx_clk_hw_mux2_flags("qspi_src", base + 0xaa80, 24, 3, qspi_sel, ARRAY_SIZE(qspi_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_USDHC1_ROOT_SRC] = imx_clk_hw_mux2_flags("usdhc1_src", base + 0xab00, 24, 3, usdhc1_sel, ARRAY_SIZE(usdhc1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_USDHC2_ROOT_SRC] = imx_clk_hw_mux2_flags("usdhc2_src", base + 0xab80, 24, 3, usdhc2_sel, ARRAY_SIZE(usdhc2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_USDHC3_ROOT_SRC] = imx_clk_hw_mux2_flags("usdhc3_src", base + 0xac00, 24, 3, usdhc3_sel, ARRAY_SIZE(usdhc3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_CAN1_ROOT_SRC] = imx_clk_hw_mux2_flags("can1_src", base + 0xac80, 24, 3, can1_sel, ARRAY_SIZE(can1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_CAN2_ROOT_SRC] = imx_clk_hw_mux2_flags("can2_src", base + 0xad00, 24, 3, can2_sel, ARRAY_SIZE(can2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_I2C1_ROOT_SRC] = imx_clk_hw_mux2_flags("i2c1_src", base + 0xad80, 24, 3, i2c1_sel, ARRAY_SIZE(i2c1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_I2C2_ROOT_SRC] = imx_clk_hw_mux2_flags("i2c2_src", base + 0xae00, 24, 3, i2c2_sel, ARRAY_SIZE(i2c2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_I2C3_ROOT_SRC] = imx_clk_hw_mux2_flags("i2c3_src", base + 0xae80, 24, 3, i2c3_sel, ARRAY_SIZE(i2c3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_I2C4_ROOT_SRC] = imx_clk_hw_mux2_flags("i2c4_src", base + 0xaf00, 24, 3, i2c4_sel, ARRAY_SIZE(i2c4_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART1_ROOT_SRC] = imx_clk_hw_mux2_flags("uart1_src", base + 0xaf80, 24, 3, uart1_sel, ARRAY_SIZE(uart1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART2_ROOT_SRC] = imx_clk_hw_mux2_flags("uart2_src", base + 0xb000, 24, 3, uart2_sel, ARRAY_SIZE(uart2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART3_ROOT_SRC] = imx_clk_hw_mux2_flags("uart3_src", base + 0xb080, 24, 3, uart3_sel, ARRAY_SIZE(uart3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART4_ROOT_SRC] = imx_clk_hw_mux2_flags("uart4_src", base + 0xb100, 24, 3, uart4_sel, ARRAY_SIZE(uart4_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART5_ROOT_SRC] = imx_clk_hw_mux2_flags("uart5_src", base + 0xb180, 24, 3, uart5_sel, ARRAY_SIZE(uart5_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART6_ROOT_SRC] = imx_clk_hw_mux2_flags("uart6_src", base + 0xb200, 24, 3, uart6_sel, ARRAY_SIZE(uart6_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_UART7_ROOT_SRC] = imx_clk_hw_mux2_flags("uart7_src", base + 0xb280, 24, 3, uart7_sel, ARRAY_SIZE(uart7_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ECSPI1_ROOT_SRC] = imx_clk_hw_mux2_flags("ecspi1_src", base + 0xb300, 24, 3, ecspi1_sel, ARRAY_SIZE(ecspi1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ECSPI2_ROOT_SRC] = imx_clk_hw_mux2_flags("ecspi2_src", base + 0xb380, 24, 3, ecspi2_sel, ARRAY_SIZE(ecspi2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ECSPI3_ROOT_SRC] = imx_clk_hw_mux2_flags("ecspi3_src", base + 0xb400, 24, 3, ecspi3_sel, ARRAY_SIZE(ecspi3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_ECSPI4_ROOT_SRC] = imx_clk_hw_mux2_flags("ecspi4_src", base + 0xb480, 24, 3, ecspi4_sel, ARRAY_SIZE(ecspi4_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PWM1_ROOT_SRC] = imx_clk_hw_mux2_flags("pwm1_src", base + 0xb500, 24, 3, pwm1_sel, ARRAY_SIZE(pwm1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PWM2_ROOT_SRC] = imx_clk_hw_mux2_flags("pwm2_src", base + 0xb580, 24, 3, pwm2_sel, ARRAY_SIZE(pwm2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PWM3_ROOT_SRC] = imx_clk_hw_mux2_flags("pwm3_src", base + 0xb600, 24, 3, pwm3_sel, ARRAY_SIZE(pwm3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_PWM4_ROOT_SRC] = imx_clk_hw_mux2_flags("pwm4_src", base + 0xb680, 24, 3, pwm4_sel, ARRAY_SIZE(pwm4_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_FLEXTIMER1_ROOT_SRC] = imx_clk_hw_mux2_flags("flextimer1_src", base + 0xb700, 24, 3, flextimer1_sel, ARRAY_SIZE(flextimer1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_FLEXTIMER2_ROOT_SRC] = imx_clk_hw_mux2_flags("flextimer2_src", base + 0xb780, 24, 3, flextimer2_sel, ARRAY_SIZE(flextimer2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SIM1_ROOT_SRC] = imx_clk_hw_mux2_flags("sim1_src", base + 0xb800, 24, 3, sim1_sel, ARRAY_SIZE(sim1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_SIM2_ROOT_SRC] = imx_clk_hw_mux2_flags("sim2_src", base + 0xb880, 24, 3, sim2_sel, ARRAY_SIZE(sim2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_GPT1_ROOT_SRC] = imx_clk_hw_mux2_flags("gpt1_src", base + 0xb900, 24, 3, gpt1_sel, ARRAY_SIZE(gpt1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_GPT2_ROOT_SRC] = imx_clk_hw_mux2_flags("gpt2_src", base + 0xb980, 24, 3, gpt2_sel, ARRAY_SIZE(gpt2_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_GPT3_ROOT_SRC] = imx_clk_hw_mux2_flags("gpt3_src", base + 0xba00, 24, 3, gpt3_sel, ARRAY_SIZE(gpt3_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_GPT4_ROOT_SRC] = imx_clk_hw_mux2_flags("gpt4_src", base + 0xba80, 24, 3, gpt4_sel, ARRAY_SIZE(gpt4_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_TRACE_ROOT_SRC] = imx_clk_hw_mux2_flags("trace_src", base + 0xbb00, 24, 3, trace_sel, ARRAY_SIZE(trace_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_WDOG_ROOT_SRC] = imx_clk_hw_mux2_flags("wdog_src", base + 0xbb80, 24, 3, wdog_sel, ARRAY_SIZE(wdog_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_CSI_MCLK_ROOT_SRC] = imx_clk_hw_mux2_flags("csi_mclk_src", base + 0xbc00, 24, 3, csi_mclk_sel, ARRAY_SIZE(csi_mclk_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_AUDIO_MCLK_ROOT_SRC] = imx_clk_hw_mux2_flags("audio_mclk_src", base + 0xbc80, 24, 3, audio_mclk_sel, ARRAY_SIZE(audio_mclk_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_WRCLK_ROOT_SRC] = imx_clk_hw_mux2_flags("wrclk_src", base + 0xbd00, 24, 3, wrclk_sel, ARRAY_SIZE(wrclk_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_CLKO1_ROOT_SRC] = imx_clk_hw_mux2_flags("clko1_src", base + 0xbd80, 24, 3, clko1_sel, ARRAY_SIZE(clko1_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_CLKO2_ROOT_SRC] = imx_clk_hw_mux2_flags("clko2_src", base + 0xbe00, 24, 3, clko2_sel, ARRAY_SIZE(clko2_sel), CLK_SET_PARENT_GATE);
 
 	hws[IMX7D_ARM_A7_ROOT_CG] = imx_clk_hw_gate3("arm_a7_cg", "arm_a7_src", base + 0x8000, 28);
 	hws[IMX7D_ARM_M4_ROOT_CG] = imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", base + 0x8080, 28);
-- 
2.28.0

