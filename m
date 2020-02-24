Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B3CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8820828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lqkDpb+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODA6Ci6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBXJL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:11:57 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:41679 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgBXJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:29 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id DBBF1637;
        Mon, 24 Feb 2020 04:10:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=68asuyXb9mkhG
        o3MqC4nnXWLXvWrKMDiLurL+qYj0Fk=; b=lqkDpb+udFg+t64wQcx1JZIuFIYCH
        PKQ0wEDAyhHkWtWVwq9zQmVvcYygem2+NusjV4W1JJVTQu5UVpXJy0EysukiCmIT
        VGFbpyUNsD7yg9XiU238x0uMNVEDE2fgaCYZJNuS74nmOHuFx3N1o4VC40kwnrse
        GfYikZjTV9yBn0ld2xbS/5NTQbplgE/aSTN4u2fqfnJooaLghLbKAp5yU6WZUdcJ
        7NryUo7WC7jIT9WKGS5EOOsbgqzSduTOG6aMS9NHBcaQytPS3jAwdKfUa9W1MWQW
        iGBUyNK8U3etRezwx6b6fEjLmqvKeS0jrLdPjGabdKaOyuJj4/YCEpROQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=68asuyXb9mkhGo3MqC4nnXWLXvWrKMDiLurL+qYj0Fk=; b=ODA6Ci6N
        QkMwOKxYy4JEWc+egqK1TtSCAJbKmpUg+YwQcDosWWMg3fgTlQ1bXXdAY7crTTvn
        PAP5IH95dJ3oQtCE8Q2yEyeHOdbpLU2sAGt2GKBRDPkNmD7i5pdgc6F7M6qE7ij/
        Z8fdmw77NLDjt7CruYRVCCFDc7ACmIP4EnmmrBKg64oP1sHmoq2bo6JwD/kwh+0l
        ImypOUShtKICsSKZE068auvjvGJHOIgPuaSz1A7XgceHdtC/fRSr2NKI5WvToZDg
        yvx/8olpusdaI+OZhGfUi0haut4w1sfDdCsoBTHJ/0T096wm4mkabnw0NivUEtOt
        MeZqO04goUBaHg==
X-ME-Sender: <xms:A5NTXr2CQIu1o0VM0oQkY31-onDcv-DozPv0KBwRrvVjRoklPypODQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:A5NTXm9NRzMkepHxprLYLjTgH8nwidKqPFL7HwKwyVuTdyJRenJZcg>
    <xmx:A5NTXrpnzpbdZMdtBM-D0TZUrYM_7qMxUWXjsXi1f9bMn4PGuctJDQ>
    <xmx:A5NTXgR2CxSPWyagyomz7u0MR8qgRK9g3sIm8cfoFmtCAiA_ctdpCw>
    <xmx:A5NTXnoPUSYqP1XVF0irJzkAyJnAykT1b1HazhQR3PDdxE3YPNtIbN3L254>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 256843280063;
        Mon, 24 Feb 2020 04:10:27 -0500 (EST)
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
Subject: [PATCH 68/89] drm/vc4: hdmi: Add container_of macros for encoders and connectors
Date:   Mon, 24 Feb 2020 10:07:10 +0100
Message-Id: <3bbb96cbb1245e6ca4cb54fdad0c4af859055706.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever the code needs to access the vc4_hdmi structure from a DRM
connector or encoder, it first accesses the drm_device associated to the
connector, then retrieve the drm_dev private data which gives it a
pointer to our vc4_dev, and will finally follow the vc4_hdmi pointer in
that structure.

That will also give us some trouble when having multiple controllers,
but now that we have our encoder and connector structures that are part
of vc4_hdmi, we can simply call container_of on the DRM connector or
encoder and retrieve the vc4_hdmi structure directly.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 41 ++++++++++-------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 16 ++++++++++++++-
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 8b563bdd451d..e3f81cbcbe6c 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -120,9 +120,7 @@ static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 static enum drm_connector_status
 vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
