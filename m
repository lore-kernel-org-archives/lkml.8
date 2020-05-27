Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF621C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8AF20EDD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Z4v6tZRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wjtxiohL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbgE0Pv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:51:29 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60819 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730599AbgE0Put (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 61F185820C0;
        Wed, 27 May 2020 11:50:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=gOeAEZiy0ED6T
        5GShD115deUVvMwxSrZt/liqYgKRqg=; b=Z4v6tZRqcX97/1oXz1ZudyP3UukMi
        V9DMKF96c9FPk5/tCR4mYBlffCKNQ71fyWKtru+Gl/KAau9PsLl1X+GUi6w9fx+f
        qAHL1U/E2Ke+NOQmVvikCwrIfbEJiIkmPUbRSjzdDHhO4a5S/vVnY5TQULgWFMzX
        sF+CUAtvLRr88KArw56+aPBMnDiGUmWvpFBWM1mDGCWLzCKu2l6QlFAP3qDeuGkv
        7gUGa2zoTAdClqKlXsjNYrQCd7OaQFK2F2T/ZFXj3xJ7m1msBQFKqbR/7GGvNPOo
        gFXlOu8B67Jc2x4O2JczcKcmkbqDp/4CYw8iTiw+n6Fe58/KGupxXLLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=gOeAEZiy0ED6T5GShD115deUVvMwxSrZt/liqYgKRqg=; b=wjtxiohL
        cI1fVAR/PBaFg59dXXHt7GSlBxrDjbc3jGPRgzRTZ3Mslfm230V/ARwmiudiDN8y
        gjsPbUfS/Kcn+LP1JNn+H44IKCdjAzWwbcwuB3A/+iRnb6H65C0fwKP29LuzHBpV
        xzdrU7MHUzifdngLmZTFHDx+WYwDMtDf/6bvdYUuqk7J/THdpeNh9T+3KR6uLvg1
        u4pwUmqr/uYSDNNFKp6pV/YunQMvjhl7F3MYNVj6GWyku9tblI72sqpIaQuMNG2V
        bLawlBlbp1A00/4wSnuQ4hX0t3YOcpiaRkSFibus55FX3p1/TMGTAzr4Wv17J507
        YY0RyK/2yZiECA==
X-ME-Sender: <xms:WIzOXqj2bFkc6vxAWMavjU6BriTtewkQRxJTtDUY29jpMYjgwIcs_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepfeeine
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WIzOXrAR1lMp5uEt2OAftQ2e4OCylBRczAzZGyYX05vgqyfj_77paA>
    <xmx:WIzOXiEAqutDJre7MfieJMxAz3FKaL3qiKAENzRsbPy3uXyvPNJ1vA>
    <xmx:WIzOXjQgzxQqbrkQUWblGDRT6Ut5B9XuOvkT1dBtyIZpDxJT9TgoFQ>
    <xmx:WIzOXuxnp-s8QiZ-jDW7i02saqUn35vx4nEWTAlFc0vAs8vMb3jOGg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02F863061CCB;
        Wed, 27 May 2020 11:50:47 -0400 (EDT)
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
Subject: [PATCH v3 057/105] drm/vc4: drv: Disable the CRTC at boot time
Date:   Wed, 27 May 2020 17:48:27 +0200
Message-Id: <68bdae53a362e74f7e355fec1f18378c9e7fcaac.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent issues during the firmware to KMS transition, we need
to make sure the pixelvalve are disabled at boot time so that the DRM state
matches the hardware state.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_drv.c  |  4 ++++
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 3d2a31cad7fa..9efd7cb25590 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -409,6 +409,29 @@ static int vc4_crtc_disable(struct drm_crtc *crtc, unsigned int channel)
 	return 0;
 }
 
+int vc4_crtc_disable_at_boot(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
+	int channel;
+
+	if (of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
+				    "brcm,bcm2835-txp"))
+		return 0;
+
+	if (!(CRTC_READ(PV_CONTROL) & PV_CONTROL_EN))
+		return 0;
+
+	if (!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN))
+		return 0;
+
+	channel = vc4_hvs_get_fifo_from_output(dev, vc4_crtc->data->hvs_output);
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
index ed7893ee188a..ea082b9d3c90 100644
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
index 99001f8783aa..32e9de15262a 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -797,6 +797,7 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
 
 /* vc4_crtc.c */
 extern struct platform_driver vc4_crtc_driver;
+int vc4_crtc_disable_at_boot(struct drm_crtc *crtc);
 void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
 void vc4_crtc_txp_armed(struct drm_crtc_state *state);
 void vc4_crtc_get_margins(struct drm_crtc_state *state,
-- 
git-series 0.9.1
