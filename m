Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA36206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838765;
	bh=zHf77lVLfTNqIaF9sRrNbaiO3qYSqs9jubzcWDx1ovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYDRdrcHdm15usR64qv88/jypBoeWAlvx6+O0o7fM5pG1TgA3PAWBvxG7H2wWuBDu
	 87lxd+eQqg1DGGOoZoUa9BEl9ZL1aVvP6eWPAUuxxBfRbvHGdfN7Lz6BfX7SYzmysW
	 8MDoQCj6iIVftgQaqn33rEE0GrGY+Ct6JBVDxUcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHSMGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgHSLrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:43 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093342310C;
        Wed, 19 Aug 2020 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837583;
        bh=zHf77lVLfTNqIaF9sRrNbaiO3qYSqs9jubzcWDx1ovA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqYhiCf4WYrkZPL2mxfY4LFdgDMcf0IqacgkYiFAinHtvsLLw3nGvlRlGBuq2tExC
         sceu3WD8kEwqxZtiHI9Du/wNwhm5UOIo8sSpTykX26dS1KpIiBGQ9TGW+NSCHCDqFT
         NvrVXGF9PpS3l24SHgKq/HPA5yjH1dbBZKrVZ1yM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXt-00Eubj-0d; Wed, 19 Aug 2020 13:46:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 37/49] staging: hikey9xx/gpu: don't use iommu code
Date:   Wed, 19 Aug 2020 13:46:05 +0200
Message-Id: <0230300d41aaa80f27aeeeafe585b8d19b4d5146.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this driver apparently supports both IOMMU and no-IOMMU
access, it always enable the IOMMU via some code, at the
downstream version.

Apparently, the downstream iommu is there just to get the
physical address of the logical IOMMU address. Based on
the downstream code, it sounds that the IOMMU would be an
specific one for the GPU.

Anyway, right now, the driver is set to not use the IOMMU
at all. So, let's comment out the code which allocates
IOMMU pages, and the code that would try to use it to
setup a register, as, without the IOMMU, this would cause
an OOPS.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c      | 12 ++++++++++--
 .../hikey9xx/gpu/kirin9xx_drm_overlay_utils.c        | 10 ++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index e3bb0a32dddf..546da775f2fb 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -769,6 +769,14 @@ static int dss_plane_init(struct drm_device *dev, struct dss_plane *aplane,
 
 static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
 {
+#if 0
+/*
+ * FIXME:
+ *
+ * Right now, the IOMMU support is actually disabled. See the caller of
+ * hisi_dss_smmu_config(). Yet, if we end enabling it, this should be
+ * ported to use io-pgtable directly.
+ */
 	struct device *dev = NULL;
 
 	dev = &pdev->dev;
@@ -781,7 +789,7 @@ static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx
 	}
 
 	iommu_attach_device(ctx->mmu_domain, dev);
-
+#endif
 	return 0;
 }
 
@@ -934,7 +942,7 @@ static int dss_dts_parse(struct platform_device *pdev, struct dss_hw_ctx *ctx)
 			 DSS_MAX_PXL0_CLK_144M, (uint64_t)clk_get_rate(ctx->dss_pxl0_clk));
 	}
 
-	/* regulator enable */
+	/* enable IOMMU */
 	dss_enable_iommu(pdev, ctx);
 
 	return 0;
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
index 9113937478f5..6b6774b8d903 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
@@ -1333,8 +1333,17 @@ static void hisi_dss_mif_on(struct dss_hw_ctx *ctx)
 	set_reg(dss_base + MIF_CH11_OFFSET + MIF_CTRL0, 0x1, 1, 0);
 }
 
+
 void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
 {
+#if 0
+/*
+ * FIXME:
+ *
+ * Right now, the IOMMU support is actually disabled. See the caller of
+ * hisi_dss_smmu_config(). Yet, if we end enabling it, this should be
+ * ported to use io-pgtable directly.
+ */
 	void __iomem *smmu_base;
 	struct iommu_domain_data *domain_data = NULL;
 	u32 phy_pgd_base = 0;
@@ -1374,6 +1383,7 @@ void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
 	phy_pgd_base = (uint32_t)(domain_data->phy_pgd_base);
 	DRM_DEBUG("fama_phy_pgd_base = %llu, phy_pgd_base =0x%x \n", fama_phy_pgd_base, phy_pgd_base);
 	set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
+#endif
 }
 
 void hisifb_dss_on(struct dss_hw_ctx *ctx)
-- 
2.26.2

