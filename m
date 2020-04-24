Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7BFC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F220767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hVgh4s1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0BusZXTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgDXPkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:13 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40435 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728463AbgDXPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 595891444;
        Fri, 24 Apr 2020 11:36:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=UdgYbZrIwJnSM
        Hscz6inzr3NelpnaolYLVN8TL98PDY=; b=hVgh4s1OSZwh1pGJXjUfnfjUOPRt+
        mhIdPTX+1RN8gv8XJ4ZKop7Bq7vCIejFJZMjMp68iTn4jTBQNL35Z328T8GdudTU
        Mom1umQ0VW4ldGLtsSxEX5xAkx3h1gtWBL1O8pmIBG8cp+mK9G21pjQsZniJJfN9
        EBQyRPBoLBuNV/H3rIqj8/Hrm3eG2vSu/QD2LY0rHgidhxiAqiakhTaQWh/aQskZ
        oFkQnjhuu1fsGPTUQcTAxDMYSCj/88OI+3pxUpzGrjdn1OaeLeUegd1iYBwafURp
        wto5/koDx8NhUIqCqCSxneAn8EfusoM3l/g12rcliSDTAHvOhjl9m3P5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=UdgYbZrIwJnSMHscz6inzr3NelpnaolYLVN8TL98PDY=; b=0BusZXTW
        Ept8UTHEPUQk+SG72HeV8u+bTJJRazreReLeHY69WWc+nljFWHN1w5Hv1UpsFj6a
        SBOzIUjkvSQagbmirJ31NjVkd6pLCIlkkj49EyWs6pjHMkBnGDz882FTH2rTJxIa
        TG7OjAWZ/4sQV72PR4TdG+AhARr5sCQlkYKuCmwYuO49nZKMAZcZCrZI/5VU6dfH
        n7bXR5Xyv1Rg++uTvTBQaOrPJYUjn5zB933agz+iPifMCf/ps0JK0txxgQlavvHM
        4Ms96MtG4AzkE6nCCpeR1daaOq/2S+eJf3aE3qxUOUbY1JpEK4UyxA70dA4rUIvT
        0VQ2GmltoFi3cA==
X-ME-Sender: <xms:aAejXpfWeSa3NpHKz-4oLDjF1gmr5N8VdaxLB_WEV2HGG1EFJHWAog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvheenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aAejXluQSr3b_qefsCvDKTKiVA0COpPSfhAqjLzMWCDzyWRXVwAQog>
    <xmx:aAejXuB3czI_CXqwWvxzP7iZRpKxvSsqm9TlvOlxLX9gOWaN5Itndw>
    <xmx:aAejXtHd2N0XU64vf-m3ivb2IPpmLl3iPlHR9o-q1jhV2kCuwDaldA>
    <xmx:aAejXh4OIt2bRC67WrFpEKJq6L50KiKlAzcRu2QcfjUkZiRDfuebAxlgqsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F13A3065DA4;
        Fri, 24 Apr 2020 11:36:08 -0400 (EDT)
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
Subject: [PATCH v2 33/91] drm/vc4: drv: Support BCM2711
Date:   Fri, 24 Apr 2020 17:34:14 +0200
Message-Id: <e56e77704251cd4fdf5caa1ef7c64138dc763a1a.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 has a reworked display pipeline, and the load tracker needs
some adjustement to operate properly. Let's add a compatible for BCM2711
and disable the load tracker until properly supported.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.c   |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h   |  3 +++
 drivers/gpu/drm/vc4/vc4_kms.c   | 32 +++++++++++++++++++++-----------
 drivers/gpu/drm/vc4/vc4_plane.c |  5 +++++
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 76f93b662766..d7f554a6f0ed 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -364,6 +364,7 @@ static int vc4_platform_drm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_of_match[] = {
+	{ .compatible = "brcm,bcm2711-vc5", },
 	{ .compatible = "brcm,bcm2835-vc4", },
 	{ .compatible = "brcm,cygnus-vc4", },
 	{},
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index e7748f8e2967..6024de9ecd35 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -201,6 +201,9 @@ struct vc4_dev {
 
 	int power_refcount;
 
+	/* Set to true when the load tracker is supported. */
+	bool load_tracker_available;
+
 	/* Set to true when the load tracker is active. */
 	bool load_tracker_enabled;
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 78d4fb0499e3..71e7211a5fb9 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -415,6 +415,9 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
 	struct drm_plane *plane;
 	int i;
 
+	if (!vc4->load_tracker_available)
+		return 0;
+
 	priv_state = drm_atomic_get_private_obj_state(state,
 						      &vc4->load_tracker);
 	if (IS_ERR(priv_state))
@@ -514,10 +517,14 @@ int vc4_kms_load(struct drm_device *dev)
 	struct vc4_load_tracker_state *load_state;
 	int ret;
 
-	/* Start with the load tracker enabled. Can be disabled through the
-	 * debugfs load_tracker file.
-	 */
-	vc4->load_tracker_enabled = true;
+	if (!of_device_is_compatible(dev->dev->of_node, "brcm,bcm2711-vc5")) {
+		vc4->load_tracker_available = true;
+
+		/* Start with the load tracker enabled. Can be
+		 * disabled through the debugfs load_tracker file.
+		 */
+		vc4->load_tracker_enabled = true;
+	}
 
 	sema_init(&vc4->async_modeset, 1);
 
@@ -547,14 +554,17 @@ int vc4_kms_load(struct drm_device *dev)
 	drm_atomic_private_obj_init(dev, &vc4->ctm_manager, &ctm_state->base,
 				    &vc4_ctm_state_funcs);
 
-	load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
-	if (!load_state) {
-		drm_atomic_private_obj_fini(&vc4->ctm_manager);
-		return -ENOMEM;
-	}
+	if (vc4->load_tracker_available) {
+		load_state = kzalloc(sizeof(*load_state), GFP_KERNEL);
+		if (!load_state) {
+			drm_atomic_private_obj_fini(&vc4->ctm_manager);
+			return -ENOMEM;
+		}
 
-	drm_atomic_private_obj_init(dev, &vc4->load_tracker, &load_state->base,
-				    &vc4_load_tracker_state_funcs);
+		drm_atomic_private_obj_init(dev, &vc4->load_tracker,
+					    &load_state->base,
+					    &vc4_load_tracker_state_funcs);
+	}
 
 	drm_mode_config_reset(dev);
 
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 91e408f7a56e..57a73a2e2e5c 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -492,6 +492,11 @@ static void vc4_plane_calc_load(struct drm_plane_state *state)
 	struct vc4_plane_state *vc4_state;
 	struct drm_crtc_state *crtc_state;
 	unsigned int vscale_factor;
+	struct vc4_dev *vc4;
+
+	vc4 = to_vc4_dev(state->plane->dev);
+	if (!vc4->load_tracker_available)
+		return;
 
 	vc4_state = to_vc4_plane_state(state);
 	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
-- 
git-series 0.9.1
