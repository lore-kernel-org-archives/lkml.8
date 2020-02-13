Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FBC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A2221734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581625276;
	bh=DixFOO1GKT4exK4e47L4oEKto/snnxtafkHfLyzoRjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIQbXwygETUjFdBSBoE8K/2YN3heXcXEtxXzUN7ZRyrqADu9r2RCw9A6Qs55hTA3P
	 kjwDJ8LNJurx5y8x2ik5WClX0Oh1/s9s6CEpiNzUAUva/pN7Ofd0pn75bhWij63klw
	 lAoPkmxyMCMMLGQPBQtsuyXP08RbQRXyT/9TnmQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgBMUVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgBMUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:21:12 -0500
Received: from ziggy.cz (unknown [37.223.145.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EAFE246AF;
        Thu, 13 Feb 2020 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581625270;
        bh=DixFOO1GKT4exK4e47L4oEKto/snnxtafkHfLyzoRjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoQVPXYTBM5OOAECJE/bFoLv6kRxp2NCvyDhOWHJsrnOAbKQLbnfxHIZ8LjZtSCsC
         ApqfRu79GzpDKRUSbQbon2hwwIiZsGhBYUDMVYJGw4rD3SOCh7oWTlZxDV9B1WYhXo
         pLz5f5al64vrKwo51arNt5Ucl74Gm0bmXnKu+SJ0=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@kernel.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, enric.balletbo@collabora.com
Cc:     devicetree@vger.kernel.org, drinkcat@chromium.org,
        frank-w@public-files.de, sean.wang@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, linux-mediatek@lists.infradead.org,
        rdunlap@infradead.org, matthias.bgg@kernel.org,
        hsinyi@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v7 13/13] drm/mediatek: Add support for mmsys through a pdev
Date:   Thu, 13 Feb 2020 21:19:53 +0100
Message-Id: <20200213201953.15268-14-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213201953.15268-1-matthias.bgg@kernel.org>
References: <20200213201953.15268-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The MMSYS subsystem includes clocks and drm components.
This patch adds an initailization path through a platform device
for the clock part, so that both drivers get probed from the same
device tree compatible.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---

Changes in v7:
- Add Rv-by from Enric

Changes in v6:
- re-arrange the patch order
- generate platform_device for mmsys clock driver inside the DRM driver
- fix DTS binding accordingly
- switch all mmsys clock driver to platform probing
- fix mt8173 platform driver remove function
- fix probe defer path in HDMI driver
- fix probe defer path in mtk_mdp_comp
- fix identation of error messages

Changes in v5:
- fix missing regmap accessors in drm diver (patch 1)
- omit probe deffered warning on all drivers (patch 5)
- update drm and clk bindings (patch 6 and 7)
- put mmsys clock part in dts child node of mmsys. Only done
for HW where no dts backport compatible breakage is expected
(either DRM driver not yet implemented or no HW available to
the public) (patch 9 to 12)

Changes in v4:
- use platform device to probe clock driver
- add Acked-by CK Hu for the probe deferred patch

Changes in v3:
- fix kconfig typo (shame on me)
- delete __initconst from mm_clocks as converted to a platform driver

Changes in v2:
- add binding documentation
- ddp: use regmap_update_bits
- ddp: ignore EPROBE_DEFER on clock probing
- mfd: delete mmsys_private
- add Reviewed-by and Acked-by tags

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b68837ea02b3..68605dedf997 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -125,6 +125,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.ext_path = mt2701_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
 	.shadow_register = true,
+	.clk_drv_name = "clk-mt2701-mm",
 };
 
 static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
@@ -134,6 +135,7 @@ static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
 	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
 	.third_path = mt2712_mtk_ddp_third,
 	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+	.clk_drv_name = "clk-mt2712-mm",
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
@@ -141,6 +143,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
 	.ext_path = mt8173_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	.clk_drv_name = "clk-mt8173-mm",
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
@@ -437,6 +440,24 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	private->data = of_device_get_match_data(dev);
 
+	/*
+	 * MMSYS includes apart from components management a block providing
+	 * clocks for the subsystem. We probe this clock driver via a platform
+	 * device.
+	 */
+	if (private->data->clk_drv_name) {
+		private->clk_dev = platform_device_register_data(dev,
+						private->data->clk_drv_name, -1,
+						NULL, 0);
+
+		if (IS_ERR(private->clk_dev)) {
+			dev_err(dev, "failed to register %s platform device\n",
+				private->data->clk_drv_name);
+
+			return PTR_ERR(private->clk_dev);
+		}
+	}
+
 	private->config_regs = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(private->config_regs))
 		return PTR_ERR(private->config_regs);
@@ -544,6 +565,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
 		of_node_put(private->comp_node[i]);
 
+	if (private->clk_dev)
+		platform_device_unregister(private->clk_dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 03201080688d..15652264c233 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -29,11 +29,13 @@ struct mtk_mmsys_driver_data {
 	unsigned int third_len;
 
 	bool shadow_register;
+	const char *clk_drv_name;
 };
 
 struct mtk_drm_private {
 	struct drm_device *drm;
 	struct device *dma_dev;
+	struct platform_device *clk_dev;
 
 	unsigned int num_pipes;
 
-- 
2.24.1

