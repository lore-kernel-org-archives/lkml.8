Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEEBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63942205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597839015;
	bh=rcRxeiZB6ID7SoRVN/Gwq+PJ1x5pFNlMdS23+MInkuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abtjxTeB+DVpaJUPhT2ID6IlUM7mEC5s4wsd3NelvYbNeNVMo8JSwXIn/yrXe8+pV
	 Jj2B/9mljYzFadb3G71YQgQDivYVmuXD4V4R9OX/+pekyOoekUB3m/5vdGkuHIJ++W
	 rlj01NS9kT03Ol1MIE2lRL7e+3+l6Zr9dUqnob9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHSMKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbgHSLrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:11 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5333722CAE;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=rcRxeiZB6ID7SoRVN/Gwq+PJ1x5pFNlMdS23+MInkuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ASwfiiqzwj7YQBOKYs+mHTJX9LtqjnFKR4ZKySgYLT6gmrEqC7AcLosA7gDhsMpM
         jZrdaSc6aRNLlvnEb0MZ9eut9Au3deURrl0kgLa/6aTaRcD93+fCzHF15QNdn/JMIr
         tzzQBMCkWgZBKwgUDjzMnBq2FadquJnAaZkyG8BU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00Euaz-BX; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/49] staging: hikey9xx/gpu: fix the DRM setting logic
Date:   Wed, 19 Aug 2020 13:45:52 +0200
Message-Id: <32904d9c4a90d7c5153d936fc6bebc4190620587.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logich which sets the MIPI parameters is currently wrong:
it is using a value stored at cur_client, with actually points
to the active location, and not to the one that it is about
to be initialized.

The entire logic sounds buggy, but for now let's just keep
following it, by adding an extra var that will tell what was
the latest attached encoder.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../hikey9xx/gpu/kirin9xx_dw_drm_dsi.c        | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
index ffc8b8e61062..39ec39a6a69b 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
@@ -241,7 +241,7 @@ struct dw_dsi {
 	unsigned long mode_flags;
 	struct gpio_desc *gpio_mux;
 	struct dw_dsi_client client[OUT_MAX];
-	enum dsi_output_client cur_client;
+	enum dsi_output_client cur_client, attached_client;
 	bool enable;
 };
 
