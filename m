Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2154C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C584E20866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="V5YZdFPQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="injtkpYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgBXJKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:10:21 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56525 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728138AbgBXJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 76055616;
        Mon, 24 Feb 2020 04:10:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SJtIc/FI3m39G
        lx6PQQ37P9dal41lxfK3JGC+OKfen8=; b=V5YZdFPQTsAsGibsBfMei1a4MGDCc
        5+G9OvcCkgia/tfLtIvwu7D8maB2yr/R4rM3/4UKkRVZOa0c4mU/Sev0z2QonS5F
        xlf2asE0dG1jrvXpafu+wWaGt3TRRsM8+ze7JZnxOWf0salQs3FcgAdnb8Zly4CH
        dUlM/iHEqAiAvxanbpJ7JtpDkJk715RA/yaQoYiGKyINPq7StjRTrnf1RrYSnVeE
        ADn0dEp8u4dESTixhwC7p38K+u/QXinkbeSe75RUlmc+suRKXIJZCsDJkSAbqcL5
        FnZiNTKR+kaivbBtcNDPABN81cqLD3Pg/triK4IGx+lNeOEWYWsZjoZPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=SJtIc/FI3m39Glx6PQQ37P9dal41lxfK3JGC+OKfen8=; b=injtkpYU
        F1OYfj5+JSxYt9xG6FwnJv53yzevcPra6Vczb/YDAtO6I9t2een0RCCOv3DcItTj
        U1q/7n32H5cNaXH324qSJRWATo9mPAt6Iwqf0YNXdlDi/UIvaqSclwzTDcKHKQbi
        Ba87M06y/1YesXOSMSHxKhMiQ2Kd3CkEX2ny8kgSRc874uOEK+r/GS8foq5nFzfC
        /i9/liNY7NTQiuAaSdeMWDUAmjLjMfSf28yO0ubfGYexNq5ebzeoHarvn7s1Hth6
        78eP/k/VkBvjrd+5rsywvFS8x3iWb0ZJTqncnlWO2PnvACMSBL6qKOsPHYX3oP1f
        v0WqjjlJxq4LeQ==
X-ME-Sender: <xms:9ZJTXl89-xxwSyWDyS1-6BT0KH9PyJHKGOPZsRmqYpdo9rpTT0erkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgephedvnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9ZJTXpn6kiY5jktwCY2Q8n5OOlD3Hdfyxyck01svoDpgUu3s54mclA>
    <xmx:9ZJTXgUwnoNTtwC5Yo0MrmhCI_XDrLWFqeCJAdTH7ILN0AA5jQn6jg>
    <xmx:9ZJTXlqny6vI7JdLHiPNF-b_QHPijEOy__OR_ONTsLF7Im_WSUE7WA>
    <xmx:9ZJTXtKgsua7QUrdHocCmpS9t9vtMfh3M-22us3LSFFIlz1XvzL3znSsriI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B81F3328005A;
        Mon, 24 Feb 2020 04:10:12 -0500 (EST)
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
Subject: [PATCH 58/89] drm/vc4: crtc: Disable color management for HVS5
Date:   Mon, 24 Feb 2020 10:07:00 +0100
Message-Id: <3310bccae61f92c54934274cb595d0c91e60d943.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HVS5 uses different color matrices. Disable color management support
for now.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 67d9beb2cff0..b10b267f56fe 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -441,7 +441,7 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 
 	HVS_WRITE(SCALER_DISPBKGNDX(vc4_state->assigned_channel),
 		  SCALER_DISPBKGND_AUTOHS |
-		  SCALER_DISPBKGND_GAMMA |
+		  ((!vc4->hvs->hvs5) ? SCALER_DISPBKGND_GAMMA : 0) |
 		  (interlace ? SCALER_DISPBKGND_INTERLACE : 0));
 
 	/* Reload the LUT, since the SRAMs would have been disabled if
@@ -1155,6 +1155,7 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
+	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_crtc *vc4_crtc;
 	struct drm_crtc *crtc;
 	struct drm_plane *primary_plane, *destroy_plane, *temp;
@@ -1196,12 +1197,16 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	drm_crtc_init_with_planes(drm, crtc, primary_plane, NULL,
 				  &vc4_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &vc4_crtc_helper_funcs);
-	drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
 
-	/* We support CTM, but only for one CRTC at a time. It's therefore
-	 * implemented as private driver state in vc4_kms, not here.
-	 */
-	drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
+	if (!vc4->hvs->hvs5) {
+		drm_mode_crtc_set_gamma_size(crtc, ARRAY_SIZE(vc4_crtc->lut_r));
+
+		/* We support CTM, but only for one CRTC at a
+		 * time. It's therefore implemented as private driver
+		 * state in vc4_kms, not here.
+		 */
+		drm_crtc_enable_color_mgmt(crtc, 0, true, crtc->gamma_size);
+	}
 
 	CRTC_WRITE(PV_INTEN, 0);
 	CRTC_WRITE(PV_INTSTAT, PV_INT_VFP_START);
-- 
git-series 0.9.1
