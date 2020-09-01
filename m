Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF8C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FCF2151B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIAFA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:00:28 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:12092 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:00:28 -0400
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te15629d385ac1401c88d0@ACLMS3.advantech.com.tw>;
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
Subject: [PATCH 2/2] usb: serial: usb_wwan: Fix lackage for Quectel EG95 LTE modem support
Date:   Tue, 1 Sep 2020 13:00:22 +0800
Message-ID: <20200901050022.3319-2-william.sung@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901050022.3319-1-william.sung@advantech.com.tw>
References: <20200901050022.3319-1-william.sung@advantech.com.tw>
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

As required by the USB protocol, add zero packet support for Quectel
EG95 LTE modem module.

Fixes: f815dd5cf48b ("net: usb: qmi_wwan: add support for Quectel EG95
LTE modem"

Signed-off-by: William Sung <william.sung@advantech.com.tw>
---
 drivers/usb/serial/usb_wwan.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 4b9845807bee..75495c939ac6 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -467,6 +467,7 @@ static struct urb *usb_wwan_setup_urb(struct usb_serial_port *port,
 	struct usb_serial *serial = port->serial;
 	struct usb_wwan_intf_private *intfdata = usb_get_serial_data(serial);
 	struct urb *urb;
+	struct usb_device_descriptor *desc = &serial->dev->descriptor;
 
 	urb = usb_alloc_urb(0, GFP_KERNEL);	/* No ISO */
 	if (!urb)
@@ -476,8 +477,15 @@ static struct urb *usb_wwan_setup_urb(struct usb_serial_port *port,
 			  usb_sndbulkpipe(serial->dev, endpoint) | dir,
 			  buf, len, callback, ctx);
 
-	if (intfdata->use_zlp && dir == USB_DIR_OUT)
-		urb->transfer_flags |= URB_ZERO_PACKET;
+	if (dir == USB_DIR_OUT) {
+		if (intfdata->use_zlp)
+			urb->transfer_flags |= URB_ZERO_PACKET;
+
+		/* Add zero packet support for Quectel EG95 */
+		if (desc->idVendor == cpu_to_le16(0x2C7C) &&
+			desc->idProduct == cpu_to_le16(0x0195))
+			urb->transfer_flags |= URB_ZERO_PACKET;
+	}
 
 	return urb;
 }
-- 
2.17.1

