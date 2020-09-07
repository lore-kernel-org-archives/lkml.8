Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82244C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486DE21473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494063;
	bh=lAWlK3q7dlSU3BX9UUth7FV/aMVc82HxwZZSp4H5Db4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUCcVjJjBGxm1a+XnzVdn5IkKlZ2kEuQB+KnaE9i9FYTRNmxAqYa7YvWQiA7HsPEK
	 PQ2ZD7MDKWscazVPz72cyN2FG5ge4fp22bZr71JCNcgZB4UQgx3TpiUJe0ZnsSff3Y
	 dnEJkDL9c967gGy9tQGhmUm7VRNm6dzGXhEk2fHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgIGPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgIGOvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:51:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC57B21481;
        Mon,  7 Sep 2020 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490266;
        bh=lAWlK3q7dlSU3BX9UUth7FV/aMVc82HxwZZSp4H5Db4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkNxOAr6D47I4QX0kM9cVJLJb6KQjj/GJaUaWXjiH8FhsjbURGG+G+VMs34hNWDq2
         CKXS0cBXxyyACxxrXpfI+2fbjTCrWSUOVFlgdW+5vPPtYUCy46eL1TIb4/MsqjF0Z+
         cMaBbQnw64NbDt9pqzu5Jd5KjbG+heuNRbK61JDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 10/11] Bluetooth: ath3k: use usb_control_msg_send() and usb_control_msg_recv()
