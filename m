Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12211C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF72E208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8iStKx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgD2Rbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbgD2Rbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:31:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB1C03C1AE;
        Wed, 29 Apr 2020 10:31:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so2944923wmh.0;
        Wed, 29 Apr 2020 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lpRZMrHTzTW8z6tlIKgNxL8ccVzt5z7E+tVpzahVStY=;
        b=g8iStKx7j3a48hQ9diCtkrfWscJCCjYi7R66T+6R1drJJReIC6vDifbT2xfmsQ2KV0
         aVGYa6wkdwF4YvznqekDAvkGExxvQ31gzgiaQ2HLsBPuNTY0xzu2x502zVSTB/xgmtG7
         YbqioJ510L4TNH/ZM8bK8O+gjwvDp/xCDSPt0PkbadtJKu3brwPlSD9ReyOx8AXzbitg
         TUkbFF7ps0QaiGzGmrGTxCz+f8SE/Lzo8DqCxDDPWMVYdU61aNZfFRlkODzjtAzqG2Je
         OJo2MdQz01EceTYw1uC5twm15UOqQWXuAkNohFwRwZLf5AIN6CioZFwr+OTAf+BNTiJa
         h25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lpRZMrHTzTW8z6tlIKgNxL8ccVzt5z7E+tVpzahVStY=;
        b=YvsDZ+P73StGYsae1CJG8etUXdhG9vF0zCK2kJRUa/bkRT6T3lGgvsq+4o1W9EOxJZ
         ilxOUwW9AjQc88en7ssr0lcNwxjPPscJP4N6/QDnaIvg+IqrS2Gjc1pQ2V+Zi+lWpBRh
         FWZDA5FC7Jk2ldem9dE2fyJJZ9KajAETlXVLZkwi/Vb/oqcrpYYFRtLygu7KQShfPGUu
         lwJ9HfcHhk1U20IdOikCwLpG9omb5pGP+l7GC7HdmZnIHHiY8mfhHPu/DD+8+upKMXD4
         ZL/ET+yinAnVkjAR2A+4buAk0rLnTNLmyxM1Mm0ylo6wwt1rlK2/k+MEnPykR9itJqfm
         TEdA==
X-Gm-Message-State: AGi0Pua2gSvWfKkykqzoaKhChCtQdV3tFL8hI7JuIsWVPRFSk8ciTPKA
        iA76BDI+DaeficWvSaFjLhKw404K/uY=
X-Google-Smtp-Source: APiQypLH8sXqeobIc6UxTjqBMumvmLNAP3xqvcVTHT/bEOZ1FL08GJZzVtJ+rSFwNZ/4eU4l+oaZxA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr4300005wmc.76.1588181501178;
        Wed, 29 Apr 2020 10:31:41 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j11sm31177182wrr.62.2020.04.29.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:31:40 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/4] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Wed, 29 Apr 2020 13:31:12 -0400
Message-Id: <20200429173112.38366-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429173112.38366-1-alcooperx@gmail.com>
References: <20200429173112.38366-1-alcooperx@gmail.com>
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
index 26f281d9f32a..6147ed78d212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3481,6 +3481,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
 F:	drivers/i2c/busses/i2c-brcmstb.c
 
+BROADCOM BRCMSTB USB EHCI DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
+F:	drivers/usb/host/ehci-brcm.*
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

