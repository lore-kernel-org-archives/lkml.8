Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E555C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB6120658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Ul+dDC2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OedseH35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBXJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:55 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37219 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbgBXJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id D4882637;
        Mon, 24 Feb 2020 04:10:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=w6FfCXj5pf1st
        /ftBzPSP5POM9VrmGJqzyT/GSrYGyE=; b=Ul+dDC2ECLueg2dcweK/LNM97qa4j
        vEWS+Cpf34CYxf6BCVn0KKNg2qk3oRJsryrZ0NI3mp+6VoEkQzAOrmnrNGBKjU4a
        X9yCV6tuqKI9XPNyP5oEnixDVPHeQEcyW2+MQj4fkjGruhc80s9ige6eRQVKXgvB
        Am7DgxkGOPT3T5EB7DHKCC5Na5ZoLmV0p3i+GA7c9KL0bDD6NgypRLO3KfYkUisg
        5rEFBKqzv1WuYfeZ8j2v0EIzGCK9hkzn1UbgQGhNr3IGPjIF10Tfx927H9hTLUvL
        UA8o9mU7qm7HxP2dE2i/aoy5jvJhOmyithwenU4/bItlH8NguPxfbKUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w6FfCXj5pf1st/ftBzPSP5POM9VrmGJqzyT/GSrYGyE=; b=OedseH35
        FEK+475okH+A/8quGXyYVTjsLwNr/3CGrraslE7ION1XGRZ6jLQchOHu+ivMGEgG
        pJ74eP5wjygcxMBHyOuanBTUIF3fnhrpKG7jmmsxplHleYhCbhtroGbKNYxXEwbi
        rj7LQuOGOdgAt3JtTCcxZZ2FovoSPsiBhXb8NXdU8PWeN/jz/RPf3N/8HWLq9KDL
        /3JhUlFFboG3U/qNpCsk/X6Eq0erZ4WaajSEJamJICPYoV/1Cmwxpxp7k6YBIYeI
        nkdBxWvc21euXyTWycHWXMNDhfBtPXcHVE+d22Kh6zwsTqz0sAcTzL7bLdrAG52F
        /SCI/nPotfmF6A==
X-ME-Sender: <xms:EJNTXoQ4ACB1ygQ--HUvWgT9TGy2VPchOroVaSLUWaaIctqJiv6jHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:EJNTXhd4MXFXT5Pf2mPG5kiezWQQfTT-XKY4JXZs-IOCPNJqNHLWFQ>
    <xmx:EJNTXgglcecs_r3MeR_3kvho8jZCef1RdIgJI7GeZg30_8kURUyanA>
    <xmx:EJNTXs87_BPhG9icEHFBYmIsYkf3tJbRtdwViNs3BWkijmCAHpuF5Q>
    <xmx:EJNTXjcb6KeH4rEj_4-s2j8rymCTl1TKV5TawA5ffYoYyE-lbR9HqEqARC8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21BBA3060FCB;
        Mon, 24 Feb 2020 04:10:40 -0500 (EST)
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
Subject: [PATCH 77/89] drm/vc4: hdmi: Add a CSC setup callback
Date:   Mon, 24 Feb 2020 10:07:19 +0100
Message-Id: <a73b3d00759a1a9a84ac485d111e2ddbe247d9ed.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the previous patches, the CSC setup is slightly different in
the BCM2711 than in the previous generations. Let's add a callback for it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 71 ++++++++++++++++++++---------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  3 +-
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 50d69c74c5c4..405019118a20 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -336,6 +336,41 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
 		DRM_ERROR("Failed to release power domain: %d\n", ret);
 }
 
+static void vc4_hdmi_csc_setup(struct vc4_hdmi *vc4_hdmi, bool enable)
+{
+	u32 csc_ctl;
+
+	csc_ctl = VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
+				VC4_HD_CSC_CTL_ORDER);
+
+	if (enable) {
+		/* CEA VICs other than #1 requre limited range RGB
+		 * output unless overridden by an AVI infoframe.
+		 * Apply a colorspace conversion to squash 0-255 down
+		 * to 16-235.  The matrix here is:
+		 *
+		 * [ 0      0      0.8594 16]
+		 * [ 0      0.8594 0      16]
+		 * [ 0.8594 0      0      16]
+		 * [ 0      0      0       1]
+		 */
+		csc_ctl |= VC4_HD_CSC_CTL_ENABLE;
+		csc_ctl |= VC4_HD_CSC_CTL_RGB2YCC;
+		csc_ctl |= VC4_SET_FIELD(VC4_HD_CSC_CTL_MODE_CUSTOM,
+					 VC4_HD_CSC_CTL_MODE);
+
+		HDMI_WRITE(HDMI_CSC_12_11, (0x000 << 16) | 0x000);
+		HDMI_WRITE(HDMI_CSC_14_13, (0x100 << 16) | 0x6e0);
+		HDMI_WRITE(HDMI_CSC_22_21, (0x6e0 << 16) | 0x000);
+		HDMI_WRITE(HDMI_CSC_24_23, (0x100 << 16) | 0x000);
+		HDMI_WRITE(HDMI_CSC_32_31, (0x000 << 16) | 0x6e0);
+		HDMI_WRITE(HDMI_CSC_34_33, (0x100 << 16) | 0x000);
+	}
+
+	/* The RGB order applies even when CSC is disabled. */
+	HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
+}
+
 static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
