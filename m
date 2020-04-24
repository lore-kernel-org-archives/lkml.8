Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D301C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6740320706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YWCgyyWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gk936bFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgDXPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:04 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:55105 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbgDXPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B96943E9;
        Fri, 24 Apr 2020 11:36:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=tCu9N/0DYaTKd
        zput/rwIDzoBFeoKGcV0BJL7O264Xg=; b=YWCgyyWceT0BRhd6Rh2BP7yBtD9Bp
        kpyB6QV9+hmIEUhi0uwmeaoSJsaQ+WP9BSTy0qDbY2vtduVNYU/U0CEnVzPcPTvd
        mTvrO6ortu9vEAC6+W3fm+jGbGOyia1JlzE/HJKVolyZfEu2JS2irE8PxroQ51PL
        /2I3AZWQWYhOZsI/sjfnTbkQ3Wn4JQKG7fPAgBkTVuaNaYbp9tI3CQdMO24uwOaO
        C6GsSkcPCcAHFs6Zww4lrGHYhvcsvxIIfgwtsQmTcnE4oypFwI99JdGnpYt29jl2
        xEfyEfHxty6LCGUVH62wcJga7Dtbj5ngC3safWR/tuGoVPnDQaZuTzajg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tCu9N/0DYaTKdzput/rwIDzoBFeoKGcV0BJL7O264Xg=; b=gk936bFW
        W9bWh9ROpBvjgYOecO3zoZp4NrEcx46upv/tpTCjAsZDJS1IcH9Vj1hmB7VSxMgk
        Fu/PvMM0RHCKk979aFPEtGVAOFrjRroyixKLjKDrD4Q2PMys7hNPWbzw6sB//hg2
        aDcXlarin1e03Vrt7prbkfxrXkhQPG5cOwhrIfHf1yUgJ1qx07pzGDB3F6kFu1cz
        2t2JvHqhcryo9a9DGC2xbbwdQk520mAKhCNdD8FBAvXrqIRSbI8GDh6c8eLPOc9X
        wfd0I+c0DaqUbkIpb1og1xZUMSASvZHDnMxP9VSNj6UZUiBQ8ZP6igh84wmvJ6bh
        8IG054UoyObyLA==
X-ME-Sender: <xms:bgejXor5jYMuocadofo137TMZTxMlae_lR2ELFXMh-MpQyRVTxcheQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvleenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bgejXhrtE9hmdMbb9aOc_dhh0grJxkzKfpXGLxPRUvVW02gOhCLLNA>
    <xmx:bgejXnEs_pfJg965P6UB9zOs0utwYJ_PMWJjks7pgZsGRgalT679sQ>
    <xmx:bgejXq-L7VTiVSd583uPrjR5yR2AYaJwQGTNSkqDY49zTOIuBKKkZQ>
    <xmx:bgejXuOrRqRNlQnPiDgAiUlGRGLCKePhFRsibysiq9sFhDuqx8XQOQoTUTM>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04EDF3065CDA;
        Fri, 24 Apr 2020 11:36:13 -0400 (EDT)
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
Subject: [PATCH v2 37/91] drm/vc4: plane: Improve LBM usage
Date:   Fri, 24 Apr 2020 17:34:18 +0200
Message-Id: <321a0f22068a9f13c792d49e39eedca916a358b2.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

LBM allocations were always taking the worst case sizing of
max(src_width, dst_width) * 16. This is significantly over
the required sizing, and stops us rendering multiple 4k images
to the screen.

Add some of the additional constraints to more accurately
describe the LBM requirements.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 1575c05e3106..602927745f84 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -142,9 +142,10 @@ static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
 	return NULL;
 }
 
-static enum vc4_scaling_mode vc4_get_scaling_mode(u32 src, u32 dst)
+static enum vc4_scaling_mode vc4_get_scaling_mode(u32 src, u32 dst,
+						  bool chroma_vrep)
 {
-	if (dst == src)
+	if (dst == src && !chroma_vrep)
 		return VC4_SCALING_NONE;
 	if (3 * dst >= 2 * src)
 		return VC4_SCALING_PPF;
@@ -369,9 +370,11 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
 		return ret;
 
 	vc4_state->x_scaling[0] = vc4_get_scaling_mode(vc4_state->src_w[0],
-						       vc4_state->crtc_w);
+						       vc4_state->crtc_w,
+						       false);
 	vc4_state->y_scaling[0] = vc4_get_scaling_mode(vc4_state->src_h[0],
-						       vc4_state->crtc_h);
+						       vc4_state->crtc_h,
+						       false);
 
 	vc4_state->is_unity = (vc4_state->x_scaling[0] == VC4_SCALING_NONE &&
 			       vc4_state->y_scaling[0] == VC4_SCALING_NONE);
@@ -384,10 +387,12 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
 
 		vc4_state->x_scaling[1] =
 			vc4_get_scaling_mode(vc4_state->src_w[1],
-					     vc4_state->crtc_w);
+					     vc4_state->crtc_w,
+					     v_subsample == 2);
 		vc4_state->y_scaling[1] =
 			vc4_get_scaling_mode(vc4_state->src_h[1],
-					     vc4_state->crtc_h);
+					     vc4_state->crtc_h,
+					     v_subsample == 2);
 
 		/* YUV conversion requires that horizontal scaling be enabled
 		 * on the UV plane even if vc4_get_scaling_mode() returned
@@ -437,10 +442,7 @@ static void vc4_write_ppf(struct vc4_plane_state *vc4_state, u32 src, u32 dst)
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
@@ -448,6 +450,11 @@ static u32 vc4_lbm_size(struct drm_plane_state *state)
 	    vc4_state->y_scaling[1] == VC4_SCALING_NONE)
 		return 0;
 
+	if (vc4_state->x_scaling[0] == VC4_SCALING_TPZ)
+		pix_per_line = vc4_state->crtc_w;
+	else
+		pix_per_line = vc4_state->src_w[0];
+
 	if (!vc4_state->is_yuv) {
 		if (vc4_state->y_scaling[0] == VC4_SCALING_TPZ)
 			lbm = pix_per_line * 8;
@@ -583,7 +590,9 @@ static int vc4_plane_allocate_lbm(struct drm_plane_state *state)
 		spin_lock_irqsave(&vc4->hvs->mm_lock, irqflags);
 		ret = drm_mm_insert_node_generic(&vc4->hvs->lbm_mm,
 						 &vc4_state->lbm,
-						 lbm_size, 32, 0, 0);
+						 lbm_size,
+						 vc4->hvs->hvs5 ? 64 : 32,
+						 0, 0);
 		spin_unlock_irqrestore(&vc4->hvs->mm_lock, irqflags);
 
 		if (ret)
-- 
git-series 0.9.1
