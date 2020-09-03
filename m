Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F2C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D3B206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BOaqwQzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ewSOpWK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgICIER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:04:17 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39287 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728378AbgICICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id ECA8DC0D;
        Thu,  3 Sep 2020 04:02:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=kYgRAIEAWPga7
        1O8AXBxP/ke4GXBvyR2dgdMwlSF3UY=; b=BOaqwQzhm9GK7RTNm4LA75F85tPB2
        o1kHIoyfH2ONP6gxpBm1ZjzpKEWf2BhOxGShezU1inUS5SgWfZF2pPvLlJ6gi23Q
        Pu0K7EWNu38IM0OSUqYOD4LlxOlzJxZEEr/ilbw6u0hUckC2SU/QmlUpu+IhkGC0
        QmoEKHn1vwOgkdP849xepAKtjdPSGkxFcbK1GB2Cj97hnTcAfSQ9lX9elzPslNaG
        7Fti4e3ogb0XVtO96vafMdlTcZbj4vOUb9C7CpK3D5PvyMJWQqcun4Abcp8nQgDU
        qgX7GtJ+NVu8yKY6O/o2UdiBcGIeys3XPSK5v4kyDx3EQ+VYRkvhOCcTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kYgRAIEAWPga71O8AXBxP/ke4GXBvyR2dgdMwlSF3UY=; b=ewSOpWK/
        ijS2h8dptssCR06jkv6G/O6Nek/KS/6wJq23eKNRLcOgo/pP16Xx/ju1EGaYRd7D
        7XWIFw/i1CYTJ0mGI4/ym6eAARqHAP8chwq+y28MILPERXxgdj8ABs4cUJdtevcu
        rnxGjq+Cu9gZr64CDHDM7iVy8tQICUIq4MvRi1JQAvGpYWI/6r3rGn+I1mG7j00m
        krD4hn5WtEYdGvJFdRQEzvnp26r9yyTBJGkfL7Jzeba6enMBgvsHnMz7HSScnsmy
        PuTY4Z7ggLIMlaZoC3eVRC0k3M8n5enrFn6XlX/lzEfW4qW1mA/vnkqxBL6dM8QP
        AgkI0M8DDfbaXg==
X-ME-Sender: <xms:B6NQX9781rvuefYO-NKJ_usmKi6RrBjz28ogusKqHXhddr01Tqtylg>
    <xme:B6NQX646Vwqrdu63ojkRVBif5myWfcd-JUljahhd3ZQ6SeGzRztfRidj-56lra4lN
    7iMcKuU8yJYFcPue6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:B6NQX0eopLk0ySINxL5CvHRy8FN31LXyNfIJ2qeC_wJdheWoI8bYMQ>
    <xmx:B6NQX2LcovL30-rHIT5I6TRJ5YF7fVJ31NxcVQjiTnr_5nWqreBk8A>
    <xmx:B6NQXxKm8wM2DSWrJO4wJVisQawJswsCQsmikglxQV8TyP3Z-LcA1A>
    <xmx:B6NQX7wHUl0xV2dWHObIYy-P1VHTrggtdF3PvjNv0x0p3Zn5_zlfjFwHwks>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D0F9306005E;
        Thu,  3 Sep 2020 04:02:15 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 15/80] drm/vc4: crtc: Add FIFO depth to vc4_crtc_data
Date:   Thu,  3 Sep 2020 10:00:47 +0200
Message-Id: <7df3549c1bea9b0a27c784dc416bb9a831e4e18f.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all pixelvalve FIFOs in vc5 have the same depth, so we need to add that
to our vc4_crtc_data structure to be able to compute the fill level
properly later on.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 20 +++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_drv.h  |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index b7e47ce1476c..2c64efd2d3d9 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -206,10 +206,21 @@ void vc4_crtc_destroy(struct drm_crtc *crtc)
 	drm_crtc_cleanup(crtc);
 }
 
-static u32 vc4_get_fifo_full_level(u32 format)
+static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 {
-	static const u32 fifo_len_bytes = 64;
+	const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
+	u32 fifo_len_bytes = pv_data->fifo_depth;
 
+	/*
+	 * Pixels are pulled from the HVS if the number of bytes is
+	 * lower than the FIFO full level.
+	 *
+	 * The latency of the pixel fetch mechanism is 6 pixels, so we
+	 * need to convert those 6 pixels in bytes, depending on the
+	 * format, and then subtract that from the length of the FIFO
+	 * to make sure we never end up in a situation where the FIFO
+	 * is full.
+	 */
 	switch (format) {
 	case PV_CONTROL_FORMAT_DSIV_16:
 	case PV_CONTROL_FORMAT_DSIC_16:
@@ -326,7 +337,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 
 	CRTC_WRITE(PV_CONTROL,
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
-		   VC4_SET_FIELD(vc4_get_fifo_full_level(format),
+		   VC4_SET_FIELD(vc4_get_fifo_full_level(vc4_crtc, format),
 				 PV_CONTROL_FIFO_LEVEL) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
 		   PV_CONTROL_CLR_AT_START |
@@ -785,6 +796,7 @@ static const struct vc4_pv_data bcm2835_pv0_data = {
 		.hvs_output = 0,
 	},
 	.debugfs_name = "crtc0_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
@@ -798,6 +810,7 @@ static const struct vc4_pv_data bcm2835_pv1_data = {
 		.hvs_output = 2,
 	},
 	.debugfs_name = "crtc1_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
@@ -811,6 +824,7 @@ static const struct vc4_pv_data bcm2835_pv2_data = {
 		.hvs_output = 1,
 	},
 	.debugfs_name = "crtc2_regs",
+	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 9e81ad8331f1..179010b9a010 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -457,6 +457,9 @@ struct vc4_crtc_data {
 struct vc4_pv_data {
 	struct vc4_crtc_data	base;
 
+	/* Depth of the PixelValve FIFO in bytes */
+	unsigned int fifo_depth;
+
 	/* Number of pixels output per clock period */
 	u8 pixels_per_clock;
 
-- 
git-series 0.9.1
