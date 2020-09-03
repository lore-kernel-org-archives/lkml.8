Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38565C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F264E20897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="P5nNvzy+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZL1Erjk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgICIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:48 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36545 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728508AbgICIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2025BCE3;
        Thu,  3 Sep 2020 04:03:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=sW0IXFyVTksJ7
        XZtB1TnvyE6Xp2pDKmTIaJ2ylm37Wo=; b=P5nNvzy+vXoszCFj10CXmKgE9Wz6Z
        h8cvPn7OScOryfwH+rLq+Go5SGT0guGNFB7im0pBzk2/jvL8IL9mBUAk2wdXCgzv
        C2VikJBhsaQq6cbdYzo0tOJYdr781wIZ8+xV70rx5YGITKb66JTxvgYFL3FxU+bv
        wSOt45zYqH55+XpkA1eyPpSEPK0XPQdu8b1D8GlxGp9fCwILABGiiOO/yRJUcG+C
        hAg7SupzDH3DEJj8Cjfyhu4nxw3N5beB+Wvgk6cGRnQguDwna6Sng5K1Y9Xvd67o
        slJTrYAU9LGKMOfOtkU6lEHV67aOosMPDIFl7ck3gWvesZjUSZ6sy/iBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=sW0IXFyVTksJ7XZtB1TnvyE6Xp2pDKmTIaJ2ylm37Wo=; b=ZL1Erjk6
        E3B0hlFyc9AgkitRqomy4RtC5jUAYgeBG1Bhn7i60YaFUuzSGgmrVrQgmmxfjEn8
        Is3MzLnO8atnBFCD3avTJP6afuzhv2yw5KUVlQquGHgN84u3wZ77N9e4hbbxdnBJ
        HO2H7/4ZayHAFI+sacdGHEDll4h+aIC5VP45eDj4d2E2Oht1DaglbaQM95br2/ZQ
        xm6G061Jh7ZgiunqOCPyWErbaAqyk677i9AyKgVzHVunuam0R/4ILs1FJkSXP6SX
        WZy47fGsLGwB3twEbE56DPUp61kTgdQNT8AXHaxmosGwt4GXqzcJo982rWaoX3Ax
        kmLmOGg/+TeyBg==
X-ME-Sender: <xms:WKNQX6e-hN_Y_APZ22Q13X1y2ejI2TUdowjnR-Ft40u4IcBxFMhzRw>
    <xme:WKNQX0NTuUr4etWFDKkYvlJwiAN00g0jkalPiYyy6EmY45qTGbCjsoy_sAZNJlxgq
    yg5hCEH2OgIj1CJ-FI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeeije
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WKNQX7j92iQ8rS6G-PazzIiffujVuyiM7dSp0iiQJs3QwWuNUhdInA>
    <xmx:WKNQX3_DtCuckoXhtLD1ySQfFq-CPm2aCTJGS-uFfHPIeRtBTBze8Q>
    <xmx:WKNQX2sb85rE0urKazteszwkcySCd_fZVay1XHEzIuaROgsK0RYEpg>
    <xmx:WKNQX-H36cyzZhHtSZIZejU9r4gzSbjua9x2bSbHXXqqgi9kBrrfeu0JbMU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BE023060062;
        Thu,  3 Sep 2020 04:03:36 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 73/80] drm/vc4: hdmi: Do the VID_CTL configuration at once
Date:   Thu,  3 Sep 2020 10:01:45 +0200
Message-Id: <08e7ebb605a560fcc149b69b4af52753a7870b2f.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VID_CTL setup is done in several places in the driver even though it's
not really required. Let's simplify it a bit to do the configuration in one
go.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 128d33c8c2c3..8bf69cafdd7e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -428,10 +428,6 @@ static void vc4_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
 
 	HDMI_WRITE(HDMI_VERTB0, vertb_even);
 	HDMI_WRITE(HDMI_VERTB1, vertb);
-
-	HDMI_WRITE(HDMI_VID_CTL,
-		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
-		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 }
 
 static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
@@ -520,8 +516,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder)
 	if (vc4_hdmi->variant->phy_init)
 		vc4_hdmi->variant->phy_init(vc4_hdmi, mode);
 
-	HDMI_WRITE(HDMI_VID_CTL, 0);
-
 	HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 		   HDMI_READ(HDMI_SCHEDULER_CONTROL) |
 		   VC4_HDMI_SCHEDULER_CONTROL_MANUAL_FORMAT |
@@ -555,15 +549,19 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder)
 
 static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
 {
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
+	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
+	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
 	int ret;
 
 	HDMI_WRITE(HDMI_VID_CTL,
-		   HDMI_READ(HDMI_VID_CTL) |
 		   VC4_HD_VID_CTL_ENABLE |
 		   VC4_HD_VID_CTL_UNDERFLOW_ENABLE |
-		   VC4_HD_VID_CTL_FRAME_COUNTER_RESET);
+		   VC4_HD_VID_CTL_FRAME_COUNTER_RESET |
+		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
+		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 
 	if (vc4_encoder->hdmi_monitor) {
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
-- 
git-series 0.9.1
