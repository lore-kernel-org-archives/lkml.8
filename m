Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824AC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A5120828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="v2Sm1pqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQBT1Yc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBXJLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:50 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51051 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgBXJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 3000F628;
        Mon, 24 Feb 2020 04:10:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=s36AIVZDhgfEH
        uHKI3bVxc71YJj8Qw9OIGIr1Y69s/c=; b=v2Sm1pqdfoIBSFBIiRkT3sUPt7H/H
        CSAn6Mffhq1n8yyAYlq3DPnTg8xLAEJT97bPBGtMBMIen2ngXLQWsrFh8Ck7O1Xz
        X6pS/iyycfzQVJLoBYK2CJ1q95PRmsCtC5xts3fkJMM4ZloWSmtCkAJaPJMN3LuN
        4qWiQsXDIgJg7eJ8yGMlIWZ2cZB4QNCCwKhylNGcVJXr7l0pCEZzMiIdb6miGgi5
        LHYMdxqO6EOmZJZ0tYkAPyiq1qRi0ojCtd0Zqnt9HlTzrwrmZCNPZ+euLjvHIArp
        M+lrE680FdZMF+Ls9S+rKCUB31SW/o6RW+pZ8eMPLb2brDZGJlYAFBlIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=s36AIVZDhgfEHuHKI3bVxc71YJj8Qw9OIGIr1Y69s/c=; b=yQBT1Yc9
        AS+NQDvMmQCWa2Ygi71UKFG+XSfdQYiCbrxBvvw7+OtHMtJCGEyaKJk1G08skXC3
        41erFzl47cM2bNweK6dxKa9JOQGK08AXGZM0em8ptTnpRSaftcbtgSelfzMvZvl6
        C8VSqpxjgzv25I7JyZVaXUlbn7bng9rlcYXtxNULCUhtZ9lU2+n0hFpKimoCZmXv
        X7xijexcOui3nuPtqPtIJU6xTRd2AX9L5swblO4tuFerZUbauDI+4WV+pZoKR3QU
        ANNGMyZ782KqiNymXs9e8wUnWkA7vN01q+j0AYO3qWJhNw0upM3rJRvdBR6+9SO9
        mTAu5Bs2qSew8g==
X-ME-Sender: <xms:B5NTXho6R_t_9wEpOgon7121Sr4ZRfUtXXq5RrC6Z9rxekBsdc5PxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpegshi
    htvghsrdgurghtrgenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrth
    gvtghh
X-ME-Proxy: <xmx:B5NTXqrZrXpub9jGUiLlp3VZ8LYzrWYIzG0058y2vgxkKMxlOhIxsg>
    <xmx:B5NTXjN3NvBgCL5xEABvgB9lA_tklMIBUUFEDI7Ht37__blHumt7QQ>
    <xmx:B5NTXrygbCwhNq6s1IIv57aqh0dPdb8VEyRe5gCOSu-J9P0muVuJrQ>
    <xmx:B5NTXgRuzjw2ng2YYYk4xX9JBSqBnPQ4TgHJxwY6idORDWmiPmQs7Kc-a9w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 715E43060FD3;
        Mon, 24 Feb 2020 04:10:31 -0500 (EST)
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
Subject: [PATCH 71/89] drm/vc4: hdmi: Remove vc4_hdmi_connector
Date:   Mon, 24 Feb 2020 10:07:13 +0100
Message-Id: <f48c48e54ea0c063756429c1f138cc1298744339.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
 drivers/gpu/drm/vc4/vc4_hdmi.c | 17 +++++++----------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 23 ++---------------------
 2 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 8049a5ba291f..bbe7b0b3e017 100644
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
@@ -659,7 +656,7 @@ static int vc4_hdmi_audio_startup(struct snd_pcm_substream *substream,
 {
 	struct vc4_hdmi *vc4_hdmi = dai_to_hdmi(dai);
 	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 	int ret;
 
 	if (vc4_hdmi->audio.substream && vc4_hdmi->audio.substream != substream)
@@ -833,7 +830,7 @@ static int vc4_hdmi_audio_eld_ctl_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = sizeof(connector->eld);
@@ -846,7 +843,7 @@ static int vc4_hdmi_audio_eld_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct vc4_hdmi *vc4_hdmi = snd_component_to_hdmi(component);
-	struct drm_connector *connector = &vc4_hdmi->connector.base;
+	struct drm_connector *connector = &vc4_hdmi->connector;
 
 	memcpy(ucontrol->value.bytes.data, connector->eld,
 	       sizeof(connector->eld));
@@ -1335,7 +1332,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 err_delete_cec_adap:
 	cec_delete_adapter(vc4_hdmi->cec_adap);
 err_destroy_conn:
-	vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
+	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
 #endif
 err_destroy_encoder:
 	vc4_hdmi_encoder_destroy(encoder);
@@ -1359,7 +1356,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
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
