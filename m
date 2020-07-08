Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF31206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ExGHd29F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tAfmDmsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGHRnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:43:20 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:38969 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgGHRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:43:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id D65852F9;
        Wed,  8 Jul 2020 13:43:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=3s7A79hlJ6aoT
        TArQxLfI/bgm5kubVGhL2NYCp3KEL8=; b=ExGHd29FPMPpLEofb2OW1vdLBxwLx
        8BThsw2+PokH1WKRCXFgxEuvB/FhbXlpVaI61llj+Hw1UZhcEsWNZicjQFLDRWvB
        ZkwN7VLreEjhcXr0Xn0GaBmvhCdQ85gdBVB7lHl3U+UViInDii3rCbr9WK/il40N
        s1mdQ+ZcEAboqnB6fUjGeVvjgbjg06NJDLLRICiUEtP04PE5875JchhYX/thHV+z
        P7wCtlp8z55w95vQHnGGTg8oJT6BMVg8Yd5a7B5xMGIjuNqpQIb5RGCBOrkdVgLP
        GrFsMVhooL8PQGmxkWu5tTWpfLD5LD6CB6uixl4SZLzCvYuo+YwpcVPgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3s7A79hlJ6aoTTArQxLfI/bgm5kubVGhL2NYCp3KEL8=; b=tAfmDmsm
        X+nstJiwVkyMSkzINkPzOGV30UF3sX5eieaDErLHMvCrSOXSo7MBre8D/v3Y0hw2
        lDPbcf71y20xdZZmWRIwZ3nKEuHp684QZre0i6rVYRv9imM50R3EPu6AdCGnHX6l
        +rcVwDyMUiXlK5egtRK2Jfahlv6GnnAi0zDsznNmyx3uocojlYcttudIcXCSPYvM
        /zJXARpm/EC8eQOZs1sTYImJknuayk4pDTfb676rQO/TMALaJbQ1vdxV0w4Y7aR7
        uO4th1IEtUJAxxI95e2yiuzL9VSwiC1Gcl3be/jmTSV5TScgMilXZq09W891vmuM
        AOlltHnu5kZQYQ==
X-ME-Sender: <xms:sgUGX8k1pf4loBDJucJomKxrGyrg6Vc4wh6qJW1SKqoHPpuDelR_Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sgUGX72Y7AVfRbuk6KfoQZ--tWreNTZ5j3SRpB8FHnENzAeeWigcow>
    <xmx:sgUGX6ouk8J-fGtY70f-77IHW-tQZMptzoT-qZCXStHbNC6MaQvwHA>
    <xmx:sgUGX4kGM8oICpBQESfCUKsbl0tilhfVtgZc5W_udH8AHPFRDenU1w>
    <xmx:sgUGXznMUWKY8h0LI9I3iFro_hmzbuKGq13NcZt376jT_QUcTbrtTl4JkzE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F68B3280063;
        Wed,  8 Jul 2020 13:43:14 -0400 (EDT)
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
Subject: [PATCH v4 30/78] drm/vc4: crtc: Clear the PixelValve FIFO on disable
Date:   Wed,  8 Jul 2020 19:41:38 +0200
Message-Id: <dd3c4cdda7252e9d40bdbef236d9aaa93af512c5.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid a stale pixel getting stuck on mode change or a disable
/ enable cycle, we need to make sure to flush the PV FIFO on disable.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 7b178d67187f..13fe0e370fb3 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -408,8 +408,7 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) & ~PV_CONTROL_EN);
-
+	vc4_crtc_pixelvalve_reset(crtc);
 	vc4_hvs_atomic_disable(crtc, old_state);
 
 	if (vc4_encoder->post_crtc_powerdown)
-- 
git-series 0.9.1
