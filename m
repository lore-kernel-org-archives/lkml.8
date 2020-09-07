Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9799C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD52087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kY1bUQBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgIGQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgIGQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:03:53 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F125C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:03:51 -0700 (PDT)
Received: from trochilidae.toradex.int (31-10-206-124.static.upc.ch [31.10.206.124])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 85A7B5C05BC;
        Mon,  7 Sep 2020 18:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1599494624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=CpO14UbtP2tQcbPOTl7yEqP11tbFzj3QRmh1sYkSBmQ=;
        b=kY1bUQBRzxxuDEzULSy5YKhMgXtt+FppllGokTl2wN7Zrr+5S2pndPiuPfCKvOMbOOTUJ6
        W/LnlT5SqKQsodfi2kerN5OWY2hOdjoaTViz/spqAClFEYcHVfvnSJYzlzza08198AlZ9q
        xv4SMxvXhHv9zAC0dXdQIF7SfBwQqXE=
From:   Stefan Agner <stefan@agner.ch>
To:     marex@denx.de, stefan@agner.ch
Cc:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: mxsfb: check framebuffer pitch
Date:   Mon,  7 Sep 2020 18:03:43 +0200
Message-Id: <20200907160343.124405-1-stefan@agner.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lcdif IP does not support a framebuffer pitch (stride) other than
the CRTC width. Check for equality and reject the state otherwise.

This prevents a distorted picture when using 640x800 and running the
Mesa graphics stack. Mesa tires to use a cache aligned stride, which
leads at that particular resolution to width != stride. Currently
Mesa has no fallback behavior, but rejecting this configuration allows
userspace to handle the issue correctly.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index b721b8b262ce..79aa14027f91 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
 {
 	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
 	struct drm_crtc_state *crtc_state;
+	unsigned int pitch;
+	int ret;
 
 	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
 						   &mxsfb->crtc);
 
-	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
-						   DRM_PLANE_HELPER_NO_SCALING,
-						   DRM_PLANE_HELPER_NO_SCALING,
-						   false, true);
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  false, true);
+	if (ret || !plane_state->visible)
+		return ret;
+
+	pitch = crtc_state->mode.hdisplay *
+		plane_state->fb->format->cpp[0];
+	if (plane_state->fb->pitches[0] != pitch) {
+		dev_err(plane->dev->dev,
+			"Invalid pitch: fb and crtc widths must be the same");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,
-- 
2.28.0

