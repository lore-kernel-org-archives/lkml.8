Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7473C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03AD20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JB+m3fWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJJPc5MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgICIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:03:02 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59407 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728352AbgICICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5DFBBB74;
        Thu,  3 Sep 2020 04:01:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=QqGZcYvmNlgMu
        X9a38SiS88Q1t5fPVWaEbYQNa0977M=; b=JB+m3fWsL+O2BERJYzfnKf4cr9JmP
        8GYos7Yafx7oJTvMVwqlkQDex3zHKNxmWSDQpbEzJDwN3SKvx8lwJKnb1nvMBdkm
        YEE8ra05NFz5VPYBjHALMDsfYGoW836vKiMs4Hq8s/N7ju6pegAtUAsxI1pgwdbx
        1w7fVFG+cf7KvqHNyQv88k3RzGJCTdcGY8dl1pgYWGGV9OcrGplHCk3tRIjNXnno
        fs6ijv3aKtVssjWxO61JUq9bHu4w+BaTWiRUuEakOPgOhzIwV0Q+ISQoMcKHuqyV
        UrI6EbQEytlYqvSQw4imTgfVf7Qgq2e+yo4fq7fauDNyhHmU37DmF/AeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QqGZcYvmNlgMuX9a38SiS88Q1t5fPVWaEbYQNa0977M=; b=OJJPc5MN
        GOKZiy3uazbr0uw9XDLAsLaFqXRQVBF68LSi5BAG4oijxSASrvSyZ2Qpj/9ujP2t
        uRjuRnW5wRwkx4Kh35dn/NsgH5sKf2YTn9iRA5K0ilp79N1lW6DRD23p0YzB7VVg
        QzZ9j95b2/0/Zn/dzR2gKFfc4Zld+pSpn/5Wxrp1RyNy0WxLydIn09J+wQX01RPf
        rINEBKJoZGPWWpiQjMaPADAjpd6WDVwKvxzYAFbHwApkU1gtd2ctT6TXn8ssvphG
        Ed6G7G51qK5QEaBrNxBMpyJVBGbXBqxUwPJrgS+9e3ryZME8myUBBluOODRZ9mv8
        j2e0SiuaBRcYEw==
X-ME-Sender: <xms:9qJQX5oT2TrfuhaGjQXUkEu25l8eJhfcHJ9pm1yeo2Ea_H9MmM7tVw>
    <xme:9qJQX7rQ9_uwLcKW2S83Or3Ess0djSuyJpMXR3VksicEloxkNYQnRd8GEYkiZ2BHt
    UhbdwBHrNZd7xyEFZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9qJQX2NT45wOkzo1ljg1qdBeYStxlpqKaf9-Kv_5rtAyEIraQ4SMVQ>
    <xmx:9qJQX07f3AdfmVTQN1IdDUrE3pdGPfqvtDElcsSbGSxXwgVBGsC-xQ>
    <xmx:9qJQX47s1oXlpGKMLlPfAvFfJalzOcFQZVf-XNzi-kXgBjbEbXpnXw>
    <xmx:96JQX4i9Gm7Y-Rc8iNYQYH9iPKnDyLHUiMAX0L4rX8HRMY_PZgCVKy5c7GA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9229D3060060;
        Thu,  3 Sep 2020 04:01:58 -0400 (EDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v5 03/80] drm/vc4: hvs: Boost the core clock during modeset
Date:   Thu,  3 Sep 2020 10:00:35 +0200
Message-Id: <37ed9e0124c5cce005ddc8dafe821d8b0da036ff.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent timeouts and stalls in the pipeline, the core clock
needs to be maxed at 500MHz during a modeset on the BCM2711.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_hvs.c | 18 ++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index e4cde1f9224b..6358f6ca8d56 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -320,6 +320,8 @@ struct vc4_hvs {
 	void __iomem *regs;
 	u32 __iomem *dlist;
 
+	struct clk *core_clk;
+
 	/* Memory manager for CRTCs to allocate space in the display
 	 * list.  Units are dwords.
 	 */
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 836d8799d79e..abdb43c4cc10 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -19,6 +19,7 @@
  * each CRTC.
  */
 
+#include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
 
@@ -540,6 +541,20 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	hvs->regset.regs = hvs_regs;
 	hvs->regset.nregs = ARRAY_SIZE(hvs_regs);
 
+	if (hvs->hvs5) {
+		hvs->core_clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(hvs->core_clk)) {
+			dev_err(&pdev->dev, "Couldn't get core clock\n");
+			return PTR_ERR(hvs->core_clk);
+		}
+
+		ret = clk_prepare_enable(hvs->core_clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Couldn't enable the core clock\n");
+			return ret;
+		}
+	}
+
 	if (!hvs->hvs5)
 		hvs->dlist = hvs->regs + SCALER_DLIST_START;
 	else
@@ -624,6 +639,7 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
 {
 	struct drm_device *drm = dev_get_drvdata(master);
 	struct vc4_dev *vc4 = drm->dev_private;
+	struct vc4_hvs *hvs = vc4->hvs;
 
 	if (drm_mm_node_allocated(&vc4->hvs->mitchell_netravali_filter))
 		drm_mm_remove_node(&vc4->hvs->mitchell_netravali_filter);
@@ -631,6 +647,8 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
 	drm_mm_takedown(&vc4->hvs->dlist_mm);
 	drm_mm_takedown(&vc4->hvs->lbm_mm);
 
+	clk_disable_unprepare(hvs->core_clk);
+
 	vc4->hvs = NULL;
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 08318e69061b..210cc2408087 100644
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
 
@@ -160,6 +163,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 		vc4_hvs_mask_underrun(dev, vc4_crtc->channel);
 	}
 
+	if (vc4->hvs->hvs5)
+		clk_set_min_rate(hvs->core_clk, 500000000);
+
 	drm_atomic_helper_wait_for_fences(dev, state, false);
 
 	drm_atomic_helper_wait_for_dependencies(state);
@@ -182,6 +188,9 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_cleanup_done(state);
 
+	if (vc4->hvs->hvs5)
+		clk_set_min_rate(hvs->core_clk, 0);
+
 	drm_atomic_state_put(state);
 
 	up(&vc4->async_modeset);
-- 
git-series 0.9.1
