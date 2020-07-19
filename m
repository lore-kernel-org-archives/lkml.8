Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14873C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE30A21741
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGSQJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:09:23 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:47754 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:09:23 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4B4B1BC053;
        Sun, 19 Jul 2020 16:09:16 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     gregkh@linuxfoundation.org, corbet@lwn.net, balbi@kernel.org,
        peter.chen@nxp.com, colin.king@canonical.com,
        dinghao.liu@zju.edu.cn, rogerq@ti.com, pawell@cadence.com,
        krzk@kernel.org, hadess@hadess.net, stern@rowland.harvard.edu,
        masahiroy@kernel.org, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] USB: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 18:09:10 +0200
Message-Id: <20200719160910.60018-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/usb/gadget_hid.rst   |  2 +-
 Documentation/usb/gadget_multi.rst | 10 +++++-----
 Documentation/usb/linux.inf        |  2 +-
 drivers/usb/cdns3/cdns3-ti.c       |  2 +-
 drivers/usb/common/debug.c         |  2 +-
 drivers/usb/host/max3421-hcd.c     |  6 +++---
 drivers/usb/misc/Kconfig           |  4 ++--
 include/linux/usb/phy_companion.h  |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/usb/gadget_hid.rst b/Documentation/usb/gadget_hid.rst
index 098d563040cc..e623416de4f1 100644
--- a/Documentation/usb/gadget_hid.rst
+++ b/Documentation/usb/gadget_hid.rst
@@ -11,7 +11,7 @@ and HID reports can be sent/received through I/O on the
 /dev/hidgX character devices.
 
 For more details about HID, see the developer page on
-http://www.usb.org/developers/hidpage/
+https://www.usb.org/developers/hidpage/
 
 Configuration
 =============
diff --git a/Documentation/usb/gadget_multi.rst b/Documentation/usb/gadget_multi.rst
index 9806b55af301..3a22c1b2f39e 100644
--- a/Documentation/usb/gadget_multi.rst
+++ b/Documentation/usb/gadget_multi.rst
@@ -142,7 +142,7 @@ Footnotes
 =========
 
 [1] Remote Network Driver Interface Specification,
-[[http://msdn.microsoft.com/en-us/library/ee484414.aspx]].
+[[https://msdn.microsoft.com/en-us/library/ee484414.aspx]].
 
 [2] Communications Device Class Abstract Control Model, spec for this
 and other USB classes can be found at
@@ -150,9 +150,9 @@ and other USB classes can be found at
 
 [3] CDC Ethernet Control Model.
 
-[4] [[http://msdn.microsoft.com/en-us/library/ff537109(v=VS.85).aspx]]
+[4] [[https://msdn.microsoft.com/en-us/library/ff537109(v=VS.85).aspx]]
 
-[5] [[http://msdn.microsoft.com/en-us/library/ff539234(v=VS.85).aspx]]
+[5] [[https://msdn.microsoft.com/en-us/library/ff539234(v=VS.85).aspx]]
 
 [6] To put it in some other nice words, Windows failed to respond to
 any user input.
@@ -160,6 +160,6 @@ any user input.
 [7] You may find [[http://www.cygnal.org/ubb/Forum9/HTML/001050.html]]
 useful.
 
-[8] http://www.nirsoft.net/utils/usb_devices_view.html
+[8] https://www.nirsoft.net/utils/usb_devices_view.html
 
-[9] [[http://msdn.microsoft.com/en-us/library/ff570620.aspx]]
+[9] [[https://msdn.microsoft.com/en-us/library/ff570620.aspx]]
diff --git a/Documentation/usb/linux.inf b/Documentation/usb/linux.inf
index 4ffa715b0ae8..c569ac6bec58 100644
--- a/Documentation/usb/linux.inf
+++ b/Documentation/usb/linux.inf
@@ -1,5 +1,5 @@
 ; Based on template INF file found at
-;    <http://msdn.microsoft.com/en-us/library/ff570620.aspx>
+;    <https://msdn.microsoft.com/en-us/library/ff570620.aspx>
 ; which was:
 ;    Copyright (c) Microsoft Corporation
 ; and released under the MLPL as found at:
diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index e701ab56b0a7..90e246601537 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -2,7 +2,7 @@
 /**
  * cdns3-ti.c - TI specific Glue layer for Cadence USB Controller
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <linux/bits.h>
diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 92a986aeaa5d..7a520d2f7e75 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -2,7 +2,7 @@
 /**
  * Common USB debugging functions
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 8819f502b6a6..233b0eb6f02e 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -11,9 +11,9 @@
  *
  * Based on:
  *	o MAX3421E datasheet
- *		http://datasheets.maximintegrated.com/en/ds/MAX3421E.pdf
+ *		https://datasheets.maximintegrated.com/en/ds/MAX3421E.pdf
  *	o MAX3421E Programming Guide
- *		http://www.hdl.co.jp/ftpdata/utl-001/AN3785.pdf
+ *		https://www.hdl.co.jp/ftpdata/utl-001/AN3785.pdf
  *	o gadget/dummy_hcd.c
  *		For USB HCD implementation.
  *	o Arduino MAX3421 driver
@@ -317,7 +317,7 @@ static const int hrsl_to_error[] = {
 };
 
 /*
- * See http://www.beyondlogic.org/usbnutshell/usb4.shtml#Control for a
+ * See https://www.beyondlogic.org/usbnutshell/usb4.shtml#Control for a
  * reasonable overview of how control transfers use the the IN/OUT
  * tokens.
  */
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 4e48f8eed168..6818ea689cd9 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -78,7 +78,7 @@ config USB_CYPRESS_CY7C63
 	  driver supports the pre-programmed devices (incl. firmware)
 	  by AK Modul-Bus Computer GmbH.
 
-	  Please see: http://www.ak-modul-bus.de/stat/mikrocontroller.html
+	  Please see: https://www.ak-modul-bus.de/stat/mikrocontroller.html
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cypress_cy7c63.
@@ -106,7 +106,7 @@ config USB_IDMOUSE
 	  This driver creates an entry "/dev/idmouseX" or "/dev/usb/idmouseX",
 	  which can be used by, e.g.,"cat /dev/idmouse0 > fingerprint.pnm".
 
-	  See also <http://www.fs.tum.de/~echtler/idmouse/>.
+	  See also <https://www.fs.tum.de/~echtler/idmouse/>.
 
 config USB_FTDI_ELAN
 	tristate "Elan PCMCIA CardBus Adapter USB Client"
diff --git a/include/linux/usb/phy_companion.h b/include/linux/usb/phy_companion.h
index 407f530061cd..263196f05015 100644
--- a/include/linux/usb/phy_companion.h
+++ b/include/linux/usb/phy_companion.h
@@ -2,7 +2,7 @@
 /*
  * phy-companion.h -- phy companion to indicate the comparator part of PHY
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
-- 
2.27.0

