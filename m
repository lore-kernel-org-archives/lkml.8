Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB736C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894C820873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="yYHqLeeT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfCerUHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgE0P4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:56:51 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40009 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390141AbgE0Pts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:49:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3994D582030;
        Wed, 27 May 2020 11:49:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FGHgip5pCgsef
        Z4M/vFInKoncWLsvsxW7FNyZtJgmzk=; b=yYHqLeeTM+s0JuUFx5k0doTF+khCA
        MBjLG0djSmTRIK45cNzxKKflIclQE6lK9L5NNcA88H0nVyTHIoai5+m29VdWEAgd
        g6hj5UJ9w38de+R79XuPs3IZn+WNN7LqXOa26JU/k2k4k24kZuSebm86Lv+u/5WK
        JEk/m2JbhZqETNFE3kE92eWHOn9yBtuLIvLzcN7vC841OC+YonV7mLi9twFEaypn
        E01VW48VExpB7y2jGIBCYbQ3XtC54AnQHFsgKpE7Wu83dHIuH0g09rPzNRFDqByg
        p6NZgR939fYveNWH0Hf1oGv7xhxc0uAIICQkWAtF9Moh3Kqc2CtXDa7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FGHgip5pCgsefZ4M/vFInKoncWLsvsxW7FNyZtJgmzk=; b=mfCerUHn
        7tbvVA0B/mMWEDtBCMmONK31ovGYj0pCPhq/V/f90eZV4pXjKkDu5YNUgJXk9LNv
        v7GSN62YQRozBV1MSpFAmORDaYMYQi7S96zR5kEs2oBG5Ier51mKpyABx3ps5owa
        R3Zrp0oKg6rpno+5lw5YZ1cPssj3AA9myFwAgC8Yqdj1+mv+DtC70QyLHvJ6FY/Z
        +z12FnHnwuCyVfQ3JWKntM7/Wm4HaRyBeih33MOkUuXBGW5GRhOfMFtZo79Id8WZ
        sawnnhVTBfftSYQ5CeYdEYIFbuxjbbFv/tGInnxhxlRZqu5NPQ/kKeSn8TodwVHv
        3UbL6TACfPg3ng==
X-ME-Sender: <xms:HIzOXqFDH5o-_Qy8DUoOhUpkzTz8P9j95KfAeiNrynV22rLfRajVCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HIzOXrWNdPTSWzoB6wpWZwzQpRfhwEaaZpr-36HBCs5W8-mzwfD4cw>
    <xmx:HIzOXkJMLV2BuiPie6Foecpez46L9naT3InCIKJyLLgeKEBX6eB03A>
    <xmx:HIzOXkEwiCxK8dskKfOYGyBJIe84B28HgYqpdkHuoa182s4s6Xfd8w>
    <xmx:HIzOXjHvIAMGDv5JopO3lQ_WK5jTj3_5trhnXO7YJA1Hgi4tR-iQ4A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3457328005E;
        Wed, 27 May 2020 11:49:47 -0400 (EDT)
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
Subject: [PATCH v3 020/105] drm/vc4: plane: Create overlays for any CRTC
Date:   Wed, 27 May 2020 17:47:50 +0200
Message-Id: <74d84c75511974bc1ff4bc044413894a43a907a6.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
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
index 824c188980b0..5335123ae2a0 100644
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
