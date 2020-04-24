Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6148620700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Q337C+LG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpuICtHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgDXPj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:29 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35229 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728576AbgDXPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5313B1457;
        Fri, 24 Apr 2020 11:36:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=V+mHt7KKq06aK
        JSiumtgG2QFQTdfaFmJqjc+axXQmds=; b=Q337C+LGUYacRfXSZ6JbCN+QBmfTX
        Q3pXbMRTsY8nSkdWR3NwECXfNbu16tsPJ2OLsfBGjFUdW+z/yWsPXsfy6K8mQnCG
        rMvdJjOGbdYxMRFkLaMWPpXRziY38ossU5i/wlCFvk4DDbEOumXAHw42cadFKNrQ
        QaKPYgGqfFuasZR8BUSANiURkT/+2R7CwBjVd5YyL0eJ6YqFYDpz88lddaKOrg1K
        QVBxEoCa8fVhoaJEoiNsbzm2r1uDbgBzMDv4IkiYaOeKUugMffBr1YQWpUMHcp5z
        rO80AxDeMwZNYsVv1cZVgKDeHPExT69drCWprXt37uDjjPIarbevlq3gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=V+mHt7KKq06aKJSiumtgG2QFQTdfaFmJqjc+axXQmds=; b=LpuICtHb
        FT2cFSdlMvBRy2Mott8SonODK5cOzdCpuzzLIUnCRahnNytK5GxmcpkltOCp0fTq
        s+eUntfYzX9rJ0TthqCOP4S4M5BnPFJ37qSnW7t1JCOp3PskHR1Y1c8cA31RHpbk
        fzzS6Oe42+JeRbtQDmBghThNwLgbP9shtKkVFbWSy/eq+yPruzHnmSePyya7Mn4Z
        IzHWLXeu+bVEoHddzHIOQsn45xIe7x+MJZwU9hlWypmbZraY7+qFCmpWoXQ+SBLV
        GxNjab+VGbvdhBPL3Hywe6sMu8K5T0xCEqNOwoPPts3tuyYq4L5GEa1czyg5tllr
        S4e4B50YZhP5Yw==
X-ME-Sender: <xms:fgejXk4FezR1KrFWtTYcvzVzrLPi6C2BYpnKzkS1gY6uyd7q4rn0ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fgejXspAbSQxp4YeQ54xjCXK8Pz1h7XutMHi3U7zAglYCS0Zsuf_5Q>
    <xmx:fgejXrkGpHZlzJ0-4MKzZ1PphUqRY95thjJh6YUVd-YZ-wAaCqAw8Q>
    <xmx:fgejXp846eiLXABA3FznF9uOHHGV7lQH0R7tpEYIFgmCJ4umj8Fafg>
    <xmx:fgejXiMUyJcfsefQBbQpSyWpHvL2I-ky8BQr55wQFWKni_1RGnZ249FeE3I>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96FDE3065D93;
        Fri, 24 Apr 2020 11:36:30 -0400 (EDT)
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
Subject: [PATCH v2 49/91] drm/vc4: crtc: Rename HVS channel to output
Date:   Fri, 24 Apr 2020 17:34:30 +0200
Message-Id: <800ff9ca9bb838bf3122ee56b449bf8fe300b8ec.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
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
index e469bdab9124..e6d8f7656dd3 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1058,7 +1058,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv0_data = {
-	.hvs_channel = 0,
+	.hvs_output = 0,
 	.debugfs_name = "crtc0_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1068,7 +1068,7 @@ static const struct vc4_crtc_data bcm2835_pv0_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv1_data = {
-	.hvs_channel = 2,
+	.hvs_output = 2,
 	.debugfs_name = "crtc1_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1078,7 +1078,7 @@ static const struct vc4_crtc_data bcm2835_pv1_data = {
 };
 
 static const struct vc4_crtc_data bcm2835_pv2_data = {
-	.hvs_channel = 1,
+	.hvs_output = 1,
 	.debugfs_name = "crtc2_regs",
 	.pixels_per_clock = 1,
 	.encoder_types = {
@@ -1107,7 +1107,7 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 		int i;
 
 		/* HVS FIFO2 can feed the TXP IP. */
-		if (crtc_data->hvs_channel == 2 &&
+		if (crtc_data->hvs_output == 2 &&
 		    encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL) {
 			encoder->possible_crtcs |= drm_crtc_mask(crtc);
 			continue;
@@ -1169,7 +1169,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  &vc4_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
-	vc4_crtc->channel = vc4_crtc->data->hvs_channel;
+	vc4_crtc->channel = vc4_crtc->data->hvs_output;
 	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 	drm_crtc_enable_color_mgmt(crtc, 0, false, crtc->gamma_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 84e318098c5f..6fe36a38a8b3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -450,8 +450,8 @@ to_vc4_encoder(struct drm_encoder *encoder)
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
