Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE8EC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9263A208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IlcQ9sPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tamQUJrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgICIJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:38 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37351 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgICICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A3266968;
        Thu,  3 Sep 2020 04:02:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=R8RukDV67kA4S
        lBsd48ysWMys3SVerSNYQrVkJ5+NyI=; b=IlcQ9sPrKZ9Jj/M/joRcolwfeHayy
        NWTGYlHWReDgBsTBKP80/adV/t39fAtd5SGhZ4e/xUQQmPukjeWdMvdbmmxnWKEP
        cPncjxAFy9WKIbQH4nk8Gy1+cRMGOY7uggLmDCLeSPF1oZ5Dc8HX44vOFr2YOYmo
        4XQ+CIpB/VtBYpJKn2aeqKK8QSmbfopA+NB2+mpUr8yzFK6yXSoRv0CpFtGQjaSM
        Jp98iwUOa3TMFE5ETyN3Jv3cf5gt23CdiVb8y8g15snLWBweKsa26+TNmNi7RAhw
        GHNSOi1HgHi1he2TYnmJsaeUx0/A+cFNFfCG0ebEdOaNJBRTZEGxDUBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=R8RukDV67kA4SlBsd48ysWMys3SVerSNYQrVkJ5+NyI=; b=tamQUJrm
        a1BPaCoPR+ALLWUVWpB+ATFU8NacElegFsoKJYy+9XpC7EPL7WTzyaLgfCc1AiLh
        hYW7036UJkK+DTHeIqnJmTmSV7Gtpqlpkx8dqeH9jS1lvoT8Qj5LEtHSZxU1eDYW
        wXzC72NxE/yniUEkvNIY5JCYcDi5+bKXwBBZx/B60Z3J4CV0POK3Cel9QidIa1zY
        7W6ls7Olk2Dr/NBRo+6WVpQ0tC948GAGfAWdpY2pOI6bMpWHncZ9PoomSxzR6qWr
        l+WISegqYiqWF7DYOC6ILQBew+BvLDzW/pKnAhbo+/cnLqkgMk7PX5izWfLbPYxh
        1AUpqxLhx9wqlQ==
X-ME-Sender: <xms:HaNQX9QGhTrK4G9c8Xqj6KoPg2OWY6skUo7ODMeAMVVWWvih2MT94Q>
    <xme:HaNQX2x8LNoPiuqzQGV-JuPKB7EqDMj2Kgu-GK9fWyGkRkMXw8RdQzJmuzR52yBJt
    0NaA5STnzmczadqCYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvje
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HaNQXy1aqi9LFayOmZNKVkWvtaM6eYFQAhuOnR4Bp3IcNh7fY6ho6A>
    <xmx:HaNQX1A_7MRKvxK2P_9vqJBeVCIDhU4FIeeiiTKCYztsDU1CvKmsmQ>
    <xmx:HaNQX2iZfBMoWZ248RZeY71nPmTx6zSfGqBCnCT-EUuFzc70Sz0wdA>
    <xmx:HaNQX9oKmLvejdues64l5SNueW0F9cVbehreufwf6Bxsfw7C_CdqqufdGL4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7F39306005E;
        Thu,  3 Sep 2020 04:02:36 -0400 (EDT)
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
Subject: [PATCH v5 31/80] drm/vc4: crtc: Clear the PixelValve FIFO during configuration
Date:   Thu,  3 Sep 2020 10:01:03 +0200
Message-Id: <ccd6269ba37b2f849ba6e62471c99bd93a4548a0.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it's not really clear why we need to flush the PV FIFO during
the configuration even though we started by flushing it, experience shows
that without it we get a stale pixel stuck in the FIFO between the HVS and
the PV.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 73d918706f7e..00b2c2b011d1 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -358,7 +358,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc)
 	if (is_dsi)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
-	CRTC_WRITE(PV_CONTROL,
+	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
 		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
 		   VC4_SET_FIELD(pixel_rep - 1, PV_CONTROL_PIXEL_REP) |
-- 
git-series 0.9.1
