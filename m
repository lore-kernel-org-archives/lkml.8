Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C34BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260FA20897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NvuPIVux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHoVHEVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgICIK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:10:58 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42409 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728392AbgICICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A956DB3E;
        Thu,  3 Sep 2020 04:02:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=XlGpFlv6D97QI
        cR+PEZduyWAquy8gwEaTC5GLSq5yqg=; b=NvuPIVux6hydkw9EJybRRCvdSvf61
        qbpp1KOXnYAbN0youhYs4Q3eftMvoJ7ImURd0OZ8VioyEhDa6jGgNeL6gR8ghZH9
        Hb96CLyA4isiDFvTNcT82CoRCZlXG+8BdX1VtPIFuvG11T3fGdGmFax3jPHR/pZC
        /aJ0cOQV3vpxCKO9wpogsQ+GCRAgYx9sBl+4MH0/YdXv1GPG524dUL/moLLs3ceC
        FPjel+qRc9/VfPWNJmgMcr5wMFrd7Hlqq9k2a3x9LIGDd4Rh/13nFuvL2Ncq2L20
        Pg+nhJYJAXrjb8aXvIJlRtAE4JEcRtF1UtxKx8gWc7Wox4VgCPJgALAiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XlGpFlv6D97QIcR+PEZduyWAquy8gwEaTC5GLSq5yqg=; b=WHoVHEVg
        A8WJrz4JA1J2dLChmKjeaRCmK6nI/Go8PzAJ82s9Pio+py26ZbSoKrmSh1ftyUns
        Mg2V6ZwdEkB8mwcsusNk9/oPqiX5TQ33vXFi4EO9s4GEXpwV7RPO7CyhRTC3Z481
        qyZSnx8oWHOF3PkOfjeekDmlveykYLD6YDAKrBGnkbUoSINnaqW/Xv8k7W+0cVRk
        rsJv6LIP2b2E6oYq7PJGrno1IwDyjHzHtXkbFnN4Ls5v69D108hYm4Nl06cRsNV6
        rIRUky12ukrDrfwLzgqLfkf1Nk26qrArb/umVPozGptuOM1BqFKCql2J+gyfgJgx
        4Sq/sHl1nYLnpA==
X-ME-Sender: <xms:CqNQX287I5OjHl9-isURx0k_K4mSYPem7mvH_MrZRvrpdWWzSO0Dag>
    <xme:CqNQX2sksKF_pbD6CDPOHU6TSBKSEsZYutnn4KlOXLzsQtmkErr9ADpxyu6Ch8X3G
    6xWNq8Q0Xv0QZ_GvYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeduge
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CqNQX8D7u2zOoxjKd201JIqWlNtpVLN_bWYccHIfMK4lts_sBzXotw>
    <xmx:CqNQX-ccHArh7O0kQ66om4YHyC9RrEzCVZx9c3S_aAoXXJkwFwRT1Q>
    <xmx:CqNQX7OcJ8Mis3zSmyC0LKUjajoISIY82kOuL8ZzE-c6PueQTEWE8A>
    <xmx:CqNQX4nt0bkbGaoRDpOB6QaZ9DNYj8qZfeOXeQTVYtKWjRNlmLLj_QXyRUw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9CA4306005B;
        Thu,  3 Sep 2020 04:02:17 -0400 (EDT)
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
Subject: [PATCH v5 17/80] drm/vc4: crtc: Rename HDMI encoder type to HDMI0
Date:   Thu,  3 Sep 2020 10:00:49 +0200
Message-Id: <84e11e4793aaa30d6e5c56e305d22404ac5a932d.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous generations were only supporting a single HDMI controller, but
that's about to change, so put an index as well to differentiate between
the two controllers.

Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.h  | 2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 1d9e3658ae59..04744223460a 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -835,7 +835,7 @@ static const struct vc4_pv_data bcm2835_pv2_data = {
 	.fifo_depth = 64,
 	.pixels_per_clock = 1,
 	.encoder_types = {
-		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
+		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI0,
 		[PV_CONTROL_CLK_SELECT_VEC] = VC4_ENCODER_TYPE_VEC,
 	},
 };
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 179010b9a010..5781773aec4b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -426,7 +426,7 @@ to_vc4_plane_state(struct drm_plane_state *state)
 
 enum vc4_encoder_type {
 	VC4_ENCODER_TYPE_NONE,
-	VC4_ENCODER_TYPE_HDMI,
+	VC4_ENCODER_TYPE_HDMI0,
 	VC4_ENCODER_TYPE_VEC,
 	VC4_ENCODER_TYPE_DSI0,
 	VC4_ENCODER_TYPE_DSI1,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 15a11cd4de25..ec34c08b16df 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1309,7 +1309,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 					GFP_KERNEL);
 	if (!vc4_hdmi_encoder)
 		return -ENOMEM;
-	vc4_hdmi_encoder->base.type = VC4_ENCODER_TYPE_HDMI;
+	vc4_hdmi_encoder->base.type = VC4_ENCODER_TYPE_HDMI0;
 	hdmi->encoder = &vc4_hdmi_encoder->base.base;
 
 	hdmi->pdev = pdev;
-- 
git-series 0.9.1
