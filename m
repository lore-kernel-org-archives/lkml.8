Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72383C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4863B20575
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584287423;
	bh=NRB9R6tu32z8WFealdCcR4r0Ghn1cI6ttGf2yRUeg/I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SEmRtp1uX35cfqq7KcabJpBbfOo3XUEJ0q4gElEePbawsA3Z/Abp2LezSOcwe0Xa6
	 r+qo0kPBiO9HxamD9HB+RAAc02kiKeIYoDJC0Sc6sZ1X+93G87SWTIP8UNZLmTTmmE
	 VxO0oYgjU1Wb/wsYTEOPxUWEXEIb4q6JMsasTVfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgCOPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:50:22 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:48729 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgCOPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:50:21 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 02FFnsYW028305;
        Mon, 16 Mar 2020 00:49:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 02FFnsYW028305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584287394;
        bh=DXSJAQYV+K0M5wfTtzFMast16/HPOG8d+XP8Fy1ApxU=;
        h=From:To:Cc:Subject:Date:From;
        b=tfqCX3RMCkBadXSFbWsEHy6hJ0kHWD78afZDuq275jnzivm7s4zzBYtwbQFmquZzz
         mYqV5B98M6vxe+zXg7V1IYJ21CBrHyqhTs2YtcX32D9qukaYMywOAJaphqFB3EPLg3
         fqRRfUMaHBugriwrNRshJGZKyk4A2mdc9k8Q58gKNQR8Wu6EcMVHaTTc3yD3IHU8aw
         eRjm84BYG97Jw5UT5osVGXcT+2Vd2T/vAHSHWC9Z0sQajdiaEEzF/vJBy1Ln+df+I3
         4z6cGN++KzZvXSfBuTHyRzW3uMZR9FZ7CZ1ztSUeJBpaTrxL8UlQsMUbwjuQaGfCbj
         0HqyC6K8u/eUA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] usb: get rid of 'choice' for legacy gadget drivers
Date:   Mon, 16 Mar 2020 00:49:48 +0900
Message-Id: <20200315154948.26569-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/gadget/legacy/Kconfig creates a 'choice' inside another
'choice'.

The outer choice: line 17 "USB Gadget precomposed configurations"
The inner choice: line 484 "EHCI Debug Device mode"

I wondered why the whole legacy gadget drivers reside in such a big
choice block.

This dates back to 2003, "[PATCH] USB: fix for multiple definition of
`usb_gadget_get_string'". [1]

At that time, the global function, usb_gadget_get_string(), was linked
into multiple drivers. That was why only one driver was able to become
built-in at the same time.

Later, commit a84d9e5361bc ("usb: gadget: start with libcomposite")
moved usb_gadget_get_string() to a separate module, libcomposite.ko
instead of including usbstring.c from multiple modules.

More and more refactoring was done, and after commit 1bcce939478f
("usb: gadget: multi: convert to new interface of f_mass_storage"),
you can link multiple gadget drivers into vmlinux without causing
multiple definition error.

This is the only user of the nested choice structure ever. Removing
this mess will make some Kconfig cleanups possible.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=fee4cf49a81381e072c063571d1aadbb29207408

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/usb/gadget/legacy/Kconfig | 48 ++++++++++++++-----------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index 6e7e1a9202e6..cc20f61d48a0 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -13,32 +13,28 @@
 # With help from a special transceiver and a "Mini-AB" jack, systems with
 # both kinds of controller can also support "USB On-the-Go" (CONFIG_USB_OTG).
 #
+# A Linux "Gadget Driver" talks to the USB Peripheral Controller
+# driver through the abstract "gadget" API.  Some other operating
+# systems call these "client" drivers, of which "class drivers"
+# are a subset (implementing a USB device class specification).
+# A gadget driver implements one or more USB functions using
+# the peripheral hardware.
+#
+# Gadget drivers are hardware-neutral, or "platform independent",
+# except that they sometimes must understand quirks or limitations
+# of the particular controllers they work with.  For example, when
+# a controller doesn't support alternate configurations or provide
+# enough of the right types of endpoints, the gadget driver might
+# not be able work with that controller, or might need to implement
+# a less common variant of a device class protocol.
+#
+# The available choices each represent a single precomposed USB
+# gadget configuration. In the device model, each option contains
+# both the device instantiation as a child for a USB gadget
+# controller, and the relevant drivers for each function declared
+# by the device.
 
-choice
-	tristate "USB Gadget precomposed configurations"
-	default USB_ETH
-	optional
-	help
-	  A Linux "Gadget Driver" talks to the USB Peripheral Controller
-	  driver through the abstract "gadget" API.  Some other operating
-	  systems call these "client" drivers, of which "class drivers"
-	  are a subset (implementing a USB device class specification).
-	  A gadget driver implements one or more USB functions using
-	  the peripheral hardware.
-
-	  Gadget drivers are hardware-neutral, or "platform independent",
-	  except that they sometimes must understand quirks or limitations
-	  of the particular controllers they work with.  For example, when
-	  a controller doesn't support alternate configurations or provide
-	  enough of the right types of endpoints, the gadget driver might
-	  not be able work with that controller, or might need to implement
-	  a less common variant of a device class protocol.
-
-	  The available choices each represent a single precomposed USB
-	  gadget configuration. In the device model, each option contains
-	  both the device instantiation as a child for a USB gadget
-	  controller, and the relevant drivers for each function declared
-	  by the device.
+menu "USB Gadget precomposed configurations"
 
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
@@ -516,4 +512,4 @@ config USB_G_WEBCAM
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_webcam".
 
-endchoice
+endmenu
-- 
2.17.1

