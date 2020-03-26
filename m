Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA69C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989562073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:10:19 -0400
Received: from sauhun.de ([88.99.104.3]:54390 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgCZVKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:01 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 4594D2C1F8B;
        Thu, 26 Mar 2020 22:10:00 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] video: backlight: tosa_lcd: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:59 +0100
Message-Id: <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/video/backlight/tosa_lcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index e8ab583e5098..113116d3585c 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -107,7 +107,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
 	/* TG LCD GVSS */
 	tosa_tg_send(spi, TG_PINICTL, 0x0);
 
-	if (!data->i2c) {
+	if (IS_ERR_OR_NULL(data->i2c)) {
 		/*
 		 * after the pannel is powered up the first time,
 		 * we can access the i2c bus so probe for the DAC
@@ -119,7 +119,7 @@ static void tosa_lcd_tg_on(struct tosa_lcd_data *data)
 			.addr	= DAC_BASE,
 			.platform_data = data->spi,
 		};
-		data->i2c = i2c_new_device(adap, &info);
+		data->i2c = i2c_new_client_device(adap, &info);
 	}
 }
 
-- 
2.20.1

