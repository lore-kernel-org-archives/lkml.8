Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFA0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E6220775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538898;
	bh=mHdTp8ziRuG+emipFCE0W+D+zrB/HLt0yjzi2Tx0IPA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lhF+Sot0lCLXNzggQ4tvNxQJ3VBnwSQQUXG2jVd3Rku9IPh8T6zX0bFT33EMRFzC9
	 WRJ1IsWXwJZv1o7rMqVno12YiCyLxwLBcqiM/1Rys7loSHS7gdbQmaBZx041Bw+SJm
	 SMjmYEEI2wGUCCPER6Xh4afbjpNnS0ZGmdqDYZkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgF3Rlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgF3Rlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:41:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B9120775;
        Tue, 30 Jun 2020 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538895;
        bh=mHdTp8ziRuG+emipFCE0W+D+zrB/HLt0yjzi2Tx0IPA=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2XUG31PExquQyM5mpYOZlcxyRBjd/OjSO13IbxR7syRJedmrcggLeNQxwoyOVFxe
         1eKHcCzzu/WG47ZyOLIrjh6SpMp28C6/oCBzVt4UgvecJr243kLTnh80Hyaj9o7z66
         kq03HCFN9AeghYnAXtmiFDeu2qCCx6iTlh8Y0JFc=
Date:   Tue, 30 Jun 2020 19:41:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Fix up terminology
Message-ID: <20200630174123.GA1906678@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB is a HOST/DEVICE protocol, as per the specification and all
documentation.  Fix up terms that are not applicable to make things
match up with the terms used through the rest of the USB stack.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/usb.c               |  5 ++---
 drivers/usb/dwc2/core.h              |  2 +-
 drivers/usb/gadget/Kconfig           |  4 ++--
 drivers/usb/gadget/legacy/zero.c     |  4 ++--
 drivers/usb/gadget/udc/Kconfig       |  2 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c | 16 ++++++++--------
 drivers/usb/gadget/udc/core.c        |  2 +-
 drivers/usb/gadget/udc/dummy_hcd.c   | 20 ++++++++++----------
 drivers/usb/serial/ftdi_sio.h        |  4 ++--
 9 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index f16c26dc079d..bafc113f2b3e 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -19,9 +19,8 @@
  * just a collection of helper routines that implement the
  * generic USB things that the real drivers can use..
  *
