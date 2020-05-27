Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6E220776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qBBrG2/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrxouZ0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgE0P4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36135 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730579AbgE0Pui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id B3C785820A0;
        Wed, 27 May 2020 11:50:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=e4GHdfwfR2Z0E
        2bNy/uEb6r3CFd7RdQxn0VWQHjT8Gs=; b=qBBrG2/gKZnW0cBntVXMOVLMz6HLs
        ZMUptMCWmgU5cKM+xWyixR592/zR+WwW8f/m4TCxg7QlN1+8GKLqTzQ9r22OBHUG
        GTHYvHElzmz9AveVElPYv5tUurQWJkrWr8UfbCGQCJsJqy8zXWbFDAa5lT6WshMU
        huSo4HzeSFXUnwQuuQ4GlEeDxNu3Hk8epIpTLz2V3rMDOA03uLOo5xUJdOiRYhlB
        +rW5W2sVusPzGIXHcKTbIDJeHYtUrdD+U6U6A5pXKL37vcsYA23Jgrgdqc6qwqsM
        uup6hElUPPAtQFgqPmUxUSPKUuafdo0cSuX7S9Mo1nJZZTyLRwpYX32jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=e4GHdfwfR2Z0E2bNy/uEb6r3CFd7RdQxn0VWQHjT8Gs=; b=ZrxouZ0j
        cZAAMBKFo8yM3HOtAVdUcPfHeASr+EbCZNLD6Br1tLk9rqEy3+yEcK/7X9a28Qdj
        32+5Wqi+kVrOA+WRVONcyjuvjKqYC9apVnjyyJS06su8VPTPSLnFInX0+ksYVYtt
        jA0iTCNT5mU2AbHaZZkSs0UvKChEiMwhj0JaVOTLf6evIdJ+bSetbuuC11MXB5yk
        tAut1lYpPTceOarbXGpBITGn4oBQ8n7ampUgU8DOncvZvSjib3pPsUmlRxvUPdg5
        mLfIHCBOeS4C8rvH05dXwEKamvAZoMhm7HxVKmiksjuNR9+GvEJfdU0P92foJ8DG
        bE+iJ5S+M+5EAg==
X-ME-Sender: <xms:TIzOXrh7n685WT49n8Tl9pcozA_RL1oSHLM2ZxAxdHsjpzGJu9oUUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TIzOXoAZpfU38tASXZzGGemka7YDdeUGoGH3x4c5lpH-yTRHwYw9ug>
    <xmx:TIzOXrEzlWXUNxT9B6SfZ6-XaoM4wWbjcCqxSOdjqjzq2DJIz85GsQ>
    <xmx:TIzOXoR0B7fDciVbvSDFSlj7OjabHk1BFbZBDmNuypFXTRQjeul3PA>
    <xmx:TIzOXrwDiCnM6CI-3m76e7XR-KLOhFyS_pVD3fJ137dpw-VuKpN_qA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42FE83280067;
        Wed, 27 May 2020 11:50:36 -0400 (EDT)
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
Subject: [PATCH v3 050/105] drm/vc4: encoder: Add finer-grained encoder callbacks
Date:   Wed, 27 May 2020 17:48:20 +0200
Message-Id: <9d35a69a2292ce8aee54b8f66523f725b8eb8723.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the BCM2711, the setup of the HVS, pixelvalve and HDMI controller
requires very precise ordering and timing that the regular atomic callbacks
don't provide. Let's add new callbacks on top of the regular ones to be
able to split the configuration as needed.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 19 +++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.h  |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 83fb5ba19b43..b3721bce7c81 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -387,6 +387,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int ret;
 
 	require_hvs_enabled(dev);
@@ -399,10 +401,16 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	if (vc4_encoder->post_crtc_disable)
+		vc4_encoder->post_crtc_disable(encoder);
+
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
 
 	vc4_hvs_atomic_disable(crtc, old_state);
 
+	if (vc4_encoder->post_crtc_powerdown)
+		vc4_encoder->post_crtc_powerdown(encoder);
+
 	/*
 	 * Make sure we issue a vblank event after disabling the CRTC if
 	 * someone was waiting it.
@@ -430,6 +438,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
 	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
 	require_hvs_enabled(dev);
 
@@ -440,17 +450,26 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	if (vc4_encoder->pre_crtc_configure)
+		vc4_encoder->pre_crtc_configure(encoder);
+
 	if (!vc4_state->feed_txp)
 		vc4_crtc_config_pv(crtc);
 
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
+	if (vc4_encoder->pre_crtc_enable)
+		vc4_encoder->pre_crtc_enable(encoder);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
 	if (!vc4_state->feed_txp)
 		CRTC_WRITE(PV_V_CONTROL,
 			   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
+
+	if (vc4_encoder->post_crtc_enable)
+		vc4_encoder->post_crtc_enable(encoder);
 }
 
 static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index d86228e1e338..ba24bad86905 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -442,6 +442,13 @@ struct vc4_encoder {
 	struct drm_encoder base;
 	enum vc4_encoder_type type;
 	u32 clock_select;
+
+	void (*pre_crtc_configure)(struct drm_encoder *encoder);
+	void (*pre_crtc_enable)(struct drm_encoder *encoder);
+	void (*post_crtc_enable)(struct drm_encoder *encoder);
+
+	void (*post_crtc_disable)(struct drm_encoder *encoder);
+	void (*post_crtc_powerdown)(struct drm_encoder *encoder);
 };
 
 static inline struct vc4_encoder *
-- 
git-series 0.9.1
