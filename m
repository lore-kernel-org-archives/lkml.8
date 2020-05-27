Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3988C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA93520C09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="u5Hmc9hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiCwZt4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbgE0Pts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40009 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390141AbgE0Ptn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 29E8958201B;
        Wed, 27 May 2020 11:49:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=tCu9N/0DYaTKd
        zput/rwIDzoBFeoKGcV0BJL7O264Xg=; b=u5Hmc9hjI4vjy+9mBkIG/GvwQ4hY6
        27y07L/GeLlqHRogQjc5lEFtIhLfh+jB1u2p9EEW+l93tMdK+y9/NxD144kuuSK4
        Dog+kXzAsPSc+OZUfRotI1Q9qsRVQ3NG2HEf6UtmpybLqlLEqnf9mGScDqrsES+Z
        Ob6Qlz8YzG8TyknyYzhnU+jZZg/VFeJ4gYy+3aM/Vn7ECzZonXloGL2SY+JIbFCJ
        Zj29yWGe0YkFKIuOfImlGrElBG9GHvA8l7wLZUD5wnHUtH4sLkPhJzje7KDA/YEX
        mmavbOL7y/QiA+FzEBymbpf4T6cjnbngEMW8Um1APFeW/Wz6MbLmRBh3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=tCu9N/0DYaTKdzput/rwIDzoBFeoKGcV0BJL7O264Xg=; b=iiCwZt4/
        KN6pdWuZIEVTVwrYX8zSbitkHK+XA9VHl6Vy3Hgy8N8HEiEbMyRF132uyWkwsfQG
        LpV6XUiIS/VbGbauG354kjkWt061Ew7cXgvFM3eRhUCgr5WxDLXUHD6pBacbDEsE
        JvJXPi7/Wul6E9HwQbquzYILioSxn62RWWy24Q2BIgItXH2sJ9xwp8Ct7fZM8JNL
        Pzi9eV1BlQpoRSm8s4gHGMDj9y8hMD52C/+U58GUHlJ/qBSoCG5x0STlYvk8MpU3
        IwahX3ACwVf4C3CGicKMHz3+kCGtdyIfeRkTiqetC4rJR7CZUqF8WS0fpaW55DTz
        HMjCYV2kvquooA==
X-ME-Sender: <xms:FYzOXgzHxDvECtfWE_eeNU07jPZ13QSY2jA0Npd3dkqEB_3TM4T6_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FozOXkSko2zzhod18GbglxDEGyhDlqxVm8o2ods6ZJHFgash9FN7fw>
    <xmx:FozOXiVhUqWCuh2CQs0TVK_JScqq8_hX9ZctA4SfxnV-XmtQTbQRMg>
    <xmx:FozOXugGWlApJyOqz9pP4n1OL7vBIp1isz3sc5slVhGhI67zXYlELA>
    <xmx:FozOXoDHDr6bfQ2WwhtB4-7JUzwQ8IwUDBigEujUv3K78zJertgYag>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF7673280069;
        Wed, 27 May 2020 11:49:41 -0400 (EDT)
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
Subject: [PATCH v3 016/105] drm/vc4: plane: Improve LBM usage
Date:   Wed, 27 May 2020 17:47:46 +0200
Message-Id: <44e3ec27ee6c0d81c440cd2d6cdd1bf93ea102e7.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
