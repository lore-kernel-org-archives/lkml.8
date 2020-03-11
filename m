Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC56C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1102F21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FG54N1Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgCKNwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:52:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36808 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgCKNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583934705; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKLbVJANv/Czsqyt6p0pEA3GDTnRolAM03ABBiTEWtY=;
        b=FG54N1UrSRMBAu66EVEUmhkLD+NRnAU0o9S5oEDVtOV6/F1aJ9aR3Aj6WXpY9bYLJgBm3s
        Ke81JbfBHMyYq6g/vzHxDQ+sfHt9BMIRfLcneYhoaV+PPIhONhxoZ8/Oq5NzKQkZuhGdna
        WEIndIWmMA3Lefg0UQgNh6N6Lptn0cc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/5] usb: musb: jz4740: Register USB role switch
Date:   Wed, 11 Mar 2020 14:51:31 +0100
Message-Id: <20200311135133.16392-3-paul@crapouillou.net>
In-Reply-To: <20200311135133.16392-1-paul@crapouillou.net>
References: <20200311135133.16392-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a USB role switch, in order to get notified by the connector
driver when the USB role changes. The notification is then transmitted
to the PHY.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change
    v3: Update prototype of jz4740_musb_role_switch_set() to reflect upstream changes

 drivers/usb/musb/Kconfig  |  1 +
 drivers/usb/musb/jz4740.c | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index c4b349e074c1..3268adb7d7cf 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -113,6 +113,7 @@ config USB_MUSB_JZ4740
 	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
 	depends on USB=n || USB_OTG_BLACKLIST_HUB
+	select USB_ROLE_SWITCH
 
 config USB_MUSB_MEDIATEK
 	tristate "MediaTek platforms"
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index aa32b5af0c1f..7f813bdaf1d1 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -12,13 +12,16 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/usb/role.h>
 #include <linux/usb/usb_phy_generic.h>
 
 #include "musb_core.h"
 
 struct jz4740_glue {
 	struct platform_device	*pdev;
+	struct musb		*musb;
 	struct clk		*clk;
+	struct usb_role_switch	*role_sw;
 };
 
 static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
@@ -72,11 +75,40 @@ static const struct musb_hdrc_config jz4740_musb_config = {
 	.fifo_cfg_size	= ARRAY_SIZE(jz4740_musb_fifo_cfg),
 };
 
+static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
+				       enum usb_role role)
+{
+	struct jz4740_glue *glue = usb_role_switch_get_drvdata(sw);
+	struct usb_phy *phy = glue->musb->xceiv;
+
+	switch (role) {
+	case USB_ROLE_NONE:
+		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_NONE, phy);
+		break;
+	case USB_ROLE_DEVICE:
+		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_VBUS, phy);
+		break;
+	case USB_ROLE_HOST:
+		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_ID, phy);
+		break;
+	}
+
+	return 0;
+}
+
 static int jz4740_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller->parent;
+	struct jz4740_glue *glue = dev_get_drvdata(dev);
+	struct usb_role_switch_desc role_sw_desc = {
+		.set = jz4740_musb_role_switch_set,
+		.driver_data = glue,
+		.fwnode = dev_fwnode(dev),
+	};
 	int err;
 
+	glue->musb = musb;
+
 	if (dev->of_node)
 		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
 	else
@@ -88,6 +120,12 @@ static int jz4740_musb_init(struct musb *musb)
 		return err;
 	}
 
+	glue->role_sw = usb_role_switch_register(dev, &role_sw_desc);
+	if (IS_ERR(glue->role_sw)) {
+		dev_err(dev, "Failed to register USB role switch");
+		return PTR_ERR(glue->role_sw);
+	}
+
 	/*
 	 * Silicon does not implement ConfigData register.
 	 * Set dyn_fifo to avoid reading EP config from hardware.
@@ -99,10 +137,20 @@ static int jz4740_musb_init(struct musb *musb)
 	return 0;
 }
 
+static int jz4740_musb_exit(struct musb *musb)
+{
+	struct jz4740_glue *glue = dev_get_drvdata(musb->controller->parent);
+
+	usb_role_switch_unregister(glue->role_sw);
+
+	return 0;
+}
+
 static const struct musb_platform_ops jz4740_musb_ops = {
 	.quirks		= MUSB_DMA_INVENTRA | MUSB_INDEXED_EP,
 	.fifo_mode	= 2,
 	.init		= jz4740_musb_init,
+	.exit		= jz4740_musb_exit,
 #ifdef CONFIG_USB_INVENTRA_DMA
 	.dma_init	= musbhs_dma_controller_create_noirq,
 	.dma_exit	= musbhs_dma_controller_destroy,
-- 
2.25.1