Date:   Mon,  7 Sep 2020 16:51:07 +0200
Message-Id: <20200907145108.3766613-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_control_msg_send() and usb_control_msg_recv() calls can return
an error if a "short" write/read happens, and they can handle data off
of the stack, so move the driver over to using those calls instead,
saving some logic when dynamically allocating memory.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:
 - no change from v1

 drivers/bluetooth/ath3k.c | 90 +++++++++++----------------------------
 1 file changed, 26 insertions(+), 64 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 4ce270513695..1472cccfd0b3 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -212,19 +212,16 @@ static int ath3k_load_firmware(struct usb_device *udev,
 
 	BT_DBG("udev %p", udev);
 
-	pipe = usb_sndctrlpipe(udev, 0);
-
 	send_buf = kmalloc(BULK_SIZE, GFP_KERNEL);
 	if (!send_buf) {
 		BT_ERR("Can't allocate memory chunk for firmware");
 		return -ENOMEM;
 	}
 
-	memcpy(send_buf, firmware->data, FW_HDR_SIZE);
-	err = usb_control_msg(udev, pipe, USB_REQ_DFU_DNLOAD, USB_TYPE_VENDOR,
-			      0, 0, send_buf, FW_HDR_SIZE,
-			      USB_CTRL_SET_TIMEOUT);
-	if (err < 0) {
+	err = usb_control_msg_send(udev, 0, USB_REQ_DFU_DNLOAD, USB_TYPE_VENDOR,
+				   0, 0, firmware->data, FW_HDR_SIZE,
+				   USB_CTRL_SET_TIMEOUT);
+	if (err) {
 		BT_ERR("Can't change to loading configuration err");
 		goto error;
 	}
@@ -259,44 +256,17 @@ static int ath3k_load_firmware(struct usb_device *udev,
 
 static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
 {
-	int ret, pipe = 0;
-	char *buf;
-
-	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(udev, 0);
-	ret = usb_control_msg(udev, pipe, ATH3K_GETSTATE,
-			      USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
-			      buf, sizeof(*buf), USB_CTRL_SET_TIMEOUT);
-
-	*state = *buf;
-	kfree(buf);
-
-	return ret;
+	return usb_control_msg_recv(udev, 0, ATH3K_GETSTATE,
+				    USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
+				    state, 1, USB_CTRL_SET_TIMEOUT);
 }
 
 static int ath3k_get_version(struct usb_device *udev,
 			struct ath3k_version *version)
 {
-	int ret, pipe = 0;
-	struct ath3k_version *buf;
-	const int size = sizeof(*buf);
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(udev, 0);
-	ret = usb_control_msg(udev, pipe, ATH3K_GETVERSION,
-			      USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
-			      buf, size, USB_CTRL_SET_TIMEOUT);
-
-	memcpy(version, buf, size);
-	kfree(buf);
-
-	return ret;
+	return usb_control_msg_recv(udev, 0, ATH3K_GETVERSION,
+				    USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
+				    version, sizeof(*version), USB_CTRL_SET_TIMEOUT);
 }
 
 static int ath3k_load_fwfile(struct usb_device *udev,
@@ -316,13 +286,10 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 	}
 
 	size = min_t(uint, count, FW_HDR_SIZE);
-	memcpy(send_buf, firmware->data, size);
 
-	pipe = usb_sndctrlpipe(udev, 0);
-	ret = usb_control_msg(udev, pipe, ATH3K_DNLOAD,
-			USB_TYPE_VENDOR, 0, 0, send_buf,
-			size, USB_CTRL_SET_TIMEOUT);
-	if (ret < 0) {
+	ret = usb_control_msg_send(udev, 0, ATH3K_DNLOAD, USB_TYPE_VENDOR, 0, 0,
+				   firmware->data, size, USB_CTRL_SET_TIMEOUT);
+	if (ret) {
 		BT_ERR("Can't change to loading configuration err");
 		kfree(send_buf);
 		return ret;
@@ -355,23 +322,19 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 	return 0;
 }
 
-static int ath3k_switch_pid(struct usb_device *udev)
+static void ath3k_switch_pid(struct usb_device *udev)
 {
-	int pipe = 0;
-
-	pipe = usb_sndctrlpipe(udev, 0);
-	return usb_control_msg(udev, pipe, USB_REG_SWITCH_VID_PID,
-			USB_TYPE_VENDOR, 0, 0,
-			NULL, 0, USB_CTRL_SET_TIMEOUT);
+	usb_control_msg_send(udev, 0, USB_REG_SWITCH_VID_PID, USB_TYPE_VENDOR,
+			     0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 }
 
 static int ath3k_set_normal_mode(struct usb_device *udev)
 {
 	unsigned char fw_state;
-	int pipe = 0, ret;
+	int ret;
 
 	ret = ath3k_get_state(udev, &fw_state);
-	if (ret < 0) {
+	if (ret) {
 		BT_ERR("Can't get state to change to normal mode err");
 		return ret;
 	}
@@ -381,10 +344,9 @@ static int ath3k_set_normal_mode(struct usb_device *udev)
 		return 0;
 	}
 
-	pipe = usb_sndctrlpipe(udev, 0);
-	return usb_control_msg(udev, pipe, ATH3K_SET_NORMAL_MODE,
-			USB_TYPE_VENDOR, 0, 0,
-			NULL, 0, USB_CTRL_SET_TIMEOUT);
+	return usb_control_msg_send(udev, 0, ATH3K_SET_NORMAL_MODE,
+				    USB_TYPE_VENDOR, 0, 0, NULL, 0,
+				    USB_CTRL_SET_TIMEOUT);
 }
 
 static int ath3k_load_patch(struct usb_device *udev)
@@ -397,7 +359,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 	int ret;
 
 	ret = ath3k_get_state(udev, &fw_state);
-	if (ret < 0) {
+	if (ret) {
 		BT_ERR("Can't get state to change to load ram patch err");
 		return ret;
 	}
@@ -408,7 +370,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 	}
 
 	ret = ath3k_get_version(udev, &fw_version);
-	if (ret < 0) {
+	if (ret) {
 		BT_ERR("Can't get version to change to load ram patch err");
 		return ret;
 	}
@@ -449,13 +411,13 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	int clk_value, ret;
 
 	ret = ath3k_get_state(udev, &fw_state);
-	if (ret < 0) {
+	if (ret) {
 		BT_ERR("Can't get state to change to load configuration err");
 		return -EBUSY;
 	}
 
 	ret = ath3k_get_version(udev, &fw_version);
-	if (ret < 0) {
+	if (ret) {
 		BT_ERR("Can't get version to change to load ram patch err");
 		return ret;
 	}
@@ -529,7 +491,7 @@ static int ath3k_probe(struct usb_interface *intf,
 			return ret;
 		}
 		ret = ath3k_set_normal_mode(udev);
-		if (ret < 0) {
+		if (ret) {
 			BT_ERR("Set normal mode failed");
 			return ret;
 		}
-- 
2.28.0

