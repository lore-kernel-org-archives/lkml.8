Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29305C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B9A2310F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738722;
	bh=DPZaom5NAT2KivsfSxfg/NbbYwOmpa1upzg9nMe0pn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYGv7l6tDY4CSUqvvihRcHzfGgeV+KcVO8hbF+SSErYKMvwwOzS5dvOe6myeW8s1A
	 znYGUWdkeka/jO5WTduGI8Q1UzAeir5jAC4PHCCVMrofRl32X4gq9BfxdYGG0Nez8T
	 lcxyh5/a4/fDuplQcmQpKW7YxUABAFBUUyTENtYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHFSbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgHFSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5165E22D04;
        Thu,  6 Aug 2020 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738133;
        bh=DPZaom5NAT2KivsfSxfg/NbbYwOmpa1upzg9nMe0pn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br6SESXvsfakDzF/1hP0mUDf1oXB70eWCEQ3qKKN4rKgzInWtHHsBHxX7FsBumrlM
         KVyZKT299K/KhuKeLy4D9GiQf3wrSnoelofZuN05GtEz5b2oKezgkhRVlQ9nvg3CUl
         jO7awguu5PH2xrZFl15Fm8gfnewVTkzd8ShLjiKc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 08/41] usb: gadget: s3c: use platform resources
Date:   Thu,  6 Aug 2020 20:20:25 +0200
Message-Id: <20200806182059.2431-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The resources are correctly initialized, so just use them
instead of relying on hardcoded data from platform headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/gadget/udc/s3c2410_udc.c          | 31 +++++++------------
 drivers/usb/gadget/udc/s3c2410_udc.h          |  1 +
 .../usb/gadget/udc/s3c2410_udc_regs.h         |  0
 3 files changed, 12 insertions(+), 20 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-udc.h => drivers/usb/gadget/udc/s3c2410_udc_regs.h (100%)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index e875a0b967c0..f1ea51476add 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -36,15 +36,11 @@
 #include <asm/byteorder.h>
 #include <asm/irq.h>
 #include <asm/unaligned.h>
-#include <mach/irqs.h>
 
-#include <mach/hardware.h>
-
-#include <plat/regs-udc.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
-
 #include "s3c2410_udc.h"
+#include "s3c2410_udc_regs.h"
 
 #define DRIVER_DESC	"S3C2410 USB Device Controller Gadget"
 #define DRIVER_AUTHOR	"Herbert Pötzl <herbert@13thfloor.at>, " \
@@ -57,6 +53,7 @@ static struct s3c2410_udc	*the_controller;
 static struct clk		*udc_clock;
 static struct clk		*usb_bus_clock;
 static void __iomem		*base_addr;
+static int			irq_usbd;
 static u64			rsrc_start;
 static u64			rsrc_len;
 static struct dentry		*s3c2410_udc_debugfs_root;
@@ -835,8 +832,6 @@ static void s3c2410_udc_handle_ep(struct s3c2410_ep *ep)
 	}
 }
 
-#include <mach/regs-irq.h>
-
 /*
  *	s3c2410_udc_irq - interrupt handler
  */
@@ -977,7 +972,7 @@ static irqreturn_t s3c2410_udc_irq(int dummy, void *_dev)
 		}
 	}
 
-	dprintk(DEBUG_VERBOSE, "irq: %d s3c2410_udc_done.\n", IRQ_USBD);
+	dprintk(DEBUG_VERBOSE, "irq: %d s3c2410_udc_done.\n", irq_usbd);
 
 	/* Restore old index */
 	udc_write(idx, S3C2410_UDC_INDEX_REG);
@@ -1777,13 +1772,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	spin_lock_init(&udc->lock);
 	udc_info = dev_get_platdata(&pdev->dev);
 
-	rsrc_start = S3C2410_PA_USBDEV;
-	rsrc_len   = S3C24XX_SZ_USBDEV;
-
-	if (!request_mem_region(rsrc_start, rsrc_len, gadget_name))
-		return -EBUSY;
-
-	base_addr = ioremap(rsrc_start, rsrc_len);
+	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (!base_addr) {
 		retval = -ENOMEM;
 		goto err_mem;
@@ -1795,17 +1784,19 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	s3c2410_udc_disable(udc);
 	s3c2410_udc_reinit(udc);
 
+	irq_usbd = platform_get_irq(pdev, 0);
+
 	/* irq setup after old hardware state is cleaned up */
-	retval = request_irq(IRQ_USBD, s3c2410_udc_irq,
+	retval = request_irq(irq_usbd, s3c2410_udc_irq,
 			     0, gadget_name, udc);
 
 	if (retval != 0) {
-		dev_err(dev, "cannot get irq %i, err %d\n", IRQ_USBD, retval);
+		dev_err(dev, "cannot get irq %i, err %d\n", irq_usbd, retval);
 		retval = -EBUSY;
 		goto err_map;
 	}
 
-	dev_dbg(dev, "got irq %i\n", IRQ_USBD);
+	dev_dbg(dev, "got irq %i\n", irq_usbd);
 
 	if (udc_info && udc_info->vbus_pin > 0) {
 		retval = gpio_request(udc_info->vbus_pin, "udc vbus");
@@ -1872,7 +1863,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	if (udc_info && udc_info->vbus_pin > 0)
 		gpio_free(udc_info->vbus_pin);
 err_int:
-	free_irq(IRQ_USBD, udc);
+	free_irq(irq_usbd, udc);
 err_map:
 	iounmap(base_addr);
 err_mem:
@@ -1906,7 +1897,7 @@ static int s3c2410_udc_remove(struct platform_device *pdev)
 		free_irq(irq, udc);
 	}
 
-	free_irq(IRQ_USBD, udc);
+	free_irq(irq_usbd, udc);
 
 	iounmap(base_addr);
 	release_mem_region(rsrc_start, rsrc_len);
diff --git a/drivers/usb/gadget/udc/s3c2410_udc.h b/drivers/usb/gadget/udc/s3c2410_udc.h
index bdcaa8dd300f..68bdf3e5aac2 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.h
+++ b/drivers/usb/gadget/udc/s3c2410_udc.h
@@ -90,6 +90,7 @@ struct s3c2410_udc {
 	unsigned			req_pending : 1;
 	u8				vbus;
 	struct dentry			*regs_info;
+	int				irq;
 };
 #define to_s3c2410(g)	(container_of((g), struct s3c2410_udc, gadget))
 
diff --git a/arch/arm/plat-samsung/include/plat/regs-udc.h b/drivers/usb/gadget/udc/s3c2410_udc_regs.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/regs-udc.h
rename to drivers/usb/gadget/udc/s3c2410_udc_regs.h
-- 
2.17.1

