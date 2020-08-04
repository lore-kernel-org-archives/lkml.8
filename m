Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B55C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C55E206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgHDJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:18:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:18:17 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1k2t5I-0001VS-UG; Tue, 04 Aug 2020 11:18:12 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1k2t5I-00036w-67; Tue, 04 Aug 2020 11:18:12 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: siox: indicate exclusive support of threaded IRQs
Date:   Tue,  4 Aug 2020 11:16:03 +0200
Message-Id: <20200804091603.541-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic GPIO consumers like gpio-keys use request_any_context_irq()
to request a threaded handler if irq_settings_is_nested_thread() ==
true or a hardirq handler otherwise.

Drivers using handle_nested_irq() must be sure that the nested
IRQs were requested with threaded handlers, because the IRQ
is handled by calling action->thread_fn().

The gpio-siox driver dispatches IRQs via handle_nested_irq,
but has irq_settings_is_nested_thread() == false.

Set gpio_irq_chip::threaded to remedy this.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
I am writing a driver similar to gpio-siox and I ran into a null pointer
dereference, because ->threaded wasn't set. I didn't test this on actual
SIOX hardware.

This patch doesn't fix the case were are driver explicitly calls
request_irq and is combined with a driver that does handle_nested_irq.

Is there a flag, such drivers should additionally set or should we
check action->thread_fn before calling it inside handle_nested_irq?
---
 drivers/gpio/gpio-siox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-siox.c b/drivers/gpio/gpio-siox.c
index 26e1fe092304..f8c5e9fc4bac 100644
--- a/drivers/gpio/gpio-siox.c
+++ b/drivers/gpio/gpio-siox.c
@@ -245,6 +245,7 @@ static int gpio_siox_probe(struct siox_device *sdevice)
 	girq->chip = &ddata->ichip;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
+	girq->threaded = true;
 
 	ret = devm_gpiochip_add_data(dev, &ddata->gchip, NULL);
 	if (ret)
-- 
2.28.0

