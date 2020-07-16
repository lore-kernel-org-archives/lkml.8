Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220A5C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD46720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="jWD2nsWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgGPMiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:17 -0400
Received: from vps.xff.cz ([195.181.215.36]:42204 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgGPMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594903092; bh=QEjTMk4ZzDSZ6Jx5V1yWHh4jwwChWuP75ep9d/rMANQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jWD2nsWAo4QoTnAKgwVif+Nqr3TV5kn/AplnCLQtSKz8rl5trI1YUH6t1AZfhdbLL
         7MjBD0eUbu0G75x3fE5Qpqq2I2G+9/0NF0Nwj5C4X284U/EarsUyAmOd8UXct61Vqq
         n2PvsVhjvcG7Zo9m9UHT/lhhEU6pNgfj0YRY2xJs=
From:   Ondrej Jirman <megous@megous.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
Cc:     Ondrej Jirman <megous@megous.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panel: st7703: Fix the power up sequence of the panel
Date:   Thu, 16 Jul 2020 14:37:53 +0200
Message-Id: <20200716123753.3552425-3-megous@megous.com>
In-Reply-To: <20200716123753.3552425-1-megous@megous.com>
References: <20200716123753.3552425-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet specifies that it's better to keep reset asserted
while powering up the supplies, and that IOVCC should be enabled
first.

There also needs to be a delay after enabling the supplies and
before deasserting the reset. The datasheet specifies 1ms after
the supplies reach the required voltage. Use 10-20ms to also
give the power supplies some time to reach the required voltage,
too.

This fixes intermittent panel initialization failures and screen
corruption during resume from sleep on PinePhone.

Reported-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 45833e6a0f4f..48569a8688f6 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -429,12 +429,8 @@ static int st7703_prepare(struct drm_panel *panel)
 		return 0;
 
 	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
-	ret = regulator_enable(ctx->vcc);
-	if (ret < 0) {
-		DRM_DEV_ERROR(ctx->dev,
-			      "Failed to enable vcc supply: %d\n", ret);
-		return ret;
-	}
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+
 	ret = regulator_enable(ctx->iovcc);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev,
@@ -442,10 +438,18 @@ static int st7703_prepare(struct drm_panel *panel)
 		goto disable_vcc;
 	}
 
-	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-	usleep_range(20, 40);
+	ret = regulator_enable(ctx->vcc);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev,
+			      "Failed to enable vcc supply: %d\n", ret);
+		return ret;
+	}
+
+	/* Give power supplies time to stabilize before deasserting reset. */
+	usleep_range(10000, 20000);
+
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
-	msleep(20);
+	usleep_range(15000, 20000);
 
 	ctx->prepared = true;
 
-- 
2.27.0

