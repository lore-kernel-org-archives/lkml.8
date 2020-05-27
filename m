Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570FB2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GTHvq7BU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DmLvZIFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgE0PuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:16 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46583 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390180AbgE0PuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA5B5582047;
        Wed, 27 May 2020 11:50:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=tK1sPZc0eto3z
        3gDAjTjmk5epnbO+EUqvo+nfO7QKg4=; b=GTHvq7BUjhPoi6mWZH4KmBNdZsm12
        XetJZ7ezG2R44lQsom2amyjCajgbLqBuzazqizE8t/y0Jmr9nDK7RucvWnfoAq6S
        Lh3jf1H23HlShmi77TnURpuJP3m84UnEk6FDYjo+OMdpPD8vV570QZvMYzel1wiZ
        GyhYWvh50Ap0Mq7afoqWtlHj1Svbsp+RTVdEGny7laLljZcAXkDLdxd+JpCd3Mwd
        5F7pFn3rE4OJwpoKiUvk/Qs3z6pqJuPL5B8yW6R+OroeaM8sy0uBRPuSQPie0sFr
        T/wZAxmHlru3WfNhT+wTbIKAwlf5/28hKSFRUNCaCFPPNb/D5rSitDFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tK1sPZc0eto3z3gDAjTjmk5epnbO+EUqvo+nfO7QKg4=; b=DmLvZIFj
        0wiCBpo/tCxDr3LZ0P+kxWkVWjxPiAwOCxbHNrSxKuhPhLK7f/EsTCKvw/3+CA/f
        p6nNrOMJcT+bUzI8AujhnzgLSRRmWbFZqRzQ0qaErrqF9yxi+x7jWqV2DvIOqxNm
        1E0OwFHkF8AEM6T8fqUYTbKqUv6ZAgbt0xjkAMnJsdu9L7pt6ZbxmTgnZdMUrlXS
        KX6sM3uYMwBoRDK134nb0/iAMANlCU+L7ABaMtSGQrkLhKlUTsnBbsktVwPgOXXi
        xoiF2tx83DJH9NzChIVyK+pJ1/4f1B3JiZ/wyjOheCNRdA5ZMQ8am8OxAI8gEeuy
        X7Hn1lRiT59pZQ==
X-ME-Sender: <xms:K4zOXriJY-ZWP1vtJKX5jh38HmiJjtcg7YNkL8wxljYoPPOEdUu7Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepuddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:K4zOXoAPs1N8ye02GgENVLkmdr6EMO7FMKxFbOsZb-fYeG10EQYUHQ>
    <xmx:K4zOXrHxisQabacy1m3f9I5dEr0ldICUcFV7R6VJiFmaIGyve1iQmA>
    <xmx:K4zOXoRaXRaIniZsjttjFb0tPGYdtnpzHxnHloy1qgZ-oSXFVk1TrQ>
    <xmx:K4zOXrx5_55YQhc08xtmgs64sxaS8PxGlm5J104NrKB4kocEWfZZ5A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 040FD30624CC;
        Wed, 27 May 2020 11:50:01 -0400 (EDT)
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
Subject: [PATCH v3 029/105] drm/vc4: crtc: Move the cob allocation outside of bind
Date:   Wed, 27 May 2020 17:47:59 +0200
Message-Id: <1c2c039ca885db63186491275708dbe4371b704c.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
 drivers/gpu/drm/vc4/vc4_crtc.c | 36 ++++++++++++++++-------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |  2 +--
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 5e1d234f3c8e..d58f881649d5 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -65,6 +65,20 @@ static const struct debugfs_reg32 crtc_regs[] = {
 	VC4_REG32(PV_HACT_ACT),
 };
 
+static unsigned int
+vc4_crtc_get_cob_allocation(struct vc4_dev *vc4, unsigned int channel)
+{
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
@@ -74,6 +88,7 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 	struct drm_device *dev = crtc->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	unsigned int cob_size;
 	u32 val;
 	int fifo_lines;
 	int vblank_lines;
@@ -109,8 +124,9 @@ static bool vc4_crtc_get_scanout_position(struct drm_crtc *crtc,
 			*hpos += mode->crtc_htotal / 2;
 	}
 
+	cob_size = vc4_crtc_get_cob_allocation(vc4, vc4_crtc->channel);
 	/* This is the offset we need for translating hvs -> pv scanout pos. */
-	fifo_lines = vc4_crtc->cob_size / mode->crtc_hdisplay;
+	fifo_lines = cob_size / mode->crtc_hdisplay;
 
 	if (fifo_lines > 0)
 		ret = true;
@@ -1106,22 +1122,6 @@ static void vc4_set_crtc_possible_masks(struct drm_device *drm,
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
@@ -1176,8 +1176,6 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	 */
 	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
 
-	vc4_crtc_get_cob_allocation(vc4_crtc);
-
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 8c0f714f557b..6c4b78b71446 100644
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
