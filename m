Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B69C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42FD206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XrirGnkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6OgA7r3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGHRpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:45:01 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:40037 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgGHRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 10CF4FE4;
        Wed,  8 Jul 2020 13:44:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WHESNcuVWnukW
        BRXCRgzBXIom6wlyAKEckGY8OnoahQ=; b=XrirGnkWIt6bDsOc4ApcQgpO/EQQZ
        P2ctGOX+nY04C/O3cNyFKUFN0exgOXtM1DG/rt436jDuHNyfdMaiOOZXTU34yTFZ
        lau+ybu5VDg5h+YijT02n8bfo7bTY2ucXeYIaMNlkRVK8DFQW17fJJZLLyHu0JJJ
        Pl18AwR+0yNn+tQ5NDAwLHnvyEpYDwCXvp060CibJHP4hnobYQfIQUaBxewMljBb
        v1xNCQEXDc7PdIMq0MDljsFOCDNq33Tyu6ai/R7U6IilRmQ09oEDl1iL5eLNROw1
        Ei7S6Q2fjCG0yGukCsxYs5dObIIXYpHLs/iaAcOGjx1MbZco6IdWrDFbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WHESNcuVWnukWBRXCRgzBXIom6wlyAKEckGY8OnoahQ=; b=e6OgA7r3
        mTYn3/zpJi6kveeF1WxcoRHpis2AXr0Zc+tYoVBJTGLkisjcTKtViXfG4c2rN2Vi
        tuufYR5Aw/y6EeAtN/bnrnHkDINSKdvnxhUDuLMSMJ9iNneAIPhFPwcrfmYizZgw
        VuBqN0L+OF8iG2pXjo0KdMVKDtfUIQnD1c7bJ2bpbH3+VxML33s5AOElKN0V7xdg
        oCVV/vnZy/G0lf1ecFgyiFVHXQBR5e3xifmJ/EItEeN5GNvmCjL43miOrdCxq8r5
        bZnpIs7myf7qBFPTraaVc3xIUfMG+zKsu6A4qStnz/eE4H57V/Hn3vHU6nOW2Hce
        SCyYVn6nJ2CqqA==
X-ME-Sender: <xms:5wUGX_YcrmDAfz3lVCvHV6IuPmpo2GB2f35KH93Wg-Ax21yrhXYAEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepiedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5wUGX-Z05eZ9dcnqn8lASRKMKdwG7oQQkLIHPmiX7hgUF5JoFluOXA>
    <xmx:5wUGXx_CIaY5_c5z4wyhL8gh8j28ARaL4JisBa-5RhvnIgbMtUz5xw>
    <xmx:5wUGX1rtPiymu1xj-zJpGH9Vn6hUvsTOHoWL6GTW9yAfv-xM1jpeAw>
    <xmx:5wUGX6IEzpVWbIAQJA5ayCkH4mE0tzIMtKKsytLL4l8ceLGomKXw0yHCnIM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FD2130600B4;
        Wed,  8 Jul 2020 13:44:07 -0400 (EDT)
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
Subject: [PATCH v4 67/78] drm/vc4: hdmi: Add audio-related callbacks
Date:   Wed,  8 Jul 2020 19:42:15 +0200
Message-Id: <3e4812754845ee5dc809aa75ec648a9935a9aa16.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index e1ef0907a827..1b6f51849d6c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -611,10 +611,22 @@ static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {
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
@@ -733,7 +745,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	u32 audio_packet_config, channel_mask;
-	u32 channel_map, i;
+	u32 channel_map;
 
 	if (substream != vc4_hdmi->audio.substream)
 		return -EINVAL;
@@ -785,12 +797,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
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
@@ -1343,6 +1350,7 @@ static int vc4_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
 		DRM_ERROR("Failed to get HDMI state machine clock\n");
 		return PTR_ERR(vc4_hdmi->hsm_clock);
 	}
+	vc4_hdmi->audio_clock = vc4_hdmi->hsm_clock;
 
 	return 0;
 }
@@ -1508,6 +1516,7 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
 	.phy_disable		= vc4_hdmi_phy_disable,
 	.phy_rng_enable		= vc4_hdmi_phy_rng_enable,
 	.phy_rng_disable	= vc4_hdmi_phy_rng_disable,
+	.channel_map		= vc4_hdmi_channel_map,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 77d47d1707ce..4aea5ee8a91d 100644
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
