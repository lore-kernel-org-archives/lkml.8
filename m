Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A0CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02E8206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Uz9EJdBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUwAGE9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgICIJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:09:50 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45787 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728397AbgICICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:02:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E4876B0C;
        Thu,  3 Sep 2020 04:02:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xjW7xn8tega2f
        QqhFSzGhgXz2ZtI1k2ChmTaGq2MRWo=; b=Uz9EJdBNxHaqLxRQ/Ib3tBqUPOG9E
        hunKIXqrpRysdlcSlHY9ShXDQR75jjGS433cJRxX4bcjzMksOWbMdreV6yjgwm7H
        dQq7Arsw0qs+Oyp8ZhF6pZO52jXFnUe+vvwZTZumB9EkMLypEeXeX7g0RM84M1Iw
        SvyGKUl+9K0Tv4mSD465hNo0gqRRNU6ZwLO50Gf0tjghTA2FxGzj3s+krTfUUmFv
        6RzQ/8+zqRV4TT5sLlA3/AlmTQXp2VSWeqKqzIWDBhADtlBAQK44eK6t725uuXtO
        hDqNTJSsiYJClYcRFx/18Jub1xAI7G7MyCopLMnfT9YgVFdZUIZlMjOcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xjW7xn8tega2fQqhFSzGhgXz2ZtI1k2ChmTaGq2MRWo=; b=VUwAGE9B
        V73t/XvIo8qh8fhp8E1IvHIWUFwKvBdyrFkVoPi50ibrHAEx6a2c9pzC6i+ThHq1
        BaOIOGGOgk3ixqmHuar0D46HX0gL3knVaYOBw317v0KwvjJKLBEIXBBP4LLFLLi/
        7n0K1Y61pINMyxG6N8glRfYxmuLaXmwSkX4O1odSRSWpmMik3Abt9KhP0R7cpO5a
        ODiytdIbohMdKAgq32nvQw9JlmWZffX3z6zCbKTiCeNYdIip/SRx3kjfz4zHb6fh
        al7pmwFNA2cKjAgoZchafrtWM8wi3tI1Nd/rf+E7x0UnRPEJP4BYtkD9oiVFR0ym
        +Oy75Qpd5jg4/w==
X-ME-Sender: <xms:GqNQXxan-cttdCgdM3JA1Au7uF3nDjVQ3YXXonh1PvWaa0jdo85NkA>
    <xme:GqNQX4YEqIkIIlZ5IfY6H-ze7E0KtxT33rVqfMKaTLZcKmbZQ2un3-RakBYSQD75J
    rn-O-0_Q0o5wv-NdC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvje
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GqNQXz-pgudW9GfT5o8pbUpoIlQjLHrMXbvQwyswbiJD-KpbjuE9mg>
    <xmx:GqNQX_oVqON8gscs6pT5K60H6BcdHsrhbvXmSIYJ26p_DhZZurOLag>
    <xmx:GqNQX8q7Cz0OnSasbUUwdKKMwpIREyWOn1VqKc5EGh4zTJYt95tHyw>
    <xmx:GqNQXxQd2bvXwCxc2bkRUhArzec_vwwIkG8OgqkBTF8h0YRvabDJ3YLgjzA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2BDD7306005B;
        Thu,  3 Sep 2020 04:02:34 -0400 (EDT)
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
Subject: [PATCH v5 29/80] drm/vc4: crtc: Add a delay after disabling the PixelValve output
Date:   Thu,  3 Sep 2020 10:01:01 +0200
Message-Id: <15cf215bd2ceebd203c4010c09c21a4019c650ed.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid pixels getting stuck in the (unflushable) FIFO between
the HVS and the PV, we need to add some delay after disabling the PV output
and before disabling the HDMI controller. 20ms seems to be good enough so
let's use that.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index d0b326e1df0a..4c23cf8aefb9 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -403,6 +403,24 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
 	ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
 	WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
 
+	/*
+	 * This delay is needed to avoid to get a pixel stuck in an
+	 * unflushable FIFO between the pixelvalve and the HDMI
+	 * controllers on the BCM2711.
+	 *
+	 * Timing is fairly sensitive here, so mdelay is the safest
+	 * approach.
+	 *
+	 * If it was to be reworked, the stuck pixel happens on a
+	 * BCM2711 when changing mode with a good probability, so a
+	 * script that changes mode on a regular basis should trigger
+	 * the bug after less than 10 attempts. It manifests itself with
+	 * every pixels being shifted by one to the right, and thus the
+	 * last pixel of a line actually being displayed as the first
+	 * pixel on the next line.
+	 */
+	mdelay(20);
+
 	if (vc4_encoder->post_crtc_disable)
 		vc4_encoder->post_crtc_disable(encoder);
 
-- 
git-series 0.9.1
