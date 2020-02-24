Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC81AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943932086A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="UFDtyTNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmU1F0CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgBXJKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:32 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51633 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgBXJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id EBC39647;
        Mon, 24 Feb 2020 04:10:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=l2OASEcIbHxuF
        HUa1Z6Kf/tu0P5xtOA1fiZVpE7/O6c=; b=UFDtyTNrdJmZEkr9MLMs7R+pJwomc
        MtLSu4Jeu/CsswUk+tOXefxY8JcAvFaP05UjCh865Z4soA8TWYowzF36oSGyiqIP
        6qu6KfM3jI51zwohFgBHUN5w4TrBn8IzQDS/1HdPmICMwfDFaU5hG5Mu+2PI4IVl
        I07xlDSe4pXqAlKtEWAvSXZfJoU1i7wgKTwYXnz8450i0SNVbOecXUDcU9J9+Guw
        Ath7CmQUzRwcafmvwaLkkfKSdJyDg5GuylGkk+5FeLjoa8kqsYRkT33HExjkKxOr
        kpcABhglWH+ndlKnq9L+F2aouaXetaXcAz6xibdnr0JE+/HP6IdI2KuHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=l2OASEcIbHxuFHUa1Z6Kf/tu0P5xtOA1fiZVpE7/O6c=; b=cmU1F0CB
        fxzAy1nkDIxpSDDuLK2XrLYkBKIqa+/iThx/9Xm4ONvoNhT4uLQkME0GpbARcEpw
        ImxE764wlvRvhfK3G3iS+skt4aF7YdAHSTYmdJlOS4FlAAS/qcJt6T7zWYfETGG+
        Kkt7p29rso0LfeeAbTW59boRL2PJEP9GyIOvjxw1lM03xCGxTqfAaRdQQs1FfeEa
        cqT2URkc2eHqOh7bU+ohCioTfWPvrKs0okcMshE6nGV+EN2yrCK4imerUYQMHL/v
        8tQKGLHkSpE9jNj7U2CzwU3N09gm5ji1aWN/P7B9neWLuYKIuBBQoxhF2V/Uclin
        TCpAty86vp9azg==
X-ME-Sender: <xms:AJNTXsLvkkPBZR9f0Yc-0N0wGxU02cA2mR-7LLAM1YC6-EvaGtp8Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:AJNTXmmwED9G48cq7ELk-8QWc660dTYJ2KxaKvkh0irwhIt-ainltg>
    <xmx:AJNTXtKgjqhSabLm5jmfgfaB3eDO6kbPBFOQQY6KGSYTY8zpQXdU9Q>
    <xmx:AJNTXrnfF3tfWNjtThpijBHl3bJXPtSRfjVdE_rVA3mUK-LZP20PZA>
    <xmx:AJNTXu-9IXldVieqrZmMn2iYYqu7-tT-WldyydaMUsEbCiu4CwWd-uz5bew>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4BBE4328005D;
        Mon, 24 Feb 2020 04:10:24 -0500 (EST)
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
Subject: [PATCH 66/89] drm/vc4: hdmi: Move accessors to vc4_hdmi
Date:   Mon, 24 Feb 2020 10:07:08 +0100
Message-Id: <5806fef7798cf7dcf65485c01278843123015c98.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver only supports a single HDMI controller, and part of
the issue is that the main vc4_dev structure holds a pointer to its
(only) HDMI controller, and the HDMI registers accessors will use it to
retrieve the mapped addresses.

Let's modify those accessors to use directly the vc4_hdmi structure so
that we can eventually get rid of that single global pointer.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 16 +++-------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  8 ++++----
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a08c25e0c056..ec3062c4469f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -122,6 +122,7 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct drm_device *dev = connector->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 
 	if (vc4->hdmi->hpd_gpio) {
 		if (gpio_get_value_cansleep(vc4->hdmi->hpd_gpio) ^
@@ -238,6 +239,7 @@ static int vc4_hdmi_stop_packet(struct drm_encoder *encoder,
 {
 	struct drm_device *dev = encoder->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 	u32 packet_id = type - 0x80;
 
 	HDMI_WRITE(VC4_HDMI_RAM_PACKET_CONFIG,
@@ -252,6 +254,7 @@ static void vc4_hdmi_write_infoframe(struct drm_encoder *encoder,
 {
 	struct drm_device *dev = encoder->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 	u32 packet_id = frame->any.type - 0x80;
 	u32 packet_reg = VC4_HDMI_RAM_PACKET(packet_id);
 	uint8_t buffer[VC4_HDMI_PACKET_STRIDE];
@@ -619,9 +622,6 @@ static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {
 /* HDMI audio codec callbacks */
 static void vc4_hdmi_audio_set_mai_clock(struct vc4_hdmi *vc4_hdmi)
 {
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_device *drm = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	u32 hsm_clock = clk_get_rate(vc4_hdmi->hsm_clock);
 	unsigned long n, m;
 
@@ -641,8 +641,6 @@ static void vc4_hdmi_set_n_cts(struct vc4_hdmi *vc4_hdmi)
 {
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 	struct drm_crtc *crtc = encoder->crtc;
-	struct drm_device *drm = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
 	u32 samplerate = vc4_hdmi->audio.samplerate;
 	u32 n, cts;
@@ -679,7 +677,6 @@ static int vc4_hdmi_audio_startup(struct snd_pcm_substream *substream,
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 	struct drm_connector *connector = &vc4_hdmi->connector.base;
-	struct vc4_dev *vc4 = to_vc4_dev(encoder->dev);
 	int ret;
 
 	if (vc4_hdmi->audio.substream && vc4_hdmi->audio.substream != substream)
@@ -710,9 +707,7 @@ static int vc4_hdmi_audio_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static void vc4_hdmi_audio_reset(struct vc4_hdmi *vc4_hdmi)
 {
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_device *drm = encoder->dev;
 	struct device *dev = &vc4_hdmi->pdev->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	int ret;
 
 	ret = vc4_hdmi_stop_packet(encoder, HDMI_INFOFRAME_TYPE_AUDIO);
@@ -743,10 +738,7 @@ static int vc4_hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_device *drm = encoder->dev;
 	struct device *dev = &vc4_hdmi->pdev->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	u32 audio_packet_config, channel_mask;
 	u32 channel_map, i;
 
@@ -817,8 +809,6 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_device *drm = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 17079a39f1b1..cdc9d90f62ac 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -78,9 +78,9 @@ struct vc4_hdmi {
 	struct debugfs_regset32 hd_regset;
 };
 
-#define HDMI_READ(offset) readl(vc4->hdmi->hdmicore_regs + offset)
-#define HDMI_WRITE(offset, val) writel(val, vc4->hdmi->hdmicore_regs + offset)
-#define HD_READ(offset) readl(vc4->hdmi->hd_regs + offset)
-#define HD_WRITE(offset, val) writel(val, vc4->hdmi->hd_regs + offset)
+#define HDMI_READ(offset) readl(vc4_hdmi->hdmicore_regs + offset)
+#define HDMI_WRITE(offset, val) writel(val, vc4_hdmi->hdmicore_regs + offset)
+#define HD_READ(offset) readl(vc4_hdmi->hd_regs + offset)
+#define HD_WRITE(offset, val) writel(val, vc4_hdmi->hd_regs + offset)
 
 #endif /* _VC4_HDMI_H_ */
-- 
git-series 0.9.1
