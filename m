Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB3EC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232F720767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YxiLJTnJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFKxLPL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgICIGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:06:12 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36085 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728485AbgICIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:03:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 930D5B18;
        Thu,  3 Sep 2020 04:03:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 04:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=jnQt4XEB0EjaE
        69LUU8juUV5o++ManSG9KwUOjrWqLk=; b=YxiLJTnJ05XHPLIMyp/gM48L7d78s
        69NozG54Oajg2BEdr1fFnJwVHTLV8lF11bv0xEiN+jznG4wOS5BbFVfWg67Pqubr
        e7aX3h3Z2LvxeZOvzD9MmDuxofW72rl8CGuJsvzP7TeXErAIfcXPYGp0TXcljamg
        rxheudTjQJRdzZzjOYylrCe8wbW5HHM0SlO6osHmSNBsN+Akux6V7FO+n6R1WJme
        /gZfy+58po/tZAOS1y1VuHojwVGOFok9zTdTJOoActidSHkXSU+dhx/iidnl+p1n
        F2MdgwTVrx1rGAFwlM27O6w7Qs82+z8WT/VQqtHympL2WWPwofqf2twOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jnQt4XEB0EjaE69LUU8juUV5o++ManSG9KwUOjrWqLk=; b=EFKxLPL5
        ZkaIe2dKrYMMBz3Z7t3eiTgCGyHHp5wqGO7x0zPsnKnO+eHauTgvqCWWNERH8HJt
        Yu+pliG9ugJxOIHPXUOB9pm3ek1ozBnzsHWK+cZGIQ7r2+C8x3LpzHQFaV0pbE/V
        iD53XJpO12voHtC07yOrM7YAfSRZUzUdjVStxzojYmcp2RCkn4r7QuQV8ukEgtyf
        gSian0RGPUI3zhM6OzvM3ZNN3RaL4fYadJzjRBkbowyNQ97UilPH2ToKtJzTeVbX
        SugDYIXLGm09Xwmo7oYExZaKmLBQyXI5GxzokI0NDwY5x+zOlryg9CrPlvpZfAVp
        8Iz1OMLt8ot5FQ==
X-ME-Sender: <xms:TKNQXzmVFl0b1JWcLe2g5WgriBpbsyKaR5YNGvHl6j-OcoN03nYyxQ>
    <xme:TKNQX23bMDNCijNUcJp-hQyj1tyeIyJrak9BDA5asZssDI9qffJKqzwhdnxA0Sggg
    BnQqjn5Jjumu9gi8BE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegtddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveev
    heehvdenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeehke
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TKNQX5qzzXbu58rstGL268O0MYEHwUndv0AoP1y5eOc9o3DpxFMv3g>
    <xmx:TKNQX7lAzcclJZuM4oAjNlBL4Ji9Dzzs8qZCZT2TN469aS8jMtorww>
    <xmx:TKNQXx2JWs_wdy1HqSqluIT9WiB9wzjx2aNptbgpWqoHnMU-Yd2z7g>
    <xmx:TKNQXytfS6wS_f6pzKngBUu7S90leQSgIfBl0IppBBXYs8AYpZ8AaoKXt2c>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFF85328005A;
        Thu,  3 Sep 2020 04:03:23 -0400 (EDT)
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
Subject: [PATCH v5 64/80] drm/vc4: hdmi: Use clk_set_min_rate instead
Date:   Thu,  3 Sep 2020 10:01:36 +0200
Message-Id: <821992209cc0d7a83254bf26fe2bf507ef0994d2.1599120059.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSM clock needs to be running at 101% the pixel clock of the HDMI
controller, however it's shared between the two HDMI controllers, which
means that if the resolutions are different between the two HDMI
controllers, and the lowest resolution is on the second (in enable order)
controller, the first HDMI controller will end up with a smaller than
expected clock rate.

Since we don't really need an exact frequency there, we can simply change
the minimum rate we expect instead.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 84273fe650d6..487c04de6b85 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -462,7 +462,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	 * pixel clock, but HSM ends up being the limiting factor.
 	 */
 	hsm_rate = max_t(unsigned long, 120000000, (pixel_rate / 100) * 101);
-	ret = clk_set_rate(vc4_hdmi->hsm_clock, hsm_rate);
+	ret = clk_set_min_rate(vc4_hdmi->hsm_clock, hsm_rate);
 	if (ret) {
 		DRM_ERROR("Failed to set HSM clock rate: %d\n", ret);
 		return;
-- 
git-series 0.9.1
