Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E98C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E844206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgIGPew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgIGPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:32:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AFBC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:32:34 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kFJ8A-0003iH-L1; Mon, 07 Sep 2020 17:32:30 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kFJ89-0000sv-Jp; Mon, 07 Sep 2020 17:32:29 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     tglx@linutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: siox: explicitly support only threaded irqs
Date:   Mon,  7 Sep 2020 17:31:35 +0200
Message-Id: <20200907153135.3307-1-a.fatoum@pengutronix.de>
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

The gpio-siox driver uses handle_nested_irq() to implement its
interrupt support. This is only capable of handling threaded irq
actions. For a hardirq action it triggers a NULL pointer oops.
(It calls action->thread_fn which is NULL then.)

Prevent registration of a hardirq action by setting
gpio_irq_chip::threaded to true.

Cc: u.kleine-koenig@pengutronix.de
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  reworded commit message (Uwe)
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

