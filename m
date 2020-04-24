Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2750EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062A420776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="b3d1ztNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkghyNB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgDXPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:36:18 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:45555 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728486AbgDXPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:36:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5C246144D;
        Fri, 24 Apr 2020 11:36:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=DDQ/otaSac56i
        RPoiWof2TO+uS7QGjui1Jou2UPbw4k=; b=b3d1ztNGvQYiYrzy71PSaCDRiwmKo
        KEUQqU5As8v990P+3wa7DyWBC8Do6cHJI5X/2b9BZQz0CIX8lr2F2n+fvj7PWy3/
        FrUoPPTxdxImVt5kTkfpLCC7Ls2troocbNxj528K1/cZCB/p++bneols5qPpuAHf
        xo8qwFJSX2XVEGIr8actzARgLJE7AikfE+p+qbascov+ByUpu3P4ptHPF0MC4GbG
        Pv6z265Fvj3O/XzwALJjHIPm3Tfdr+3ZP4HnhgjA27o6eP/8kyS6Uzj0jJ5WyCqO
        oc6fz+JVYzvFxqDOThu2R/85mHEq9TjAxsoRQj5JRfXEKEeobtYGZMqIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=DDQ/otaSac56iRPoiWof2TO+uS7QGjui1Jou2UPbw4k=; b=kkghyNB0
        PnyXof+QVjsCWDz/luNPb1QeR8ce43Zb5oLatpUVCiPQau0rUMmTxRbD874xPgi5
        0khcVHLdEl79oITRiCwwP+fgxQRYYVGvxXmSmd9n9rb7UXC26UKcPOw4kADjrzoT
        5obL8K5j/oBuUwx5zdC+iCSTSwGhCUluhBaiWw9l1sqEwGYUqafkqTq74JtyKooY
        B7F7NjrSz9emgjJI6tPhuoq8PNakvcQ7TOVque21DCNB3Wjvb7bSlDUf/hVnyiZy
        8Xzo5S2uOw5LoqlCWwjFa1vCdDhpheRKdbP9O9Bu41bV+xZS88wJGZUajyqUcvHh
        NkgrQeIFzYDszw==
X-ME-Sender: <xms:bAejXviguTbO3jIIaa2S4IwJGtsN_Ko74x5qgzNoW82-bnUgL7K5AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvleenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bAejXgRPbSkVWjwtc_0B1fnHisSnqwVw5akBMogeUf8lGQU6hC4Dlw>
    <xmx:bAejXqEp4-l9o_ghcOONv1Qf265on5FWlltMKcq2kXHSVdsbD7RvYw>
    <xmx:bAejXglpirrtWsgAKFMV2WrzScoJ1FNzRrW4ey0NQxHLbSr5TNO5wA>
    <xmx:bAejXvM8Wn-zBHmavSNbpMYCHZvdRMEfteyLa1n_Kh0hJ3wiRgzSIYmmfSo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FCBF328005E;
        Fri, 24 Apr 2020 11:36:12 -0400 (EDT)
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
Subject: [PATCH v2 36/91] drm/vc4: hvs: Boost the core clock during modeset
Date:   Fri, 24 Apr 2020 17:34:17 +0200
Message-Id: <679dca5ae8e93eb994bbbae63d77588d3c3bf2ec.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent timeouts and stalls in the pipeline, the core clock
needs to be maxed at 500MHz during a modeset on the BCM2711.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_hvs.c |  9 +++++++++
 drivers/gpu/drm/vc4/vc4_kms.c |  7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 7da417feff5a..4fd6f72dec56 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -323,6 +323,8 @@ struct vc4_hvs {
 	void __iomem *regs;
 	u32 __iomem *dlist;
 
+	struct clk *core_clk;
+
 	/* Memory manager for CRTCs to allocate space in the display
 	 * list.  Units are dwords.
 	 */
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 0fe4758de03a..f4942667355b 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -19,6 +19,7 @@
  * each CRTC.
  */
 
+#include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
 
@@ -241,6 +242,14 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	hvs->regset.regs = hvs_regs;
 	hvs->regset.nregs = ARRAY_SIZE(hvs_regs);
 
+	if (hvs->hvs5) {
+		hvs->core_clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(hvs->core_clk)) {
+			dev_err(&pdev->dev, "Couldn't get core clock\n");
+			return PTR_ERR(hvs->core_clk);
+		}
+	}
+
 	if (!hvs->hvs5)
 		hvs->dlist = hvs->regs + SCALER_DLIST_START;
 	else
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 71e7211a5fb9..851f0740b260 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -11,6 +11,8 @@
  * crtc, HDMI encoder).
  */
 
+#include <linux/clk.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
@@ -149,6 +151,7 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_hvs *hvs = vc4->hvs;
 	struct vc4_crtc *vc4_crtc;
 	int i;
 
@@ -160,6 +163,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 		vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
 	}
 
+	clk_set_rate(hvs->core_clk, 500000000);
+
 	drm_atomic_helper_wait_for_fences(dev, state, false);
 
 	drm_atomic_helper_wait_for_dependencies(state);
@@ -182,6 +187,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_cleanup_done(state);
 
+	clk_set_rate(hvs->core_clk, 200000000);
+
 	drm_atomic_state_put(state);
 
 	up(&vc4->async_modeset);
-- 
git-series 0.9.1
