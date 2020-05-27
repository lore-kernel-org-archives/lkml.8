Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A44B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jTygBAYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y5Rh7V3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbgE0PyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:07 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46947 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390361AbgE0Pv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D84F582126;
        Wed, 27 May 2020 11:51:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=BuUKiGuqk973s
        DDN5AZmCuX6+VtoVQEUzT93MfWaojA=; b=jTygBAYybWdJmfyo8k2Ct9ZWKqqdz
        6cr3EDlE1KyQn90HRJQ4yszEkjDwFHwNGpPuQAe7hEyFnGsktGzjTB9lYB9sPQLA
        mPIaNz4PqhauZYpuwLp1kh0rcJ6yDNKiifb2SSGV2o3Hu6z4PhCcQo1+2A40dWZl
        /natkAQ5x+kJDaNVYwvSIZwMzI8CIHsiEWlXjZ2AmXAILn/MW+rBFwAt8o2uk55j
        vKjoSGK/0UI2ldCMHuzeBFqPq/TeQwAXqz6Z+Q3f/0xcPquuzoshx5tEzZEDfUKm
        DRtyt+3XkKepuvAZZr7Q+FYhy+AA6hoH596QMK3wICNAUt1xylrHWz7aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BuUKiGuqk973sDDN5AZmCuX6+VtoVQEUzT93MfWaojA=; b=y5Rh7V3Z
        qWQN1KSDAMmzPoDI4HrmYqdhSxMjEQFFxyCvXBhX1X4TJkQqJlCkhFbG73UuPPYf
        CohwqFLzxJunDdf4/vytLXKd//rosgtBhI2+bg8uHGk8dip/2PQZqiNGwX/6OlVU
        fn3RUr76Yoe5SPN0cJWpgIlKVtQRzlmScSk/PGuprazeOUAIusAPMigSvqOQxiTj
        ZMigkVijCL7oESAxGsXk8cmwINyriVlrOttj01fcKCWikjUhyBPcVgMZjXYzt7qk
        yKau+41WP0eCWDlQIj2kYLQWvB5N9/KyNEkZGOwDh8ax41J2sqrJtBRDv6QQYcv/
        vhyHdjUs5PAn6A==
X-ME-Sender: <xms:nYzOXjaIKie76PkGruBk1ooHVnpOMbciA11H153PszCsXagxbrgF1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nYzOXiafOpEH5eKHLnoVjZpv8iE2jX9zjsGDa_HihT4zxkRx4yiwXQ>
    <xmx:nYzOXl8_WiMRM6P53D2nuYrzOftXluOEr7iKKfI-QcXk_cZfyjhOtg>
    <xmx:nYzOXprB0zTIQsW7eQg90RFEqoGxtrpiLh6KO98kP70BKgWkrAf5Dg>
    <xmx:nYzOXuI-wqTsJn3Mww78i4EHepYfaI2tkl20Aa1kw1IZeajGZAiHnA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ED1A328005A;
        Wed, 27 May 2020 11:51:57 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 102/105] drm/vc4: hdmi: Switch to blank pixels when disabled
Date:   Wed, 27 May 2020 17:49:12 +0200
Message-Id: <271605b39ee5e9bc7db5ac1d0ed9df6ecc4edc29.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid pixels getting stuck in an unflushable FIFO, we need when
we disable the HDMI controller to switch away from getting our pixels from
the pixelvalve and instead use blank pixels, and switch back to the
pixelvalve when we enable the HDMI controller.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_regs.h |  3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d889a83a0f56..8c9cff9ce216 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -325,6 +325,12 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder)
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 
 	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+
+	HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) |
+		   VC4_HD_VID_CTL_CLRRGB | VC4_HD_VID_CTL_CLRSYNC);
+
+	HDMI_WRITE(HDMI_VID_CTL,
+		   HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_BLANKPIX);
 }
 
 static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
@@ -563,6 +569,9 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder)
 		   (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
 		   (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 
+	HDMI_WRITE(HDMI_VID_CTL,
+		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_BLANKPIX);
+
 	if (vc4_encoder->hdmi_monitor) {
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) |
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 5a3ee2030cff..ce103f925f05 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -723,6 +723,9 @@
 # define VC4_HD_VID_CTL_FRAME_COUNTER_RESET	BIT(29)
 # define VC4_HD_VID_CTL_VSYNC_LOW		BIT(28)
 # define VC4_HD_VID_CTL_HSYNC_LOW		BIT(27)
+# define VC4_HD_VID_CTL_CLRSYNC			BIT(24)
+# define VC4_HD_VID_CTL_CLRRGB			BIT(23)
+# define VC4_HD_VID_CTL_BLANKPIX		BIT(18)
 
 # define VC4_HD_CSC_CTL_ORDER_MASK		VC4_MASK(7, 5)
 # define VC4_HD_CSC_CTL_ORDER_SHIFT		5
-- 
git-series 0.9.1
