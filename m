Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92D20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="bum1GQm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGHSES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:04:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:4514 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgGHSEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:04:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4B26d75cftzMP;
        Wed,  8 Jul 2020 20:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1594231451; bh=xM/vWleWXURnCmkoT1m4VqMEiH0DaR/Qp4g8IWC4YVs=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bum1GQm0msIj7p2nETmbGZKQvjcCCBWedhvYhFIwdap2XWn9HbP4noedwDNa9Bqf9
         yJPsrYv7s7dGMaZcWKLKGDV6FdkSPNxd4uca77CeZwf9geRele95F5ejAyU47ERikf
         es/U/qXq156uvIANDAhaILaey+XAN/h/8ruo/L76LJoaBUr2hWqhyBJNxjbGzyUogM
         qbwXpz+YTAzfLBviQq1ZHqtKtqe8hmd+Vzal2ZgE7rym8D0S1L8ijOfqKLCoLFwIyP
         bOyC4dAkIyhlJrRlie0BDBBauiNyiyj0WoIZyKvJeq3logf0xzrkc1mMdhekB0DINQ
         mpdTeCwmyyG/g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Wed, 08 Jul 2020 20:04:10 +0200
Message-Id: <63121e624012996a2f6f5f3763270ad834667a12.1594231056.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
References: <cover.1594231056.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESEND 3/3] usb: gadget: udc: atmel: implement .pullup
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Songjun Wu <songjun.wu@atmel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement udc->pullup callback, so that udc_connect/disconnect work.
This is needed for composite gadget, as it assumes udc_disconnect()
actually works and calls its ->disconnect callback.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 9342a3d24963..c5128c229c52 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1028,6 +1028,7 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 	return 0;
 }
 
+static int atmel_usba_pullup(struct usb_gadget *gadget, int is_on);
 static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver);
 static int atmel_usba_stop(struct usb_gadget *gadget);
@@ -1101,6 +1102,7 @@ static const struct usb_gadget_ops usba_udc_ops = {
 	.get_frame		= usba_udc_get_frame,
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
+	.pullup			= atmel_usba_pullup,
 	.udc_start		= atmel_usba_start,
 	.udc_stop		= atmel_usba_stop,
 	.match_ep		= atmel_usba_match_ep,
@@ -1957,6 +1959,24 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int atmel_usba_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
+	unsigned long flags;
+	u32 ctrl;
+
+	spin_lock_irqsave(&udc->lock, flags);
+	ctrl = usba_readl(udc, CTRL);
+	if (is_on)
+		ctrl &= ~USBA_DETACH;
+	else
+		ctrl |= USBA_DETACH;
+	usba_writel(udc, CTRL, ctrl);
+	spin_unlock_irqrestore(&udc->lock, flags);
+
+	return 0;
+}
+
 static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
-- 
2.20.1

