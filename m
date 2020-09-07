Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B82521473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599493928;
	bh=hkO0EMVvCu8X7CeNAbfTmSK1pWFJrTzl3nDdebnZHHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6Xkrh6H2H7C+97Am2qjOOzUCLkOIvJe+7v+417SBOvGJIZ+8YfjAL4Kx12Tdtq57
	 PzsY7m3WdLLjYUb7cgkdDKe1SjczvgV/6cz2L3X3EXX3kNfkHzQz8FwhCiIhfo7qLF
	 2eSXOCAim6DGfOODjKevzyc23bNhthVPiwrAJwWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgIGPwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbgIGOvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:51:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515BD218AC;
        Mon,  7 Sep 2020 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490277;
        bh=hkO0EMVvCu8X7CeNAbfTmSK1pWFJrTzl3nDdebnZHHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgTDrp7IPbcWgWNaaD690SP+mq2VsJpUKvsnVgZIc8ntfUU/bjkTDvxpZQEo2M/mE
         Ob9YzTDMdNI3mym+y907RGeutk8dZShkABagM/ShmcOwO7IjuexA1gpjfz7EgIxyg+
         /HsNxeWuxRRH0vGn2j8mY0AVJDBQXDeiW44Ad6zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 04/11] USB: core: hub.c: use usb_control_msg_send() in a few places
Date:   Mon,  7 Sep 2020 16:51:01 +0200
Message-Id: <20200907145108.3766613-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few calls to usb_control_msg() that can be converted to use
usb_control_msg_send() instead, so do that in order to make the error
checking a bit simpler and the code smaller.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:
 - dropped changes to usb_req_set_sel() thanks to review from Alan

 drivers/usb/core/hub.c | 99 +++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5b768b80d1ee..bbb41993d4ba 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -410,8 +410,8 @@ static int get_hub_descriptor(struct usb_device *hdev,
  */
 static int clear_hub_feature(struct usb_device *hdev, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-		USB_REQ_CLEAR_FEATURE, USB_RT_HUB, feature, 0, NULL, 0, 1000);
+	return usb_control_msg_send(hdev, 0, USB_REQ_CLEAR_FEATURE, USB_RT_HUB,
+				    feature, 0, NULL, 0, 1000);
 }
 
 /*
@@ -419,9 +419,8 @@ static int clear_hub_feature(struct usb_device *hdev, int feature)
  */
 int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+	return usb_control_msg_send(hdev, 0, USB_REQ_CLEAR_FEATURE, USB_RT_PORT,
+				    feature, port1, NULL, 0, 1000);
 }
 
 /*
@@ -429,9 +428,8 @@ int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
  */
 static int set_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
-		NULL, 0, 1000);
+	return usb_control_msg_send(hdev, 0, USB_REQ_SET_FEATURE, USB_RT_PORT,
+				    feature, port1, NULL, 0, 1000);
 }
 
 static char *to_led_name(int selector)
@@ -755,15 +753,14 @@ hub_clear_tt_buffer(struct usb_device *hdev, u16 devinfo, u16 tt)
 	/* Need to clear both directions for control ep */
 	if (((devinfo >> 11) & USB_ENDPOINT_XFERTYPE_MASK) ==
 			USB_ENDPOINT_XFER_CONTROL) {
-		int status = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-				HUB_CLEAR_TT_BUFFER, USB_RT_PORT,
-				devinfo ^ 0x8000, tt, NULL, 0, 1000);
+		int status = usb_control_msg_send(hdev, 0, 
+						  HUB_CLEAR_TT_BUFFER, USB_RT_PORT,
+						  devinfo ^ 0x8000, tt, NULL, 0, 1000);
 		if (status)
 			return status;
 	}
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-			       HUB_CLEAR_TT_BUFFER, USB_RT_PORT, devinfo,
-			       tt, NULL, 0, 1000);
+	return usb_control_msg_send(hdev, 0, HUB_CLEAR_TT_BUFFER, USB_RT_PORT,
+				    devinfo, tt, NULL, 0, 1000);
 }
 
 /*
@@ -1049,11 +1046,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 	 */
 	if (type != HUB_RESUME) {
 		if (hdev->parent && hub_is_superspeed(hdev)) {
-			ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
-					HUB_SET_DEPTH, USB_RT_HUB,
-					hdev->level - 1, 0, NULL, 0,
-					USB_CTRL_SET_TIMEOUT);
-			if (ret < 0)
+			ret = usb_control_msg_send(hdev, 0, HUB_SET_DEPTH, USB_RT_HUB,
+						   hdev->level - 1, 0, NULL, 0,
+						   USB_CTRL_SET_TIMEOUT);
+			if (ret)
 				dev_err(hub->intfdev,
 						"set hub depth failed\n");
 		}