@@ -359,7 +394,6 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 					mode->crtc_vsync_end -
 					interlaced,
 					VC4_HDMI_VERTB_VBP));
-	u32 csc_ctl;
 	int ret;
 
 	ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
@@ -430,41 +464,19 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 		 (vsync_pos ? 0 : VC4_HD_VID_CTL_VSYNC_LOW) |
 		 (hsync_pos ? 0 : VC4_HD_VID_CTL_HSYNC_LOW));
 
-	csc_ctl = VC4_SET_FIELD(VC4_HD_CSC_CTL_ORDER_BGR,
-				VC4_HD_CSC_CTL_ORDER);
-
 	if (vc4_encoder->hdmi_monitor &&
-	    drm_default_rgb_quant_range(mode) ==
-	    HDMI_QUANTIZATION_RANGE_LIMITED) {
-		/* CEA VICs other than #1 requre limited range RGB
-		 * output unless overridden by an AVI infoframe.
-		 * Apply a colorspace conversion to squash 0-255 down
-		 * to 16-235.  The matrix here is:
-		 *
-		 * [ 0      0      0.8594 16]
-		 * [ 0      0.8594 0      16]
-		 * [ 0.8594 0      0      16]
-		 * [ 0      0      0       1]
-		 */
-		csc_ctl |= VC4_HD_CSC_CTL_ENABLE;
-		csc_ctl |= VC4_HD_CSC_CTL_RGB2YCC;
-		csc_ctl |= VC4_SET_FIELD(VC4_HD_CSC_CTL_MODE_CUSTOM,
-					 VC4_HD_CSC_CTL_MODE);
+	    drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
+		if (vc4_hdmi->variant->csc_setup)
+			vc4_hdmi->variant->csc_setup(vc4_hdmi, true);
 
-		HDMI_WRITE(HDMI_CSC_12_11, (0x000 << 16) | 0x000);
-		HDMI_WRITE(HDMI_CSC_14_13, (0x100 << 16) | 0x6e0);
-		HDMI_WRITE(HDMI_CSC_22_21, (0x6e0 << 16) | 0x000);
-		HDMI_WRITE(HDMI_CSC_24_23, (0x100 << 16) | 0x000);
-		HDMI_WRITE(HDMI_CSC_32_31, (0x000 << 16) | 0x6e0);
-		HDMI_WRITE(HDMI_CSC_34_33, (0x100 << 16) | 0x000);
 		vc4_encoder->limited_rgb_range = true;
 	} else {
+		if (vc4_hdmi->variant->csc_setup)
+			vc4_hdmi->variant->csc_setup(vc4_hdmi, false);
+
 		vc4_encoder->limited_rgb_range = false;
 	}
 
-	/* The RGB order applies even when CSC is disabled. */
-	HDMI_WRITE(HDMI_CSC_CTL, csc_ctl);
-
 	HDMI_WRITE(HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
 
 	if (debug_dump_regs) {
@@ -1411,6 +1423,7 @@ struct vc4_hdmi_variant bcm2835_variant = {
 	.num_registers		= ARRAY_SIZE(vc4_hdmi_fields),
 
 	.init_resources		= vc4_hdmi_init_resources,
+	.csc_setup		= vc4_hdmi_csc_setup,
 	.reset			= vc4_hdmi_reset,
 	.phy_init		= vc4_hdmi_phy_init,
 	.phy_disable		= vc4_hdmi_phy_disable,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 9ae4d2c5a4f0..22669e07b22e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -41,6 +41,9 @@ struct vc4_hdmi_variant {
 	/* Callback to reset the HDMI block */
 	void (*reset)(struct vc4_hdmi *vc4_hdmi);
 
+	/* Callback to enable / disable the CSC */
+	void (*csc_setup)(struct vc4_hdmi *vc4_hdmi, bool enable);
+
 	/* Callback to initialize the PHY according to the mode */
 	void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
 			 struct drm_display_mode *mode);
-- 
git-series 0.9.1
