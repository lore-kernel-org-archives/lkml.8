Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A02C2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C612083E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585577555;
	bh=Z34pspBhqMJqahd4MffOLhAEomB14DsGzR3OqdRcvaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUBgxgeasxus2P4GrWrXSVYBu9IF5nWh229r3s6ImJzRhLQay8Y2kH6LFAlHHmaNW
	 kyifseGzP64nUx6EhE5B9VuPgB4XoKq38exFw8GqIsl3a56Mi0HuwWfnZ/3anXb+CU
	 XNs2Za5cKuz/8be6Vs9SzrsYsH8OqV4iKUlpwlsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgC3OMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3OMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:12:32 -0400
Received: from DESKTOP-GFFITBK.localdomain (218-161-90-76.HINET-IP.hinet.net [218.161.90.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D37C20786;
        Mon, 30 Mar 2020 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585577551;
        bh=Z34pspBhqMJqahd4MffOLhAEomB14DsGzR3OqdRcvaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atvZ6Rtt/bMPqgEsYtpAPfg88D4jpRYXX/SuBml3WGT3My+5iq7RkSUilWkgkD8ck
         PiLeYfw+0m4ykvga4NEuNwTJdRR2aRkQpdk9U0rjHu2WTefNXeA3V4Ppm3GNAx3cxR
         fZ0p4yG6g/NvauzQRW0XhvdyTcrBoCvy4VeqBLv0=
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 1/4] drm/mediatek: Move tz_disabled from mtk_hdmi_phy to mtk_hdmi driver
Date:   Mon, 30 Mar 2020 22:12:19 +0800
Message-Id: <20200330141222.17529-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330141222.17529-1-chunkuang.hu@kernel.org>
References: <20200330141222.17529-1-chunkuang.hu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

tz_disabled is used to control mtk_hdmi output signal, but this variable
is stored in mtk_hdmi_phy and mtk_hdmi_phy does not use it. So move
tz_disabled to mtk_hdmi where it's used.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 22 ++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |  1 -
 .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |  1 -
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 5e4a4dbda443..878433c09c9b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -144,11 +144,16 @@ struct hdmi_audio_param {
 	struct hdmi_codec_params codec_params;
 };
 
+struct mtk_hdmi_conf {
+	bool tz_disabled;
+};
+
 struct mtk_hdmi {
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
 	struct drm_connector conn;
 	struct device *dev;
+	const struct mtk_hdmi_conf *conf;
 	struct phy *phy;
 	struct device *cec_dev;
 	struct i2c_adapter *ddc_adpt;
@@ -230,7 +235,6 @@ static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
 static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 {
 	struct arm_smccc_res res;
-	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(hdmi->phy);
 
 	/*
 	 * MT8173 HDMI hardware has an output control bit to enable/disable HDMI
@@ -238,7 +242,7 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	 * The ARM trusted firmware provides an API for the HDMI driver to set
 	 * this control bit to enable HDMI output in supervisor mode.
 	 */
-	if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
+	if (hdmi->conf->tz_disabled)
 		regmap_update_bits(hdmi->sys_regmap,
 				   hdmi->sys_offset + HDMI_SYS_CFG20,
 				   0x80008005, enable ? 0x80000005 : 0x8000);
@@ -1688,6 +1692,7 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdmi->dev = dev;
+	hdmi->conf = of_device_get_match_data(dev);
 
 	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
 	if (ret)
@@ -1765,8 +1770,19 @@ static int mtk_hdmi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mtk_hdmi_pm_ops,
 			 mtk_hdmi_suspend, mtk_hdmi_resume);
 
+static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
+	.tz_disabled = true,
+};
+
+static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8173;
+
 static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-hdmi", },
+	{ .compatible = "mediatek,mt2701-hdmi",
+	  .data = &mtk_hdmi_conf_mt2701,
+	},
+	{ .compatible = "mediatek,mt8173-hdmi",
+	  .data = &mtk_hdmi_conf_mt8173,
+	},
 	{}
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index 2d8b3182470d..fc1c2efd1128 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -20,7 +20,6 @@
 struct mtk_hdmi_phy;
 
 struct mtk_hdmi_phy_conf {
-	bool tz_disabled;
 	unsigned long flags;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index d3cc4022e988..99fe05cd3598 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -237,7 +237,6 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 }
 
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
-	.tz_disabled = true,
 	.flags = CLK_SET_RATE_GATE,
 	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
-- 
2.17.1

