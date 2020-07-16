Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318B320739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="X089cgNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgGPMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:38:15 -0400
Received: from vps.xff.cz ([195.181.215.36]:42186 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgGPMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594903092; bh=dSbyi6wULGgN5LmJysYayv3TsF8wkvs/olfr2qRV6H0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X089cgNO00tj2xzQgTQefrTAbp/6POIMBW/ZM8iMbezzHouqiZwooLtWgP8t4invr
         RT2Jc4b96uw7wXyao4O7bMHH9/Bma+eGeWcv3qk6skTfZgPblpJoppIeMvYx/dC6xU
         kSgoCiq1L4O8uGB5sCz0UpLnWRArqFx5eUA0aFPg=
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
Subject: [PATCH 1/2] drm/panel: st7703: Make the sleep exit timing match the spec
Date:   Thu, 16 Jul 2020 14:37:52 +0200
Message-Id: <20200716123753.3552425-2-megous@megous.com>
In-Reply-To: <20200716123753.3552425-1-megous@megous.com>
References: <20200716123753.3552425-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver seemed to try to make the total cumulative time of all delays
across the whole power up sequence to sum up to 120ms.

The datasheet on the other hand specifies that there needs to be 120ms
delay after the sleep out command, not after reset as the driver
assumes.

Lastly, the delay between init commands and the sleep exit command is
not necessary. (not specified anywhere)

Reported-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 8996ced2b721..45833e6a0f4f 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -291,7 +291,6 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 	dsi_dcs_write_seq(dsi, ST7703_CMD_SETBGP,
 			  0x07, /* VREF_SEL = 4.2V */
 			  0x07  /* NVREF_SEL = 4.2V */);
-	msleep(20);
 
 	dsi_dcs_write_seq(dsi, ST7703_CMD_SETVCOM,
 			  0x2C, /* VCOMDC_F = -0.67V */
@@ -369,16 +368,14 @@ static int st7703_enable(struct drm_panel *panel)
 		return ret;
 	}
 
-	msleep(20);
-
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
 		DRM_DEV_ERROR(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
 		return ret;
 	}
 
-	/* Panel is operational 120 msec after reset */
-	msleep(60);
+	/* Dsiplay on can be issued 120 msec after sleep out */
+	msleep(120);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret)
-- 
2.27.0

