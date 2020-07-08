Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4284F207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mZJ6GAcA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZSVm1s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGHRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:19 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45515 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgGHRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 0F4442F3;
        Wed,  8 Jul 2020 13:43:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=4ovOYU6JzpFt/
        RYQbSmJy7CjmiXZoiogNvFC2X/3xU0=; b=mZJ6GAcAHQg5fgX52WkiKirygWzD3
        YwcQ2lJybVovSO1T35hRQv/WvNjeZk+WhU4zjWrCGv2ghMwyo364usdszeZ/WuE3
        qmAJHHJhGspiqEwZHQkQH4/zwquzEfOjr0O4fAZ2ZJjtEzyGIJq7TXPZPKJ4wm6m
        Fq6aHAP3aHN7isf3/Zq9pq3vpYxYX8+JfPQSYrTI+qYajeC8KrpY9cC0fUdNq7iu
        wXYkk6atGey+6WPMhYKHoVbTPLVIbBKFvJniQyEB+lJC6oQnPdQ1huhQq3584H+G
        /ion6xIYAlsPZGb7gPFDJkEj2TyTDP2Xq0oodZRaTC3mahUvBtqFUWHvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=4ovOYU6JzpFt/RYQbSmJy7CjmiXZoiogNvFC2X/3xU0=; b=nZSVm1s9
        9oOrgi0z/FuWhONpYluANldea+10xM+Ff2HRpElBdQKYKQgSaOAx54g+3+P1c0RA
        Vm3MTmrcf8SdDF4dRkxyuuFuZN5RicoXG17YR3kEwd9w0XrxhnyCfEIn0y2TTH2g
        0Pq6/dBn2co+hc23b4m/4rhLJ9HFnQ0idkyfvq730Xcda6E0UQ2Av038ddqGj8ce
        2UZ4NLuj6DiwpgVcovWf9epE4ZcWnqmMrnVqzLlsQv5EM8vLCVhSMjFdiHKjPoky
        zQyqyljHZqED8gVokifnVd5KnEXhq7zR6PSl6roS2S0LnvNMMi3VJipeGfEgWzcY
        gKPaqFwkC3L9Ig==
X-ME-Sender: <xms:rwUGX6Zb_-ugiq-KsKI3CRjRM5uMXU6BbafoC2_KGr2Faanw8xIXTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rwUGX9ZFD6Gu4zyv1VJrPxgmel_n8SdldrRhHbbOckxrlrcCZiiA0A>
    <xmx:rwUGX09Y5zh5TK8PzxTr964J5y29i4gx9HAc4p2WJfPXo2y-Ul5c5w>
    <xmx:rwUGX8r_jkMJgGyO-IKn5SFpz_HERwhnS7StFL6bG7H_HdmLgN5qyw>
    <xmx:rwUGX5LxzdpWbQPx38WQJdy47vQ8bmLmRWaISix-ZdehgUNO8HFYF4zCJ4g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4391C3280059;
        Wed,  8 Jul 2020 13:43:11 -0400 (EDT)
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
Subject: [PATCH v4 28/78] drm/vc4: encoder: Add finer-grained encoder callbacks
Date:   Wed,  8 Jul 2020 19:41:36 +0200
Message-Id: <5fadf9256d130d447e3c66a0c86ceeba05c47fa4.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
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
index b7b0e19e2fe1..d0b326e1df0a 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -389,6 +389,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 	int ret;
 
 	require_hvs_enabled(dev);
@@ -401,10 +403,16 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
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
@@ -424,6 +432,8 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc);
+	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
 
 	require_hvs_enabled(dev);
 
@@ -434,15 +444,24 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vc4_hvs_atomic_enable(crtc, old_state);
 
+	if (vc4_encoder->pre_crtc_configure)
+		vc4_encoder->pre_crtc_configure(encoder);
+
 	vc4_crtc_config_pv(crtc);
 
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
 
+	if (vc4_encoder->pre_crtc_enable)
+		vc4_encoder->pre_crtc_enable(encoder);
+
 	/* When feeding the transposer block the pixelvalve is unneeded and
 	 * should not be enabled.
 	 */
 	CRTC_WRITE(PV_V_CONTROL,
 		   CRTC_READ(PV_V_CONTROL) | PV_VCONTROL_VIDEN);
+
+	if (vc4_encoder->post_crtc_enable)
+		vc4_encoder->post_crtc_enable(encoder);
 }
 
 static enum drm_mode_status vc4_crtc_mode_valid(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index dfcc684f5d28..251fcc35530c 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -439,6 +439,13 @@ struct vc4_encoder {
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
