Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D24C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230932084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCFNZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:25:18 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:36902 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:25:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D45DC8030700;
        Fri,  6 Mar 2020 13:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mbEKk7vi2mtk; Fri,  6 Mar 2020 16:25:16 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] gpio: dwapb: Use optional-clocks interface for APB ref-clocks
Date:   Fri, 6 Mar 2020 16:24:47 +0300
In-Reply-To: <20200306132448.13917-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306132448.13917-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306132516.D45DC8030700@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

The common clocks kernel framework provide a generic way to use
an optional reference clock sources. If it's utilized there is no
need in checking whether the clocks descriptor is actually a
negative error at the moment of the prepare/unprepare clocks method
calling. So if the corresponding clock source is provided, then
getting an error shall actually terminate the device probe procedure.
If it isn't specified then the driver shall proceed with further
initializations.

We'll use the optional clocks getting method to handle the APB interface
reference clocks, which can be provided for instance in the device
of-node with "bus" clock-name.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/gpio/gpio-dwapb.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 92e127e74813..bfa16172f973 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -690,13 +690,16 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio->regs);
 
 	/* Optional bus clock */
-	gpio->clk = devm_clk_get(&pdev->dev, "bus");
-	if (!IS_ERR(gpio->clk)) {
-		err = clk_prepare_enable(gpio->clk);
-		if (err) {
-			dev_info(&pdev->dev, "Cannot enable clock\n");
-			return err;
-		}
+	gpio->clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(gpio->clk)) {
+		dev_info(&pdev->dev, "Cannot get APB clock\n");
+		return PTR_ERR(gpio->clk);
+	}
+
+	err = clk_prepare_enable(gpio->clk);
+	if (err) {
+		dev_info(&pdev->dev, "Cannot enable APB clock\n");
+		return err;
 	}
 
 	gpio->flags = 0;
@@ -793,8 +796,7 @@ static int dwapb_gpio_resume(struct device *dev)
 	unsigned long flags;
 	int i;
 
-	if (!IS_ERR(gpio->clk))
-		clk_prepare_enable(gpio->clk);
+	clk_prepare_enable(gpio->clk);
 
 	spin_lock_irqsave(&gc->bgpio_lock, flags);
 	for (i = 0; i < gpio->nr_ports; i++) {
-- 
2.25.1