@@ -2329,13 +2325,10 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 		/* enable HNP before suspend, it's simpler */
 		if (port1 == bus->otg_port) {
 			bus->b_hnp_enable = 1;
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_B_HNP_ENABLE,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0) {
+			err = usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, 0,
+						   USB_DEVICE_B_HNP_ENABLE, 0,
+						   NULL, 0, USB_CTRL_SET_TIMEOUT);
+			if (err) {
 				/*
 				 * OTG MESSAGE: report errors here,
 				 * customize to match your product.
@@ -2347,13 +2340,10 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
 			/* Set a_alt_hnp_support for legacy otg device */
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_A_ALT_HNP_SUPPORT,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
+			err = usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, 0,
+						   USB_DEVICE_A_ALT_HNP_SUPPORT, 0,
+						   NULL, 0, USB_CTRL_SET_TIMEOUT);
+			if (err)
 				dev_err(&udev->dev,
 					"set a_alt_hnp_support failed: %d\n",
 					err);
@@ -3121,10 +3111,8 @@ int usb_disable_ltm(struct usb_device *udev)
 	if (!udev->actconfig)
 		return 0;
 
-	return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			USB_REQ_CLEAR_FEATURE, USB_RECIP_DEVICE,
-			USB_DEVICE_LTM_ENABLE, 0, NULL, 0,
-			USB_CTRL_SET_TIMEOUT);
+	return usb_control_msg_send(udev, 0, USB_REQ_CLEAR_FEATURE, USB_RECIP_DEVICE,
+				    USB_DEVICE_LTM_ENABLE, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
 EXPORT_SYMBOL_GPL(usb_disable_ltm);
 
@@ -3143,10 +3131,8 @@ void usb_enable_ltm(struct usb_device *udev)
 	if (!udev->actconfig)
 		return;
 
-	usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
-			USB_DEVICE_LTM_ENABLE, 0, NULL, 0,
-			USB_CTRL_SET_TIMEOUT);
+	usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
+			     USB_DEVICE_LTM_ENABLE, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
 EXPORT_SYMBOL_GPL(usb_enable_ltm);
 
@@ -3163,17 +3149,14 @@ EXPORT_SYMBOL_GPL(usb_enable_ltm);
 static int usb_enable_remote_wakeup(struct usb_device *udev)
 {
 	if (udev->speed < USB_SPEED_SUPER)
-		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
-				USB_DEVICE_REMOTE_WAKEUP, 0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
+		return usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
+					    USB_DEVICE_REMOTE_WAKEUP, 0,
+					    NULL, 0, USB_CTRL_SET_TIMEOUT);
 	else
-		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
-				USB_INTRF_FUNC_SUSPEND,
-				USB_INTRF_FUNC_SUSPEND_RW |
-					USB_INTRF_FUNC_SUSPEND_LP,
-				NULL, 0, USB_CTRL_SET_TIMEOUT);
+		return usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
+					    USB_INTRF_FUNC_SUSPEND,
+					    USB_INTRF_FUNC_SUSPEND_RW | USB_INTRF_FUNC_SUSPEND_LP,
+					    NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
 
 /*
@@ -3189,15 +3172,11 @@ static int usb_enable_remote_wakeup(struct usb_device *udev)
 static int usb_disable_remote_wakeup(struct usb_device *udev)
 {
 	if (udev->speed < USB_SPEED_SUPER)
-		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				USB_REQ_CLEAR_FEATURE, USB_RECIP_DEVICE,
-				USB_DEVICE_REMOTE_WAKEUP, 0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
+		return usb_control_msg_send(udev, 0, USB_REQ_CLEAR_FEATURE, USB_RECIP_DEVICE,
+					    USB_DEVICE_REMOTE_WAKEUP, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 	else
-		return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
-				USB_INTRF_FUNC_SUSPEND,	0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
+		return usb_control_msg_send(udev, 0, USB_REQ_SET_FEATURE, USB_RECIP_INTERFACE,
+					    USB_INTRF_FUNC_SUSPEND, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
 
 /* Count of wakeup-enabled devices at or below udev */
@@ -4056,7 +4035,7 @@ static void usb_enable_link_state(struct usb_hcd *hcd, struct usb_device *udev,
 	 * associated with the link state we're about to enable.
 	 */
 	ret = usb_req_set_sel(udev, state);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&udev->dev, "Set SEL for device-initiated %s failed.\n",
 				usb3_lpm_names[state]);
 		return;
-- 
2.28.0

