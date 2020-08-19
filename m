Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830ADC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607EF2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837660;
	bh=27YoqCzmydSp3olHMeOrDUwXFIPAGPfc/YzDgqMVKcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GPKlF5fuBTAO+mDrtjVYUVrZDrBR019UKFsjz641Jq7Mh/Xpj883Rl8uCv82WnhB3
	 RT3aqjN1yGRt/Uq/PFDHE1oY30KM3NwpqAHvC4I4wHTAZJTOzpt8QEFoLGje6JfxGS
	 vJzO9SUwelZFijaWZfUSXSfhnN2aBxQPT9fFhAK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHSLrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgHSLqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:46:31 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F43208DB;
        Wed, 19 Aug 2020 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837581;
        bh=27YoqCzmydSp3olHMeOrDUwXFIPAGPfc/YzDgqMVKcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZR0vqHwSatPDbmsultS+4AMQG13FkHDGbAJ4B0IKKNzKTW2AMYZT6TPEhBErPajF+
         hqAx06gxT6fGMrrsa0HT9BrFRm5dyCcTICuhRAXxHAGNoBElaXw90oUKz4YC4Q+VUT
         Gl6G7kjglDW1Q98z/8Z1b360HcUuhYasx+bIPNMM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXr-00EuaH-LM; Wed, 19 Aug 2020 13:46:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Rob Clark <robdclark@chromium.org>,
        Liuyao An <anliuyao@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/49] staging: hikey9xx/gpu: Support MIPI DSI 3 lanes for hikey970.
Date:   Wed, 19 Aug 2020 13:45:36 +0200
Message-Id: <11d875c4d945febe2dceb7f7ca991003551b57b1.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubin Zhang <zhangxiubin1@huawei.com>

Modfiy mipi dsi lanes to improve HDMI compatibility.

Signed-off-by: Xiubin Zhang <zhangxiubin1@huawei.com>
Signed-off-by: Liuyao An <anliuyao@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/dw_drm_dsi.c     | 24 ++++++++++++-------
 drivers/staging/hikey9xx/gpu/hdmi/adv7535.c   |  4 ----
 .../staging/hikey9xx/gpu/kirin970_dpe_reg.h   |  1 +
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
index e87363ab7373..2ba94fa15d0f 100644
--- a/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/dw_drm_dsi.c
@@ -359,7 +359,10 @@ static void get_dsi_dphy_ctrl(struct dw_dsi *dsi,
 	if (bpp < 0)
 		return;
 
-	dsi->client[id].lanes = 4;
+	if (mode->clock > 80000)
+	    dsi->client[id].lanes = 4;
+	else
+	    dsi->client[id].lanes = 3;
 
 	if (dsi->client[id].phy_clock)
 		dphy_req_kHz = dsi->client[id].phy_clock;
@@ -935,8 +938,7 @@ static void mipi_config_dphy_spec1v2_parameter(struct dw_dsi *dsi, char __iomem
 	u32 lanes;
 
 	lanes =  dsi->client[dsi->cur_client].lanes - 1;
-
-	for (i = 0; i <= (lanes+1); i++) {
+	for (i = 0; i <= (lanes + 1); i++) {
 		//Lane Transmission Property
 		addr = MIPIDSI_PHY_TST_LANE_TRANSMISSION_PROPERTY + (i << 5);
 		dsi_phy_tst_set(mipi_dsi_base, addr, 0x43);
@@ -960,10 +962,12 @@ static void mipi_config_dphy_spec1v2_parameter(struct dw_dsi *dsi, char __iomem
 	//clock lane timing ctrl - t_hs_trial
 	dsi_phy_tst_set(mipi_dsi_base, MIPIDSI_PHY_TST_CLK_TRAIL, DSS_REDUCE(dsi->phy.clk_t_hs_trial));
 
-	for (i = 0; i <= (lanes + 1); i++) {
-		if (i == 2) {
+	for (i = 0; i <= 4; i++) {
+		if (lanes == 2 && i == 1) /*init mipi dsi 3 lanes shoud skip lane3*/
+			i++;
+
+		if (i == 2) /* skip clock lane*/
 			i++;  //addr: lane0:0x60; lane1:0x80; lane2:0xC0; lane3:0xE0
-		}
 
 		//data lane pre_delay
 		addr = MIPIDSI_PHY_TST_DATA_PRE_DELAY + (i << 5);
@@ -1019,6 +1023,9 @@ static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 	dss_rect_t rect;
 	u32 cmp_stopstate_val = 0;
 	u32 lanes;
+#if !defined (CONFIG_HISI_FB_970)
+	int i = 0;
+#endif
 
 	WARN_ON(!dsi);
 	WARN_ON(!mipi_dsi_base);
@@ -1132,7 +1139,7 @@ static void dsi_mipi_init(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 	/* clock lane timing ctrl - t_hs_trial*/
 	dsi_phy_tst_set(mipi_dsi_base, 0x25, dsi->phy.clk_t_hs_trial);
 
-	for (int i = 0; i <= lanes; i++) {
+	for (i = 0; i <= lanes; i++) {
 		/* data lane pre_delay*/
 		tmp = 0x30 + (i << 4);
 		dsi_phy_tst_set(mipi_dsi_base, tmp, DSS_REDUCE(dsi->phy.data_pre_delay));
@@ -1361,10 +1368,9 @@ static int mipi_dsi_on_sub1(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 
 static int mipi_dsi_on_sub2(struct dw_dsi *dsi, char __iomem *mipi_dsi_base)
 {
+	u64 pctrl_dphytx_stopcnt = 0;
 	WARN_ON(!mipi_dsi_base);
-	u64 pctrl_dphytx_stopcnt;
 
-	pctrl_dphytx_stopcnt = 0;
 	/* switch to video mode */
 	set_reg(mipi_dsi_base + MIPIDSI_MODE_CFG_OFFSET, 0x0, 1, 0);
 
diff --git a/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c b/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
index 0343b2cd4c45..a21a8f8b917e 100644
--- a/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
+++ b/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
@@ -939,14 +939,10 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 		struct mipi_dsi_device *dsi = adv7511->dsi;
 		int lanes, ret;
 
-#if defined(CONFIG_HISI_FB_970)
-		lanes = 4;
-#else
 		if (adj_mode->clock > 80000)
 			lanes = 4;
 		else
 			lanes = 3;
-#endif
 
 		if (lanes != dsi->lanes) {
 			mipi_dsi_detach(dsi);
diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index 867266073bc0..5c2ddcf01b26 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -449,6 +449,7 @@ enum dss_chn_module {
 	MODULE_SCL_LUT,
 	MODULE_ARSR2P,
 	MODULE_ARSR2P_LUT,
+	MODULE_POST_CLIP_ES,
 	MODULE_POST_CLIP,
 	MODULE_PCSC,
 	MODULE_CSC,
-- 
2.26.2

