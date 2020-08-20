Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A4BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C55D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QUeJX0UQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgHTLCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:02:34 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:35137 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731691AbgHTK6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:58:47 -0400
IronPort-SDR: YumMd3Db2DoVYT5oyny29iQRFlia7vmB5Ow7/qCj5e4X8AprM1QY2Ylqw+RK6EsWdgYLCML63c
 TH/hS2FVxKYMD/Sd32tD55SuTW240sQEQt/Gwg006lHEqD/iAkT3VVB86tUouKyd764uK0xF5G
 97Rvw9UVaX7doxyrvOSbBTjqEp1ju7n2uHtJWIBzr7PAH3YloVqcVg4MpLl2S2EJZjM5LF1w1E
 C0bqpZNpbsagTFc9DQon0+lVKAQ2ScCcUoooALKORVsf8rZMnQgCbzpiwqB5K2NARfzaSzisSk
 NOo=
X-IronPort-AV: E=Sophos;i="5.76,332,1592863200"; 
   d="scan'208";a="13538551"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Aug 2020 12:58:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 20 Aug 2020 12:58:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 20 Aug 2020 12:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1597921124; x=1629457124;
  h=from:to:cc:subject:date:message-id;
  bh=AvbWJpxiY9x30e5bs5u9l8RtJTLeeuHsRpLnISJKq8c=;
  b=QUeJX0UQYjeqZhS30T6F/Nh1GDOCB7D3kV94RSgABmyFVtGNRsl0vFk8
   Er0zBISu82lrJYhg4tJITRYTii25EWT9jgi1BSNEF05IYEPwlpzJDsTsR
   vwaCK0epivrhA2sW4jmwP8gTbo0XOBwG7ipZGlSTUqHgCZyFnqSBBRjpl
   +SeZzwq/S+YdCTgNGfLJgVtzad6GfT43GOBB1s3aDfCsPVW20dipYyh+s
   klhILVkFzrqecHWKAIdqeMFRjOVFqPjlmz82xDDQX9yI9PUbgugazbtAC
   V4PZYQVFhsqseVwrsi2LYJrytFcKLMXGIbuTfdxzN3lR71JVLpEEFxeOk
   g==;
IronPort-SDR: /cSvPJBux6HC5bgToM0tKrqIFpq8lI8ypZ/WzYQ99QPoGS2VsJOAZowbG/GXWLGW39cSKyegwK
 BWw3oABPLuPhKaQPzoN8ALFvAcCMX5wxVPq0pj3K1WhanQMkVB0V8T5HEGttrGUgIECnwzf49g
 5C2jCkWrRuskW1qTcRTAbtWHvJ4B+bjeMFIGql5Af+8RDTlG8cl9wYbMnvUqcXGBbQU0oI6Sfv
 GGOmCCRf7owMOWAklauvEev3jctKWJRS/oc/DpJ6qrqXb2rXldr6MMIlNnFWBv1ApvJIAAUsHM
 yWg=
X-IronPort-AV: E=Sophos;i="5.76,332,1592863200"; 
   d="scan'208";a="13538550"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Aug 2020 12:58:44 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8F6AF280065;
        Thu, 20 Aug 2020 12:58:44 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] drm: fsl-dcu: enable PIXCLK on LS1021A
Date:   Thu, 20 Aug 2020 12:58:32 +0200
Message-Id: <20200820105832.22331-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PIXCLK needs to be enabled in SCFG before accessing the DCU on LS1021A,
or the access will hang.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25 +++++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index d7dd8ba90e3a..9e5a35e7c00c 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -8,6 +8,7 @@ config DRM_FSL_DCU
 	select DRM_PANEL
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
+	select MFD_SYSCON if SOC_LS1021A
 	help
 	  Choose this option if you have an Freescale DCU chipset.
 	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index abbc1ddbf27f..8a7556655581 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -51,6 +51,23 @@ static const struct regmap_config fsl_dcu_regmap_config = {
 	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
 };
 
+static int fsl_dcu_scfg_config_ls1021a(struct device_node *np)
+{
+	struct regmap *scfg;
+
+	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (IS_ERR(scfg))
+		return PTR_ERR(scfg);
+
+	/*
+	 * For simplicity, enable the PIXCLK unconditionally. It might
+	 * be possible to disable the clock in PM or on unload as a future
+	 * improvement.
+	 */
+	return regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
+				  SCFG_PIXCLKCR_PXCEN);
+}
+
 static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
@@ -70,6 +87,14 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 		return ret;
 	}
 
+	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
+		ret = fsl_dcu_scfg_config_ls1021a(fsl_dev->np);
+		if (ret < 0) {
+			dev_err(dev->dev, "failed to enable pixclk\n");
+			goto done;
+		}
+	}
+
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92..566396013c04 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -160,6 +160,9 @@
 #define FSL_DCU_ARGB4444		12
 #define FSL_DCU_YUV422			14
 
+#define SCFG_PIXCLKCR			0x28
+#define SCFG_PIXCLKCR_PXCEN		BIT(31)
+
 #define VF610_LAYER_REG_NUM		9
 #define LS1021A_LAYER_REG_NUM		10
 
-- 
2.17.1

