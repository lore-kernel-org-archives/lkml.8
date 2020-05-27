Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970ECC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AFB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="w0ErxFaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJ/aIjn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgE0PwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:52:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46737 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390323AbgE0Pv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:51:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 63E995814FC;
        Wed, 27 May 2020 11:51:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=YLgHQlgusRMFY
        H3oIrPEeoCTOvM+aBf2NkHA4+L5RjA=; b=w0ErxFaUcsUoJUqORgbXZo3SHKEYS
        T/6lYxDLeF7n963e8leZNqKXeWsKrzcNy7SMVb/4xC0ExfM8w2OGwcZMojFm4JSF
        buU6f8K0lxcOK3gYp5UlmlcM/zUhUXY4DsVWyLNmwESag510xQo2UdwJBnsthYwp
        zdW7F9tFcmSB5NdyWufcFDN71rtfD0VAw6HbehpS7pLwa3Cw654/S40ePHqf872m
        iKzYnH9gNcmu8hnLCv6FI6EN+5wCrrsJu/ydo1pV4Mr4EyzyXNaDkxbuiNLF6bY1
        DijVhb1OCViU/WqcUKLNnhSXFcQ/yjoo6TPTrAsNMI3VHRaJHaU1sLoag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YLgHQlgusRMFYH3oIrPEeoCTOvM+aBf2NkHA4+L5RjA=; b=GJ/aIjn6
        Rkhnb2v68Xe9sX9ag696XPiRuSrsjmb5Rgy07SlQJfO2rLZJjfukl6GQv6cj6pSC
        Wr/Y5Yicl7qO8CcwB7QlD9BfhQ7E3jXH0NMHFVQqaLbVOe3fctt+MBnb5xhtDbGA
        amkzHoWbWimWk705U3UNk95YOW47lGZj+xtiIY2LHo/jcZXc6hbEFLQTHvKPq17r
        aBXX4gLXsDNtYz96vf3h+9JKaKXoSWxV95Gea21Zi5MquI2Grb0K9lw31hpHTe5D
        Nuf8WnnEZqqLStswlx5fr5LLuDNiOt+YB1cKvUIKL4lJFzkL5tkbGYAdveHYN4uB
        N6W9ua4N1GWLwQ==
X-ME-Sender: <xms:gIzOXimFWQmRzbNfWw6o7tjsccbT3ZgPI7hdKrEuZjj55bgcZMyZjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gIzOXp2kggAfOfXvmiYC0sDAxktBy_2y3vfADllc5dxyZQ5k28JvBw>
    <xmx:gIzOXgp9oXUR-Sg6gToPRWBov1l1HxLZnS0lJ-FeTSL7aY9Ky3iKSw>
    <xmx:gIzOXmmlNGIlrKwtJhxH-fXjqYcpj6rsT2NA0oyA_SLy_lvwlVHD7w>
    <xmx:gIzOXhmQApD1DJAFCXFdw_i2tBRRMm9WztZBoOMFbPKuO-kcPKplyQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2955306218B;
        Wed, 27 May 2020 11:51:27 -0400 (EDT)
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
Subject: [PATCH v3 083/105] drm/vc4: hdmi: Add PHY RNG enable / disable function
Date:   Wed, 27 May 2020 17:48:53 +0200
Message-Id: <4ff7428d535748a50d25f3788197df8bc24a4102.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
index 3d5e35aa96ff..133c7453e588 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -762,9 +762,9 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -776,9 +776,10 @@ static int vc4_hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -1414,6 +1415,8 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
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
index 5a1746877bb5..93287e24d7d1 100644
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
