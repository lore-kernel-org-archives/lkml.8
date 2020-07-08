Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0126AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FA6206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VWW54A6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFEq3mun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgGHRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:42:45 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44797 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgGHRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 29ADE2F9;
        Wed,  8 Jul 2020 13:42:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=w13OGPPr5xLPF
        fNdGgAvwXGU0LzBOM3S5NR8R2EchZ0=; b=VWW54A6cXbJAGiR7gCKlePNvuBYvS
        3ajlFKyNBvKC4nRpMw8tN8q2667aYl6ZOOoZQeQ2AjnRZjKijqbOAUMCVTH9sMBo
        9/HSoq4IfmQMxtAtvYMSn9QzrRgfWNVlM/VaEPZoESTWZms4rcKdLQZ59y06Iz5f
        QaT4s4ASNR1F+izYKQoyPsTiGapeMEtIGSYlEMeiXby892lG478HN9CafXug6ckZ
        EEUjDBaZyAnmKUz6Smi7nyjdqWejnTkjY/Ux8/zyoBM12iKYEjmbs1PixWKp0j4G
        O1Jds/4wOaCGpSh9EluOGAfh4u6e8yqiYpYh5CcobwjofifYGSDPqxU2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=w13OGPPr5xLPFfNdGgAvwXGU0LzBOM3S5NR8R2EchZ0=; b=YFEq3mun
        ukcivyxLZ23yXOuHIrIRnFI2zGXW/mTKTujjRaE5dqHib8TI/O3DMFzFVicq/Eht
        bKbnw8rg9WoaeOc8rUiAlyouG6ZVi/1anxSu9+VH+ewpmx7G8bR/q/SrCTZHSf+G
        fHPhsgbEuF7DsUGk7kIljA4Rettv+EoRJ0vh0jMD3jSY6RK9kOs1w7uyQRUZmW07
        ae7UGZDMagsrb4rDN6S01RpzDBHENMfW1MxZIUXwKDh5YKo/impzzfIbXtRmcgvu
        h66OiXKK+OmAv876dxphq48TH4QS1rnuuNc0UJOg7hp0UX2puqFeXn0F4RFXa/0y
        +P3C0y5IR5YQSA==
X-ME-Sender: <xms:jgUGX8tkpKmnLa53hRMdvgST2G5VfbtJTHc7Q-bnkRiLNujSSW7AOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jgUGX5dopyp4ywQlVRsn4TNXhi_YX6FqfpRfymSZcMA-9QsCMC7Y7Q>
    <xmx:jgUGX3yK0-VCaTNrKATiWpD2PHNfnxEGDSHQZSTMZaLgNUeCdPhhxA>
    <xmx:jgUGX_PKsGBtBHqXbXNHZ4ZNZORwp5oEDQ4b6c972g2ypktL3hVuWQ>
    <xmx:jgUGX5NGKBqLrD3HKeRfxqGxRFri2xoqbZ7otX3r5A4imCIP1QsyOrCfmzk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6810D30600A3;
        Wed,  8 Jul 2020 13:42:38 -0400 (EDT)
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
Subject: [PATCH v4 05/78] drm/vc4: plane: Optimize the LBM allocation size
Date:   Wed,  8 Jul 2020 19:41:13 +0200
Message-Id: <3496764856363a45b80c0505da486fdeb8a48feb.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The current code is using the maximum of the source line size and the
destination line size to compute the size of the LBM to allocate.

While this is simpler, it starts to be an issue with modes such as 4k with
a quite long that will consume all the available memory, so we no longer
have that luxury.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index d0771ebd5f75..23916814b4e3 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -437,10 +437,7 @@ static void vc4_write_ppf(struct vc4_plane_state *vc4_state, u32 src, u32 dst)
 static u32 vc4_lbm_size(struct drm_plane_state *state)
 {
 	struct vc4_plane_state *vc4_state = to_vc4_plane_state(state);
-	/* This is the worst case number.  One of the two sizes will
-	 * be used depending on the scaling configuration.
-	 */
-	u32 pix_per_line = max(vc4_state->src_w[0], (u32)vc4_state->crtc_w);
+	u32 pix_per_line;
 	u32 lbm;
 
 	/* LBM is not needed when there's no vertical scaling. */
@@ -448,6 +445,18 @@ static u32 vc4_lbm_size(struct drm_plane_state *state)
 	    vc4_state->y_scaling[1] == VC4_SCALING_NONE)
 		return 0;
 
+	/*
+	 * This can be further optimized in the RGB/YUV444 case if the PPF
+	 * decimation factor is between 0.5 and 1.0 by using crtc_w.
+	 *
+	 * It's not an issue though, since in that case since src_w[0] is going
+	 * to be greater than or equal to crtc_w.
+	 */
+	if (vc4_state->x_scaling[0] == VC4_SCALING_TPZ)
+		pix_per_line = vc4_state->crtc_w;
+	else
+		pix_per_line = vc4_state->src_w[0];
+
 	if (!vc4_state->is_yuv) {
 		if (vc4_state->y_scaling[0] == VC4_SCALING_TPZ)
 			lbm = pix_per_line * 8;
-- 
git-series 0.9.1
