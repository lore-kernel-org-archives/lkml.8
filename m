Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F27C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FDD206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GpnxllrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbgIHQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbgIHQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:14 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B99C0612F1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:56:02 -0700 (PDT)
Received: from trochilidae.toradex.int (31-10-206-124.static.upc.ch [31.10.206.124])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6BFD55C4CAB;
        Tue,  8 Sep 2020 14:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1599569760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=qxfcotVSiPgSlKPB5rZ5xXDXpnK6trtv7RzFevjZqVc=;
        b=GpnxllrNBTG+jCZMxIjRiuwMkKDhmunZ5oYrsTtVr2FjWZ8FBeSR3aOGSCi7oxp+4zOEZD
        YK2pCIkK0Kx+ZXHdzzFoKzQv6R7cIYiuV7+Ho/qw0lMc2tEpjklLwNUcVrnZ/1kNm0HRUQ
        XuSQkc1BYcXovM4hqzcwycbL+krdrP0=
From:   Stefan Agner <stefan@agner.ch>
To:     marex@denx.de, stefan@agner.ch
Cc:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tomi.valkeinen@ti.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: mxsfb: check framebuffer pitch
Date:   Tue,  8 Sep 2020 14:55:58 +0200
Message-Id: <20200908125558.256843-1-stefan@agner.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdif IP does not support a framebuffer pitch (stride) other than
framebuffer width. Check for equality and reject the framebuffer
otherwise.

This prevents a distorted picture when using 640x800 and running the
Mesa graphics stack. Mesa tires to use a cache aligned stride, which
leads at that particular resolution to width != stride. Currently
Mesa has no fallback behavior, but rejecting this configuration allows
userspace to handle the issue correctly.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 8c549c3931af..fa6798d21029 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
@@ -81,8 +82,26 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
 		clk_disable_unprepare(mxsfb->clk_axi);
 }
 
+static struct drm_framebuffer *
+mxsfb_fb_create(struct drm_device *dev, struct drm_file *file_priv,
+		  const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	const struct drm_format_info *info;
+
+	info = drm_get_format_info(dev, mode_cmd);
+	if (!info)
+		return ERR_PTR(-EINVAL);
+
+	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
+		dev_dbg(dev->dev, "Invalid pitch: fb width must match pitch\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return drm_gem_fb_create(dev, file_priv, mode_cmd);
+}
+
 static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
-	.fb_create		= drm_gem_fb_create,
+	.fb_create		= mxsfb_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
-- 
2.28.0

