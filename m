Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6253C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B193220716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAZUA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:00:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:25049 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAZUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:00:25 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjcv7w="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id k0645aw0QK0FF2G
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 26 Jan 2020 21:00:15 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v3 2/2] wl1251: remove ti,power-gpio for SDIO mode
Date:   Sun, 26 Jan 2020 21:00:14 +0100
Message-Id: <e77b49bb475f63dd7b07bfb76a75651e80bbace7.1580068813.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1580068813.git.hns@goldelico.com>
References: <cover.1580068813.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove handling of this property from code.

Note that wl->power_gpio is still needed in
the header file for SPI mode (N900).

Suggested by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/net/wireless/ti/wl1251/sdio.c | 32 ++-------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index 94569cd695c8..c9a4e9a43400 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -15,9 +15,7 @@
 #include <linux/wl12xx.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 
 #include "wl1251.h"
@@ -160,15 +158,6 @@ static int wl1251_sdio_set_power(struct wl1251 *wl, bool enable)
 	int ret;
 
 	if (enable) {
-		/*
-		 * Power is controlled by runtime PM, but we still call board
-		 * callback in case it wants to do any additional setup,
-		 * for example enabling clock buffer for the module.
-		 */
-		if (gpio_is_valid(wl->power_gpio))
-			gpio_set_value(wl->power_gpio, true);
-
-
 		ret = pm_runtime_get_sync(&func->dev);
 		if (ret < 0) {
 			pm_runtime_put_sync(&func->dev);
@@ -186,9 +175,6 @@ static int wl1251_sdio_set_power(struct wl1251 *wl, bool enable)
 		ret = pm_runtime_put_sync(&func->dev);
 		if (ret < 0)
 			goto out;
-
-		if (gpio_is_valid(wl->power_gpio))
-			gpio_set_value(wl->power_gpio, false);
 	}
 
 out:
@@ -241,31 +227,17 @@ static int wl1251_sdio_probe(struct sdio_func *func,
 
 	wl1251_board_data = wl1251_get_platform_data();
 	if (!IS_ERR(wl1251_board_data)) {
-		wl->power_gpio = wl1251_board_data->power_gpio;
 		wl->irq = wl1251_board_data->irq;
 		wl->use_eeprom = wl1251_board_data->use_eeprom;
 	} else if (np) {
-		wl->use_eeprom = of_property_read_bool(np,
-						       "ti,wl1251-has-eeprom");
-		wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
+		wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 		wl->irq = of_irq_get(np, 0);
-
-		if (wl->power_gpio == -EPROBE_DEFER ||
-		    wl->irq == -EPROBE_DEFER) {
+		if (wl->irq == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto disable;
 		}
 	}
 
-	if (gpio_is_valid(wl->power_gpio)) {
-		ret = devm_gpio_request(&func->dev, wl->power_gpio,
-								"wl1251 power");
-		if (ret) {
-			wl1251_error("Failed to request gpio: %d\n", ret);
-			goto disable;
-		}
-	}
-
 	if (wl->irq) {
 		irq_set_status_flags(wl->irq, IRQ_NOAUTOEN);
 		ret = request_irq(wl->irq, wl1251_line_irq, 0, "wl1251", wl);
-- 
2.23.0

