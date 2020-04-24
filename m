Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C7C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7903920700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qh8ruamF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XX/ojDPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDXPih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:38:37 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:59863 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728742AbgDXPhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:37:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 0BF871457;
        Fri, 24 Apr 2020 11:37:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=NESTCen3MrXXh
        708mrqkdFkXV/OmuAZPbcYxn1s5Ivw=; b=qh8ruamFGcgMXbGqmht0o4d1xa/cK
        Yj+DFbdYFO9TdUbwEpYr0q5s756jUaLx6mD1f79OtQHbo0mx72qxUnL8CYX0ruaO
        IcIjXNa3/k0UHgXwExoXua9A3eBCPfmzWiKwT7ea37T92gO+PSdy4L58S2b12qx6
        4Uv+a9o3Cqrk6Xziurk3t9oOEuv4q7Bz9nqbyb/dqh2aroP8rN77NaU2oZ4+4+ZO
        B914tAvem7SWxF78OeUq2cvVQsbdrqoBLyVrxOspo63QBblq+OhYOXzuazSIIOfK
        z2L8K3auyO3E1GotyuHsnDicTPTRhE9ziExEvn9nKmxUjMQmTHvil7wAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NESTCen3MrXXh708mrqkdFkXV/OmuAZPbcYxn1s5Ivw=; b=XX/ojDPD
        LMhmDGiAqxA64HhnKGWHv4XGvs6Urzs7hEtOQfHP35eqCvTVDSeR8HllEhrjhcN8
        AQ4wvtOmYWjlvyPSu9ImKww0vB/O5V2FS3GVTLvlhv2n0kvTpVwZofnwAHPFzViX
        OjGYgDbUKairSzVzzLgn5seg8xyFTgLraCScV5ycLfGxGvj6/KZaE3bY81BX8VF5
        h22fDqNfTfSIxt5LNJMGpJptd9AbRGkhx1Xcf7eGY7zBG7BmXEbZcQabHNx4+Dtz
        ky3AjzP9rT2D0gHpSTWfG6iP9kBZfwq4j/Bdh6hiVFG/SLR0SwMM3zsCgb/nIrWf
        uf01EYDHrcjx8A==
X-ME-Sender: <xms:nQejXuaVaYmQMA0TDSLjU7kXiKH_kv1UecZi-0ojR2ow1dzXW6k2mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epsgihthgvshdruggrthgrnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:nQejXiX14T5CJnwgf-rpONKyDoLLWTL4BeCBraSninTv_oNbKFkK1A>
    <xmx:nQejXpSkPbsEKiuSjBReEWEP4GudUTHTgUqyDY-1dvvQPf_qW53T3Q>
    <xmx:nQejXvHUDdnC0rfvkQXpmsvhsEjgjtOaQ_XRu2WMn6X86_F1H1o6Kg>
    <xmx:nQejXtAPfxVslaQy7z9VHNX-xL5jM1M9Rg8m-WvQGbgMvZP0XhMIkzyeTWk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 485DE3065D97;
        Fri, 24 Apr 2020 11:37:01 -0400 (EDT)
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
Subject: [PATCH v2 71/91] drm/vc4: hdmi: Remove vc4_hdmi_connector
Date:   Fri, 24 Apr 2020 17:34:52 +0200
Message-Id: <8be358dcf5121dc7080dd176cf171cb74567cafe.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_hdmi_connector was only used to switch between drm_connector to
drm_encoder. However, we can now use vc4_hdmi to do the switch, so that
structure is redundant.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 19 ++++++++-----------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 23 ++---------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 93c9ed7c16cf..eeaea2ad46fa 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -188,13 +188,10 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
 static int vc4_hdmi_connector_init(struct drm_device *dev,
 				   struct vc4_hdmi *vc4_hdmi)
 {
-	struct vc4_hdmi_connector *hdmi_connector = &vc4_hdmi->connector;
-	struct drm_connector *connector = &hdmi_connector->base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
 	int ret;
 
-	hdmi_connector->encoder = encoder;
-
 	drm_connector_init_with_ddc(dev, connector,
 				    &vc4_hdmi_connector_funcs,
 				    DRM_MODE_CONNECTOR_HDMIA,
@@ -292,7 +289,7 @@ static void vc4_hdmi_set_avi_infoframe(struct drm_encoder *encoder)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	struct drm_connector_state *cstate = connector->state;
 	struct drm_crtc *crtc = encoder->crtc;
 	const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
@@ -671,7 +668,7 @@ static int vc4_hdmi_audio_startup(struct snd_pcm_substream *substream,
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	int ret;
 
 	if (vc4_hdmi->audio.substream && vc4_hdmi->audio.substream != substream)
@@ -845,7 +842,7 @@ static int vc4_hdmi_audio_eld_ctl_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = sizeof(connector->eld);
@@ -858,7 +855,7 @@ static int vc4_hdmi_audio_eld_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	memcpy(ucontrol->value.bytes.data, connector->eld,
 	       sizeof(connector->eld));
@@ -1310,7 +1307,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret < 0)
 		goto err_destroy_conn;
 
-	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector.base);
+	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
 	cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
 
 	HDMI_WRITE(VC4_HDMI_CPU_MASK_SET, 0xffffffff);
@@ -1347,7 +1344,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 err_delete_cec_adap:
 	cec_delete_adapter(vc4_hdmi->cec_adap);
 err_destroy_conn:
-	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
+	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 #endif
 err_destroy_encoder:
 	vc4_hdmi_encoder_destroy(encoder);
@@ -1371,7 +1368,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	struct vc4_hdmi *vc4_hdmi = snd_soc_card_get_drvdata(card);
 
 	cec_unregister_adapter(vc4_hdmi->cec_adap);
-	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
+	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 	vc4_hdmi_encoder_destroy(&vc4_hdmi->encoder.base.base);
 
 	clk_disable_unprepare(vc4_hdmi->hsm_clock);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 749a807cd1f3..88794136d2e4 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -21,23 +21,6 @@ to_vc4_hdmi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
 }
 
-/* VC4 HDMI connector KMS struct */
-struct vc4_hdmi_connector {
-	struct drm_connector base;
-
-	/* Since the connector is attached to just the one encoder,
-	 * this is the reference to it so we can do the best_encoder()
-	 * hook.
-	 */
-	struct drm_encoder *encoder;
-};
-
-static inline struct vc4_hdmi_connector *
-to_vc4_hdmi_connector(struct drm_connector *connector)
-{
-	return container_of(connector, struct vc4_hdmi_connector, base);
-}
-
 /* HDMI audio information */
 struct vc4_hdmi_audio {
 	struct snd_soc_card card;
@@ -56,7 +39,7 @@ struct vc4_hdmi {
 	struct platform_device *pdev;
 
 	struct vc4_hdmi_encoder encoder;
-	struct vc4_hdmi_connector connector;
+	struct drm_connector connector;
 
 	struct vc4_hdmi_audio audio;
 
@@ -81,9 +64,7 @@ struct vc4_hdmi {
 static inline struct vc4_hdmi *
 connector_to_vc4_hdmi(struct drm_connector *connector)
 {
-	struct vc4_hdmi_connector *_connector = to_vc4_hdmi_connector(connector);
-
-	return container_of(_connector, struct vc4_hdmi, connector);
+	return container_of(connector, struct vc4_hdmi, connector);
 }
 
 static inline struct vc4_hdmi *
-- 
git-series 0.9.1
