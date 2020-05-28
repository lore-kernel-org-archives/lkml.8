Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239822075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgE1OvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:51:18 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42656 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgE1OvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:51:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5A4EB80307CB;
        Thu, 28 May 2020 14:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 70hDWOJs3K_k; Thu, 28 May 2020 17:50:59 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Olof Johansson <olof@lixom.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <soc@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] bus: bt1-axi: Optimize the return points in the driver
Date:   Thu, 28 May 2020 17:50:49 +0300
Message-ID: <20200528145050.5203-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
References: <20200528145050.5203-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to have a single return statement where it's applicable
instead of returning from a conditional statement if-clause. Let's
do this in the request registers, clock and IRQ methods.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: soc@kernel.org
---
 drivers/bus/bt1-axi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 2005f9174118..c194d9a2bbeb 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -124,12 +124,10 @@ static int bt1_axi_request_regs(struct bt1_axi *axi)
 	}
 
 	axi->qos_regs = devm_platform_ioremap_resource_byname(pdev, "qos");
-	if (IS_ERR(axi->qos_regs)) {
+	if (IS_ERR(axi->qos_regs))
 		dev_err(dev, "Couldn't map AXI-bus QoS registers\n");
-		return PTR_ERR(axi->qos_regs);
-	}
 
-	return 0;
+	return PTR_ERR_OR_ZERO(axi->qos_regs);
 }
 
 static int bt1_axi_request_rst(struct bt1_axi *axi)
@@ -173,12 +171,10 @@ static int bt1_axi_request_clk(struct bt1_axi *axi)
 	}
 
 	ret = devm_add_action_or_reset(axi->dev, bt1_axi_disable_clk, axi);
-	if (ret) {
+	if (ret)
 		dev_err(axi->dev, "Can't add AXI clock disable action\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int bt1_axi_request_irq(struct bt1_axi *axi)
@@ -192,12 +188,10 @@ static int bt1_axi_request_irq(struct bt1_axi *axi)
 
 	ret = devm_request_irq(axi->dev, axi->irq, bt1_axi_isr, IRQF_SHARED,
 			       "bt1-axi", axi);
-	if (ret) {
+	if (ret)
 		dev_err(axi->dev, "Couldn't request AXI EHB IRQ\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static ssize_t count_show(struct device *dev,
-- 
2.26.2

