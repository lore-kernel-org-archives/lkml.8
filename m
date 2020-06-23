Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F05C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C0214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944562;
	bh=gJEas820U3rfXiDS9RIeDB+Lu1Nbj+FZtjQ5YuG7cXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdfvDUc4IA9DNoTYpUczj/J5ChWhzTdqiV3O+A+7hOOWU4gf2oljAz9NPZTGcLUWi
	 Jp6HplEOD6RNb+Hy8EE0AFmLsrt8DZfOKKehiUKctspHzMs3OV1okrvxpPCUYwXoIP
	 0l3pYg9tMUpAZdzqHY/91Z4zNjKTlVdVWJarLVnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391755AbgFWUf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391750AbgFWUf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:35:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1399720836;
        Tue, 23 Jun 2020 20:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944556;
        bh=gJEas820U3rfXiDS9RIeDB+Lu1Nbj+FZtjQ5YuG7cXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onLV8GifVVShWcszTs+2ALRer1hsrOR0KMaOtIUs9jOMg7MB3NkjXs5+JIk3Fq5sD
         3SkZmPN5ulNjjFy1jp6g2fpVD//s+aBHIW3dFfUkECmPCTnd6AHQN9H/fEnM2+C1DO
         W+Oa3hc72zGDe6DeDslMyqwau/yYwBf7n/6EO3cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/206] gpio: dwapb: Call acpi_gpiochip_free_interrupts() on GPIO chip de-registration
Date:   Tue, 23 Jun 2020 21:55:56 +0200
Message-Id: <20200623195318.363769191@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 494a94e38dcf62543a32a4424d646ff80b4b28bd ]

Add missed acpi_gpiochip_free_interrupts() call when unregistering ports.

While at it, drop extra check to call acpi_gpiochip_request_interrupts().
There is no need to have an additional check to call
acpi_gpiochip_request_interrupts(). Even without any interrupts available
the registered ACPI Event handlers can be useful for debugging purposes.

Fixes: e6cb3486f5a1 ("gpio: dwapb: add gpio-signaled acpi event support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20200519131233.59032-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-dwapb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 044888fd96a1f..68db0033d1586 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -535,26 +535,33 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 		dwapb_configure_irqs(gpio, port, pp);
 
 	err = gpiochip_add_data(&port->gc, port);
-	if (err)
+	if (err) {
 		dev_err(gpio->dev, "failed to register gpiochip for port%d\n",
 			port->idx);
-	else
-		port->is_registered = true;
+		return err;
+	}
 
 	/* Add GPIO-signaled ACPI event support */
-	if (pp->has_irq)
-		acpi_gpiochip_request_interrupts(&port->gc);
+	acpi_gpiochip_request_interrupts(&port->gc);
 
-	return err;
+	port->is_registered = true;
+
+	return 0;
 }
 
 static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 {
 	unsigned int m;
 
-	for (m = 0; m < gpio->nr_ports; ++m)
-		if (gpio->ports[m].is_registered)
-			gpiochip_remove(&gpio->ports[m].gc);
+	for (m = 0; m < gpio->nr_ports; ++m) {
+		struct dwapb_gpio_port *port = &gpio->ports[m];
+
+		if (!port->is_registered)
+			continue;
+
+		acpi_gpiochip_free_interrupts(&port->gc);
+		gpiochip_remove(&port->gc);
+	}
 }
 
 static struct dwapb_platform_data *
-- 
2.25.1



