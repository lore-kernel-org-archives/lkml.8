Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361EA20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgHNIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:30:31 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:32390 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:30:31 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id C2A404826D4;
        Fri, 14 Aug 2020 16:30:27 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bernard Zhao <bernard@vivo.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] drm/via: reduce no need mutex_lock area
Date:   Fri, 14 Aug 2020 01:30:19 -0700
Message-Id: <20200814083021.8962-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0JNTh1KTRhLSkNLVkpOQkxIQkhDSUxCT0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6Sjo5KT8dCjosSQEOEx4t
        DjIKCxNVSlVKTkJMSEJIQ0lDTklMVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSkNPSjcG
X-HM-Tid: 0a73ec17783893bakuwsc2a404826d4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function via_mem_alloc`s error branch, DRM_ERROR is protected
in the mutex_lock(&dev->struct_mutex) area.
From the code, we see that DRM_ERROR is just an error log print
without any struct element, there is no need to protect this.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/via/via_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_mm.c b/drivers/gpu/drm/via/via_mm.c
index 45cc9e900260..dae1bacd86c1 100644
--- a/drivers/gpu/drm/via/via_mm.c
+++ b/drivers/gpu/drm/via/via_mm.c
@@ -129,9 +129,9 @@ int via_mem_alloc(struct drm_device *dev, void *data,
 	mutex_lock(&dev->struct_mutex);
 	if (0 == ((mem->type == VIA_MEM_VIDEO) ? dev_priv->vram_initialized :
 		      dev_priv->agp_initialized)) {
+		mutex_unlock(&dev->struct_mutex);
 		DRM_ERROR
 		    ("Attempt to allocate from uninitialized memory manager.\n");
-		mutex_unlock(&dev->struct_mutex);
 		return -EINVAL;
 	}
 
-- 
2.26.2

