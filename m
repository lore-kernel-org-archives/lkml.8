Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215DC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E40A2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDZmG2j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCMOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCMOQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14so12307018wrt.8;
        Fri, 13 Mar 2020 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=suutDYpQ/bEjugHVP9bWCcemianLUbaHZjVOmNlD4S8=;
        b=VDZmG2j2t962DhcwYUrCKkn/lXu+Th3J+ej/KQy8aEpD41mm+pBGFpmHuWN3uIOdDT
         u7IAxLKSb3pMTTvyEa3F589teEPJyl9y2nK7Rj2d1cGwuu/Pl2XvKPDL4t87LwhGyaHF
         Fm0uqrgR19tJ3XVQH/cIJN69MU2pfpo9bbrQjoLNo9u86dAXCsdYHlVxGfrnNwhJEbth
         UuZlpdd9AAH9fEdNromi1fdCQoTPtuLAWu9OPGcJXkWhzi+8OcO7Z0WikM4w0cCZJbgQ
         goeJaZEQQgRYLJ8enxkzr+B6W7WPC+xC7tnqKHviyojs7SBFLRbrDG2+tN2A2/kB8glt
         XPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=suutDYpQ/bEjugHVP9bWCcemianLUbaHZjVOmNlD4S8=;
        b=ZCRh85IjwdkgyqydYLw79QqKQPj0SwTPhM918BmLj/sFYQ3N+E28S3xxyPwCJu9Q+q
         vO4USBbgPWt/Jf+HUK5FdtoqNHt0zOvDVzKjxw6x2JKFRVHD3ay0mdOw6Vj2ncTNRZw6
         iVbP29P3a+JOlNiSuko3/vCUv5c7xF4uWC54Jkc1TReab74MQi0b8QENRblXcXsfhbUd
         8T9lkD6sPAC77fxFseAFubzzpyqt1j9qeLNhOAQnrbyaHjLxw7AipshFmefZ9DrRF6YG
         6rxtjnjMiDRlU8AfZfWTOky0+v83lQNO/1zx4SzmXpgT/pAt7AdVJIQvvBrEzn4neFk4
         liNQ==
X-Gm-Message-State: ANhLgQ2CJHdmLQc9V2bVCISm4g3+7mMD7t1EElJ/qMpEuPPf8B/KpmYl
        UDBjYR5qd1JF9c197nF0aaJO3BdB2Uo=
X-Google-Smtp-Source: ADFU+vs3TmRsg7cI5A0Y5yxhnvJ0uXk7VL3dYV8q6UE2xtOydnhuEG+EMGk3aRJ9qhsQVfZyERQ/Ww==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr19071339wrp.249.1584108992201;
        Fri, 13 Mar 2020 07:16:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id l83sm17561422wmf.43.2020.03.13.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:16:31 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4/4] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Fri, 13 Mar 2020 10:15:45 -0400
Message-Id: <20200313141545.31943-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313141545.31943-1-alcooperx@gmail.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the build system changes needed to get the Broadcom STB XHCI,
EHCI and OHCI functionality working. The OHCI support does not
require anything unique to Broadcom so the standard ohci-platform
driver is being used. The link order for XHCI was changed in the
Makefile because of the way STB XHCI, EHCI and OHCI controllers
share a port which requires that the XHCI driver be initialized
first. Also update MAINTAINERS.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS               |  9 +++++++++
 drivers/usb/host/Kconfig  | 20 ++++++++++++++++++++
 drivers/usb/host/Makefile | 20 ++++++++++++++------
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6fbdf354d34..71bf287941c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3433,6 +3433,15 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-brcmstb.c
 F:	Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
 
+BROADCOM BRCMSTB USB XHCI and EHCI DRIVERS
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	drivers/usb/host/ehci-brcm.*
+F:	drivers/usb/host/xhci-brcm.*
+F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 55bdfdf11e4c..bc582ab6c5c8 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -97,6 +97,26 @@ config USB_XHCI_TEGRA
 
 endif # USB_XHCI_HCD
 
+config USB_EHCI_BRCMSTB
+       tristate
+
+config USB_XHCI_BRCMSTB
+       tristate
+
+config USB_BRCMSTB
+	tristate "Broadcom STB USB support"
+	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
+	select USB_EHCI_BRCMSTB if USB_EHCI_HCD
+	select USB_XHCI_BRCMSTB if USB_XHCI_HCD
+	select USB_XHCI_PLATFORM if USB_XHCI_HCD
+	help
+	  Say Y to enable support for XHCI, EHCI and OHCI host controllers
+	  found in Broadcom STB SoC's.
+
+	  Disabling this will keep the controllers and corresponding
+	  PHYs powered down.
+
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
 	depends on HAS_DMA && HAS_IOMEM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index b191361257cc..2a9a16047684 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -31,12 +31,25 @@ ifneq ($(CONFIG_USB_XHCI_RCAR), )
 	xhci-plat-hcd-y		+= xhci-rcar.o
 endif
 
+ifneq ($(CONFIG_USB_XHCI_BRCMSTB), )
+	xhci-plat-hcd-y		+= xhci-brcm.o
+endif
+
 ifneq ($(CONFIG_DEBUG_FS),)
 	xhci-hcd-y		+= xhci-debugfs.o
 endif
 
 obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
 
+# NOTE: BRCMSTB systems require that xhci driver be linked before the
+# ehci/ohci drivers.
+obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
+obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
+obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
+obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
+obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
+obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
+
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_EHCI_PCI)	+= ehci-pci.o
 obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)	+= ehci-platform.o
@@ -49,6 +62,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= ehci-tegra.o
+obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
@@ -69,12 +83,6 @@ obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
-obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
-obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
-obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
-obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
-obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk.o
-obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
 obj-$(CONFIG_USB_SL811_HCD)	+= sl811-hcd.o
 obj-$(CONFIG_USB_SL811_CS)	+= sl811_cs.o
 obj-$(CONFIG_USB_U132_HCD)	+= u132-hcd.o
-- 
2.17.1

