Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7990C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8311520776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tLSC0/Ub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrBLsC6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgDXPhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:37:50 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44281 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728871AbgDXPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9688F1450;
        Fri, 24 Apr 2020 11:37:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=/KsyQOpfutU4j
        AT75agxrluQ1cWQoNM89G9u2gOdhXQ=; b=tLSC0/UbxSbZKpyPzYyr4uIaj8d5n
        QCQXRhaS+QZ8ncKsz++oAfZA3IeSZJWw63r2/Vrovtv/ZTtNymE4oEcJod1JWwfA
        Ny7/SCUwcEnfvSRJPZh4JIeCyRopDT999hlmL8KB5cYWIQRFg3Mi5dji7qYWT5ZA
        7ruEkUgG0fB+sAvbmVsIfVw2L3N/q/vG/SmBAd++eod0zyhl+7STiwzigxGWZ1Gw
        rh+2Fh14DwmhhZM1CgUOTMlK3TF0lhvJ/xoJNS6B+eqjpGCUumvazOBStggNxRkI
        gwq255uo23d4bynTJHqYFtNl10j6jbTgreIleTDQZH77k9qTQQ35OIIxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/KsyQOpfutU4jAT75agxrluQ1cWQoNM89G9u2gOdhXQ=; b=qrBLsC6l
        YD3zUOpoGZxbt27eVYBWiQ/c77LjoAHvP/397bPupBDGjIkXuE/h/VVhu7SC/4wo
        ymwjqkWmUzzaef/wnFx/67y3hT4ler14vm41ZvSAHmdoOBeJJvKxk5BGlokGxA62
        1xvkePHhcN7PQDthNZ2CsbjXaCbo8q+3AFUn3MVJExK/2yR+qYuhCojjDF7jgwOw
        ymcFzU259RS8Jwme464tUx/yLdVi/67DAkoNSSNyMn2T2Wh0v9Mnjh6i6aIoZEEG
        KLaGOuA/DqI3uXNTo6KXkl2j57/+iwqh+9hXTByFEZYoHlrGjL+M6FwPJbfy4CxJ
        XUSukH5rkvsWow==
X-ME-Sender: <xms:tQejXtbY-WedBrS92KuWQQyhDSK-UJjYHJZSR2BVZE0Y5gJlhbXzsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeejkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tQejXi7BDsVDUJzX0GG2tYxO0Hp8kPZ1GDI8JbFdv1qmZLGZFb-p3Q>
    <xmx:tQejXqy7rya1HutnUC3-Qi2JtsidROuOyEVMmjmFOT5wFtgRpw9AJg>
    <xmx:tQejXh38dWtnPCQpNFUXUqWc8lS1cVSOmnKk05VZRYZihkPZybgS0Q>
    <xmx:tQejXuUDyYHZ56yI8KW5j-9vk5NXsJXtPDkbrFFxa6kL-1DiDDbRvyXLSKo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3110328005E;
        Fri, 24 Apr 2020 11:37:24 -0400 (EDT)
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
Subject: [PATCH v2 88/91] drm/vc4: hdmi: Add audio-related callbacks
Date:   Fri, 24 Apr 2020 17:35:09 +0200
Message-Id: <d2be7532c52a1b4ecd3748e327c1847b918b2e81.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The audio configuration has changed for the BCM2711, with notably a
different parent clock and a different channel configuration.

Make that modular to be able to support the BCM2711.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 25 +++++++++++++++++--------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  4 ++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7c43c039e669..6baf4d460b80 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -613,10 +613,22 @@ static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {
 	.enable = vc4_hdmi_encoder_enable,
 };
 
+static u32 vc4_hdmi_channel_map(struct vc4_hdmi *vc4_hdmi, u32 channel_mask)
+{
+	int i;
+	u32 channel_map = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (channel_mask & BIT(i))
+			channel_map |= i << (3 * i);
+	}
+	return channel_map;
+}
+
 /* HDMI audio codec callbacks */
 static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi)
 {
-	u32 hsm_clock = clk_get_rate(vc4_hdmi->hsm_clock);
+	u32 hsm_clock = clk_get_rate(vc4_hdmi->audio_clock);
 	unsigned long n, m;
 
 	rational_best_approximation(hsm_clock, vc4_hdmi->audio.samplerate,
@@ -735,7 +747,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	u32 audio_packet_config, channel_mask;
-	u32 channel_map, i;
+	u32 channel_map;
 
 	if (substream != vc4_hdmi->audio.substream)
 		return -EINVAL;
@@ -787,12 +799,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 		   VC4_HDMI_MAI_CONFIG_BIT_REVERSE |
 		   VC4_SET_FIELD(channel_mask, VC4_HDMI_MAI_CHANNEL_MASK));
 
-	channel_map = 0;
-	for (i = 0; i < 8; i++) {
-		if (channel_mask & BIT(i))
-			channel_map |= i << (3 * i);
-	}
-
+	channel_map = vc4_hdmi->variant->channel_map(vc4_hdmi, channel_mask);
 	HDMI_WRITE(HDMI_MAI_CHANNEL_MAP, channel_map);
 	HDMI_WRITE(HDMI_AUDIO_PACKET_CONFIG, audio_packet_config);
 	vc4_hdmi_set_n_cts(vc4_hdmi);
@@ -1342,6 +1349,7 @@ static int vc4_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
 		DRM_ERROR("Failed to get HDMI state machine clock\n");
 		return PTR_ERR(vc4_hdmi->hsm_clock);
 	}
+	vc4_hdmi->audio_clock = vc4_hdmi->hsm_clock;
 
 	return 0;
 }
@@ -1499,6 +1507,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.phy_disable		= vc4_hdmi_phy_disable,
 	.phy_rng_enable		= vc4_hdmi_phy_rng_enable,
 	.phy_rng_disable	= vc4_hdmi_phy_rng_disable,
+	.channel_map		= vc4_hdmi_channel_map,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index eb0f91b57316..30eac891dc74 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -72,6 +72,9 @@ struct vc4_hdmi_variant {
 
 	/* Callback to disable the RNG in the PHY */
 	void (*phy_rng_disable)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to get channel map */
+	u32 (*channel_map)(struct vc4_hdmi *vc4_hdmi, u32 channel_mask);
 };
 
 /* HDMI audio information */
@@ -112,6 +115,7 @@ struct vc4_hdmi {
 
 	struct clk *pixel_clock;
 	struct clk *hsm_clock;
+	struct clk *audio_clock;
 
 	struct debugfs_regset32 hdmi_regset;
 	struct debugfs_regset32 hd_regset;
-- 
git-series 0.9.1
