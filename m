Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327EC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6402080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="osFzyJsf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPeOci/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBXJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:18 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40335 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727938AbgBXJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id ED45C616;
        Mon, 24 Feb 2020 04:09:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=CXHdiG9U8EDuW
        CnCZKkwdZQss3NgmVso6HcYjtytaAQ=; b=osFzyJsfTKDvzGTpTfY1rRAaGSv5q
        CtnReunvWD65+Vx0qX6cLKx33W6FMlPy3S4HraLj+IhaLrkB2ymofYxnru/GhlOm
        +lOUnbgqYh+0DF5GXttQfb7WNTRzprLomG6IJQpQqATFiGOAF65mX9PhgnTUxhBh
        w35tupkgGSR0dQmAMyjVIH4vrYto6iBmGVCp1+y3EEknBuKyuhVMYweQwTXiYoYq
        oa8rG1XViFwsrAxf+E/+h/KVhFi52FdhkYvz5YbQsuXKJC6Jd8N/ILgG5QDP9r6K
        cBDJ/F27oxstoO9U4K0Nqm8ylhwsbbd3H+FFPnS2RFT6D1bJeIc1ZxT7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CXHdiG9U8EDuWCnCZKkwdZQss3NgmVso6HcYjtytaAQ=; b=LPeOci/a
        gbhbUBPHNFLNaBXjAK60H6jOdGImhxFj1WaRItVITvh/JG5bl2n4lWE3VwZ+ndxU
        eFTNWxLyeoYdVzfV2AZbeRniIrazHhaemWDx0fz337tsia8kMJ1+x+LiHTGfyPT5
        yF0K0GDUzkfV8Zt9+VH9ALnhztzaLX8sQnoMa6n/4B/Fd5Uf1PExq+f+mmz9/sSd
        y3BEcgEMuee77aSa8xOKKS0RQIb5AlRSPF8XK1KlODpCmPWNfalB2LCsGxUF3R4y
        XDJdn9SMQxz+2GjmqxpX8aCEDweMhkyRzIcTGwxDWFJnB/joIWj4+o5XsN4FDOhq
        TuDyF8f88RhUhQ==
X-ME-Sender: <xms:3JJTXnBgvbA_29t1Xq1e6VGI9r1Mg_rrO3_Xu_YA4YSNsJePksnnhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeehnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3JJTXhxMgTra0UJPiBbf6Wi7FAEIgfA23LcGHF8E_WtK99bqYhshNQ>
    <xmx:3JJTXmKDj4d0k95F0uCDl7mQTDpbmAT0_mKF5oENiSiwchj3vUBCWQ>
    <xmx:3JJTXo4NqRrimlNKpwALHc4ATqGugWrxHaGjnRFTrKxZyIn_eYFSHg>
    <xmx:3JJTXuLqzzTUrjIMXjoXVm3nOvnwDCyUP6WzligyfBAX-2ydy60v3VrrKTA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4A9243060BD1;
        Mon, 24 Feb 2020 04:09:48 -0500 (EST)
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
Subject: [PATCH 41/89] drm/vc4: plane: Create overlays for any CRTC
Date:   Mon, 24 Feb 2020 10:06:43 +0100
Message-Id: <faaea57a74a0e35ae6d8f22cf120cd9b56c9c329.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have everything in place, we can now register all the overlay
planes that can be assigned to all the CRTCs.

This has two side effects:

  - The number of overlay planes is reduced from 24 to 8. This is temporary
    and will be increased again in the next patch.

  - The ID of the various planes is changed again, and we will now have all
    the primary planes, then all the overlay planes and finally the cursor
    planes. This shouldn't cause any issue since the ordering between
    primary, overlay and cursor planes is preserved.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 35 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 1dcb2ccd65bb..ea1d848aad14 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1378,26 +1378,27 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
 	struct drm_crtc *crtc;
 	unsigned int i;
 
-	drm_for_each_crtc(crtc, drm) {
-		/* Set up some arbitrary number of planes.  We're not limited
-		 * by a set number of physical registers, just the space in
-		 * the HVS (16k) and how small an plane can be (28 bytes).
-		 * However, each plane we set up takes up some memory, and
-		 * increases the cost of looping over planes, which atomic
-		 * modesetting does quite a bit.  As a result, we pick a
-		 * modest number of planes to expose, that should hopefully
-		 * still cover any sane usecase.
-		 */
-		for (i = 0; i < 8; i++) {
-			struct drm_plane *plane =
-				vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
+	/* Set up some arbitrary number of planes.  We're not limited
+	 * by a set number of physical registers, just the space in
+	 * the HVS (16k) and how small an plane can be (28 bytes).
+	 * However, each plane we set up takes up some memory, and
+	 * increases the cost of looping over planes, which atomic
+	 * modesetting does quite a bit.  As a result, we pick a
+	 * modest number of planes to expose, that should hopefully
+	 * still cover any sane usecase.
+	 */
+	for (i = 0; i < 8; i++) {
+		struct drm_plane *plane =
+			vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY);
 
-			if (IS_ERR(plane))
-				continue;
+		if (IS_ERR(plane))
+			continue;
 
-			plane->possible_crtcs = drm_crtc_mask(crtc);
-		}
+		plane->possible_crtcs =
+			GENMASK(drm->mode_config.num_crtc - 1, 0);
+	}
 
+	drm_for_each_crtc(crtc, drm) {
 		/* Set up the legacy cursor after overlay initialization,
 		 * since we overlay planes on the CRTC in the order they were
 		 * initialized.
-- 
git-series 0.9.1
