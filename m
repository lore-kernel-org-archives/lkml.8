Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D618C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC08221E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443565;
	bh=Zn29QQOI0ycuXRLcrGs67DF+14r1u6Z7gLuIOVr4LUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oOMiEWMjl7YKHDRtzmj4tD+Je+zGPC3EqDWBjFLVXDd5eyO/TsSzrEzLQKBggm6aL
	 HmkBQT7aK6ZtWgfxs9kN8T4gqTOojCF+QsgZEgA+7x+z9u1TU+LVKmcHu83LfYDJog
	 MqPj7WIrdNCNNRTtt/1cx7yQoCIacxDG1s92Fy6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgFRB0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730898AbgFRBXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CF220776;
        Thu, 18 Jun 2020 01:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443379;
        bh=Zn29QQOI0ycuXRLcrGs67DF+14r1u6Z7gLuIOVr4LUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuOPFnHTG4n7cHjkiplawLdPC8nODZBefayj1mb6d5l9BFNbyaQi/QXV2YO6ncv6Q
         OCtJIa94FK0OxKNePAefzGa/syCeD1o2zMZ1grzuziS1AYJObo5TRi5oGsZvtiyp6Z
         /hBd3D1nlgaYTH3CMzCJ1lEuUy9lsXjxTG0p1llc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 031/172] gpio: dwapb: Call acpi_gpiochip_free_interrupts() on GPIO chip de-registration
Date:   Wed, 17 Jun 2020 21:19:57 -0400
Message-Id: <20200618012218.607130-31-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 044888fd96a1..68db0033d158 100644
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

