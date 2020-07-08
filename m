Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88350206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="fNrfs2R0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZKOSFTZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGHRrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:47:43 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51911 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgGHRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:42:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B88452F2;
        Wed,  8 Jul 2020 13:42:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 13:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=NTcrnxvQck9gY
        DiF2BJtKRRo7ypRR9x+FvwIvb6tAhs=; b=fNrfs2R0HC+Zq5JbncInyHuwJqbWD
        nhnOTndwA4f1p3C8jha1BX1JopXgyR1O4/5mMOCYt2pdmKCoeNlYPHgvqRHjxaFL
        xfrWMbbaG4IrJlP8PmoffQisqwJDKoWV94JKsD4XiCRA8cmCcPN/7xCOGvoGks2y
        hNuU8Va71qSo7KWu15c1ACBoHVCdBvx1/Xr3r2BGPTnClwXqATuYhc/tIl7CpZYn
        bRDPzUVnS1uUtTIDHbzEIDrdeuuHXQUr9M/lqcw8mNMtpSR5GqhYZrVuvnZ6FGy0
        Ybq96vSG/So6BOERr9IEPRUS9DvJ0GUBw+mtcy1mkZE9gV0ImfdkBKWig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NTcrnxvQck9gYDiF2BJtKRRo7ypRR9x+FvwIvb6tAhs=; b=ZKOSFTZ3
        PNZut6RCJotCOZLPqkCc87dlqDZBeBVtRb655EK1iLPXsUv1C8Czdm8ydR2r2r26
        +99A9LQ3LTl9NZ/38FISJs37gr1MHbk0nuDVcO9ot6V6dEXqiPcWpWaD72c8Ovvx
        PkzI7ftZWNw65cL8o1Sclbaa93L89shwYd2zJUvuAoPeOtHjaou5HqdiAuD2eYLU
        9S4uRyIT6lz3QcG11vHzlGETDTFG9H48LzdnMZFkmdyQmh1VsmE1XjC/RLt/EapE
        pdi5+JhqE9IKiMlgLUfNwKI0XGXr7zacQuEQtU8xWFgVlYCrCw4KtymMP3Y/c+Y1
        S+1H7HTLUJaT8A==
X-ME-Sender: <xms:oQUGX-7UC2fO6bwqkEZEDOQu2DBQNG2ACmCu7pxdxRorYRfohFPf1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:oQUGX36ZtXiSeoKLyHYCOCkJbqR1VinkRkd0VhUyLXSJvyrk4RJhtw>
    <xmx:oQUGX9fmwUgUlVYN5IfYOybFtoQrvuIq-i9KBsr_aTtZYKd_04Xp4w>
    <xmx:oQUGX7LfC7VTtw7GLjZGZm6GlKQt71lJycrqx2Qr81Y_SWzmokYUfA>
    <xmx:oQUGXzp_0ND_SF6_tYw973jPn1t274eUz70nY_7UjQiHMqGv_f-daaht9S8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F16B4328005A;
        Wed,  8 Jul 2020 13:42:56 -0400 (EDT)
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
Subject: [PATCH v4 18/78] drm/vc4: crtc: Add HDMI1 encoder type
Date:   Wed,  8 Jul 2020 19:41:26 +0200
Message-Id: <6b2ca2dacd997bdf24a38318d427cfe4d6fbb7e7.1594230107.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 sports a second HDMI controller, so let's add that second HDMI
encoder type.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 5781773aec4b..4126506b3a69 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -427,6 +427,7 @@ to_vc4_plane_state(struct drm_plane_state *state)
 enum vc4_encoder_type {
 	VC4_ENCODER_TYPE_NONE,
 	VC4_ENCODER_TYPE_HDMI0,
+	VC4_ENCODER_TYPE_HDMI1,
 	VC4_ENCODER_TYPE_VEC,
 	VC4_ENCODER_TYPE_DSI0,
 	VC4_ENCODER_TYPE_DSI1,
-- 
git-series 0.9.1
