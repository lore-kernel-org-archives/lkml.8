Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE7C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EAA20658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="gA8q8QDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oy4IsHXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBXJNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:33 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43291 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727355AbgBXJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 54090616;
        Mon, 24 Feb 2020 04:09:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=x6EiQ/3Kh9/Dc
        ewSo4uUKE9sdgK8FyyTne2GvDeYpZw=; b=gA8q8QDvUXwCCce0Ul3XjIF7gfMVs
        xSnev/PCxs8pLULTphFYtLzPxVAEESxnU4qE33GLje0LsqGkuJD8RAOf+M8PNhk0
        w9bPlnw+UiD3744vMp1QJvF6T22V6QW9oLw2BuCmS3KgphU0ZTM0+BLZmsb6JXNX
        Q6FVv9WyqMu4nZUUFDJD6Xfrhow0oQf7gOKBKwHH39kK5LBM5Bk90+xLafE11vBl
        PaSEw/T1bL5N9gJSR4sJ2u0wks32eRIXP1Wau8LBOftRB3RqlrRxlJBTEhaZJB0Y
        bhj4HiJousejUF25yKeZLnXKYYb1IqUGYq/IeMKAS+cm5lz5usHALkhgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=x6EiQ/3Kh9/DcewSo4uUKE9sdgK8FyyTne2GvDeYpZw=; b=Oy4IsHXt
        ftsnzRiwQL9J18o9I35EpClCV5mAJJ9ZZ1z7hNGIXRVBZ1H+06ok4hv6/IjW4eHk
        aAPbFIIi/t/aEShEc8+NcFWm1yhOPuQX5DvvqhnPgdh7qyvZvFfbNB6cSNQS/pFJ
        LNTQxnUS593RoV5MENWGilmp7LSSwFxPv5vR5GDzgcqIBx0bV09Wn3GoxMqs7X+R
        nk31OXP0MWD8whuClboSRrbl0HFt5om2vXjHhoYt2OZGxAQi7kCudiDMAqq4S5hK
        xHl+WBqZ2HDcI04nvV4DLsSs2lmOkqx4CAGqqzF5E0pH1wTk0NOscB8T3WfSZRhm
        XcQ5aI/DBZ8SiA==
X-ME-Sender: <xms:1pJTXkEDRADzElSafl3zJwRS26gfbl7cO25pQ94rucwHj7dZ_21JLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfedunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1pJTXu1kr1hTUvi6W8WyZhwp3c_Nd4gb5ajmb7G5om7Mf6y8IUENRA>
    <xmx:1pJTXry_fApV8kmGUeM3-ET-G2Y-6UR0KZ3GigriHHYUTRNvmaDrIg>
    <xmx:1pJTXtg9cGG4-RfdJUwcYC8iNmLSe8gHkvTkAXEPZ40p-E8Iu8hIfw>
    <xmx:1pJTXmCjkM3SgB7vWBQUJvcL47cFipSlPtsiRBXYiDrgEn1t53XE4_jFBYU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9450F3060BD1;
        Mon, 24 Feb 2020 04:09:42 -0500 (EST)
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
Subject: [PATCH 37/89] drm/vc4: plane: Improve LBM usage
Date:   Mon, 24 Feb 2020 10:06:39 +0100
Message-Id: <155fc1ae0b330e1bb9292340096b306dfd6b6c4b.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
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
index 0b8309247dec..26e96b15e9b4 100644
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
