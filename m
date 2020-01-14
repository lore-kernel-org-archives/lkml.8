Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D9DC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C892820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996446;
	bh=rE7QBSma/p8DVJlJA35iUxJ1Y9UvZCnyIuSvTLJfYBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBMyUF4dbVTisgYDMHj200rnJXDa1cOoCaAJO9BOh/c7eUuaw/StlNYpyczUW1vkA
	 XMNQlY91dlQ3suFk+gLzSMEs8F4IEGlQMellMUm1mjoQq3h1kF7+ZEHcZQAJrVtWHc
	 L18T6x7bUGtXmM9twsmfxjPXmvIgc84bcNc/GfAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgANKHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbgANKHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EF024687;
        Tue, 14 Jan 2020 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996434;
        bh=rE7QBSma/p8DVJlJA35iUxJ1Y9UvZCnyIuSvTLJfYBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlgWeyITZoQm4ki8DMmIeBGg51e3xZeswLUvjKwrXIa9gsJsVPpsy9iO4z4RIAN1+
         teN0JOijkahAOx9M0xMQr6bdWooIhnMKYtoIdcm4HP29ziXgSM+sprJg4NHIRKZZW9
         vJ0ZYpuxaiNHQ63QR3GKUJEpuct2CP0V2fiw4/qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 4.19 16/46] drm/sun4i: tcon: Set RGB DCLK min. divider based on hardware model
Date:   Tue, 14 Jan 2020 11:01:33 +0100
Message-Id: <20200114094343.835349007@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

commit 4396393fb96449c56423fb4b351f76e45a6bcaf6 upstream.

In commit 0b8e7bbde5e7 ("drm/sun4i: tcon: Set min division of TCON0_DCLK
to 1.") it was assumed that all TCON variants support a minimum divider
of 1 if only DCLK was used.

However, the oldest generation of hardware only supports minimum divider
of 4 if only DCLK is used. If a divider of 1 was used on this old
hardware, some scrolling artifact would appear. A divider of 2 seemed
OK, but a divider of 3 had artifacts as well.

Set the minimum divider when outputing to parallel RGB based on the
hardware model, with a minimum of 4 for the oldest (A10/A10s/A13/A20)
hardware, and a minimum of 1 for the rest. A value is not set for the
TCON variants lacking channel 0.

This fixes the scrolling artifacts seen on my A13 tablet.

Fixes: 0b8e7bbde5e7 ("drm/sun4i: tcon: Set min division of TCON0_DCLK to 1.")
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200107070113.28951-1-wens@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |   15 ++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -423,7 +423,7 @@ static void sun4i_tcon0_mode_set_rgb(str
 
 	WARN_ON(!tcon->quirks->has_channel_0);
 
-	tcon->dclk_min_div = 1;
+	tcon->dclk_min_div = tcon->quirks->dclk_min_div;
 	tcon->dclk_max_div = 127;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
@@ -1249,12 +1249,14 @@ static int sun6i_tcon_set_mux(struct sun
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
 	.has_channel_0		= true,
 	.has_channel_1		= true,
+	.dclk_min_div		= 4,
 	.set_mux		= sun4i_a10_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 	.has_channel_0		= true,
 	.has_channel_1		= true,
+	.dclk_min_div		= 4,
 	.set_mux		= sun5i_a13_tcon_set_mux,
 };
 
@@ -1263,6 +1265,7 @@ static const struct sun4i_tcon_quirks su
 	.has_channel_1		= true,
 	.has_lvds_alt		= true,
 	.needs_de_be_mux	= true,
+	.dclk_min_div		= 1,
 	.set_mux		= sun6i_tcon_set_mux,
 };
 
@@ -1270,11 +1273,13 @@ static const struct sun4i_tcon_quirks su
 	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.needs_de_be_mux	= true,
+	.dclk_min_div		= 1,
 };
 
 static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
 	.has_channel_0		= true,
 	.has_channel_1		= true,
+	.dclk_min_div		= 4,
 	/* Same display pipeline structure as A10 */
 	.set_mux		= sun4i_a10_tcon_set_mux,
 };
@@ -1282,11 +1287,13 @@ static const struct sun4i_tcon_quirks su
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.has_channel_0		= true,
 	.has_lvds_alt		= true,
+	.dclk_min_div		= 1,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
 	.supports_lvds		= true,
 	.has_channel_0		= true,
+	.dclk_min_div		= 1,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
@@ -1295,11 +1302,13 @@ static const struct sun4i_tcon_quirks su
 
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	.has_channel_0		= true,
+	.dclk_min_div		= 1,
 };
 
 static const struct sun4i_tcon_quirks sun9i_a80_tcon_lcd_quirks = {
-	.has_channel_0	= true,
-	.needs_edp_reset = true,
+	.has_channel_0		= true,
+	.needs_edp_reset	= true,
+	.dclk_min_div		= 1,
 };
 
 static const struct sun4i_tcon_quirks sun9i_a80_tcon_tv_quirks = {
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -224,6 +224,7 @@ struct sun4i_tcon_quirks {
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+	u8	dclk_min_div;	/* minimum divider for TCON0 DCLK */
 
 	/* callback to handle tcon muxing options */
 	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);


