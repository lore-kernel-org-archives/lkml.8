Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47865C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221D82087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgIBLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:03:12 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:42462 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:03:04 -0400
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te15c9c306fac14014b1cfc@ACLMS1.advantech.com.tw>;
 Wed, 2 Sep 2020 19:03:01 +0800
Received: from localhost (172.16.12.96) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Sep
 2020 19:03:01 +0800
From:   William Sung <william.sung@advantech.com.tw>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Campion Kang <campion.kang@advantech.com.tw>,
        William Sung <william.sung@advantech.com.tw>
Subject: [PATCH v2] usb: serial: option: Fix the lackage for Quectel EG95 LTE modem support
Date:   Wed, 2 Sep 2020 19:03:01 +0800
Message-ID: <20200902110301.21936-1-william.sung@advantech.com.tw>
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

* Add zero packet support

Fixes: da6902e5b6db ("USB: serial: option: add Quectel EG95 LTE modem"

Signed-off-by: William Sung <william.sung@advantech.com.tw>
---

 v2: * Add ZLP support
     * Remove redundant code for reserving interface number 4

 drivers/usb/serial/option.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 89b3192af326..ba4dc67dab2f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1099,7 +1099,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC25),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG95),
-	  .driver_info = RSVD(4) },
+	  .driver_info = RSVD(4) | ZLP },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
@@ -2069,6 +2069,7 @@ static struct usb_serial_driver option_1port_device = {
 #ifdef CONFIG_PM
 	.suspend           = usb_wwan_suspend,
 	.resume            = usb_wwan_resume,
+	.reset_resume      = usb_wwan_resume,
 #endif
 };
 
-- 
2.17.1

