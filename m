Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F96C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244AE21582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgIKBpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:45:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgIKBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:45:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7452C3F805FEE07E17DD;
        Fri, 11 Sep 2020 09:45:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 09:44:56 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <agx@sigxcpu.org>, <laurentiu.palcu@oss.nxp.com>,
        <l.stach@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] drm/imx: fix unused but set variable warnings
Date:   Fri, 11 Sep 2020 09:44:14 +0800
Message-ID: <20200911014414.4663-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unused but set variable warning building with `make W=1`:

drivers/gpu/drm/imx/dcss/dcss-plane.c:270:6: warning:
 variable ‘pixel_format’ set but not used [-Wunused-but-set-variable]
  u32 pixel_format;
      ^~~~~~~~~~~~

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/gpu/drm/imx/dcss/dcss-plane.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
index 961d671f171b..e13652e3a115 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
@@ -267,7 +267,6 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
 	struct dcss_plane *dcss_plane = to_dcss_plane(plane);
 	struct dcss_dev *dcss = plane->dev->dev_private;
 	struct drm_framebuffer *fb = state->fb;
-	u32 pixel_format;
 	struct drm_crtc_state *crtc_state;
 	bool modifiers_present;
 	u32 src_w, src_h, dst_w, dst_h;
@@ -277,7 +276,6 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
 	if (!fb || !state->crtc || !state->visible)
 		return;
 
-	pixel_format = state->fb->format->format;
 	crtc_state = state->crtc->state;
 	modifiers_present = !!(fb->flags & DRM_MODE_FB_MODIFIERS);
 
-- 
2.17.1

