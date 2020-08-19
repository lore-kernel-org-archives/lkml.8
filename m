Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE602C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05C1205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838786;
	bh=/MsFR5yo97fbYiaXe78ATOp4uwBvaZayZe6OISEBmvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QM0zOYbhRiRfmbBWH8Dg2A9gX/WDVjd0U+T+VvNtIDRzCrckP3mBtcpHQoDYRmVIA
	 VGp+T7UwJBX1Q4/2OZv0Dx3Ymt8ikKwhVmXLRYgQG5FD9unsWM9Thx4PYmXtY4f4xh
	 /7L2lXEpp5Apnvi5bpAyWXg62w1KBeAXRArbQj5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHSMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgHSLrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:43 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED3A22E01;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=/MsFR5yo97fbYiaXe78ATOp4uwBvaZayZe6OISEBmvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMe/JyEHABNJs5BK5WR1YdbBbJBRLkbUKn8W83UpWRHD8sP4WHbny2L3bW6bJvry6
         EwScYlyHiJxNqDp2BRyz5+w/GLXAQf7FNjFAPBbIsA3EOPtq/54KLNZTZt9MqAL0CY
         HCRs504EnPbVxJqkXKrqmFm6zOjsFV/+2tSVRsU0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubS-MD; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liuyao An <anliuyao@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 34/49] staging: hikey9xx/gpu: add support for enable/disable ldo3 regulator
Date:   Wed, 19 Aug 2020 13:46:02 +0200
Message-Id: <625c83a9df80e4ee3df88e920aa7636cc037fbac.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for the DRM to work. Ok, right now, this is
enabled on default fastboot logic, but, as soon as we enable
the proper SPMI driver, such code is needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h       | 4 +---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c | 6 +++---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c       | 8 --------
 drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h      | 4 +---
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index 9c1b62831733..0c6b6eb9dcab 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -41,9 +41,7 @@
 #define FB_ACCEL_PLATFORM_TYPE_ASIC     0x20000000   //ASIC
 
 /* vcc name */
-#define REGULATOR_PDP_NAME	"regulator_dsssubsys"
-#define REGULATOR_MMBUF	"regulator_mmbuf"
-#define REGULATOR_MEDIA_NAME  "regulator_media_subsys"
+#define REGULATOR_PDP_NAME	"ldo3"
 
 /*******************************************************************************
 **
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
index a15c335da026..3b8ff0bdd359 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
@@ -967,13 +967,13 @@ int dpe_regulator_enable(struct dss_hw_ctx *ctx)
 {
 	int ret = 0;
 
-	DRM_INFO("+. \n");
+	DRM_INFO("enabling DPE regulator\n");
 	if (NULL == ctx) {
 		DRM_ERROR("NULL ptr.\n");
 		return -EINVAL;
 	}
 
-	//ret = regulator_enable(ctx->dpe_regulator);
+	ret = regulator_enable(ctx->dpe_regulator);
 	if (ret) {
 		DRM_ERROR(" dpe regulator_enable failed, error=%d!\n", ret);
 		return -EINVAL;
@@ -998,7 +998,7 @@ int dpe_regulator_disable(struct dss_hw_ctx *ctx)
 		dpe_set_common_clk_rate_on_pll0(ctx);
 	#endif
 
-	//ret = regulator_disable(ctx->dpe_regulator);
+	ret = regulator_disable(ctx->dpe_regulator);
 	if (ret != 0) {
 		DRM_ERROR("dpe regulator_disable failed, error=%d!\n", ret);
 		return -EINVAL;
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index 0844bf372ca8..fe5b371734fe 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -873,20 +873,12 @@ static int dss_dts_parse(struct platform_device *pdev, struct dss_hw_ctx *ctx)
 
 	DRM_INFO("dss irq = %d. \n", ctx->irq);
 
-#ifndef DSS_POWER_UP_ON_UEFI
 #if defined (CONFIG_DRM_HISI_KIRIN970)
 	ctx->dpe_regulator = devm_regulator_get(dev, REGULATOR_PDP_NAME);
 	if (!ctx->dpe_regulator) {
 		DRM_ERROR("failed to get dpe_regulator resource! ret=%d.\n", ret);
 		return -ENXIO;
 	}
-
-	ctx->mediacrg_regulator = devm_regulator_get(dev, REGULATOR_MEDIA_NAME);
-	if (!ctx->mediacrg_regulator) {
-		DRM_ERROR("failed to get mediacrg_regulator resource! ret=%d.\n", ret);
-		return -ENXIO;
-	}
-#endif
 #endif
 
 	ctx->dss_mmbuf_clk = devm_clk_get(dev, "clk_dss_axi_mm");
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h b/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
index 0f69af49a355..83e79a4350c1 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
@@ -38,9 +38,7 @@
 #define DEV_NAME_LCD_BKL		"lcd_backlight0"
 
 /* vcc name */
-#define REGULATOR_PDP_NAME	"regulator_dsssubsys"
-#define REGULATOR_MMBUF	"regulator_mmbuf"
-#define REGULATOR_MEDIA_NAME  "regulator_media_subsys"
+#define REGULATOR_PDP_NAME	"ldo3"
 
 
 /* irq name */
-- 
2.26.2

