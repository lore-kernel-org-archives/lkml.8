Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A8BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5684821D47
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIKPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:51:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgIKPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:51:19 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.103.56]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFshF-1kJFLs3aFb-00HPgf; Fri, 11 Sep 2020 17:41:03 +0200
Received: from lemmy.internal.home.lespocky.de ([192.168.243.176] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <alex@home.lespocky.de>)
        id 1kGlAb-00013B-Hm; Fri, 11 Sep 2020 17:41:02 +0200
Received: (nullmailer pid 28466 invoked by uid 2001);
        Fri, 11 Sep 2020 15:41:01 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Alexander Dahl <ada@thorsis.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH v4 2/3] leds: pwm: Allow automatic labels for DT based devices
Date:   Fri, 11 Sep 2020 17:40:03 +0200
Message-Id: <20200911154004.28354-3-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911154004.28354-1-post@lespocky.de>
References: <20200911154004.28354-1-post@lespocky.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scan-Signature: 581c7ffa71bd056d31bcd0d50462ce09
X-Provags-ID: V03:K1:vd9UlApDbNcfwPEYFW0CXQ5k2yys8xV/ckjs/vE1n5cNGUt7WaY
 9l6aRrLvcHeN8aDpvR/SFqWKVLKDT9rDQJ/Bz6xeKBXBt2ATGa2HIuLO3akCzAZ1JzhGBJg
 CyVUVE3qbA4lYa56ASIscbrPd/avSDg4NzA6p5LOGfeCOl7AnnKD2BbT+YDpjs7qUVtMQX7
 m9hCLm2dFYHSoEaqDfICQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GB9tWlAJ3Y8=:rbijMWapG6GKdg/yV13mm1
 vjMRjccUyPp/1BjUjzuUyDBqkq5SSiJ8W8W4bhoFZxkGdTga4tA5raTsF+wyNtVaLjx04R0Pi
 brTvjCveH2Bsx9DTlH7G4JA6PVRUMRX7GTHTLRDCQs41NQ0AHe8Ye0EWT3m0GWHRzhoz+5fY0
 mLqPSl1YSMdpw/9cB68lKYwxMvkOKA6PYXUYcGzopKvNDFYgKL4cXF3nrQneYIYJmKlB7zyMF
 mccxbsk0gqZWveVcVN/EzXDfqWYZy0RlIbwHx22tMMXAzamEdZokWFMPknT4pEVSZCdAJxftl
 MixPL394xGQz1qLF7fGSIWXEY1U6iejcD/k2ssCEtPhF+/xg8Vli7zOTFmsJYqWlNEqZdcsJk
 RKkqZa+UeVmU9R3/M51pAFB+zdBxg/z9ra5C7TdjOKppP1JZePvp49xHP/cEa9erj2xxe+GDX
 b6dWBeY90NhV3daEJaHeBLk5CRYBDnMO1cSEShJd6CnE2rnVn2PrqspznQjCRP9fO9Dn0mK+f
 MjCD42br4knMglmGawA51xAI8UFriPNxPolDaWu7sJdJQq6dgrfwCguosyq6YHUD/aBq0ov1h
 GPs4QDRofSTVBEZrYMM+IJ3wtUJ51ky7cW3xWajN95MtY5co7HQFVvz6P8ptLytjJ7CKpU+9l
 ZZYd3lKqas4QwRkwDOq97moJW6dvQHXxwjc46n4/EW2JH0CkUmYJabgnMhWbBBFIOnFppUX0G
 KIN7YDUdVu3xZ7xzMjNNvaqW453NFkaHnOPCno/fxs7m2Ra4jkU5e1JLw6lH2W2pSTxXGteRm
 oS6hqZCAqy1EyQ9Ft5VAjxaBktnNsjSl/1+fJOI0Z0acbKbYDzTS6n0oZ7xGznCW0v7fI3X
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If LEDs are configured through device tree and the property 'label' is
omitted, the label is supposed to be generated from the properties
'function' and 'color' if present.  While this works fine for e.g. the
'leds-gpio' driver, it did not for 'leds-pwm'.

The reason is, you get this label naming magic only if you add a LED
device through 'devm_led_classdev_register_ext()' and pass a pointer to
the current device tree node.

The approach to fix this requires a change to led-class checking on
init_data->fwnode being NULL early.

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
    v3 -> v4:
      * simplified implementation based on a new change in led-core
      * removed Acked-by due to changed implementation
    
    v2 -> v3:
      * added Acked-by
    
    v1 -> v2:
      * no change to this patch

 drivers/leds/leds-pwm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index ef7b91bd2064..9017d3e7dd94 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -65,6 +65,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
+	struct led_init_data init_data = { .fwnode = fwnode };
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -90,7 +91,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	ret = devm_led_classdev_register_ext(dev, &led_data->cdev, &init_data);
 	if (ret) {
 		dev_err(dev, "failed to register PWM led for %s: %d\n",
 			led->name, ret);
-- 
2.20.1

