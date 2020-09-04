Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CA0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E84206EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgIDBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 21:52:05 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:55484 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgIDBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 21:52:04 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 21:52:02 EDT
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id A068FCC32F;
        Fri,  4 Sep 2020 09:45:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P26187T140084141602560S1599183920504328_;
        Fri, 04 Sep 2020 09:45:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3994b269af9c38a21cceaaaa8aa79b91>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
From:   Penghao <penghao@uniontech.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, jonathan@jdcox.net, kai.heng.feng@canonical.com,
        gustavo.padovan@collabora.com, tomasz@meresinski.eu,
        hdegoede@redhat.com, kerneldev@karsmulder.nl,
        penghao@uniontech.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for Lenovo A630Z TIO built-in usb audio card
Date:   Fri,  4 Sep 2020 09:45:16 +0800
Message-Id: <20200904014516.12298-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
usb-audio.when A630Z going into S3,the system immediately wakeup 7-8
seconds later by usb-audio disconnect interrupt.to avoids the issue.

Seeking a better fix, we've tried a lot of things, including:
 - Check that the device's power/wakeup is disabled
 - Check that remote wakeup is off at the USB level
 - All the quirks in drivers/usb/core/quirks.c e.g. USB_QUIRK_RESET_RESUME,
   USB_QUIRK_RESET, USB_QUIRK_IGNORE_REMOTE_WAKEUP, USB_QUIRK_NO_LPM.

but none of that makes any difference.

There are no errors in the logs showing any suspend/resume-related issues.
When the system wakes up due to the modem, log-wise it appears to be a
normal resume.

Introduce a quirk to disable the port during suspend when the modem is
detected.

Signed-off-by: Penghao <penghao@uniontech.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7c1198f80c23..d2a9493cc360 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -403,6 +403,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 
+	/* Lenovo A630Z TIO build-in usb sound card */
+	{ USB_DEVICE9(0x17ef, 0xa012), driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* SKYMEDI USB_DRIVE */
 	{ USB_DEVICE(0x1516, 0x8628), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.11.0



