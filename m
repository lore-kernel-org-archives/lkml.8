Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5AC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF44620767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="APVIBb0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ms44j6wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgICIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:04:49 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39287 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728430AbgICICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B0086B84;
        Thu,  3 Sep 2020 04:02:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=8CjhO/oufe9mi
        iuIeroM+ywrY892Ab6UeAx03HtursY=; b=APVIBb0kwprBJkq9p21ofQoKMiAJl
        0VwIv7fJAav6M3/Pc8GgyLENntY1d4Z+amaQC58PYKauOPrD33T1MhdwD25t5iOc
        Rv5V1dy2oIh/11FOMTNa7TSRNhQneF0LYB9UQiNcUe21wELTjbrXatsVZC0JDbeY
        NAQ9+s68rOrA40pHqi0wZUFOK9ZItC0kEPx1WLO18RnABfqWk3B5T/v8zx93Zv4r
        VqxL7uP3m5IYc+FgoVpi+mkoxjGHuR8l4FTqlNADfbEyG/ClApv+1ll25ZzuwqCk
        jY+pFTOO/7DWiyNFNw7oSG3k0QTpFVUDd/S7L9pup2fvdye2NKH0nY5Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8CjhO/oufe9miiuIeroM+ywrY892Ab6UeAx03HtursY=; b=Ms44j6wG
        5I7E8/myrnjYOX1HJ/t2J9B0bQCu4U2iSIYJx22UBWyIsNR+nYrvddENox9eXJn8
        xoxe/twpRoiCtTY1wTv9yhr/vnINzubsE1yya5ujHH16BrAHBrpnvOU60mqVoRBq
        inqjSw58Vvt5CiF9szElzkomsNfn574vlvTimgwt1xpjyW31fK235wIE06RJJrLO
        GAeoJcSUMBoTHs+UhRlVS2aEAgpbM3J4OZ/YgpdhKUJhQqJAtEIPJJlkRZaeKIvT
        tj5uV4vMbknZu3u0W4JUfTQrY9eMXgpYwacN1x6DpA1bnSAYRolja7AguDZuVTTR
        ykN9n0UZC6gERA==
X-ME-Sender: <xms:IaNQXzRso1Bc5g08hSCge7vt7EaoAJ4Tipf1J-P-l5UsgJp1_OWEeA>
    <xme:IaNQX0zmsUgU_KtBVpQ5QZfoux5vRQmUuiDBgetN1NLPGqVzrV9Se6MeVmMNs_Rqi
    9OWy9YWcB244jUkIPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefvd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IaNQX42uF_Y-2dFUO35aQIVH_jRbZjtmijM0W_6eVTXsxroW5vi8GA>
    <xmx:IaNQXzBsx4ME8ovjDEwqW2achlCOCtRLxWZVGF6xVPI-g8U9bVjUXg>
    <xmx:IaNQX8j0n9-uZ_NpcQhDf6XUvpDhZ0u76Ap613YGhX9a5B7SEqN7lQ>
    <xmx:IaNQX7rqly4r12R4joof_dvBZixz1SKRoK3l8TEmnLakanDfZ8QfsjkZByE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA5AD3280064;
        Thu,  3 Sep 2020 04:02:40 -0400 (EDT)
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
Subject: [PATCH v5 34/80] drm/vc4: crtc: Move the CRTC disable out
Date:   Thu,  3 Sep 2020 10:01:06 +0200
Message-Id: <5288fb72ed2da643085dce1bc7f6d6f656bf176e.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need to reuse the part that disables the HVS and PixelValve during
boot too, so let's create a separate function.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 00b2c2b011d1..4156c5f66877 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -384,20 +384,14 @@ static void require_hvs_enabled(struct drm_device *dev)
 		     SCALER_DISPCTRL_ENABLE);
 }
 
-static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
-				    struct drm_crtc_state *old_state)
+static int vc4_crtc_disable(struct drm_crtc *crtc, unsigned int channel)
 {
-	struct drm_device *dev = crtc->dev;
-	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
 	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 	int ret;
 
-	require_hvs_enabled(dev);
-
-	/* Disable vblank irq handling before crtc is disabled. */
-	drm_crtc_vblank_off(crtc);
-
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) & ~PV_VCONTROL_VIDEN);
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
@@ -421,15 +415,31 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	 */
 	mdelay(20);
 
-	if (vc4_encoder->post_crtc_disable)
+	if (vc4_encoder && vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
 	vc4_crtc_pixelvalve_reset(crtc);
-	vc4_hvs_atomic_disable(crtc, old_state);
+	vc4_hvs_stop_channel(dev, channel);
 
-	if (vc4_encoder->post_crtc_powerdown)
+	if (vc4_encoder && vc4_encoder->post_crtc_powerdown)
 		vc4_encoder->post_crtc_powerdown(encoder);
 
+	return 0;
+}
+
+static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_crtc_state *old_state)
+{
+	struct vc4_crtc_state *old_vc4_state = to_vc4_crtc_state(old_state);
+	struct drm_device *dev = crtc->dev;
+
+	require_hvs_enabled(dev);
+
+	/* Disable vblank irq handling before crtc is disabled. */
+	drm_crtc_vblank_off(crtc);
+
+	vc4_crtc_disable(crtc, old_vc4_state->assigned_channel);
+
 	/*
 	 * Make sure we issue a vblank event after disabling the CRTC if
 	 * someone was waiting it.
-- 
git-series 0.9.1
