Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755B9206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f2SOgkC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCq5Ezxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgGHRn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:28 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34437 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgGHRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 0A3F3102C;
        Wed,  8 Jul 2020 13:43:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=LjqrLHs4v5mr0
        TXyo6kPt156JThQE6jS69AxBPJMQy0=; b=f2SOgkC9/emCbgD7eq0uvJ1MNbjYe
        fbuK2rjCkBzcjXBDVGITrEEV7e1ZOTQaBZbU99PQitlpcUw10KjQbR+MhfgqOQJ7
        KLBtcyPKzLo5og3E0Zcch2yctVzd/uK7kqrfgxp6qgtp1+wMp6NWGa5feaUA82ht
        aLSF5MN6dEdKXhxYUebW5on6s7GQDrBZvY69g7C/Tcruc9bzt4ZSsdxJHvqJyWv9
        oHKUkBF0i5qw9cbmYjvR9dJDR9+Rnn27p3PV/McKj5O09fyNFPfnv3OBffrIemcA
        v7pouKB0b+KF1xTlXrQkMQZWhdnVnXFCPJr1WuQLUm63PfF+cEKsoy6bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LjqrLHs4v5mr0TXyo6kPt156JThQE6jS69AxBPJMQy0=; b=KCq5Ezxz
        MHHfmL2dIXggEku3jiEVJXdzv5weOD7Ul20Ej74MKOUBotrIEZs86VqqC6evhOeh
        7X3CbzRBclnFlPB8cOXh3jkWmcoUEM14edk77jGAh/BMhP8ZeARJQfMINSPI50Wn
        6rrXFtXjYD53kj9fg6YIrPGyIquFgu4e+5u5lXV5E6km5gAgm18uBPDnXlTbqLdS
        xLaUo4B6/N1OG/zf2Gtxuj90rW1fYAtV5stS5DgUfEnWEQnZtEfR6ybuhSMM/tX2
        pTLQM9RxYjjQxciCziI2Jh9WZM3c6mUDuqlPD5syAliUKvl3Co8Rk8HctK2zn5hg
        Rkx7gRGzs3wxPg==
X-ME-Sender: <xms:uQUGX2QoYG9FXBbuUe8utH_tRW_7v1h-lbylqPr6cESpcZVgpOIs4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfedvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:uQUGX7wmYQxcs5LaQomU6P8P3BBianJReFrGhgd5J1HuDuiQdly0CA>
    <xmx:uQUGXz2-2kLScKev2UzLOO9agL3PAmEGfiuOhz5lX644OmRU55FkGA>
    <xmx:uQUGXyA6LYkXmzvxOWv2lIqL7SRvLEOp-xP-wRjc0-F5-mXw-eyZsw>
    <xmx:uQUGX_jXkebL_dseVymZI9isrRjv8vlyWG985SgHnMXLW92VWZ5z7RS06dU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4A38830600B1;
        Wed,  8 Jul 2020 13:43:21 -0400 (EDT)
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
Subject: [PATCH v4 35/78] drm/vc4: drv: Disable the CRTC at boot time
Date:   Wed,  8 Jul 2020 19:41:43 +0200
Message-Id: <339db0f813606d5c7a54bd4217be89fc35ca023b.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent issues during the firmware to KMS transition, we need
to make sure the pixelvalve are disabled at boot time so that the DRM state
matches the hardware state.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c  |  4 ++++
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 69851e19e2ab..a8bc3b26a0fb 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -411,6 +411,31 @@ static int vc4_crtc_disable(struct drm_crtc *crtc, unsigned int channel)
 	return 0;
 }
 
+int vc4_crtc_disable_at_boot(struct drm_crtc *crtc)
+{
+	struct drm_device *drm = crtc->dev;
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	int channel;
+
+	if (!(of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
+				      "brcm,bcm2711-pixelvalve2") ||
+	      of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
+				      "brcm,bcm2711-pixelvalve4")))
+		return 0;
+
+	if (!(CRTC_READ(PV_CONTROL) & PV_CONTROL_EN))
+		return 0;
+
+	if (!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN))
+		return 0;
+
+	channel = vc4_hvs_get_fifo_from_output(drm, vc4_crtc->data->hvs_output);
+	if (channel < 0)
+		return 0;
+
+	return vc4_crtc_disable(crtc, channel);
+}
+
 static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 38343d2fb4fb..9567d1019212 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -252,6 +252,7 @@ static int vc4_drm_bind(struct device *dev)
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
 	struct device_node *node;
+	struct drm_crtc *crtc;
 	int ret = 0;
 
 	dev->coherent_dma_mask = DMA_BIT_MASK(32);
@@ -298,6 +299,9 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto unbind_all;
 
+	drm_for_each_crtc(crtc, drm)
+		vc4_crtc_disable_at_boot(crtc);
+
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
 		goto unbind_all;
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 860be019d8e3..1a97545b9244 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -813,6 +813,7 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
 
 /* vc4_crtc.c */
 extern struct platform_driver vc4_crtc_driver;
+int vc4_crtc_disable_at_boot(struct drm_crtc *crtc);
 int vc4_crtc_init(struct drm_device *drm, struct vc4_crtc *vc4_crtc,
 		  const struct drm_crtc_funcs *crtc_funcs,
 		  const struct drm_crtc_helper_funcs *crtc_helper_funcs);
-- 
git-series 0.9.1
