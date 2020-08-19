Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3971205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838756;
	bh=U1Fn6R3HH/nCSOGEI8Nq0OF9Epnu4lU5x3hp5T2IvBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIxx7z59mue7ooAo4LHb4JegtPTSvX1c1oZbJC4c9ORgVkOCvzRByrsrDbjwBw1Vq
	 ssj11m7cNPRSG2ubzuvUZxfXTqWveaG5XZjhgIzmdDODQOjgwmdY/zAD57oKHcVOOx
	 ytfVAY9KCTtFjRW2pqeuXNITtssOyaq7D//7yWT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHSMFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgHSLrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:43 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE2922D75;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=U1Fn6R3HH/nCSOGEI8Nq0OF9Epnu4lU5x3hp5T2IvBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TileK6/o3AqFkzLVtx5iczylaFoJqwGC1tfmpvA2PoRr6hsRwO+q4FnCKsGcLfhRV
         tecOMMRhwEm0m7Z7zpBHroLLZHKmeRooJN4h45vN2vrufJF1G9Fvk4DGtuaaRFCjwQ
         pKxudLioPgVDcxiltIqqWJl0XVBo4gFI2/lrv+9w=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubL-J6; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Liuyao An <anliuyao@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/49] staging: hikey9xx/gpu: get rid of iommu_format
Date:   Wed, 19 Aug 2020 13:46:00 +0200
Message-Id: <22b04b229a090821671eafaec635d4feff205afb.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those aren't needed anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h | 1 -
 drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h | 1 -
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
index a0f7732063a3..7b9da796a671 100644
--- a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
@@ -3087,7 +3087,6 @@ struct dss_hw_ctx {
 	struct iommu_domain *mmu_domain;
 	struct ion_client *ion_client;
 	struct ion_handle *ion_handle;
-	struct iommu_map_format iommu_format;
 	char __iomem *screen_base;
 	unsigned long smem_start;
 	unsigned long screen_size;
diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index 84293d2d462e..9c1b62831733 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -4100,7 +4100,6 @@ struct dss_hw_ctx {
 	struct iommu_domain *mmu_domain;
 	struct ion_client *ion_client;
 	struct ion_handle *ion_handle;
-	struct iommu_map_format iommu_format;
 	char __iomem *screen_base;
 	unsigned long smem_start;
 	unsigned long screen_size;
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
index 261259cb8f5f..54b4ddc2fe42 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
@@ -18,7 +18,6 @@
 #include <drm/drm_print.h>
 
 #include <linux/iommu.h>
-#include <linux/hisi/hisi-iommu.h>
 
 #define MAX_CRTC	2
 
@@ -41,7 +40,6 @@ struct kirin_fbdev {
 
 	struct ion_client *ion_client;
 	struct ion_handle *ion_handle;
-	struct iommu_map_format iommu_format;
 	void *screen_base;
 	unsigned long smem_start;
 	unsigned long screen_size;
-- 
2.26.2

