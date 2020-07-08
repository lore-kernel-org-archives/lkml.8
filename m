Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A443C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C96206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="qHi5FBbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GefVFuHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGHRpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:45:36 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51819 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgGHRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2F776109A;
        Wed,  8 Jul 2020 13:43:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3cIHC8KqWY8Pe
        iNu1IDQcZfEsyotilFpvuSQDL8zpGo=; b=qHi5FBbeE8ScAd6aXjURRRtrY6hed
        u9J2AEesG70n57GcGR+vdHCYxQVYkG9uvLseVPOPIY0DILwF3Sx3g1LBig5bVDjc
        vsYFXrn0Fo4i6+sOklv9Es/oDMuxai262udSEcgt0hjLstD97yX+hn0J0jdDUcu4
        kTdqRlDi1Ncej+C0kiNHMOYEG6JjS4/wEvx+CNAOUEEldWjW0EtHflIrk+GR8sUa
        0J3GON9QHJkhaUICz9lUy1lDwrMEFliMw0Rir7lRUnIghtXCch5o9S7QQVFcFgN+
        1r5Sln7UiHkE70BMeOdTf7pnWkcvdsMtl1YGVeIlDS2nGiJGzMdG3uBww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3cIHC8KqWY8PeiNu1IDQcZfEsyotilFpvuSQDL8zpGo=; b=GefVFuHQ
        68kBP7+GaN1wBYxwxHlA/UYT+dSW2E3D1g53iUFZvftOzBPB723ayxpbtmAhn/Ey
        4uvESd8bt+IW+yYSEOLbXrTFtXRgGka5cDF9GDef4EDVhTkdo2fsTpN4u0KDfukU
        5pPiM9CVd8YFBU1AsT9jkK1dvzRCbmh3ydd6qOFiAkxiREt9KwPjks8Qk2bqkb/S
        F9g+Iktf48kpTbQz3YRZSqndPp7Bn3wgwKExeyeaQV0L29zfPVnpK0GSlQDxlPHy
        ojgWTOx7+bgxUfc+ZnHvAaVn1CuJnrh+KDzJ2AmP8o3eFGNwKbdhTNnkIkk3FH1J
        3i1Y7WYNRFH+jQ==
X-ME-Sender: <xms:zQUGX6qzEe4MdkysB0OiWuigBpdTCt3rCN0jz9DUbGQqTjkWuo2joA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepieeugeefgfeiieelveekheehhedtueetueehkedtfffgvedtvdeijeduieff
    veevnecuffhomhgrihhnpegshihtvghsrdgurghtrgenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zQUGX4pXoplQ5MwF3R8Bnze0Cn3FOL9-rIjLmXtdEy7BdOKdxmHfjA>
    <xmx:zQUGX_OZXZvFqinof0Eg1Y1s6Js0BhmEvTZk6hY9qatg0jJ8Gcn9rw>
    <xmx:zQUGX55KEirRfAkrjPtYozEI0DcR4LQiAyMBGP_S7ZeKth--klDEJg>
    <xmx:zQUGX0bY2KO7B04HbPfC2L3SNR660irsIJz03a6ZZ8vfsFPXUD-nm_N0Ij4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6650A306005F;
        Wed,  8 Jul 2020 13:43:41 -0400 (EDT)
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
Subject: [PATCH v4 49/78] drm/vc4: hdmi: Remove vc4_hdmi_connector
Date:   Wed,  8 Jul 2020 19:41:57 +0200
Message-Id: <cc2808fd070156df6d1f627b3e6a4f3f9e8531b6.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vc4_hdmi_connector was only used to switch between drm_connector to
drm_encoder. However, we can now use vc4_hdmi to do the switch, so that
structure is redundant.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 19 ++++++++-----------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 23 ++---------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index c5c9f7bf5dee..ec7710dfd04e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -189,13 +189,10 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
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
@@ -284,7 +281,7 @@ static void vc4_hdmi_set_avi_infoframe(struct drm_encoder *encoder)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	struct drm_connector_state *cstate = connector->state;
 	struct drm_crtc *crtc = encoder->crtc;
 	const struct drm_display_mode *mode = &crtc->state->adjusted_mode;
@@ -663,7 +660,7 @@ static int vc4_hdmi_audio_startup(struct snd_pcm_substream *substream,
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	int ret;
 
 	if (vc4_hdmi->audio.substream && vc4_hdmi->audio.substream != substream)
@@ -837,7 +834,7 @@ static int vc4_hdmi_audio_eld_ctl_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = sizeof(connector->eld);
@@ -850,7 +847,7 @@ static int vc4_hdmi_audio_eld_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	memcpy(ucontrol->value.bytes.data, connector->eld,
 	       sizeof(connector->eld));
@@ -1305,7 +1302,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret < 0)
 		goto err_destroy_conn;
 
-	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector.base);
+	cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
 	cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
 
 	HDMI_WRITE(VC4_HDMI_CPU_MASK_SET, 0xffffffff);
@@ -1342,7 +1339,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 err_delete_cec_adap:
 	cec_delete_adapter(vc4_hdmi->cec_adap);
 err_destroy_conn:
-	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
+	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 #endif
 err_destroy_encoder:
 	drm_encoder_cleanup(encoder);
@@ -1382,7 +1379,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	vc4_hdmi = dev_get_drvdata(dev);
 
 	cec_unregister_adapter(vc4_hdmi->cec_adap);
-	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
+	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 	drm_encoder_cleanup(&vc4_hdmi->encoder.base.base);
 
 	clk_disable_unprepare(vc4_hdmi->hsm_clock);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index d43462789450..674541493909 100644
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
@@ -58,7 +41,7 @@ struct vc4_hdmi {
 	struct platform_device *pdev;
 
 	struct vc4_hdmi_encoder encoder;
-	struct vc4_hdmi_connector connector;
+	struct drm_connector connector;
 
 	struct i2c_adapter *ddc;
 	void __iomem *hdmicore_regs;
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
