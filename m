Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553C7207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="bAS/s/vD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAckAeNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGHRoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:44:11 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36627 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbgGHRoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:44:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 30A511092;
        Wed,  8 Jul 2020 13:44:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=/q3vv+C2bDbjW
        DsIstdQOTWXqEEuVW1JCBrii9WgS0Q=; b=bAS/s/vDxNqKej0wS2D509MllQ3VF
        tjaeT7zjQx6da+uzukzv4I8PVg65+wP402kS5vwTR22CjxZ+mMZZNJDY93WiQ5he
        478RiBYVWREi+jxMNcXvoz6awkL0l1B6V06iDa1W8CA0A6qPBK3w0BJurwUZAZ/+
        K3TPjEQvteEGdmfDNZDAcWAdlFYSn7FUhEtchsnCeQZPoVr6+66qxjJGCVND+yk6
        XcdPVK/Ry2uyZ+hMFEuxl0Ql4sE7cyK/tCOYYmzycUGzbF1NSB3SUKYLRcCXdTG/
        +pImoxdNHtXIWrhYiZbHXI76uC3/tKXwy2P7Iu5sJj1gO9mc+YKf0rY3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/q3vv+C2bDbjWDsIstdQOTWXqEEuVW1JCBrii9WgS0Q=; b=rAckAeNh
        +uUaOej1J45c+uWrt82C9jy0rVRuBde9l+LQuepNK3M5HusQ2DYQ+lQdbu5CQ4Tv
        +r7zCXock7+wa3QNcqGmfohjs6Fs3ooaYgBFeTcnFHvGqn3Xl6fv3R84OsDzhVF9
        S3gdxHCCxoav+zVYiXFSHN/WHP8Dcu3zHOZyYs10lp1UCTe38YRuf8JCS8x68yn7
        LEF7UZrutmuwQ2r8Tsmoh4Wrj5DYXXgf12Zmk0gtA/KTLkcfrmOjYTDisVNtczU8
        QrQewhkZw70nbRPS6GAyX9VSBO/Pr2HND4nJv09JPJPIcPbfjpZ6FaFAk+OEKwv3
        GS7PAsEYX/FrMQ==
X-ME-Sender: <xms:5AUGX0kCtk7RaXUE4UqbpA7GuGoE8oXnULTIIh4Cmcjb0SynEc60rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:5AUGXz2rzrqHXyYJunah4NBzMr-D52SO5UohgyFjH6NsiyChw4s1uw>
    <xmx:5AUGXyoPdPEY0tWn7VpQZ3CXT4Omd0ucSj_i3aKnak6ppNISP8-d8w>
    <xmx:5AUGXwmdpb9GB_MNpl2paQVfDSUDrANOaWOk9FF4Mt5RRJT7t8zpAA>
    <xmx:5AUGX7l-3XVHRmv6uXEs0RefUSesjlX3TP851as9Z54bSq13jCbWHhgMy0g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B6B7306005F;
        Wed,  8 Jul 2020 13:44:04 -0400 (EDT)
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
Subject: [PATCH v4 65/78] drm/vc4: hdmi: Reset audio infoframe on encoder_enable if previously streaming
Date:   Wed,  8 Jul 2020 19:42:13 +0200
Message-Id: <541e206cc374e908e6d2741243a037a935c79ca6.1594230107.git-series.maxime@cerno.tech>
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

If the encoder is disabled and re-enabled (eg mode change) all infoframes
are reset, whilst the audio subsystem know nothing about this change.
The driver therefore needs to reinstate the audio infoframe for
itself.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 12 ++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 8b94b920be43..c96d9f2af2bf 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -308,8 +308,16 @@ static void vc4_hdmi_set_audio_infoframe(struct drm_encoder *encoder)
 
 static void vc4_hdmi_set_infoframes(struct drm_encoder *encoder)
 {
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
+
 	vc4_hdmi_set_avi_infoframe(encoder);
 	vc4_hdmi_set_spd_infoframe(encoder);
+	/*
+	 * If audio was streaming, then we need to reenabled the audio
+	 * infoframe here during encoder_enable.
+	 */
+	if (vc4_hdmi->audio.streaming)
+		vc4_hdmi_set_audio_infoframe(encoder);
 }
 
 static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
@@ -694,6 +702,7 @@ static void vc4_hdmi_audio_reset(struct vc4_hdmi *vc4_hdmi)
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	int ret;
 
+	vc4_hdmi->audio.streaming = false;
 	ret = vc4_hdmi_stop_packet(encoder, HDMI_INFOFRAME_TYPE_AUDIO);
 	if (ret)
 		dev_err(dev, "Failed to stop audio infoframe: %d\n", ret);
@@ -797,6 +806,7 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		vc4_hdmi_set_audio_infoframe(encoder);
+		vc4_hdmi->audio.streaming = true;
 
 		if (vc4_hdmi->variant->phy_rng_enable)
 			vc4_hdmi->variant->phy_rng_enable(vc4_hdmi);
@@ -815,6 +825,8 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (vc4_hdmi->variant->phy_rng_disable)
 			vc4_hdmi->variant->phy_rng_disable(vc4_hdmi);
 
+		vc4_hdmi->audio.streaming = false;
+
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 342f6e0227a2..77d47d1707ce 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -85,6 +85,8 @@ struct vc4_hdmi_audio {
 	int channels;
 	struct snd_dmaengine_dai_dma_data dma_data;
 	struct snd_pcm_substream *substream;
+
+	bool streaming;
 };
 
 /* General HDMI hardware state. */
-- 
git-series 0.9.1
