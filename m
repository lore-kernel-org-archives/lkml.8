Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352F720C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="a/Xn4+11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hiq/c1jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgE0Pu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:58 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34895 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730571AbgE0Pue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82BC6582096;
        Wed, 27 May 2020 11:50:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=oDKZIgoeG+vnD
        EfqXcJAda79bnMM+UMDrK/U0Onwb1w=; b=a/Xn4+11C4fXDUvHzBoeRoGWVulPI
        0kTzhNDJMeaZQHurBlMtx1HneHExI+Khp5kAU/5+rzL9ZZfFPGLEA2eUJaLO0LZO
        fudOW7Uw5Fpe57Ml2AfP9bYc31R7Zk7Ui6+4LZ8f7qBVE+zmoX2bxLf454En9ncK
        +X7sWUuuRYtY2zE/uHOTxPjI25VDNNKy2tUgysPGjlTjwolTcvbyNcd6/A/BCczF
        YEwK5fQuxV+F7Ww0sE+d+hv/Ug/rc1JsSPAl+Ly2ic94Wx9ljXnlp+GqnKmjtV9k
        7NKwYb3o7jSZIfzRi1fbdoapSdpVGI6MuMQZNaaysp1rJbeSbwDzTI2wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oDKZIgoeG+vnDEfqXcJAda79bnMM+UMDrK/U0Onwb1w=; b=Hiq/c1jp
        avrufbNjOhMZXDNJx3gYpXSZg6gHYKBQk3iGZ+PU8QLQgpaUOhhKK2FOpGzWIINY
        f/egZWG1uEgK7Nx9nnWOmJAFps/qIjo5P6lrI4Lb0cMIEBGpbEJwu8qfBfl3PzqQ
        qQKM67Cwr/ExRzofXxceHz9QejZ1V5Y9c+u/YF3YDynTmSdHLJHBkoVHP02YxHfN
        T974zTz1NLAK8S9r7N88ik/w++Y9JGeQ/WBfdOT+daG6BsKMxYi4UFLd+80RqCJd
        1/0L90kG4OqUOLOp11WRA8gg/eORxVIwLZrMjBQWfAyPEUX1pcxXRLBRpAAgXABj
        hYQFt7ovkl7nOg==
X-ME-Sender: <xms:SYzOXuIopX0SUHYDtL7Z7L6gStUb4_CqaTuHqzenmXZ-djMZcyCUdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdelne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SYzOXmKQW9Zf4WwPPFI_6Rj0dPAcm8JU8FaS9xd2x7PG06aqNdJeow>
    <xmx:SYzOXuvdbJY51tXtRSU5MgiJvv-3dAYTkWrZkLfQ0tUwwwgsKwj1Zg>
    <xmx:SYzOXjYLQ3-X0_k95auKGmo5lVxVWjTdiz3Wtm_git4w8I4smnyykw>
    <xmx:SYzOXh73MUPgWKUnbJzjWi6FVc_LBj2qBBXw2g15OgRqkMMxq0XIXw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32A7E3280060;
        Wed, 27 May 2020 11:50:33 -0400 (EDT)
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
Subject: [PATCH v3 048/105] drm/vc4: crtc: Remove redundant pixelvalve reset
Date:   Wed, 27 May 2020 17:48:18 +0200
Message-Id: <0fa72666fcd0ad1d0c97f92310c60238715bbd59.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we moved the pixelvalve configuration to atomic_enable, we're now
first calling the function that resets the pixelvalve and then the one that
configures it.

However, the first thing the latter is doing is calling the reset function,
meaning that we reset twice our pixelvalve. Let's remove the first call.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 08bd595f6a7c..3c9b0d684136 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -433,8 +433,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	vc4_crtc_pixelvalve_reset(crtc);
-
 	if (!vc4_state->feed_txp)
 		vc4_crtc_config_pv(crtc);
 
-- 
git-series 0.9.1
