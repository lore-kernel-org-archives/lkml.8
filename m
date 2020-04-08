Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE66C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977DB20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhkOjge1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgDHSO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:14:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51040 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgDHSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:14:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id x25so428479wmc.0;
        Wed, 08 Apr 2020 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tx9SuZa4528oyKjVq2QW+3pFwATH8j8hfUgow6U+cVs=;
        b=dhkOjge1FOcNsiNiZF2yeHjcKsn4vGpV93bOHiT/h3SjgPdPSzjSjrD54wPMXx2E6h
         te9kAcvQiAdjBV53ViIchEPlDwIGqJmJSQ3fH5ydAeCWSqo5egqg64phJEbq4HFAv2be
         39JuQ9ZS0f92uL1tnV7DMN217ElC1G5cauToJ16nIh2mpuF1ych9lkgHB5SXnaNnVLIJ
         wD1nDLpcGG43drwcmelbnS1aD6q4Fb1V3G8WBdp3XP9EEnKJICIaFFy57xzJQbcA3bLU
         Mn6HHoN5FZCA5DJUtzXGVSQ9sU74pQvH1nn8z7tgixjN8KVf2Fvho/p0FNKAkMnKaKJm
         AVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tx9SuZa4528oyKjVq2QW+3pFwATH8j8hfUgow6U+cVs=;
        b=SBpdB/DCOJ3tLOFMFitoQ+ez1OH4yO1uUwwMsmEawiJRfj99SkULJhcJXhEJiznrcz
         8Z9Rg8h+kpBFAHEmB1mr79+ks0MXcfeK/nSEe227cWDR6FngHaaAlyUzWNj6HuDNMviE
         9m8nKikuSsHb6E7raLgFN5ypauISzvwNLptGnd4VjGDcawfPxW37y/h88MvBnS9VwDJP
         a7b9DFD8+33wxhSS+/DqN7ZemPrYW0ux2X0hjBvakra09VtHYziVcMGezZ1xgsDNCu6I
         UYNI90M/Pc8I74BGhWbZA3Rf3+QF6gnl0x97nvqdcWgwUtO6CKV/RZNw2SVxYmxVQze+
         aTyQ==
X-Gm-Message-State: AGi0PuYrBt8yRdjzp7MpxqlW5PR7mMsTK4QLmUBtKZsNRyBkOoDRl3jK
        Bcc5c0jKJ0xIAgdrmcS9Lism7ZSeD70=
X-Google-Smtp-Source: APiQypJ+5IcVPxKY76g09B/HutFLGxlHrHOTeMAmfTQAHNbQddhk2Nx6W7SDc63sGFl/ijyZphTz4A==
X-Received: by 2002:a1c:1f96:: with SMTP id f144mr5660370wmf.114.1586369689891;
        Wed, 08 Apr 2020 11:14:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n124sm441700wma.11.2020.04.08.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:14:49 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/4] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Wed,  8 Apr 2020 14:14:06 -0400
Message-Id: <20200408181406.40389-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408181406.40389-1-alcooperx@gmail.com>
References: <20200408181406.40389-1-alcooperx@gmail.com>
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
 MAINTAINERS               |  8 ++++++++
 drivers/usb/host/Kconfig  | 16 ++++++++++++++++
 drivers/usb/host/Makefile | 16 ++++++++++------
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 534a8dc4f84a..f6e8ebc8ccfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3477,6 +3477,14 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-brcmstb.c
 F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
 
+BROADCOM BRCMSTB USB EHCI DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	drivers/usb/host/ehci-brcm.*
+F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 55bdfdf11e4c..7d58fd66e412 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -97,6 +97,22 @@ config USB_XHCI_TEGRA
 
 endif # USB_XHCI_HCD
 
+config USB_EHCI_BRCMSTB
+       tristate
+
+config USB_BRCMSTB
+	tristate "Broadcom STB USB support"
+	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
+	select USB_EHCI_BRCMSTB if USB_EHCI_HCD
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
index b191361257cc..85fa6ace552a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -37,6 +37,15 @@ endif
 
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
@@ -49,6 +58,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= ehci-tegra.o
+obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
@@ -69,12 +79,6 @@ obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
 
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