-	struct drm_device *dev = connector->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
 
 	if (vc4_hdmi->hpd_gpio) {
 		if (gpio_get_value_cansleep(vc4_hdmi->hpd_gpio) ^
@@ -149,17 +147,13 @@ static void vc4_hdmi_connector_destroy(struct drm_connector *connector)
 
 static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 {
-	struct vc4_hdmi_connector *vc4_connector =
-		to_vc4_hdmi_connector(connector);
-	struct drm_encoder *encoder = vc4_connector->encoder;
-	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	struct drm_device *dev = connector->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
+	struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
 	int ret = 0;
 	struct edid *edid;
 
-	edid = drm_get_edid(connector, vc4->hdmi->ddc);
-	cec_s_phys_addr_from_edid(vc4->hdmi->cec_adap, edid);
+	edid = drm_get_edid(connector, vc4_hdmi->ddc);
+	cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
 	if (!edid)
 		return -ENODEV;
 
@@ -237,9 +231,7 @@ static const struct drm_encoder_funcs vc4_hdmi_encoder_funcs = {
 static int vc4_hdmi_stop_packet(struct drm_encoder *encoder,
 				enum hdmi_infoframe_type type)
 {
-	struct drm_device *dev = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	u32 packet_id = type - 0x80;
 
 	HDMI_WRITE(VC4_HDMI_RAM_PACKET_CONFIG,
@@ -252,9 +244,7 @@ static int vc4_hdmi_stop_packet(struct drm_encoder *encoder,
 static void vc4_hdmi_write_infoframe(struct drm_encoder *encoder,
 				     union hdmi_infoframe *frame)
 {
-	struct drm_device *dev = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	u32 packet_id = frame->any.type - 0x80;
 	u32 packet_reg = VC4_HDMI_RAM_PACKET(packet_id);
 	uint8_t buffer[VC4_HDMI_PACKET_STRIDE];
@@ -300,9 +290,8 @@ static void vc4_hdmi_write_infoframe(struct drm_encoder *encoder,
 
 static void vc4_hdmi_set_avi_infoframe(struct drm_encoder *encoder)
 {
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	struct vc4_dev *vc4 = encoder->dev->dev_private;
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
 	struct drm_connector *connector = &vc4_hdmi->connector.base;
 	struct drm_connector_state *cstate = connector->state;
 	struct drm_crtc *crtc = encoder->crtc;
@@ -346,9 +335,7 @@ static void vc4_hdmi_set_spd_infoframe(struct drm_encoder *encoder)
 
 static void vc4_hdmi_set_audio_infoframe(struct drm_encoder *encoder)
 {
-	struct drm_device *drm = encoder->dev;
-	struct vc4_dev *vc4 = drm->dev_private;
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	union hdmi_infoframe frame;
 	int ret;
 
@@ -370,9 +357,7 @@ static void vc4_hdmi_set_infoframes(struct drm_encoder *encoder)
 
 static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
 {
-	struct drm_device *dev = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	int ret;
 
 	HDMI_WRITE(VC4_HDMI_RAM_PACKET_CONFIG, 0);
@@ -391,10 +376,8 @@ static void vc4_hdmi_encoder_disable(struct drm_encoder *encoder)
 static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
-	struct vc4_hdmi_encoder *vc4_encoder = to_vc4_hdmi_encoder(encoder);
-	struct drm_device *dev = encoder->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
+	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
+	struct vc4_hdmi_encoder *vc4_encoder = &vc4_hdmi->encoder;
 	bool debug_dump_regs = false;
 	bool hsync_pos = mode->flags & DRM_MODE_FLAG_PHSYNC;
 	bool vsync_pos = mode->flags & DRM_MODE_FLAG_PVSYNC;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index cdc9d90f62ac..749a807cd1f3 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -78,6 +78,22 @@ struct vc4_hdmi {
 	struct debugfs_regset32 hd_regset;
 };
 
+static inline struct vc4_hdmi *
+connector_to_vc4_hdmi(struct drm_connector *connector)
+{
+	struct vc4_hdmi_connector *_connector = to_vc4_hdmi_connector(connector);
+
+	return container_of(_connector, struct vc4_hdmi, connector);
+}
+
+static inline struct vc4_hdmi *
+encoder_to_vc4_hdmi(struct drm_encoder *encoder)
+{
+	struct vc4_hdmi_encoder *_encoder = to_vc4_hdmi_encoder(encoder);
+
+	return container_of(_encoder, struct vc4_hdmi, encoder);
+}
+
 #define HDMI_READ(offset) readl(vc4_hdmi->hdmicore_regs + offset)
 #define HDMI_WRITE(offset, val) writel(val, vc4_hdmi->hdmicore_regs + offset)
 #define HD_READ(offset) readl(vc4_hdmi->hd_regs + offset)
-- 
git-series 0.9.1
