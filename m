Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900ECC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C99820737
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 00:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="T0YSsb4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDDAAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:00:15 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2456 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDDAAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:09 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vH465jf5zqB;
        Sat,  4 Apr 2020 02:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585958406; bh=ERaR7ygM77SbTRq+ee9gcCX1NXRy6uMU4qvMkPRl8pk=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=T0YSsb4jOs8jPx/dRCcVRaaPL+VAs1GTk4ed+4c/4HbhcftgsFR0WcFvaxOam/jp1
         CyEhpbfGmYOoWbNLX4E0zAGcD4UK5SIpBYZYZlqPuDxhUzR4YvYfefasta6eD6BjfV
         ZZECMM2LnpioEIDw+62+FGj95JRGg5TPuomH04jY+m/kLmbI5p6PR6W6MGzMu0FjYZ
         7oLoSmFw3ivPVZR0wIWWU4X61jfKFV+72RM8kv5ea6ZJDS1ZRfzPb5BS9zeJ2H8KSA
         YqDMyA6IXPAxE6ncUnCJ7yV6iOqdlqXIQLVXDKrWcj58tHBopE2uVMFUdQ1BWdVVcF
         Oho3eV0ciBzeA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 04 Apr 2020 02:00:06 +0200
Message-Id: <1bf89d4301baa8632daf48b3e28858aff5371954.1585958250.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/5] usb: chipidea: allow disabling glue drivers if EMBEDDED
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to cut down on driver size for embedded config.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/chipidea/Kconfig  | 37 ++++++++++++++++++++++++-----------
 drivers/usb/chipidea/Makefile | 12 +++++-------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index d53db520e209..8bafcfc6080d 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -18,17 +18,6 @@ config USB_CHIPIDEA
 
 if USB_CHIPIDEA
 
-config USB_CHIPIDEA_OF
-	tristate
-	depends on OF
-	default USB_CHIPIDEA
-
-config USB_CHIPIDEA_PCI
-	tristate
-	depends on USB_PCI
-	depends on NOP_USB_XCEIV
-	default USB_CHIPIDEA
-
 config USB_CHIPIDEA_UDC
 	bool "ChipIdea device controller"
 	depends on USB_GADGET
@@ -43,4 +32,30 @@ config USB_CHIPIDEA_HOST
 	help
 	  Say Y here to enable host controller functionality of the
 	  ChipIdea driver.
+
+config USB_CHIPIDEA_PCI
+	tristate "Enable PCI glue driver" if EMBEDDED
+	depends on USB_PCI
+	depends on NOP_USB_XCEIV
+	default USB_CHIPIDEA
+
+config USB_CHIPIDEA_MSM
+	tristate "Enable MSM hsusb glue driver" if EMBEDDED
+	default USB_CHIPIDEA
+
+config USB_CHIPIDEA_IMX
+	tristate "Enable i.MX USB glue driver" if EMBEDDED
+	depends on OF
+	default USB_CHIPIDEA
+
+config USB_CHIPIDEA_GENERIC
+	tristate "Enable generic USB2 glue driver" if EMBEDDED
+	default USB_CHIPIDEA
+
+config USB_CHIPIDEA_TEGRA
+	tristate "Enable Tegra UDC glue driver" if EMBEDDED
+	depends on OF
+	depends on USB_CHIPIDEA_UDC
+	default USB_CHIPIDEA
+
 endif
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 985663ba6e68..fae779a23866 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -8,10 +8,8 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
 
 # Glue/Bridge layers go here
 
-obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_usb2.o
-obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_msm.o
-
-obj-$(CONFIG_USB_CHIPIDEA_PCI)	+= ci_hdrc_pci.o
-
-obj-$(CONFIG_USB_CHIPIDEA_OF)	+= usbmisc_imx.o ci_hdrc_imx.o
-obj-$(CONFIG_USB_CHIPIDEA_OF)	+= ci_hdrc_tegra.o
+obj-$(CONFIG_USB_CHIPIDEA_GENERIC)	+= ci_hdrc_usb2.o
+obj-$(CONFIG_USB_CHIPIDEA_MSM)		+= ci_hdrc_msm.o
+obj-$(CONFIG_USB_CHIPIDEA_PCI)		+= ci_hdrc_pci.o
+obj-$(CONFIG_USB_CHIPIDEA_IMX)		+= ci_hdrc_imx.o usbmisc_imx.o
+obj-$(CONFIG_USB_CHIPIDEA_TEGRA)	+= ci_hdrc_tegra.o
-- 
2.20.1

