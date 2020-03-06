Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49278C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F792084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCFNYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:24:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53381 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:24:17 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACxZ-0004ES-Qk; Fri, 06 Mar 2020 14:24:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 41AEC104085; Fri,  6 Mar 2020 14:24:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Subject: [PATCH] staging: greybus: Fix the irq API abuse
Date:   Fri, 06 Mar 2020 14:24:13 +0100
Message-ID: <87o8t9boqq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing outside of low level architecture code is supposed to look up
interrupt descriptors and fiddle with them.

Replace the open coded abuse by calling generic_handle_irq().

This still does not explain why and in which context this connection
magic is injecting interrupts in the first place and why this is correct
and safe, but at least the API abuse is gone.

Fixes: 036aad9d0224 ("greybus: gpio: add interrupt handling support")
Fixes: 2611ebef8322 ("greybus: gpio: don't call irq-flow handler directly")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/staging/greybus/gpio.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -364,8 +364,7 @@ static int gb_gpio_request_handler(struc
 	struct gb_message *request;
 	struct gb_gpio_irq_event_request *event;
 	u8 type = op->type;
-	int irq;
-	struct irq_desc *desc;
+	int irq, ret;
 
 	if (type != GB_GPIO_TYPE_IRQ_EVENT) {
 		dev_err(dev, "unsupported unsolicited request: %u\n", type);
@@ -391,17 +390,15 @@ static int gb_gpio_request_handler(struc
 		dev_err(dev, "failed to find IRQ\n");
 		return -EINVAL;
 	}
-	desc = irq_to_desc(irq);
-	if (!desc) {
-		dev_err(dev, "failed to look up irq\n");
-		return -EINVAL;
-	}
 
 	local_irq_disable();
-	generic_handle_irq_desc(desc);
+	ret = generic_handle_irq(irq);
 	local_irq_enable();
 
-	return 0;
+	if (ret)
+		dev_err(dev, "failed to invoke irq handler\n");
+
+	return ret;
 }
 
 static int gb_gpio_request(struct gpio_chip *chip, unsigned int offset)
