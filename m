Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3986BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2048120786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHSJ0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:26:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgHSJZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:25:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7F74EB90568D6566459;
        Wed, 19 Aug 2020 17:25:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 17:25:40 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 2/4] drm/hisilicon: Use drm_err instead of DRM_ERROR in hibmc_drm_vdac
Date:   Wed, 19 Aug 2020 17:23:32 +0800
Message-ID: <1597829014-39942-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
References: <1597829014-39942-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_err instead of DRM_ERROR in hibmc_drm_vdac

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index ed12f61..376a05d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -85,7 +85,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_encoder_init(dev, encoder, &hibmc_encoder_funcs,
 			       DRM_MODE_ENCODER_DAC, NULL);
 	if (ret) {
-		DRM_ERROR("failed to init encoder: %d\n", ret);
+		drm_err(dev, "failed to init encoder: %d\n", ret);
 		return ret;
 	}
 
@@ -94,7 +94,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_connector_init(dev, connector, &hibmc_connector_funcs,
 				 DRM_MODE_CONNECTOR_VGA);
 	if (ret) {
-		DRM_ERROR("failed to init connector: %d\n", ret);
+		drm_err(dev, "failed to init connector: %d\n", ret);
 		return ret;
 	}
 	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
-- 
2.7.4

