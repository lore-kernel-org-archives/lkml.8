Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDF4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0522081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YU+RBJh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFZA4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:56:21 -0400
Received: from vps.xff.cz ([195.181.215.36]:45366 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgFZA4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132969; bh=N2+51FLSxUgYRTfkXppkmskKeBdxuh3L5G/ggCgw7IU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YU+RBJh1BuD/O0pZTuUclupCY0WwQbwCu7LwnIsZ9fPLnfxBKXxeNefY3Ju6DjE1f
         +oomT5n3OGj1k/gML4Nobh8D0ib0BdJVSzYpLTkzf1P39N/lftJ5Kvy1VLx73X0paN
         QohLdX6hy/qdRtXWDCD20Wew0lgTsbDK4+8s/zGA=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v5 11/13] drm/panel: st7703: Assert reset prior to powering down the regulators
Date:   Fri, 26 Jun 2020 02:55:59 +0200
Message-Id: <20200626005601.241022-12-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset pin is inverted, so if we don't assert reset, the actual gpio
will be high and may keep driving the IO port of the panel.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index e771281eb547..92930e127559 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -416,6 +416,7 @@ static int st7703_unprepare(struct drm_panel *panel)
 	if (!ctx->prepared)
 		return 0;
 
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
 	ctx->prepared = false;
-- 
2.27.0

