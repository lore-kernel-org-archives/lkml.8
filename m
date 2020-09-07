Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A952C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFFA206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgIGMjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:39:08 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:22820 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgIGMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:32:25 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 8CED0482A30;
        Mon,  7 Sep 2020 20:31:37 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] gpu/drm: cleanup coding style a bit
Date:   Mon,  7 Sep 2020 05:31:29 -0700
Message-Id: <20200907123129.27905-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0xMQkkfGBhJThpPVkpOQkJPQ0pDQkxMSU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6Fio4Ij8tGhgpMjwyVjUt
        DUoKFD1VSlVKTkJCT0NKQ0JDSk1NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSU1ITjcG
X-HM-Tid: 0a74688ce2f893bakuws8ced0482a30
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove first assignment to info which is meaningless.
Put the width and higth check first.
This change is to make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index df656366a530..2f5b0c2bb0fe 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -176,8 +176,7 @@ static int framebuffer_check(struct drm_device *dev,
 	int i;
 
 	/* check if the format is supported at all */
-	info = __drm_format_info(r->pixel_format);
-	if (!info) {
+	if (!__drm_format_info(r->pixel_format)) {
 		struct drm_format_name_buf format_name;
 
 		DRM_DEBUG_KMS("bad framebuffer format %s\n",
@@ -186,9 +185,6 @@ static int framebuffer_check(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	/* now let the driver pick its own format info */
-	info = drm_get_format_info(dev, r);
-
 	if (r->width == 0) {
 		DRM_DEBUG_KMS("bad framebuffer width %u\n", r->width);
 		return -EINVAL;
@@ -199,6 +195,9 @@ static int framebuffer_check(struct drm_device *dev,
 		return -EINVAL;
 	}
 
+	/* now let the driver pick its own format info */
+	info = drm_get_format_info(dev, r);
+
 	for (i = 0; i < info->num_planes; i++) {
 		unsigned int width = fb_plane_width(r->width, info, i);
 		unsigned int height = fb_plane_height(r->height, info, i);
-- 
2.28.0

