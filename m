Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE674C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76ED2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858720;
	bh=rlajjikebCRDWVOwFb95SlsQIjaNNRrnpUO6V0/4mPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OzkhPy3YgyAnlLLP6eWmUT/XFL3bHmJYzA7uNETdCOy5V5+2sirfuCBc8dB7qTit4
	 HSgklCzoiqq0qU79trP2j7j8UJOo3721uRZSKpcsH2IkhL/uGEky7A+M5shkfKNM9T
	 EbrEIvCKYMSr6lPCrtMDLPRR0v+k+k6bzeO+yQJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgAXJik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgAXJih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:38:37 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA87208C4;
        Fri, 24 Jan 2020 09:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858716;
        bh=rlajjikebCRDWVOwFb95SlsQIjaNNRrnpUO6V0/4mPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0xJCANWoTa+l601qgvZN4bdMeQh+AwtHx79r1tvUanj2RRD7ZzVGpuTnUi4Z0Gep
         PKQgjGWQo7bg6RwOnzfKGHsH+Kh54frCEtyVPcmMWnMHs4AsV2k6r9DK35cBJnCCvF
         pJ04C3IXgpcOHOg7nSC0aoOCGlRS2oX9QNBpW/aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5.4 040/102] leds: tlc591xx: update the maximum brightness
Date:   Fri, 24 Jan 2020 10:30:41 +0100
Message-Id: <20200124092812.340606620@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Jacques Hiblot <jjhiblot@ti.com>

commit a2cafdfd8cf5ad8adda6c0ce44a59f46431edf02 upstream.

The TLC chips actually offer 257 levels:
- 0: led OFF
- 1-255: Led dimmed is using a PWM. The duty cycle range from 0.4% to 99.6%
- 256: led fully ON

Fixes: e370d010a5fe ("leds: tlc591xx: Driver for the TI 8/16 Channel i2c LED driver")
Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-tlc591xx.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 
 #define TLC591XX_MAX_LEDS	16
+#define TLC591XX_MAX_BRIGHTNESS	256
 
 #define TLC591XX_REG_MODE1	0x00
 #define MODE1_RESPON_ADDR_MASK	0xF0
@@ -112,11 +113,11 @@ tlc591xx_brightness_set(struct led_class
 	struct tlc591xx_priv *priv = led->priv;
 	int err;
 
-	switch (brightness) {
+	switch ((int)brightness) {
 	case 0:
 		err = tlc591xx_set_ledout(priv, led, LEDOUT_OFF);
 		break;
-	case LED_FULL:
+	case TLC591XX_MAX_BRIGHTNESS:
 		err = tlc591xx_set_ledout(priv, led, LEDOUT_ON);
 		break;
 	default:
@@ -157,7 +158,7 @@ tlc591xx_configure(struct device *dev,
 		led->priv = priv;
 		led->led_no = i;
 		led->ldev.brightness_set_blocking = tlc591xx_brightness_set;
-		led->ldev.max_brightness = LED_FULL;
+		led->ldev.max_brightness = TLC591XX_MAX_BRIGHTNESS;
 		err = led_classdev_register(dev, &led->ldev);
 		if (err < 0) {
 			dev_err(dev, "couldn't register LED %s\n",


