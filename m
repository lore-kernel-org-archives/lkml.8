Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1EA205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220251;
	bh=rQmFTUu6gz/gizWikfCmnBtD6sywhhWM9uaIXaMx7ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QeUymPz7s+wVErqgsKzRSsUAXL/YwoGm3dcsaJrXqJcn0akRavFOtvVBgiajMqtmG
	 sG2tm9jCKK/ZUCyptTvhDEMjvWzbklP6VRcAo/pRDNuJXa5YL4lSYl0eGG1hE4WmB7
	 D9B1SSATP1tMj9/bhecOdK8rwzJ8a+pdb/BhmhOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgA1OEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgA1OEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:04:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFDDA24683;
        Tue, 28 Jan 2020 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220247;
        bh=rQmFTUu6gz/gizWikfCmnBtD6sywhhWM9uaIXaMx7ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1ar0h9DfXcPcs1FLTXxXEHYuc9ofkNFSwCC19yXbbMnhFJ8fdzhQVOayn9jbeEC5
         nG5vXV2Emf09zqdJUqnJrgHrPzDCzUERmFwktctHX0/usJu50dR6blgTiI+q4qfGkB
         Lh3Yr0T5MP98fTtjof5Zga3TfgkSawseZzHYvNSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5.4 074/104] leds: gpio: Fix uninitialized gpio label for fwnode based probe
Date:   Tue, 28 Jan 2020 15:00:35 +0100
Message-Id: <20200128135827.510578407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

commit 90a8e82d3ca8c1f85ac63f4a94c9b034f05af4ee upstream.

When switching to using generic LED name composition mechanism via
devm_led_classdev_register_ext() API the part of code initializing
struct gpio_led's template name property was removed alongside.
It was however overlooked that the property was also passed to
devm_fwnode_get_gpiod_from_child() in place of "label" parameter,
which when set to NULL, results in gpio label being initialized to '?'.

It could be observed in debugfs and failed to properly identify
gpio association with LED consumer.

Fix this shortcoming by updating the GPIO label after the LED is
registered and its final name is known.

Fixes: d7235f5feaa0 ("leds: gpio: Use generic support for composing LED names")
Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
[fixed comment]
Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/leds-gpio.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -151,9 +151,14 @@ static struct gpio_leds_priv *gpio_leds_
 		struct gpio_led led = {};
 		const char *state = NULL;
 
+		/*
+		 * Acquire gpiod from DT with uninitialized label, which
+		 * will be updated after LED class device is registered,
+		 * Only then the final LED name is known.
+		 */
 		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
 							     GPIOD_ASIS,
-							     led.name);
+							     NULL);
 		if (IS_ERR(led.gpiod)) {
 			fwnode_handle_put(child);
 			return ERR_CAST(led.gpiod);
@@ -186,6 +191,9 @@ static struct gpio_leds_priv *gpio_leds_
 			fwnode_handle_put(child);
 			return ERR_PTR(ret);
 		}
+		/* Set gpiod label to match the corresponding LED name. */
+		gpiod_set_consumer_name(led_dat->gpiod,
+					led_dat->cdev.dev->kobj.name);
 		priv->num_leds++;
 	}
 


