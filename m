Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5ED206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JAhw5BLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcvk7P0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgICIJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:54 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41843 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbgICICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BC536C41;
        Thu,  3 Sep 2020 04:02:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=qaa0v/8YrRUgG
        WrZD1j/XryU+Asyskx6+1ELGSSqF5w=; b=JAhw5BLlEmqhvGmUdtzz2X6WakvRo
        /rW5XqqSxtBqOXlER/VHwkIsvjVJDuMWZt9RnadLSTsHsi/x6kVNtNHOEsp9Y3Eg
        DLqASZEtRsgb3b/0H4/CUsRkaruy+WLZLEmm6fHnwuJAfSEyNmsa+Xcoo7be7ayh
        EEDvS6NntM9G0wC03kMZl3X9lThGzC4yglmNedTSNgDNKaL7kKDIDAkdrrMq/jxn
        qmncHRjbVn9ft9uhgxpduiBInNm4mn73FQs292WCTPJ1jyZC43VikntGJWvYlHqR
        3GY+Vt3xHe7OOYy7oaEOqQBRu7lI+lB1FeAGiyZt95+aVPK1G08XYH8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=qaa0v/8YrRUgGWrZD1j/XryU+Asyskx6+1ELGSSqF5w=; b=jcvk7P0E
        LKkgdYU5romkgGG9U5G+IyMLjzLrgf74J5b0zyvRn3C+FJjyZSBPovahsvnwpVZL
        DrndfaRjMKuMw7nIjhVlgNPeIkTLHEzFIEnCnL0x0QLcvclFt8ZurbMM2n+uFCha
        INTdvCg/0hQmpc+Sm1y6WP4R3xZGn3gxdu5n4mFym+AaXNSLqF2ls4ccmPqouYxX
        JjTTjk/wlK3iMR/Q7dA3uk54utROCB1N9ilqIvrqZLWMZoZN4OzAR2Poe1apT3EM
        OEyqNqN8hDnb8SyteCpDy2GvbN1HZjTqgLGy8dBr80MxKF6nxtH3hE4YztfA5SXb
        AAqadAAunFzsdw==
X-ME-Sender: <xms:FqNQXyhX3hr_5_A3VnQbeA9pGU6OeYIKxkvuzi75l7hwnISNKoag0Q>
    <xme:FqNQXzAoz4MScSBaAy72a8Sif56iYEuzwPmu5qO1z_QFQualAaoyV_WMyG7A65PEv
    3T2OJAWzRp0lrUePMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvfe
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:FqNQX6GU7-BDx6JdaCdcW80hRa6Iu411EcFrnH0oLNsuvwiZaJyDhw>
    <xmx:FqNQX7Ra2uwQ5_Pea782_zErlnOLY5RDpcQeu4a3pSfZ-FH1NpkDPg>
    <xmx:FqNQX_waqvhSmbGpYg1NYwRmtu26Os4BnDXWLOiNw94dmxfKC-nHbQ>
    <xmx:FqNQX943tBWelUwvRW_XibzZcqsGYj1f-fWyUQwzV5OJWkA7Gm30LDFSUnQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 162AC328005E;
        Thu,  3 Sep 2020 04:02:30 -0400 (EDT)
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
Subject: [PATCH v5 26/80] drm/vc4: crtc: Remove redundant pixelvalve reset
Date:   Thu,  3 Sep 2020 10:00:58 +0200
Message-Id: <a0a31af0d4a7a070de979f0e5b618d9e2c730e7f.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
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

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 2eda2e6429ec..2c5ff45dc315 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -427,7 +427,6 @@ static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	require_hvs_enabled(dev);
 
-	vc4_crtc_pixelvalve_reset(crtc);
 	vc4_crtc_config_pv(crtc);
 
 	CRTC_WRITE(PV_CONTROL, CRTC_READ(PV_CONTROL) | PV_CONTROL_EN);
-- 
git-series 0.9.1
