Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65476C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAE62078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044572;
	bh=TQYCGifWGQVmBMPr9KtgIH6n55KKlRaC54GjvFdP+6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJwXHc43k9ug29qMTdfdHrnaHzRdsAvJtmUxRebjqfVx5zb+mWCn3Plqs9LkHCdx5
	 nQ3p4wvgF8siG9QMnOLkpEwF154WZG0D9fpu7riQ8tEFHb81YAuGc5gY0aAGtJE609
	 0hW4Luy2XbJD1bBHwmE6U9NT866nhToQfCcTiawM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIBLCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIBLBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:01:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5858521582;
        Wed,  2 Sep 2020 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044484;
        bh=TQYCGifWGQVmBMPr9KtgIH6n55KKlRaC54GjvFdP+6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3h4bu8QC01c5lZypDBpqAAXKu6k5WnOm/OxNsLhUGCSeCbFVv8coBl8biydycLUi
         +OVQL2mHaxJwN0H87TiybUomBdxpQmGwv0ADz9uXxC9VwLGcBg3h260DXVmDkdgQxJ
         hTnIFzbxNoUYN9GMQ+WF0Qe99GnFfbMi4m/wcreo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/10] sound: 6fire: move to use usb_control_msg_send() and usb_control_msg_recv()
Date:   Wed,  2 Sep 2020 13:01:09 +0200
Message-Id: <20200902110115.1994491-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_control_msg_send() and usb_control_msg_recv() calls can return
an error if a "short" write/read happens, so move the driver over to
using those calls instead, saving some logic in the wrapper functions
that were being used in this driver.

This also resolves a long-staging bug where data on the stack was being
sent in a USB control message, which was not allowed.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/6fire/firmware.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index 69137c14d0dc..5b8994070c96 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -158,29 +158,17 @@ static int usb6fire_fw_ihex_init(const struct firmware *fw,
 static int usb6fire_fw_ezusb_write(struct usb_device *device,
 		int type, int value, char *data, int len)
 {
-	int ret;
-
-	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0), type,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			value, 0, data, len, HZ);
-	if (ret < 0)
-		return ret;
-	else if (ret != len)
-		return -EIO;
-	return 0;
+	return usb_control_msg_send(device, 0, type,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				    value, 0, data, len, HZ);
 }
 
 static int usb6fire_fw_ezusb_read(struct usb_device *device,
 		int type, int value, char *data, int len)
 {
-	int ret = usb_control_msg(device, usb_rcvctrlpipe(device, 0), type,
-			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE, value,
-			0, data, len, HZ);
-	if (ret < 0)
-		return ret;
-	else if (ret != len)
-		return -EIO;
-	return 0;
+	return usb_control_msg_recv(device, 0, type,
+				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				    value, 0, data, len, HZ);
 }
 
 static int usb6fire_fw_fpga_write(struct usb_device *device,
@@ -230,7 +218,7 @@ static int usb6fire_fw_ezusb_upload(
 	/* upload firmware image */
 	data = 0x01; /* stop ezusb cpu */
 	ret = usb6fire_fw_ezusb_write(device, 0xa0, 0xe600, &data, 1);
-	if (ret < 0) {
+	if (ret) {
 		kfree(rec);
 		release_firmware(fw);
 		dev_err(&intf->dev,
@@ -242,7 +230,7 @@ static int usb6fire_fw_ezusb_upload(
 	while (usb6fire_fw_ihex_next_record(rec)) { /* write firmware */
 		ret = usb6fire_fw_ezusb_write(device, 0xa0, rec->address,
 				rec->data, rec->len);
-		if (ret < 0) {
+		if (ret) {
 			kfree(rec);
 			release_firmware(fw);
 			dev_err(&intf->dev,
@@ -257,7 +245,7 @@ static int usb6fire_fw_ezusb_upload(
 	if (postdata) { /* write data after firmware has been uploaded */
 		ret = usb6fire_fw_ezusb_write(device, 0xa0, postaddr,
 				postdata, postlen);
-		if (ret < 0) {
+		if (ret) {
 			dev_err(&intf->dev,
 				"unable to upload ezusb firmware %s: post urb.\n",
 				fwname);
@@ -267,7 +255,7 @@ static int usb6fire_fw_ezusb_upload(
 
 	data = 0x00; /* resume ezusb cpu */
 	ret = usb6fire_fw_ezusb_write(device, 0xa0, 0xe600, &data, 1);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&intf->dev,
 			"unable to upload ezusb firmware %s: end message.\n",
 			fwname);
@@ -302,7 +290,7 @@ static int usb6fire_fw_fpga_upload(
 	end = fw->data + fw->size;
 
 	ret = usb6fire_fw_ezusb_write(device, 8, 0, NULL, 0);
-	if (ret < 0) {
+	if (ret) {
 		kfree(buffer);
 		release_firmware(fw);
 		dev_err(&intf->dev,
@@ -327,7 +315,7 @@ static int usb6fire_fw_fpga_upload(
 	kfree(buffer);
 
 	ret = usb6fire_fw_ezusb_write(device, 9, 0, NULL, 0);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&intf->dev,
 			"unable to upload fpga firmware: end urb.\n");
 		return ret;
@@ -363,7 +351,7 @@ int usb6fire_fw_init(struct usb_interface *intf)
 	u8 buffer[12];
 
 	ret = usb6fire_fw_ezusb_read(device, 1, 0, buffer, 8);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&intf->dev,
 			"unable to receive device firmware state.\n");
 		return ret;
-- 
2.28.0

