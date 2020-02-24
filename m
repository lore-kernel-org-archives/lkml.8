Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185F0C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD25720658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Y7p+ZFHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tyz9SG3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBXJKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:05 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43597 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728060AbgBXJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 6E27E628;
        Mon, 24 Feb 2020 04:10:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=vjSNRpYZkG92K
        LT9/+dPCEfMZ9b8pczRyj2NMpqaBy0=; b=Y7p+ZFHpRnXi7Y1Sc5fTwQ1yOApRq
        +iCxPqrvTpMY7SHtRhNer8EXj3f7hTE0u+IMooMEvu13nhuCr8wGRqj4zA4JzGnu
        yM1mXsn7DPBqXDHBuL9u+3Tf1vg7Ms/TDyb6wbFidttkP182JeFUla0GDs2RYTMi
        cFnFISAF+dR1mzIi67OrpMG9pun8JhwmjgVXObm15kBm8FjG8EaW7GyjyYnJ+Iwg
        7lwk39qnWloVme5CSOSsVmRu4R47VzSfcj7tatdiMNVWsr2rUrFltee7a7w/mtQh
        ljObaLne5OfvPY02fQN7oHYt21j1BCeUasz1d56ZfCEFvQIVOzx+x5oqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=vjSNRpYZkG92KLT9/+dPCEfMZ9b8pczRyj2NMpqaBy0=; b=Tyz9SG3Z
        sTzB88ZO2C7Gqb9ReanX6vBCqirN+PLQ4bowmOdmCXYs+vlxOz4MtJ2ku/pUn5ah
        ayDZptcD8o4QKCjE21LLRikjhmE2dQNzQdvuSyGL2tk8b7UAicdLbzSFrfznKc5a
        H2sTq/Ib9I1ZZPpTu3bCX+vzLYPjYm0zy5TjTNu5YY1o2heCyqaoCGsjXNhWIPzL
        bLjq5Dp+WWpSREC88aDYoR8u/WN/MNdCYYFbUPbiz4f5hIL00NGUXvp/LfQ+3+BH
        qHqZnrxPD88F2KmoZmL4J17b/Xx6UH2UIv8LbYDADh4+GlUbM21eca7KvfS4VszO
        gFrOuSGt9EO3uw==
X-ME-Sender: <xms:55JTXkavADEOOAjNMy-oiudzYfJnMervbnCXURoBFmnNyM-MXvN0RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeelnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:55JTXhUzZR0Ec420O-MEjPJkcBcKWxmsG5no8D8ga-XnpwKPHwsw3A>
    <xmx:55JTXpWR3WzSZYLXR7PZzDGJwAbFL3Y4CXCu5TPb9MvwjYzMFCFy7A>
    <xmx:55JTXr8A8bmv2vbNxM4P3OBFtn_qlgI4safaUqcJ5isALJ4_h-ABYg>
    <xmx:6JJTXumtontmD8ANK6AGIFCjdw51oZsyWPSum5FrrB7iZwoIgWE3h9iZ-70>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE30A3060BD1;
        Mon, 24 Feb 2020 04:09:59 -0500 (EST)
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
Subject: [PATCH 49/89] drm/vc4: crtc: Rename HVS channel to output
Date:   Mon, 24 Feb 2020 10:06:51 +0100
Message-Id: <fb497985032737bed4a7192465063b0be0567fca.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc5, the HVS has 6 outputs and 3 FIFOs (or channels), with
pixelvalves each being assigned to a given output, but each output can
then be muxed to feed from multiple FIFOs.

Since vc4 had that entirely static, both were probably equivalent, but
since that changes, let's rename hvs_channel to hvs_output in the
vc4_crtc_data, since a pixelvalve is really connected to an output, and
not to a FIFO.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_drv.h  |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 6f797218f0c9..d03bd7946a84 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1056,7 +1056,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv0_data = {
-	.hvs_channel = 0,
+	.hvs_output = 0,
 	.debugfs_name = "crtc0_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1066,7 +1066,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv1_data = {
-	.hvs_channel = 2,
+	.hvs_output = 2,
 	.debugfs_name = "crtc1_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1076,7 +1076,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv2_data = {
-	.hvs_channel = 1,
+	.hvs_output = 1,
 	.debugfs_name = "crtc2_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1105,7 +1105,7 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 		int i;
 
 		/* HVS FIFO2 can feed the TXP IP. */
-		if (crtc_data->hvs_channel == 2 &&
+		if (crtc_data->hvs_output == 2 &&
 		    encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL) {
 			encoder->possible_crtcs |= drm_crtc_mask(crtc);
 			continue;
@@ -1167,7 +1167,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  &vc4_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
-	vc4_crtc->channel = vc4_crtc->data->hvs_channel;
+	vc4_crtc->channel = vc4_crtc->data->hvs_output;
 	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 7457cd50dcee..e1cb7a16f475 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -448,8 +448,8 @@ to_vc4_encoder(struct drm_encoder *encoder)
 }
 
 struct vc4_crtc_data {
-	/* Which channel of the HVS this pixelvalve sources from. */
-	int hvs_channel;
+	/* Which output of the HVS this pixelvalve sources from. */
+	int hvs_output;
 
 	/* Number of pixels output per clock period */
 	u8 pixels_per_clock;
-- 
git-series 0.9.1
