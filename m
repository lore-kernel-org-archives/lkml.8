Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7326D2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="cgimq93H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmDEp8eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbgE0P4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:15 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35245 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730549AbgE0Pu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E7ED58208B;
        Wed, 27 May 2020 11:50:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=GAOeZq/xDTflc
        6+P9LvBBHtQ9OlNDddl/lapwGwoANs=; b=cgimq93HzfgKRS6nQic9ZXJgcznq7
        feFRMqB03YBMQWWq1b+bVSj/YpqnQTTZ7qI/hAGiApbVOvzABTMYmil/xS+cwHBh
        +D8XXng7/de7pN5Et12Zz8Tc/QjEo72vIlwKzhd6lbv3kOje/4dD8/USN+39+ngD
        fNtOwzNhogquofQl2hFmoGeQmTBKHsCArTKtNYc3ZlzObMoFmBYuMtZnkw5ZzEOo
        /+xKjrtiEgFIWSfMTD/tI06w5MjLrMck6Es+btliBSX1d4l84IuD4vLKwd5Ps6XP
        Jpg3hw8Kiyd1RUYZyOXImYgaIhr5+KwgdnwqBrcHpWUDL+NNIzK5k00dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=GAOeZq/xDTflc6+P9LvBBHtQ9OlNDddl/lapwGwoANs=; b=kmDEp8eU
        cmwjzM9Z1zO8xSDTSEJDUHynohjfK1PCbcxanoMa04/A4xa76ipoMndA3kMONFgj
        UJSVySYgPcZBcF+PcyDFz7UrGWGGCZLxI/auSl2WNmdE15F7EmjkQY6Hf69qvgOx
        qVjFCaFIz0xzCsi7YJf4jg1/EbzPvo5116RzPJNqAASIb+vzOg0ugWHkNEF3sln+
        uUhtpIArAszMcUHKgVIUWAEMi0BbTW2emtgsNUE7T0xKqneO+p9lUOK19MeI+iVa
        2EhrsqTp1Ol3cXCBicFLTb8k+paI27u7lxv1lTT4Y97H8rNvc14wgOOKqiSBeCrr
        NpY128nQ9VdBXw==
X-ME-Sender: <xms:Q4zOXkazRh37YV4SnK8xjokLg1tb7ezshx9C5MikkgMutmHCvhmCIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Q4zOXvZUqTwumq3GQPgyl_IwNuKVir2V-YsRGrinksEbnIO9FYXQ5g>
    <xmx:Q4zOXu-IlpTh-fXIXDi8N31lycdWcV5x1AicnbzZ_B9f42ZKybbOhg>
    <xmx:Q4zOXupzVkZgmioJvv77Bb-QS2UnNIPay_4r88Bq4M0737zsetkYZA>
    <xmx:Q4zOXrIIimuNMJbJWpoP-V5mjdb8yB23cQzVLHUNXW-s_sT52ZVN6g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 11EDF3280060;
        Wed, 27 May 2020 11:50:26 -0400 (EDT)
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
Subject: [PATCH v3 044/105] drm/vc4: crtc: Move the HVS gamma LUT setup to our init function
Date:   Wed, 27 May 2020 17:48:14 +0200
Message-Id: <aa92d353d0cf3673a5d36a60fb82f7a5634270ac.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since most of the HVS channel is setup in the init function, let's move the
gamma setup there too.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2352a63fd26b..87bbd68d44db 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -201,6 +201,8 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 {
 	struct vc4_crtc_state *vc4_crtc_state = to_vc4_crtc_state(crtc->state);
 	unsigned int chan = vc4_crtc_state->assigned_channel;
+	bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
+	u32 dispbkgndx;
 	u32 dispctrl;
 
 	/* Turn on the scaler, which will wait for vstart to start
@@ -225,6 +227,20 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 
 	HVS_WRITE(SCALER_DISPCTRLX(chan), dispctrl);
 
+	dispbkgndx = HVS_READ(SCALER_DISPBKGNDX(chan));
+	dispbkgndx &= ~SCALER_DISPBKGND_GAMMA;
+	dispbkgndx &= ~SCALER_DISPBKGND_INTERLACE;
+
+	HVS_WRITE(SCALER_DISPBKGNDX(chan), dispbkgndx |
+		  SCALER_DISPBKGND_AUTOHS |
+		  ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
+		  (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
+
+	/* Reload the LUT, since the SRAMs would have been disabled if
+	 * all CRTCs had SCALER_DISPBKGND_GAMMA unset at once.
+	 */
+	vc4_hvs_lut_load(crtc);
+
 	return 0;
 }
 
@@ -427,8 +443,6 @@ void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
-	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
-	bool interlace = mode->flags & DRM_MODE_FLAG_INTERLACE;
 
 	if (vc4_crtc->data->hvs_output == 2) {
 		u32 dispctrl;
@@ -453,16 +467,6 @@ void vc4_hvs_mode_set_nofb(struct drm_crtc *crtc)
 			   ~SCALER_DISPCTRL_DSP3_MUX_MASK;
 		HVS_WRITE(SCALER_DISPCTRL, dispctrl | dsp3_mux);
 	}
-
-	HVS_WRITE(SCALER_DISPBKGNDX(vc4_state->assigned_channel),
-		  SCALER_DISPBKGND_AUTOHS |
-		  ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
-		  (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
-
-	/* Reload the LUT, since the SRAMs would have been disabled if
-	 * all CRTCs had SCALER_DISPBKGND_GAMMA unset at once.
-	 */
-	vc4_hvs_lut_load(crtc);
 }
 
 void vc4_hvs_mask_underrun(struct drm_device *dev, int channel)
-- 
git-series 0.9.1
