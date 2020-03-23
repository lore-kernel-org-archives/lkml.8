Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA28820736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCWOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:52:51 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:37190 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgCWOwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:52:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BCAB6FB03;
        Mon, 23 Mar 2020 15:52:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F-X3cVK12ioL; Mon, 23 Mar 2020 15:52:47 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D9654412BE; Mon, 23 Mar 2020 15:52:46 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mxsfb: Make supported modifiers explicit
Date:   Mon, 23 Mar 2020 15:52:46 +0100
Message-Id: <26877532e272c12a74c33188e2a72abafc9a2e1c.1584973664.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrast to other display controllers on imx like DCSS and ipuv3
lcdif/mxsfb does not support detiling e.g. vivante tiled layouts.
Since mesa might assume otherwise make it explicit that only
DRM_FORMAT_MOD_LINEAR is supported.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 762379530928..fc71e7a7a02e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -73,6 +73,11 @@ static const uint32_t mxsfb_formats[] = {
 	DRM_FORMAT_RGB565
 };
 
+static const uint64_t mxsfb_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 static struct mxsfb_drm_private *
 drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
 {
@@ -334,8 +339,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 	}
 
 	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
-			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
-			mxsfb->connector);
+			mxsfb_formats, ARRAY_SIZE(mxsfb_formats),
+			mxsfb_modifiers, mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
 		goto err_vblank;
-- 
2.23.0

