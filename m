Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4835C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983DA21D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473435;
	bh=vjhHAtX89dp52fJGjMBaXCx1opCt0jlVamfjql7G9Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZTdWMpIgay517SpZVzscsUyiUomfyzv9E3H5QAvRmOk0HsqAuzSxjTJ2usz1G7zh
	 FUrPe2GPDaJJvQLY/ieqiJzlCX++JW/PfbcnMMm5ozP/5Thg+8rzXyQMsy8WU3vQPG
	 RKssE/vwTU4TkWwxoDQwUhq3wyeokl+Q6BbsWlN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgFRJny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgFRJnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614A721548;
        Thu, 18 Jun 2020 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473396;
        bh=vjhHAtX89dp52fJGjMBaXCx1opCt0jlVamfjql7G9Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DE/EtOgB0MLEK0vpt1l55jo6m76nx5qJ/UzQM6X0TCKLWK/8qUizlPV5w4J3Tdy6y
         VM6y5jnruykVnFtZmoGDjuBKxZIOTzA5yxtWLD2LOccsOR/GynlvCRgWHU5p4FJ9CQ
         1rABQZ/SPgutE3LSZ6yJsfIgsAOahiZ6MKm5JPU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bin Liu <b-liu@ti.com>, Paul Cercueil <paul@crapouillou.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        Keiya Nobuta <nobuta.keiya@fujitsu.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>
Subject: [PATCH 2/8] USB: rename USB OTG hub configuration option
Date:   Thu, 18 Jun 2020 11:42:54 +0200
Message-Id: <20200618094300.1887727-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB OTG code has the ability to disable external hubs, but the
configuration option for it is oddly named.  Rename it to be more
obvious as to what it does.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Bin Liu <b-liu@ti.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: David Heinzelmann <heinzelmann.david@gmail.com>
Cc: "Lee, Chiasheng" <chiasheng.lee@intel.com>
Cc: Keiya Nobuta <nobuta.keiya@fujitsu.com>
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/configs/gcw0_defconfig | 2 +-
 drivers/usb/core/Kconfig         | 2 +-
 drivers/usb/core/hub.c           | 2 +-
 drivers/usb/musb/Kconfig         | 2 +-
 drivers/usb/musb/musb_core.c     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/gcw0_defconfig b/arch/mips/configs/gcw0_defconfig
index 48131cb47e66..4994749b9eaa 100644
--- a/arch/mips/configs/gcw0_defconfig
+++ b/arch/mips/configs/gcw0_defconfig
@@ -96,7 +96,7 @@ CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB_CONN_GPIO=y
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-CONFIG_USB_OTG_BLACKLIST_HUB=y
+CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_MUSB_HDRC=y
diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index ecaacc8ed311..06bae55860e4 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -66,7 +66,7 @@ config USB_OTG_WHITELIST
 	  "Targeted Peripherals List".  "Embedded Hosts" are likewise
 	  allowed to support only a limited number of peripherals.
 
-config USB_OTG_BLACKLIST_HUB
+config USB_OTG_DISABLE_EXTERNAL_HUB
 	bool "Disable external hubs"
 	depends on USB_OTG || EXPERT
 	help
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14beaac5f..ab26ac0147f7 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1834,7 +1834,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return -E2BIG;
 	}
 
-#ifdef	CONFIG_USB_OTG_BLACKLIST_HUB
+#ifdef	CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB
 	if (hdev->parent) {
 		dev_warn(&intf->dev, "ignoring external hub\n");
 		return -ENODEV;
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 3b0d1c20ebe6..8de143807c1a 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -113,7 +113,7 @@ config USB_MUSB_JZ4740
 	depends on OF
 	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
-	depends on USB=n || USB_OTG_BLACKLIST_HUB
+	depends on USB=n || USB_OTG_DISABLE_EXTERNAL_HUB
 	select USB_ROLE_SWITCH
 
 config USB_MUSB_MEDIATEK
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 384a8039a7fd..5a56a03996b1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1637,8 +1637,8 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 		musb->is_multipoint = 0;
 		type = "";
 		if (IS_ENABLED(CONFIG_USB) &&
-		    !IS_ENABLED(CONFIG_USB_OTG_BLACKLIST_HUB)) {
-			pr_err("%s: kernel must blacklist external hubs\n",
+		    !IS_ENABLED(CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB)) {
+			pr_err("%s: kernel must disable external hubs, please fix the configuration\n",
 			       musb_driver_name);
 		}
 	}
-- 
2.27.0