- * Think of this as a "USB library" rather than anything else.
- * It should be considered a slave, with no callbacks. Callbacks
- * are evil.
+ * Think of this as a "USB library" rather than anything else,
+ * with no callbacks.  Callbacks are evil.
  */
 
 #include <linux/module.h>
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 132d687f1590..9deff0400a92 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1036,7 +1036,7 @@ struct dwc2_hregs_backup {
  * @fifo_mem:			Total internal RAM for FIFOs (bytes)
  * @fifo_map:		Each bit intend for concrete fifo. If that bit is set,
  *			then that fifo is used
- * @gadget:		Represents a usb slave device
+ * @gadget:		Represents a usb gadget device
  * @connected:		Used in slave mode. True if device connected with host
  * @eps_in:		The IN endpoints being supplied to the gadget framework
  * @eps_out:		The OUT endpoints being supplied to the gadget framework
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c6db0a0a340c..7e47e6223089 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -19,8 +19,8 @@ menuconfig USB_GADGET
 	select USB_COMMON
 	select NLS
 	help
-	   USB is a master/slave protocol, organized with one master
-	   host (such as a PC) controlling up to 127 peripheral devices.
+	   USB is a host/device protocol, organized with one host (such as a
+	   PC) controlling up to 127 peripheral devices.
 	   The USB hardware is asymmetric, which makes it easier to set up:
 	   you can't connect a "to-the-host" connector to a peripheral.
 
diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index 6e84b44c8a3b..23312a07efb4 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -11,8 +11,8 @@
  * can write a hardware-agnostic gadget driver running inside a USB device.
  * Some hardware details are visible, but don't affect most of the driver.
  *
- * Use it with the Linux host/master side "usbtest" driver to get a basic
- * functional test of your device-side usb stack, or with "usb-skeleton".
+ * Use it with the Linux host side "usbtest" driver to get a basic functional
+ * test of your device-side usb stack, or with "usb-skeleton".
  *
  * It supports two similar configurations.  One sinks whatever the usb host
  * writes, and in return sources zeroes.  The other loops whatever the host
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 3a7179e90f4e..1a12aab208b4 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -474,7 +474,7 @@ config USB_DUMMY_HCD
 	help
 	  This host controller driver emulates USB, looping all data transfer
 	  requests back to a USB "gadget driver" in the same host.  The host
-	  side is the master; the gadget side is the slave.  Gadget drivers
+	  side is the controller; the gadget side is the device.  Gadget drivers
 	  can be high, full, or low speed; and they have access to endpoints
 	  like those from NET2280, PXA2xx, or SA1100 hardware.
 
diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 54501814dc3f..feaec00a3c16 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -266,8 +266,8 @@ struct bcm63xx_req {
  * @pd: Platform data (board/port info).
  * @usbd_clk: Clock descriptor for the USB device block.
  * @usbh_clk: Clock descriptor for the USB host block.
- * @gadget: USB slave device.
- * @driver: Driver for USB slave devices.
+ * @gadget: USB device.
+ * @driver: Driver for USB device.
  * @usbd_regs: Base address of the USBD/USB20D block.
  * @iudma_regs: Base address of the USBD's associated IUDMA block.
  * @bep: Array of endpoints, including ep0.
@@ -1744,7 +1744,7 @@ static void bcm63xx_ep0_process(struct work_struct *w)
 
 /**
  * bcm63xx_udc_get_frame - Read current SOF frame number from the HW.
- * @gadget: USB slave device.
+ * @gadget: USB device.
  */
 static int bcm63xx_udc_get_frame(struct usb_gadget *gadget)
 {
@@ -1756,7 +1756,7 @@ static int bcm63xx_udc_get_frame(struct usb_gadget *gadget)
 
 /**
  * bcm63xx_udc_pullup - Enable/disable pullup on D+ line.
- * @gadget: USB slave device.
+ * @gadget: USB device.
  * @is_on: 0 to disable pullup, 1 to enable.
  *
  * See notes in bcm63xx_select_pullup().
@@ -1805,8 +1805,8 @@ static int bcm63xx_udc_pullup(struct usb_gadget *gadget, int is_on)
 
 /**
  * bcm63xx_udc_start - Start the controller.
- * @gadget: USB slave device.
- * @driver: Driver for USB slave devices.
+ * @gadget: USB device.
+ * @driver: Driver for USB device.
  */
 static int bcm63xx_udc_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
@@ -1842,8 +1842,8 @@ static int bcm63xx_udc_start(struct usb_gadget *gadget,
 
 /**
  * bcm63xx_udc_stop - Shut down the controller.
- * @gadget: USB slave device.
- * @driver: Driver for USB slave devices.
+ * @gadget: USB device.
+ * @driver: Driver for USB device.
  */
 static int bcm63xx_udc_stop(struct usb_gadget *gadget)
 {
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 2e28dde8376f..ee226ad802a4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
  * for interrupt transfers as well as bulk, but it likely couldn't be used
  * for iso transfers or for endpoint 14.  some endpoints are fully
  * configurable, with more generic names like "ep-a".  (remember that for
- * USB, "in" means "towards the USB master".)
+ * USB, "in" means "towards the USB host".)
  *
  * This routine must be called in process context.
  *
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0eeaead5acea..425a97926590 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -14,7 +14,7 @@
  * Linux-USB host controller driver.  USB traffic is simulated; there's
  * no need for USB hardware.  Use this with two other drivers:
  *
- *  - Gadget driver, responding to requests (slave);
+ *  - Gadget driver, responding to requests (device);
  *  - Host-side device driver, as already familiar in Linux.
  *
  * Having this all in one kernel can help some stages of development,
@@ -261,7 +261,7 @@ struct dummy {
 	spinlock_t			lock;
 
 	/*
-	 * SLAVE/GADGET side support
+	 * DEVICE/GADGET side support
 	 */
 	struct dummy_ep			ep[DUMMY_ENDPOINTS];
 	int				address;
@@ -276,7 +276,7 @@ struct dummy {
 	unsigned			pullup:1;
 
 	/*
-	 * MASTER/HOST side support
+	 * HOST side support
 	 */
 	struct dummy_hcd		*hs_hcd;
 	struct dummy_hcd		*ss_hcd;
@@ -323,7 +323,7 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
 
 /*-------------------------------------------------------------------------*/
 
-/* SLAVE/GADGET SIDE UTILITY ROUTINES */
+/* DEVICE/GADGET SIDE UTILITY ROUTINES */
 
 /* called with spinlock held */
 static void nuke(struct dummy *dum, struct dummy_ep *ep)
@@ -486,7 +486,7 @@ static void set_link_state(struct dummy_hcd *dum_hcd)
 
 /*-------------------------------------------------------------------------*/
 
-/* SLAVE/GADGET SIDE DRIVER
+/* DEVICE/GADGET SIDE DRIVER
  *
  * This only tracks gadget state.  All the work is done when the host
  * side tries some (emulated) i/o operation.  Real device controller
@@ -957,7 +957,7 @@ static DEVICE_ATTR_RO(function);
  * hardware can be built with discrete components, so the gadget API doesn't
  * require that assumption.
  *
- * For this emulator, it might be convenient to create a usb slave device
+ * For this emulator, it might be convenient to create a usb device
  * for each driver that registers:  just add to a big root hub.
  */
 
@@ -981,7 +981,7 @@ static int dummy_udc_start(struct usb_gadget *g,
 	}
 
 	/*
-	 * SLAVE side init ... the layer above hardware, which
+	 * DEVICE side init ... the layer above hardware, which
 	 * can't enumerate without help from the driver we're binding.
 	 */
 
@@ -1151,7 +1151,7 @@ static unsigned int dummy_get_ep_idx(const struct usb_endpoint_descriptor *desc)
 	return index;
 }
 
-/* MASTER/HOST SIDE DRIVER
+/* HOST SIDE DRIVER
  *
  * this uses the hcd framework to hook up to host side drivers.
  * its root hub will only have one device, otherwise it acts like
@@ -2451,8 +2451,8 @@ static int dummy_start(struct usb_hcd *hcd)
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
 	/*
-	 * MASTER side init ... we emulate a root hub that'll only ever
-	 * talk to one device (the slave side).  Also appears in sysfs,
+	 * HOST side init ... we emulate a root hub that'll only ever
+	 * talk to one device (the gadget side).  Also appears in sysfs,
 	 * just like more familiar pci-based HCDs.
 	 */
 	if (!usb_hcd_is_primary_hcd(hcd))
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index a79a1325b4d9..be1641e0408b 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -302,7 +302,7 @@ enum ftdi_sio_baudrate {
 /*
  * FTDI_SIO_GET_LATENCY_TIMER
  *
- * Set the timeout interval. The FTDI collects data from the slave
+ * Set the timeout interval. The FTDI collects data from the
  * device, transmitting it to the host when either A) 62 bytes are
  * received, or B) the timeout interval has elapsed and the buffer
  * contains at least 1 byte.  Setting this value to a small number
@@ -324,7 +324,7 @@ enum ftdi_sio_baudrate {
 /*
  * FTDI_SIO_SET_LATENCY_TIMER
  *
- * Set the timeout interval. The FTDI collects data from the slave
+ * Set the timeout interval. The FTDI collects data from the
  * device, transmitting it to the host when either A) 62 bytes are
  * received, or B) the timeout interval has elapsed and the buffer
  * contains at least 1 byte.  Setting this value to a small number
-- 
2.27.0

