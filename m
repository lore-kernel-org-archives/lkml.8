Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDFC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9C920658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="r7opekzn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qClZALjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBXJKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:45 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42237 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728298AbgBXJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 62D32616;
        Mon, 24 Feb 2020 04:10:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=fWBZbyrT0uRoO
        bLKfHkx1ZYBCNRpYMOQo8jZHcfF4IE=; b=r7opekznwc4D94odEJu7EYN3Xkq1u
        xAtBJe3Q9d2G/KhPxfQ6oMerxcV+oUpAxmkYtIbx3IMR/hpyUu3uj99ZgkRDG2fG
        7TEvP+pKsAc/DoAHi8hRDFm4qmdYYFB6Disxr9QMkfh3v78fTTPJpO4bHDShDCSv
        bpav+JQzWObewtNOWxfMAt+iKZlbJeUkRQ8dZ86eTsvDjvaDgI+hV1LkzszXNXwo
        wjf2dUPhM95lwD8LpoHiV0iK/lXl86v2wK8lO9JKGlwVI5peURsqiAjeA16wk1tR
        22POo85veb6xc/HGAIM5vp3/qSSxMUZ76JXzIvUwR26/g/qj9HN7rFIrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=fWBZbyrT0uRoObLKfHkx1ZYBCNRpYMOQo8jZHcfF4IE=; b=qClZALjn
        brGcgu+Qo5fc8GR/FykvqwcmDz5g+cuatFeQMpqBMmJOh7YtYGDrBo4pVkpDNuhk
        INX6YkUBbpB/4l1QLNuB8qIrQ1wDpYhM4Jg/iuGuewB74CRMMxRLUG+ThzK5ePOM
        x2uE7hbEIVLF1Dg6VOh/wjn2pxwYQ0OvNTxt7noUaIhcpufQzGBjlBqnzOfCp4Fa
        sZBlUX3VMA4aWc33Jtepvw2c/OaaNjPN6PzNU9IHxh9LKtjnyIiNc5dYiH8KJA4+
        INgFVxBL/IxUpaIHCn8yrHIuZrU9Q6Z2Hcd60ct/AbBmLXOF9JRmsCBKIi7UlF+F
        Rml4LA0dApWsUA==
X-ME-Sender: <xms:DpNTXqVKr6fn_o9Vhe3lkthH2uSjNHl8jz1qLQqRfS2A9kaq4Mxqzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DpNTXnUPQgoVvkHqFlhidpn8-mPLNJhM9BvS-kkp7A6B6IV7PLzm7Q>
    <xmx:DpNTXnTipJsIvL1wIqUU0XCoGFnzpFI8xZAR4US9fj5e9D5waSRh3g>
    <xmx:DpNTXpM5Nwng5WQnNsLF6UYxXSs3Qnw2zGINu7T83zFI7ycHJg4pTQ>
    <xmx:D5NTXrG7A0AieWUdUWZmEa1uRH-6kCnIEGuhX5N9-D4glqf_gH38djj5eAc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2B97328005E;
        Mon, 24 Feb 2020 04:10:38 -0500 (EST)
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
Subject: [PATCH 76/89] drm/vc4: hdmi: Add PHY RNG enable / disable function
Date:   Mon, 24 Feb 2020 10:07:18 +0100
Message-Id: <a651c02df91d28f288259af4a17dcc289e10053c.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's continue the implementation of hooks for the parts that change in the
BCM2711 SoC with the PHY RNG setup.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c     | 15 +++++++++------
 drivers/gpu/drm/vc4/vc4_hdmi.h     |  8 ++++++++
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 14c5ce4e7010..50d69c74c5c4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -752,9 +752,9 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		vc4_hdmi_set_audio_infoframe(encoder);
-		HDMI_WRITE(HDMI_TX_PHY_CTL_0,
-			   HDMI_READ(HDMI_TX_PHY_CTL_0) &
-			   ~VC4_HDMI_TX_PHY_RNG_PWRDN);
+
+		if (vc4_hdmi->variant->phy_rng_enable)
+			vc4_hdmi->variant->phy_rng_enable(vc4_hdmi);
 
 		HDMI_WRITE(HDMI_MAI_CTL,
 			 VC4_SET_FIELD(vc4_hdmi->audio.channels,
@@ -766,9 +766,10 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
 			 VC4_HD_MAI_CTL_DLATE |
 			 VC4_HD_MAI_CTL_ERRORE |
 			 VC4_HD_MAI_CTL_ERRORF);
-		HDMI_WRITE(HDMI_TX_PHY_CTL_0,
-			   HDMI_READ(HDMI_TX_PHY_CTL_0) |
-			   VC4_HDMI_TX_PHY_RNG_PWRDN);
+
+		if (vc4_hdmi->variant->phy_rng_disable)
+			vc4_hdmi->variant->phy_rng_disable(vc4_hdmi);
+
 		break;
 	default:
 		break;
@@ -1413,6 +1414,8 @@ struct vc4_hdmi_variant bcm2835_variant = {
 	.reset			= vc4_hdmi_reset,
 	.phy_init		= vc4_hdmi_phy_init,
 	.phy_disable		= vc4_hdmi_phy_disable,
+	.phy_rng_enable		= vc4_hdmi_phy_rng_enable,
+	.phy_rng_disable	= vc4_hdmi_phy_rng_disable,
 };
 
 static const struct of_device_id vc4_hdmi_dt_match[] = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 39ae5273f36b..9ae4d2c5a4f0 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -47,6 +47,12 @@ struct vc4_hdmi_variant {
 
 	/* Callback to disable the PHY */
 	void (*phy_disable)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to enable the RNG in the PHY */
+	void (*phy_rng_enable)(struct vc4_hdmi *vc4_hdmi);
+
+	/* Callback to disable the RNG in the PHY */
+	void (*phy_rng_disable)(struct vc4_hdmi *vc4_hdmi);
 };
 
 /* HDMI audio information */
@@ -107,5 +113,7 @@ encoder_to_vc4_hdmi(struct drm_encoder *encoder)
 void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
 		       struct drm_display_mode *mode);
 void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi);
+void vc4_hdmi_phy_rng_enable(struct vc4_hdmi *vc4_hdmi);
+void vc4_hdmi_phy_rng_disable(struct vc4_hdmi *vc4_hdmi);
 
 #endif /* _VC4_HDMI_H_ */
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
index 26d6ee08edcf..8fdea621d8b1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
@@ -7,6 +7,7 @@
  */
 
 #include "vc4_hdmi.h"
+#include "vc4_regs.h"
 #include "vc4_hdmi_regs.h"
 
 void vc4_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi, struct drm_display_mode *mode)
@@ -23,3 +24,17 @@ void vc4_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
 {
 	HDMI_WRITE(HDMI_TX_PHY_RESET_CTL, 0xf << 16);
 }
+
+void vc4_hdmi_phy_rng_enable(struct vc4_hdmi *vc4_hdmi)
+{
+	HDMI_WRITE(HDMI_TX_PHY_CTL_0,
+		   HDMI_READ(HDMI_TX_PHY_CTL_0) &
+		   ~VC4_HDMI_TX_PHY_RNG_PWRDN);
+}
+
+void vc4_hdmi_phy_rng_disable(struct vc4_hdmi *vc4_hdmi)
+{
+	HDMI_WRITE(HDMI_TX_PHY_CTL_0,
+		   HDMI_READ(HDMI_TX_PHY_CTL_0) |
+		   VC4_HDMI_TX_PHY_RNG_PWRDN);
+}
-- 
git-series 0.9.1
