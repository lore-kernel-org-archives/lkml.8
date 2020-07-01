Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F9520747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593623774;
	bh=FYAlFEMRS1WiJv3/ZHFyo32zEs/Uyaxc8XAy7NNpdCw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sYTd1+SiqyOpGWplsbOk11idv9/vAg6DCfgByz8fNIP/v9acIayiDG9pSaczRm3Pc
	 9bVo4YZsTcQrqmf6qnY42RnohZd/Z9YU0L27fDR7tZwALpq3xmZtBVdG/9+sQWpNGQ
	 /VGO1e8IV2sQ4ju4q3gp9b/Xqt2yOanzkVKcTo3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgGARQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732584AbgGARQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:16:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C95420747;
        Wed,  1 Jul 2020 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593623770;
        bh=FYAlFEMRS1WiJv3/ZHFyo32zEs/Uyaxc8XAy7NNpdCw=;
        h=From:To:Cc:Subject:Date:From;
        b=OlZwctqwPB7GWvCwNCwvVpqeUtXV7rMudQdATkKf9JlgM1ldVH3jzHViPdAKCD6rq
         LginZCfbswDBmLwFcTJKIsHfYaUeuoQrECH0DvlEs+Kc+E3c059ZQ78p4RKjNOHSCD
         +iBOgYw19mITVkSS/KrVgAF9WC5RRSkWLPgpdFlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] USB: Fix up terminology in include files
Date:   Wed,  1 Jul 2020 19:15:55 +0200
Message-Id: <20200701171555.3198836-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB is a HOST/DEVICE protocol, as per the specification and all
documentation.  Fix up terms that are not applicable to make things
match up with the terms used through the rest of the USB stack.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/usb.h        | 2 +-
 include/linux/usb/ch9.h    | 8 ++++----
 include/linux/usb/gadget.h | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index c86e4ec4d00f..c28fc391444a 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -422,7 +422,7 @@ struct usb_devmap {
  * Allocated per bus (tree of devices) we have:
  */
 struct usb_bus {
-	struct device *controller;	/* host/master side hardware */
+	struct device *controller;	/* host side hardware */
 	struct device *sysdev;		/* as seen from firmware or bus */
 	int busnum;			/* Bus number (in order of reg) */
 	const char *bus_name;		/* stable id (PCI slot_name etc) */
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 58b83066bea4..604c6c514a50 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -6,13 +6,13 @@
  * Wireless USB 1.0 (spread around).  Linux has several APIs in C that
  * need these:
  *
- * - the master/host side Linux-USB kernel driver API;
+ * - the host side Linux-USB kernel driver API;
  * - the "usbfs" user space API; and
- * - the Linux "gadget" slave/device/peripheral side driver API.
+ * - the Linux "gadget" device/peripheral side driver API.
  *
  * USB 2.0 adds an additional "On The Go" (OTG) mode, which lets systems
- * act either as a USB master/host or as a USB slave/device.  That means
- * the master and slave side APIs benefit from working well together.
+ * act either as a USB host or as a USB device.  That means the host and
+ * device side APIs benefit from working well together.
  *
  * There's also "Wireless USB", using low power short range radios for
  * peripheral interconnection but otherwise building on the USB framework.
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 6a178177e4c9..298b334e2951 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -4,7 +4,8 @@
  *
  * We call the USB code inside a Linux-based peripheral device a "gadget"
  * driver, except for the hardware-specific bus glue.  One USB host can
- * master many USB gadgets, but the gadgets are only slaved to one host.
+ * talk to many USB gadgets, but the gadgets are only able to communicate
+ * to one host.
  *
  *
  * (C) Copyright 2002-2004 by David Brownell
@@ -328,7 +329,7 @@ struct usb_gadget_ops {
 };
 
 /**
- * struct usb_gadget - represents a usb slave device
+ * struct usb_gadget - represents a usb device
  * @work: (internal use) Workqueue to be used for sysfs_notify()
  * @udc: struct usb_udc pointer for this gadget
  * @ops: Function pointers used to access hardware-specific operations.
@@ -602,7 +603,7 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
 /*-------------------------------------------------------------------------*/
 
 /**
- * struct usb_gadget_driver - driver for usb 'slave' devices
+ * struct usb_gadget_driver - driver for usb gadget devices
  * @function: String describing the gadget's function
  * @max_speed: Highest speed the driver handles.
  * @setup: Invoked for ep0 control requests that aren't handled by
-- 
2.27.0

