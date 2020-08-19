Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD74C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EF4206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838664;
	bh=FpfLqTZVGeSp8MM2Pkt3e1EBtQJ47pB5nXQ5ggNPs24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q313CZde1zHw3XVd9zHP97pEqqX9PuBTEFyEW7lcetJxbXs0M1xzZV1Bs9BKMPe0v
	 bWXEjGaVNcPwGau5ZDiOkMQ/nDNLKkG8gPlS3vgSYdt1hgmZMSgxf2U9x2z1mJIgxf
	 dEPjDoe+zvhnm5L+q4gOi+oaRy5z6x3jCQ229GuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgHSMET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgHSLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:48:58 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7F62311D;
        Wed, 19 Aug 2020 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837583;
        bh=FpfLqTZVGeSp8MM2Pkt3e1EBtQJ47pB5nXQ5ggNPs24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrRCC8dhYwIRWv2oe6nSuz0KoupARv8q0VsVrzsultzPiVOgnadXlAHnekjl4l67d
         HkwG7/9/N9ibqukhgRCRbiGxoyHDVpX/uWTa4frM/NYuphkaeBJfiWgbBlZWaYaRsv
         TRvkEQphTmMWEnmW/E3sTWXqRKRDgorMg8/fYXaI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXt-00Eubt-5a; Wed, 19 Aug 2020 13:46:21 +0200
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
        Chen Feng <puck.chen@hisilicon.com>,
        Liuyao An <anliuyao@huawei.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 41/49] staging: hikey9xx/gpu: get rid of some unused data
Date:   Wed, 19 Aug 2020 13:46:09 +0200
Message-Id: <024a251bfc6c10f11e09add5fe84cfcc924d7751.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some things inside struct dss_hw_ctx that are unused.
Get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h | 2 --
 drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h | 3 ---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c | 2 --
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
index cd248bf15503..ae4eaae14429 100644
--- a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
@@ -3081,8 +3081,6 @@ struct dss_hw_ctx {
 	ktime_t vsync_timestamp_prev;
 
 	struct iommu_domain *mmu_domain;
-	struct ion_client *ion_client;
-	struct ion_handle *ion_handle;
 	char __iomem *screen_base;
 	unsigned long smem_start;
 	unsigned long screen_size;
diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index aeae3720c889..4751b8b6423c 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -4068,12 +4068,9 @@ struct dss_hw_ctx {
 	ktime_t vsync_timestamp_prev;
 
 	struct iommu_domain *mmu_domain;
-	struct ion_client *ion_client;
-	struct ion_handle *ion_handle;
 	char __iomem *screen_base;
 	unsigned long smem_start;
 	unsigned long screen_size;
-	struct dss_smmu smmu;
 };
 
 struct dss_clk_rate {
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index 292e14d2edf5..6792ac6fa8dc 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -976,8 +976,6 @@ static int dss_drm_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	ctx->ion_client = NULL;
-	ctx->ion_handle = NULL;
 	ctx->screen_base = 0;
 	ctx->screen_size = 0;
 	ctx->smem_start = 0;
-- 
2.26.2

