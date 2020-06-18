Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DA9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D99321D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473424;
	bh=wjyYT4RLyVR3OeGS5l2kxDYeJIyFGOP2unCtzYh4VRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJ+eFdPkfMP+ykWqeXvTpKgW255Evmh7zm7w5TFzhFlzMwCkvLSXrXpFQyyWtOF1c
	 tm48cDLTYwDoCJuGvIbVv51iF/Faf3qXx4m/UXDQO+vq/TcsYMll/aNgV4E1TTWDZD
	 gkJE7iuCtvy8mW9o5IUjmBirMIQ8YtHVC/A6+kps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgFRJnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFRJnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE0C21548;
        Thu, 18 Jun 2020 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473412;
        bh=wjyYT4RLyVR3OeGS5l2kxDYeJIyFGOP2unCtzYh4VRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOD5HnGtJ1cJtguIkNRuNWdncr3BnjzK1Gw2MgwXadB9lZzZDDcLJrzSWxUUpH+OM
         SNiKcRE7v5TLiOsw//CVMk5Gi91KPMpZyDwN3c/VSGgrszEubrqq71dydLfCde/SO8
         eDtw6Wd51CEaMVYDiz4X8WS4VTft365/gW3J4qMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Qi Zhou <atmgnd@outlook.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH 8/8] USB: OTG: rename product list of devices
Date:   Thu, 18 Jun 2020 11:43:00 +0200
Message-Id: <20200618094300.1887727-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the list of specific devices that an OTG device could support to
make it more obvious as to what this list is for and what it is doing.
Also rename the configuration option to make it more obvious as well.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: "Diego Elio Pettenò" <flameeyes@flameeyes.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Philippe Mathieu-Daudé" <f4bug@amsat.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Qi Zhou <atmgnd@outlook.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: Harry Pan <harry.pan@intel.com>
Cc: David Heinzelmann <heinzelmann.david@gmail.com>
Cc: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/configs/fuloong2e_defconfig              |  2 +-
 arch/mips/configs/lemote2f_defconfig               |  2 +-
 drivers/usb/core/Kconfig                           |  6 +++---
 drivers/usb/core/hub.c                             |  4 ++--
 .../core/{otg_whitelist.h => otg_productlist.h}    | 14 +++++---------
 5 files changed, 12 insertions(+), 16 deletions(-)
 rename drivers/usb/core/{otg_whitelist.h => otg_productlist.h} (90%)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 6466e83067b4..023b4e644b1c 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -159,7 +159,7 @@ CONFIG_USB_KBD=y
 CONFIG_USB_MOUSE=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_OTG_WHITELIST=y
+CONFIG_USB_OTG_PRODUCTLIST=y
 CONFIG_USB_WUSB_CBAF=m
 CONFIG_USB_C67X00_HCD=m
 CONFIG_USB_EHCI_HCD=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 8254d7d1396f..3a9a453b1264 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -207,7 +207,7 @@ CONFIG_ZEROPLUS_FF=y
 CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_OTG_WHITELIST=y
+CONFIG_USB_OTG_PRODUCTLIST=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 06bae55860e4..dfacc478a8fc 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -55,12 +55,12 @@ config USB_OTG
 	  Select this only if your board has Mini-AB/Micro-AB
 	  connector.
 
-config USB_OTG_WHITELIST
+config USB_OTG_PRODUCTLIST
 	bool "Rely on OTG and EH Targeted Peripherals List"
 	depends on USB
 	help
-	  If you say Y here, the "otg_whitelist.h" file will be used as a
-	  product whitelist, so USB peripherals not listed there will be
+	  If you say Y here, the "otg_productlist.h" file will be used as a
+	  product list, so USB peripherals not listed there will be
 	  rejected during enumeration.  This behavior is required by the
 	  USB OTG and EH specification for all devices not on your product's
 	  "Targeted Peripherals List".  "Embedded Hosts" are likewise
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index ab26ac0147f7..71bbd2eed7c6 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -35,7 +35,7 @@
 #include <asm/byteorder.h>
 
 #include "hub.h"
-#include "otg_whitelist.h"
+#include "otg_productlist.h"
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
 #define USB_VENDOR_SMSC				0x0424
@@ -2403,7 +2403,7 @@ static int usb_enumerate_device(struct usb_device *udev)
 	if (err < 0)
 		return err;
 
-	if (IS_ENABLED(CONFIG_USB_OTG_WHITELIST) && hcd->tpl_support &&
+	if (IS_ENABLED(CONFIG_USB_OTG_PRODUCTLIST) && hcd->tpl_support &&
 		!is_targeted(udev)) {
 		/* Maybe it can talk to us, though we can't talk to it.
 		 * (Includes HNP test device.)
diff --git a/drivers/usb/core/otg_whitelist.h b/drivers/usb/core/otg_productlist.h
similarity index 90%
rename from drivers/usb/core/otg_whitelist.h
rename to drivers/usb/core/otg_productlist.h
index fdd4897401e2..db67df29fb2b 100644
--- a/drivers/usb/core/otg_whitelist.h
+++ b/drivers/usb/core/otg_productlist.h
@@ -1,18 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * drivers/usb/core/otg_whitelist.h
- *
- * Copyright (C) 2004 Texas Instruments
- */
+/* Copyright (C) 2004 Texas Instruments */
 
 /*
- * This OTG and Embedded Host Whitelist is "Targeted Peripheral List".
+ * This OTG and Embedded Host list is "Targeted Peripheral List".
  * It should mostly use of USB_DEVICE() or USB_DEVICE_VER() entries..
  *
  * YOU _SHOULD_ CHANGE THIS LIST TO MATCH YOUR PRODUCT AND ITS TESTING!
  */
 
-static struct usb_device_id whitelist_table[] = {
+static struct usb_device_id productlist_table[] = {
 
 /* hubs are optional in OTG, but very handy ... */
 { USB_DEVICE_INFO(USB_CLASS_HUB, 0, 0), },
@@ -44,7 +40,7 @@ static struct usb_device_id whitelist_table[] = {
 
 static int is_targeted(struct usb_device *dev)
 {
-	struct usb_device_id	*id = whitelist_table;
+	struct usb_device_id	*id = productlist_table;
 
 	/* HNP test device is _never_ targeted (see OTG spec 6.6.6) */
 	if ((le16_to_cpu(dev->descriptor.idVendor) == 0x1a0a &&
@@ -59,7 +55,7 @@ static int is_targeted(struct usb_device *dev)
 	/* NOTE: can't use usb_match_id() since interface caches
 	 * aren't set up yet. this is cut/paste from that code.
 	 */
-	for (id = whitelist_table; id->match_flags; id++) {
+	for (id = productlist_table; id->match_flags; id++) {
 		if ((id->match_flags & USB_DEVICE_ID_MATCH_VENDOR) &&
 		    id->idVendor != le16_to_cpu(dev->descriptor.idVendor))
 			continue;
-- 
2.27.0

