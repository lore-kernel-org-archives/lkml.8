Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A3C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987DF20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZWkoKpxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7aPv8II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgDXPjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:32 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52391 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbgDXPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EE20B1455;
        Fri, 24 Apr 2020 11:36:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=D6e4t8zccDn6J
        GhqZd6rz9zBMzaRydbfuBc+37xeq5A=; b=ZWkoKpxwMS3bl0kfCSCqkOhLguqdP
        jfi7PXtV8IIe/UkOU0wnGERrlOKzJNOZ7Zer/O24NCUajUtMT0ZluKvfKv64Uuda
        vkrO0JaU7HAH24WuSkjc9bEwG7D9wD6+VSzmthrdMPG3VUffGbHf+TJRW0A1LQTD
        hzszDrE58RGHrtK9noHPNhHaKIMlK6WM28D+5fihSBxFQrkfUBfIFzXgFUnDFqD+
        SAOzA+IOc5NZPqJUX0MD/Gh6sVZHwBtBAHYF42AJM/2sEwutqeZmaCqXV7IOBqkM
        Ly4AkMeogqoY8atxsrKKRJ6vEJ4FgnJFB6+fO+ONL9M4Q3Gb6tQLAKrbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=D6e4t8zccDn6JGhqZd6rz9zBMzaRydbfuBc+37xeq5A=; b=I7aPv8II
        yr6Bmv3QTl64HNuS1YKnlsg1jPhGUgp6IxwZqT6bwWiNVREFYodjDz8JEa2CUBH+
        e7A44iwhh4oal2SzL+F2UhNWtaKkGlWhwJ64PdloSwC0f5HRcX/KnucAaAd0JqaA
        BiDM+eP+Cc8T3+TaW1a27beJIHlBuGYWxJUlj/80fl53kJVSS2lylgnNTCNafkj8
        dgpEOqqGZURR1BJl1InmbMF8ZvC4HaImWa2xEEOevCwsxDAV48emNoVN4s2lu+4V
        VdpCGutfoYpDrzmE5r1GgIdd6m+NfI/yKbHFd095qHup9kDK59ivBHySBg3TnKuy
        7JtMp0W8eRhssg==
X-ME-Sender: <xms:fQejXkUIxGOb5nW8x0S01dFZWF0HE7pLNosm1-C7cmpSCo3nNxolGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fQejXuF54LfBkodRs7effvzAICLFvP-KnoAyVKwt1x03LVmRMkDjvw>
    <xmx:fQejXrF0AoyB2YOJgItzsA1guiMwrtuCON1Bsh5btBPLbRfAfkBcRw>
    <xmx:fQejXgs1PePoxQZ6ZarfHrqZswFciRoPMmAPxfnPBluAGXx2_7nBDA>
    <xmx:fQejXpp0idQVhkqx9yUR_8C485x8g1wUR8Pu6gPIQ6K6zRPBYjfNjKRQ4jU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34F16328006B;
        Fri, 24 Apr 2020 11:36:29 -0400 (EDT)
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
Subject: [PATCH v2 48/91] drm/vc4: crtc: Move the cob allocation outside of bind
Date:   Fri, 24 Apr 2020 17:34:29 +0200
Message-Id: <8a63b7d2863bd0c3e9811eb59917e077a4a44384.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COB allocation depends on the HVS channel used for a given
pixelvalve.

While the channel allocation was entirely static in vc4, vc5 changes
that and at bind time, a pixelvalve can be assigned to multiple
HVS channels.

Let's prepare that rework by allocating the COB when it's actually
needed.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 39 +++++++++++++++++------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |  2 +--
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 06bda23cd560..e469bdab9124 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -65,6 +65,23 @@ static const struct debugfs_reg32 crtc_regs[] = {
 	VC4_REG32(PV_HACT_ACT),
 };
 
+static unsigned int
+vc4_crtc_get_cob_allocation(struct vc4_crtc *vc4_crtc, unsigned int channel)
+{
+	struct drm_device *drm = vc4_crtc->base.dev;
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
+
+	u32 dispbase = HVS_READ(SCALER_DISPBASEX(channel));
+	/* Top/base are supposed to be 4-pixel aligned, but the
+	 * Raspberry Pi firmware fills the low bits (which are
+	 * presumably ignored).
+	 */
+	u32 top = VC4_GET_FIELD(dispbase, SCALER_DISPBASEX_TOP) & ~3;
+	u32 base = VC4_GET_FIELD(dispbase, SCALER_DISPBASEX_BASE) & ~3;
+
+	return top - base + 4;
+}
+
 static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 					  bool in_vblank_irq,
 					  int *vpos, int *hpos,
@@ -74,6 +91,7 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 	struct drm_device *dev = crtc->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	unsigned int cob_size;
 	u32 val;
 	int fifo_lines;
 	int vblank_lines;
@@ -109,8 +127,9 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 			*hpos += mode->crtc_htotal / 2;
 	}
 
+	cob_size = vc4_crtc_get_cob_allocation(vc4_crtc, vc4_crtc->channel);
 	/* This is the offset we need for translating hvs -> pv scanout pos. */
-	fifo_lines = vc4_crtc->cob_size / mode->crtc_hdisplay;
+	fifo_lines = cob_size / mode->crtc_hdisplay;
 
 	if (fifo_lines > 0)
 		ret = true;
@@ -1105,22 +1124,6 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
 	}
 }
 
-static void
-vc4_crtc_get_cob_allocation(struct vc4_crtc *vc4_crtc)
-{
-	struct drm_device *drm = vc4_crtc->base.dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
-	u32 dispbase = HVS_READ(SCALER_DISPBASEX(vc4_crtc->channel));
-	/* Top/base are supposed to be 4-pixel aligned, but the
-	 * Raspberry Pi firmware fills the low bits (which are
-	 * presumably ignored).
-	 */
-	u32 top = VC4_GET_FIELD(dispbase, SCALER_DISPBASEX_TOP) & ~3;
-	u32 base = VC4_GET_FIELD(dispbase, SCALER_DISPBASEX_BASE) & ~3;
-
-	vc4_crtc->cob_size = top - base + 4;
-}
-
 static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1175,8 +1178,6 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	 */
 	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
 
-	vc4_crtc_get_cob_allocation(vc4_crtc);
-
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index cda738dbd6c1..84e318098c5f 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -475,8 +475,6 @@ struct vc4_crtc {
 	u8 lut_r[256];
 	u8 lut_g[256];
 	u8 lut_b[256];
-	/* Size in pixels of the COB memory allocated to this CRTC. */
-	u32 cob_size;
 
 	struct drm_pending_vblank_event *event;
 
-- 
git-series 0.9.1
