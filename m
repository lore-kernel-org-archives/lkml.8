Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE2C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4962064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975688;
	bh=+ylZnX4/j8eti9Uf7Vpo8bft5YvKK0gCQkZdhkpNGqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qCiw2uH6g5tqo/6iZQJQNht5M7tSLifaSI6jz/nXciKCcNv0jonZn0lwvAAE759WA
	 yMy/f5oBJpQ7AWadsHCic+Do1S4jd7o/ziF9OX4obaHNwoQdyU1HUiA8IPiRXUA1lP
	 DcDA94eYJrc4d/FMoAnqJGrIngIoE7YRYSi1GoWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgIAPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731920AbgIAPqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:46:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2602064B;
        Tue,  1 Sep 2020 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975172;
        bh=+ylZnX4/j8eti9Uf7Vpo8bft5YvKK0gCQkZdhkpNGqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLuK5vYc3MrtoimRmc3hg5qY9J7+OkkIoyNb+OYNBdfyxkwhsNphLoDdyuTByCm6e
         A1bLDbBEWUywHrYIdc1EMRViAqdfzPBxTz62+w2qNdQlod+vuyF8VlqR4UV/LrTD44
         zVprqSQBqXveQfeQlnbW6/BlnsiyBvepWgVPjOtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.8 237/255] USB: Fix device driver race
Date:   Tue,  1 Sep 2020 17:11:33 +0200
Message-Id: <20200901151012.108895365@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

commit d5643d2249b279077427b2c2b2ffae9b70c95b0b upstream.

When a new device with a specialised device driver is plugged in, the
new driver will be modprobe()'d but the driver core will attach the
"generic" driver to the device.

After that, nothing will trigger a reprobe when the modprobe()'d device
driver has finished initialising, as the device has the "generic"
driver attached to it.

Trigger a reprobe ourselves when new specialised drivers get registered.

Fixes: 88b7381a939d ("USB: Select better matching USB drivers when available")
Signed-off-by: Bastien Nocera <hadess@hadess.net>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200818110445.509668-3-hadess@hadess.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/driver.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -905,6 +905,35 @@ static int usb_uevent(struct device *dev
 	return 0;
 }
 
+static bool is_dev_usb_generic_driver(struct device *dev)
+{
+	struct usb_device_driver *udd = dev->driver ?
+		to_usb_device_driver(dev->driver) : NULL;
+
+	return udd == &usb_generic_driver;
+}
+
+static int __usb_bus_reprobe_drivers(struct device *dev, void *data)
+{
+	struct usb_device_driver *new_udriver = data;
+	struct usb_device *udev;
+	int ret;
+
+	if (!is_dev_usb_generic_driver(dev))
+		return 0;
+
+	udev = to_usb_device(dev);
+	if (usb_device_match_id(udev, new_udriver->id_table) == NULL &&
+	    (!new_udriver->match || new_udriver->match(udev) != 0))
+		return 0;
+
+	ret = device_reprobe(dev);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(dev, "Failed to reprobe device (error %d)\n", ret);
+
+	return 0;
+}
+
 /**
  * usb_register_device_driver - register a USB device (not interface) driver
  * @new_udriver: USB operations for the device driver
@@ -934,13 +963,20 @@ int usb_register_device_driver(struct us
 
 	retval = driver_register(&new_udriver->drvwrap.driver);
 
-	if (!retval)
+	if (!retval) {
 		pr_info("%s: registered new device driver %s\n",
 			usbcore_name, new_udriver->name);
-	else
+		/*
+		 * Check whether any device could be better served with
+		 * this new driver
+		 */
+		bus_for_each_dev(&usb_bus_type, NULL, new_udriver,
+				 __usb_bus_reprobe_drivers);
+	} else {
 		printk(KERN_ERR "%s: error %d registering device "
 			"	driver %s\n",
 			usbcore_name, retval, new_udriver->name);
+	}
 
 	return retval;
 }