@@ -330,13 +330,12 @@ EXPORT_SYMBOL(dsi_set_output_client);
 
 #if defined (CONFIG_DRM_HISI_KIRIN970)
 static void get_dsi_dphy_ctrl(struct dw_dsi *dsi,
-							struct mipi_phy_params *phy_ctrl)
+			      struct mipi_phy_params *phy_ctrl, u32 id)
 {
 	struct mipi_panel_info *mipi = NULL;
 	struct drm_display_mode *mode = NULL;
 	u32 dphy_req_kHz;
 	int bpp;
-	u32 id = 0;
 	u32 ui = 0;
 	u32 m_pll = 0;
 	u32 n_pll = 0;
@@ -364,7 +363,6 @@ static void get_dsi_dphy_ctrl(struct dw_dsi *dsi,
 	WARN_ON(!phy_ctrl);
 	WARN_ON(!dsi);
 
-	id = dsi->cur_client;
 	mode = &dsi->cur_mode;
 	mipi = &dsi->mipi;
 
@@ -562,13 +560,12 @@ static void get_dsi_dphy_ctrl(struct dw_dsi *dsi,
 }
 #else
 static void get_dsi_phy_ctrl(struct dw_dsi *dsi,
-							struct mipi_phy_params *phy_ctrl)
+			     struct mipi_phy_params *phy_ctrl, u32 id)
 {
 	struct mipi_panel_info *mipi = NULL;
 	struct drm_display_mode *mode = NULL;
 	u32 dphy_req_kHz;
 	int bpp;
-	u32 id = 0;
 	u32 ui = 0;
 	u32 m_pll = 0;
 	u32 n_pll = 0;
@@ -602,7 +599,6 @@ static void get_dsi_phy_ctrl(struct dw_dsi *dsi,
 	WARN_ON(!phy_ctrl);
 	WARN_ON(!dsi);
 
-	id = dsi->cur_client;
 	mode = &dsi->cur_mode;
 	mipi = &dsi->mipi;
 
@@ -949,13 +945,15 @@ static void dsi_phy_tst_set(void __iomem *base, u32 reg, u32 val)
 	writel(0x00, base + MIPIDSI_PHY_TST_CTRL0_OFFSET);
 }
 
-static void mipi_config_dphy_spec1v2_parameter(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
+static void mipi_config_dphy_spec1v2_parameter(struct dw_dsi *dsi,
+					       char __iomem *mipi_dsi_base,
+					       u32 id)
 {
 	uint32_t i;
 	uint32_t addr = 0;
 	u32 lanes;
 
-	lanes =  dsi->client[dsi->cur_client].lanes - 1;
+	lanes =  dsi->client[id].lanes - 1;
 	for (i = 0; i <= (lanes + 1); i++) {
 		//Lane Transmission Property
 		addr = MIPIDSI_PHY_TST_LANE_TRANSMISSION_PROPERTY + (i << 5);
@@ -1027,13 +1025,13 @@ static void mipi_config_dphy_spec1v2_parameter(struct dw_dsi *dsi, char __iomem
 	}
 }
 
-static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
+static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base,
+			  u32 id)
 {
 	u32 hline_time = 0;
 	u32 hsa_time = 0;
 	u32 hbp_time = 0;
 	u64 pixel_clk = 0;
-	u32 id = 0;
 	unsigned long dw_jiffies = 0;
 	u32 tmp = 0;
 	bool is_ready = false;
@@ -1048,8 +1046,6 @@ static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 	WARN_ON(!dsi);
 	WARN_ON(!mipi_dsi_base);
 
-	id = dsi->cur_client;
-
 	DRM_INFO("dsi_mipi_init, id=%d\n", id);
 
 
@@ -1063,9 +1059,9 @@ static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 	memset(&dsi->phy, 0, sizeof(struct mipi_phy_params));
 
 #if defined (CONFIG_DRM_HISI_KIRIN970)
-	get_dsi_dphy_ctrl(dsi, &dsi->phy);
+	get_dsi_dphy_ctrl(dsi, &dsi->phy, id);
 #else
-	get_dsi_phy_ctrl(dsi, &dsi->phy);
+	get_dsi_phy_ctrl(dsi, &dsi->phy, id);
 #endif
 
 	rect.x = 0;
@@ -1113,7 +1109,7 @@ static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 	dsi_phy_tst_set(mipi_dsi_base, 0x004B, 0x1);
 
 	//set dphy spec parameter
-	mipi_config_dphy_spec1v2_parameter(dsi, mipi_dsi_base);
+	mipi_config_dphy_spec1v2_parameter(dsi, mipi_dsi_base, id);
 #else
 	/* physical configuration PLL I*/
 	dsi_phy_tst_set(mipi_dsi_base, 0x14,
@@ -1363,12 +1359,13 @@ static void dsi_encoder_disable(struct drm_encoder *encoder)
 	dsi->enable = false;
 }
 
-static int mipi_dsi_on_sub1(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
+static int mipi_dsi_on_sub1(struct dw_dsi *dsi, char __iomem *mipi_dsi_base,
+			    u32 id)
 {
 	WARN_ON(!mipi_dsi_base);
 
 	/* mipi init */
-	dsi_mipi_init(dsi, mipi_dsi_base);
+	dsi_mipi_init(dsi, mipi_dsi_base, id);
 
 	/* dsi memory init */
 #if defined (CONFIG_DRM_HISI_KIRIN970)
@@ -1443,7 +1440,7 @@ static void dsi_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	mipi_dsi_on_sub1(dsi, ctx->base);
+	mipi_dsi_on_sub1(dsi, ctx->base, dsi->attached_client);
 
 	mipi_dsi_on_sub2(dsi, ctx->base);
 
@@ -1550,6 +1547,8 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->client[id].mode_flags = mdsi->mode_flags;
 	dsi->client[id].phy_clock = 0;
 
+	dsi->attached_client = id;
+
 	DRM_INFO("host attach, client name=[%s], id=%d\n", mdsi->name, id);
 
 	return 0;
@@ -1959,6 +1958,7 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 
 	/* set dsi default output to panel */
 	dsi->cur_client = OUT_PANEL;
+	dsi->attached_client = dsi->cur_client;
 
 	DRM_INFO("dsi  cur_client is %d  <0->hdmi;1->panel> \n", dsi->cur_client);
 	/*dis-reset*/
-- 
2.26.2

