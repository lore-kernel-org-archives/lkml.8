Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F758C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2AA20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oSXFSYjQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7NTrXbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgDXPju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:50 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60323 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgDXPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 96908143F;
        Fri, 24 Apr 2020 11:36:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=oSQosAw4Q7vGc
        L01pDAaCeuv0svJvci7XNfnDxhY4go=; b=oSXFSYjQObu3vcNrYbR+Dk5ILlF+k
        pMt/BaE4vJ/DNZ/aEFjg33T6IIUcdLmIsnq3ZzjBWSoe1vyheouMB+VUHiRxRtJ2
        ewcQX/iqaTQSfe36F+h/KYQgpCyRaOR2HyxF4m/hiF/Hvn4cSKGzL/YmV/Gy5oSM
        5xM3CxkofxB1Sn6Y3e9sngNyftfcy4/5aYm4kO/r/SiznHXEk9X8lo1g2y0BZIVs
        fdEdrgb63EnzJr3ce1GCy+1f5ouDtbxws7VGQrhW3w16uDuyGei+4a9LvJLfgcea
        5Hx1OnC5lD/C8kuBbncCpIuZWacsRKllzWEQbHIWAM82f9TV0L1OdIKfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oSQosAw4Q7vGcL01pDAaCeuv0svJvci7XNfnDxhY4go=; b=I7NTrXbJ
        7Yhoea9zCVQaHEl+KonYaR7neXCWL29lbC/PfrcD6ErwHow+ISehQtbA/Edht8QD
        38dWwuV1rmh4e1zluzhu0YAG6dMrkCitfginyb3Hnc0WOS57qh9+OcUHRPpQLiPs
        tlCCiumbNQG/JGpgQLK45q8Tiurj/hn6oMc6ND2mF0J66j0jhcw2lvH/x6NM5za5
        EawPhcjVMyDV011BiLcmFhyAiWA5RdKyRC+vm4Fh+0q/5fsSx6GSWeBLX8E27fy1
        Wxf/SiOxz6GIM1usMvWwpp5X/+BuCFKB7l1LCKedBNzKbHyjYYKRPi/+ekoNJuVo
        bAcx1YBsm0378Q==
X-ME-Sender: <xms:cQejXsalXkeVkG9HYuoR4t9yB1BtRL8_QwkioJoW0G1kFHl9AKwgAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefgeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cQejXv1wjZHPFFahpv51lcH-rntfd2IAyuUU9I9hSNqWBxNvok8z3A>
    <xmx:cQejXsmTjSmrpzgmOpY0kI9zAOncc98kscwPpV09F477PYzvFJBmDw>
    <xmx:cQejXqupynLWV0KUiPmiC7aPlXk2yBk02xVUfIJaRNP7Vqtaw8YjPw>
    <xmx:cQejXiSXuMtNzB97TkhEGd9DeqchlKbFmqjk8l5SG-8lNyYgV7W1jAa5zog>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C12DD3065DA3;
        Fri, 24 Apr 2020 11:36:16 -0400 (EDT)
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
Subject: [PATCH v2 39/91] drm/vc4: plane: Move additional planes creation to driver
Date:   Fri, 24 Apr 2020 17:34:20 +0200
Message-Id: <6ea3f6cad2d8e64a6b7c3294505839b4e5c8b9d2.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the plane creation was done when each CRTC was bound, and those
planes were only tied to the CRTC that was registering them.

This causes two main issues:
  - The planes in the vc4 hardware are actually not tied to any CRTC, but
    can be used with every combination

  - More importantly, so far, we allocate 10 planes per CRTC, with 3 CRTCs.
    However, the next generation of hardware will have 5 CRTCs, putting us
    well above the maximum of 32 planes currently allowed by DRM.

This patch is the first one in a series of patches that will take down both
of these issues so that we can support the next generation of hardware
while keeping a good amount of planes.

We start by changing the way the planes are registered to first registering
the primary planes for each CRTC in the CRTC bind function as we used to,
but moving the overlay and cursor creation to the main driver bind
function, after all the CRTCs have been bound.

This will slightly change the ID order of the planes, since the primary
planes of all CRTCs will be first, and then a pattern of 8 overlays, 1
cursor plane for each CRTC.

This shouldn't cause any trouble since the ordering between the planes is
preserved though.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 4 ----
 drivers/gpu/drm/vc4/vc4_drv.c  | 7 +++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 29c72c322c6b..2131164779dd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1192,10 +1192,6 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	 */
 	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
 
-	ret = vc4_plane_create_additional_planes(drm, crtc);
-	if (ret)
-		goto err_destroy_planes;
-
 	vc4_crtc_get_cob_allocation(vc4_crtc);
 
 	CRTC_WRITE(PV_INTEN, 0);
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d7f554a6f0ed..daf07a61a7b5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -250,6 +250,7 @@ static int vc4_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm;
+	struct drm_crtc *crtc;
 	struct vc4_dev *vc4;
 	struct device_node *node;
 	int ret = 0;
@@ -288,6 +289,12 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret)
 		goto gem_destroy;
 
+	drm_for_each_crtc(crtc, drm) {
+		ret = vc4_plane_create_additional_planes(drm, crtc);
+		if (ret)
+			continue;
+	}
+
 	drm_fb_helper_remove_conflicting_framebuffers(NULL, "vc4drmfb", false);
 
 	ret = vc4_kms_load(drm);
-- 
git-series 0.9.1
