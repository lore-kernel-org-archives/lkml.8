Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A398AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3220829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgG3P2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:28:21 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57198 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbgG3P2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:28:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 73AFE8040A6A;
        Thu, 30 Jul 2020 15:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cFKWCe8eLLUR; Thu, 30 Jul 2020 18:28:15 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/10] gpio: dwapb: Discard ACPI GPIO-chip IRQs request
Date:   Thu, 30 Jul 2020 18:28:04 +0300
Message-ID: <20200730152808.2955-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200730152808.2955-1-Sergey.Semin@baikalelectronics.ru>
References: <20200730152808.2955-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GPIOlib-based IRQ-chip interface is now utilized there is no need
in calling the methods acpi_gpiochip_{request,free}_interrupts() here.
They will be called from gpiochip_add_irqchip()/gpiochip_irqchip_remove()
anyway.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changelog v2:
- This is a new patch detached from commit
  "gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip".
---
 drivers/gpio/gpio-dwapb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index b6affe7161b0..707e9087ca59 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -526,9 +526,6 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 		return err;
 	}
 
-	/* Add GPIO-signaled ACPI event support */
-	acpi_gpiochip_request_interrupts(&port->gc);
-
 	port->is_registered = true;
 
 	return 0;
@@ -544,7 +541,6 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 		if (!port->is_registered)
 			continue;
 
-		acpi_gpiochip_free_interrupts(&port->gc);
 		gpiochip_remove(&port->gc);
 	}
 }
-- 
2.27.0

