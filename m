Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB8C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0559F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 06:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSGKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:10:13 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36434 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgBSGKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:10:11 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 49B7F1A0BBF;
        Wed, 19 Feb 2020 07:10:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1DE01A109C;
        Wed, 19 Feb 2020 07:10:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A7AF5402AB;
        Wed, 19 Feb 2020 14:09:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, abel.vesa@nxp.com,
        peng.fan@nxp.com, fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] clk: imx8mp: Correct IMX8MP_CLK_HDMI_AXI clock parent
Date:   Wed, 19 Feb 2020 14:04:10 +0800
Message-Id: <1582092251-19222-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582092251-19222-1-git-send-email-Anson.Huang@nxp.com>
References: <1582092251-19222-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX8MP_CLK_HDMI_AXI should be from imx8mp_media_axi_sels instead
of imx8mp_media_apb_sels, fix it.

Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a6313cf..1a9d7a0 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -561,7 +561,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
 	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
 	hws[IMX8MP_CLK_HDMI_APB] = imx8m_clk_hw_composite("hdmi_apb", imx8mp_media_apb_sels, ccm_base + 0x8b00);
-	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite("hdmi_axi", imx8mp_media_apb_sels, ccm_base + 0x8b80);
+	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite("hdmi_axi", imx8mp_media_axi_sels, ccm_base + 0x8b80);
 	hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite("gpu_axi", imx8mp_gpu_axi_sels, ccm_base + 0x8c00);
 	hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite("gpu_ahb", imx8mp_gpu_ahb_sels, ccm_base + 0x8c80);
 	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
-- 
2.7.4

