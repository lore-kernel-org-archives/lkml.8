Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D90C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613882088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="A5CdNSbz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Fp/wADc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgE0Pu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:50:56 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47645 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730557AbgE0Pua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:50:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2AD8A582086;
        Wed, 27 May 2020 11:50:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=nG/RYo7tmKxJf
        6kRryI78rAS9caRthvRwWfJX3SbsG0=; b=A5CdNSbzLgWsDFPRyDGr7S6i2Qp6J
        vgfku64SpbbqX1swjGP4Im9bmXzaraxHGW+KHX2EOPNHDfZcxTmnRaU1vbl+9bLS
        ZRJEfcwoFdN5LbbSsGqd8ywC9dAY8Qp8F8LIRTZHH0PQScEZZcLTss0H2wDxYFeN
        n5/Vaz1eV3NHGr8Q9hAkDtzgP2P/3zIjyL1TbTB/aULwNTi8Jr3nDPlrumDkTmIo
        Y6I1oBAPiOJn64U1BU7LDhC9bIgIyFOAqAxfCtPOqFDHyg6ER+1UYOU3B/CUba0G
        ChRxxPKpajCBqC0lE28jtAOFLrsOEEs0aWZyKuvmjWRreqULCHPgiH0xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=nG/RYo7tmKxJf6kRryI78rAS9caRthvRwWfJX3SbsG0=; b=1Fp/wADc
        U9CoB8+Xb/cAepV5LsvhZE5Ybj7f3c4OX2rHQyLcWZ2XbbORDmY39LaWY53JYyUu
        qd7qhVu3LFi+lFsbEaDYmnPgF3640mj7rya8im20njaCYB3LNyDPqcmMWtBwdTue
        03dDIU2yvmlpdHkqTebyeiUk/cuX4phcz9kkyHHF00LoSSbE3/DcQUEOI9IT3Rri
        6QPkXya+7at64Q69oO9G/FY+QR0MjJUnnXvbKTcee4o/9I7y5PkTAn2CHHpVqyRl
        e7ix3nZaY5qw64x1swnuPMWHQRbu/F8Prx+RlCnkT/5OVE8UZ2hkKj1V15e70gG4
        HjiZ4tWzuXEVFg==
X-ME-Sender: <xms:RYzOXu39WoUbQEbRgsOLV35Yfy_8hMu55Unxy0A0yEWaG_lMy9ALVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdehne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:RYzOXhEoU2zzLKEzZoaPyG5uMLEcxpZmJcjyVfHvjK6x-lwksZp7sQ>
    <xmx:RYzOXm6tc3rkK2f05zF3f2CO28fhhrgFKmyf7ooU0eyHR_b6UY2Edg>
    <xmx:RYzOXv0XXZvz_mGcy7MCNvksUEk9Xi8anuFRCeMFaY_J2onO8DufPg>
    <xmx:RYzOXo3YiqEi58qDNsOLf2piHcaszUUnKVyvxxTCUXSCvfobXzrscA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98E263061CCB;
        Wed, 27 May 2020 11:50:28 -0400 (EDT)
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
Subject: [PATCH v3 045/105] drm/vc4: hvs: Make sure our channel is reset
Date:   Wed, 27 May 2020 17:48:15 +0200
Message-Id: <c1c69d2d2d909822300dca1ddc0bb5b5896a5107.1590594512.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to clear our intermediate FIFOs that might end up with a stale
pixel, let's make sure our FIFO channel is reset everytime our channel is
setup.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 87bbd68d44db..754aff3966bd 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -205,6 +205,10 @@ static int vc4_hvs_init_channel(struct vc4_dev *vc4, struct drm_crtc *crtc,
 	u32 dispbkgndx;
 	u32 dispctrl;
 
+	HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
+	HVS_WRITE(SCALER_DISPCTRLX(chan), SCALER_DISPCTRLX_RESET);
+	HVS_WRITE(SCALER_DISPCTRLX(chan), 0);
+
 	/* Turn on the scaler, which will wait for vstart to start
 	 * compositing.
 	 * When feeding the transposer, we should operate in oneshot
-- 
git-series 0.9.1
