Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C27C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158092075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgHZJpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:45:50 -0400
Received: from mail.thorsis.com ([92.198.35.195]:50826 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgHZJpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:45:50 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2020 05:45:50 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 6C7ED46E1;
        Wed, 26 Aug 2020 11:37:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wtvtf5oFOyjP; Wed, 26 Aug 2020 11:37:42 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 3E5BE471B; Wed, 26 Aug 2020 11:37:41 +0200 (CEST)
Received: from adahl by ada.ifak-system.com with local (Exim 4.92)
        (envelope-from <ada@thorsis.com>)
        id 1kArs9-0007Yb-BO; Wed, 26 Aug 2020 11:37:37 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-kernel@vger.kernel.org, Alexander Dahl <post@lespocky.de>
Subject: [PATCH] leds: pwm: Allow automatic labels for DT based devices
Date:   Wed, 26 Aug 2020 11:37:37 +0200
Message-Id: <20200826093737.29008-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Dahl <post@lespocky.de>

If LEDs are configured through device tree and the property 'label' is
omitted, the label is supposed to be generated from the properties
'function' and 'color' if present.  While this works fine for e.g. the
'leds-gpio' driver, it did not for 'leds-pwm'.

The reason is, you get this label naming magic only if you add a LED
device through 'devm_led_classdev_register_ext()' and pass a pointer to
the current device tree node.  The approach to fix this was adopted from
the 'leds-gpio' driver.

For the following node from dts the LED appeared as 'led5' in sysfs
before and as 'red:debug' after this change.

        pwm_leds {
                compatible = "pwm-leds";

                led5 {
                        function = LED_FUNCTION_DEBUG;
                        color = <LED_COLOR_ID_RED>;
                        pwms = <&pwm0 2 10000000 0>;
                        max-brightness = <127>;

                        linux,default-trigger = "heartbeat";
                        panic-indicator;
                };
        };

Signed-off-by: Alexander Dahl <post@lespocky.de>
---

Notes:
    v1: based on v5.9-rc2, backport on v5.4.59 also works

 drivers/leds/leds-pwm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index ef7b91bd2064..a27a1d75a3e9 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -65,6 +65,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
+	struct led_init_data init_data = {};
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -90,7 +91,13 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	if (fwnode) {
+		init_data.fwnode = fwnode;
+		ret = devm_led_classdev_register_ext(dev, &led_data->cdev,
+						     &init_data);
+	} else {
+		ret = devm_led_classdev_register(dev, &led_data->cdev);
+	}
 	if (ret) {
 		dev_err(dev, "failed to register PWM led for %s: %d\n",
 			led->name, ret);
-- 
2.27.0

