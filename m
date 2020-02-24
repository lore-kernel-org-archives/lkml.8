Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F9E20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Cp9C1sQd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vYPU9pzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBXJJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:09:57 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50661 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgBXJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id D70CD628;
        Mon, 24 Feb 2020 04:09:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=+P3Mooao6xRyz
        6NjQNJGdStRJFWbrJ+Bh4471XgOQgM=; b=Cp9C1sQdZx0REJGTYG0//Oo5uxn9y
        JLAKxPa1xmq93in6rwnL7+J4rLFQ362WljOlLbkCWGMhaVkTU0QTeCNTs0lJa7yO
        vOsqJeYCmc5iWdjOLIYaIgq9quGKwCeHrSp8fDw8O0OZGYUTPVusq1qpJjzP9pD0
        L+DJUhuJ2gFoQT0kivxZtLHV5Ornjzt34fv7k3l74qXdxhXrf6h3rjpb/mzkTQ4P
        8hTOfuIwUOjOFLRgiXh7SrrcI1P24ZmiJ+4MpHknX6hEJ2peLDyIjy2pBrQcqKS0
        SpqqEsVwtoXPanPUMqzal78e6ioSkw+hk3+PnSZ3kLpXC87iJvfgx2LQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+P3Mooao6xRyz6NjQNJGdStRJFWbrJ+Bh4471XgOQgM=; b=vYPU9pzx
        Kps0fNlvLdFA8PefzEsPVdY3SxbqupZ2ZmEjg0SPLf2nQa13AVeBHdtOWkOXNs4m
        1tur1Vv0TX/7MvQeCc3HDJijPpogM7DYwXUJy1AqpzbwBH98ror+aaFN9pPQ9ljE
        oze+Drh6OFfJPPTqNwf+Bp96fQf5AIt7BFYTsgqyF1GOMzZVg6gOLBTUh0aRaOZm
        YrMzJIwURJI4cF+NrECuhCcIyBY6IgcvLEY8//6+EVmNNDcR0fYjX69QscYpiOfL
        RY79sGlGL/JPf4VrR6xANHYfoqOalyV9jJfPRbquiNavMsfpnh2DW2jLp8HuUQaX
        K+5S9LN149TMxg==
X-ME-Sender: <xms:35JTXmjaUr4AVRjD6XrnEEjtzvV46o2LNJORuwlhDL6knFqKWf3yFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepfeehnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:35JTXp-MYRFMh640P9eWEBp9W9Kk3jPDL4LAkqxi1G8glS1vMBOV3Q>
    <xmx:35JTXmQOPOw7fWMiiCHczLM86IZNLOWKwRj57GpKOBAC1xBBVQqIZA>
    <xmx:35JTXuGcqSOxqag1LBpsxKS1En-5V5NxmSOCPpQX4dasoI-5EMsIvQ>
    <xmx:35JTXlU4jbN1-ch0skW9_0xo-rDQZS8e2mYDOwd65LvdFrYVYAm2Tjt71Sk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2500D3060D1A;
        Mon, 24 Feb 2020 04:09:51 -0500 (EST)
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
Subject: [PATCH 43/89] drm/vc4: crtc: Rename SoC data structures
Date:   Mon, 24 Feb 2020 10:06:45 +0100
Message-Id: <e1b911053d81fe2c3e4961be973e5df92796d0f9.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to introduce pixelvalve data structures for other SoCs
than the BCM2835, let's rename the structures defined in the code to
make it obvious which SoC we're targetting.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index fc9977bdf347..ce902d31f92c 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1055,7 +1055,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 	.atomic_disable = vc4_crtc_atomic_disable,
 };
 
-static const struct vc4_crtc_data pv0_data = {
+static const struct vc4_crtc_data bcm2835_pv0_data = {
 	.hvs_channel = 0,
 	.debugfs_name = "crtc0_regs",
 	.encoder_types = {
@@ -1064,7 +1064,7 @@ static const struct vc4_crtc_data pv0_data = {
 	},
 };
 
-static const struct vc4_crtc_data pv1_data = {
+static const struct vc4_crtc_data bcm2835_pv1_data = {
 	.hvs_channel = 2,
 	.debugfs_name = "crtc1_regs",
 	.encoder_types = {
@@ -1073,7 +1073,7 @@ static const struct vc4_crtc_data pv1_data = {
 	},
 };
 
-static const struct vc4_crtc_data pv2_data = {
+static const struct vc4_crtc_data bcm2835_pv2_data = {
 	.hvs_channel = 1,
 	.debugfs_name = "crtc2_regs",
 	.encoder_types = {
@@ -1083,9 +1083,9 @@ static const struct vc4_crtc_data pv2_data = {
 };
 
 static const struct of_device_id vc4_crtc_dt_match[] = {
-	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &pv0_data },
-	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &pv1_data },
-	{ .compatible = "brcm,bcm2835-pixelvalve2", .data = &pv2_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &bcm2835_pv0_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &bcm2835_pv1_data },
+	{ .compatible = "brcm,bcm2835-pixelvalve2", .data = &bcm2835_pv2_data },
 	{}
 };
 
-- 
git-series 0.9.1
