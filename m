Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B03C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30AF208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIAFA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:00:29 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:34011 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAFA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:00:28 -0400
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te15629d267ac14014b1cfc@ACLMS1.advantech.com.tw>;
 Tue, 1 Sep 2020 13:00:23 +0800
Received: from localhost (172.16.12.96) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 1 Sep
 2020 13:00:22 +0800
From:   William Sung <william.sung@advantech.com.tw>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        William Sung <william.sung@advantech.com.tw>,
        Campion Kang <campion.kang@advantech.com.tw>
Subject: [PATCH 1/2] usb: serial: option: Fix the lackage for Quectel EG95 LTE modem support
Date:   Tue, 1 Sep 2020 13:00:21 +0800
Message-ID: <20200901050022.3319-1-william.sung@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.12.96]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei09.ADVANTECH.CORP (172.20.0.236)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add reset-resume callback for resetting USB devices after MCU exits
from suspend/sleep mode.

* Because Quectel EG95 uses USB interface 4 as a USB network device, so
return from option_startup() to prevent being used as a USB serial
device.

Fixes: da6902e5b6db ("USB: serial: option: add Quectel EG95 LTE modem"

Signed-off-by: William Sung <william.sung@advantech.com.tw>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 89b3192af326..9de8aec47e5e 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2069,6 +2069,7 @@ static struct usb_serial_driver option_1port_device = {
 #ifdef CONFIG_PM
 	.suspend           = usb_wwan_suspend,
 	.resume            = usb_wwan_resume,
+	.reset_resume      = usb_wwan_resume,
 #endif
 };
 
@@ -2104,6 +2105,11 @@ static int option_probe(struct usb_serial *serial,
 	if (device_flags & NUMEP2 && iface_desc->bNumEndpoints != 2)
 		return -ENODEV;
 
+	/* Quectel EC25 & EC21 & EG91 & EG95 ... interface 4 can be used as USB network device */
+	if (serial->dev->descriptor.idVendor == cpu_to_le16(0x2c7c) &&
+		serial->interface->cur_altsetting->desc.bInterfaceNumber >= 4)
+		return -ENODEV;
+
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);
 
-- 
2.17.1

