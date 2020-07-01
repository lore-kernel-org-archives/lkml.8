Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B4BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D4420747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="d5cAgCYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgGAKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:31:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:42428 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbgGAKbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599493; bh=DvITnUxZVcnsKisp8VN9mijP099DQ56ot4eLoJf/s34=;
        h=From:To:Cc:Subject:Date:References:From;
        b=d5cAgCYYo9BAdY5QF30KJ1wlKezbARyhLlDubu3e8Gp7xC35/Tmapd+SZ3Jdfds0Y
         oKNP4pXz8szJTwMhX+Ci+fqoTE38t29pFNEuQbJH5CKr0VeHC3vpHg8JbSUgyfDIow
         eqnKaRNKDbjux/3AJj1+vhLI0A6UAY9Qcu60zQDs=
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
Subject: [PATCH v6 10/13] drm/panel: st7703: Enter sleep after display off
Date:   Wed,  1 Jul 2020 12:31:23 +0200
Message-Id: <20200701103126.1512615-11-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet suggests to issue sleep in after display off
as a part of the panel's shutdown sequence.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 5cd5503f894f..0c4167994d01 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -395,8 +395,19 @@ static int st7703_disable(struct drm_panel *panel)
 {
 	struct st7703 *ctx = panel_to_st7703(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to turn off the display: %d\n", ret);
 
-	return mipi_dsi_dcs_set_display_off(dsi);
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to enter sleep mode: %d\n", ret);
+
+	return 0;
 }
 
 static int st7703_unprepare(struct drm_panel *panel)
-- 
2.27.0

