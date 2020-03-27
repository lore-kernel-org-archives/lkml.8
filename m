Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B8DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85DC206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf4eu+nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgC0Urt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:47:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgC0Urs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:47:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so13188956wrn.2;
        Fri, 27 Mar 2020 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SZQxM/8L6c14zoyYaEljetpWBvkbLkTTHBa0hQabWQ=;
        b=Uf4eu+nrSqCVBqkyDz5hqbUadokH8pm41sABl6/bCS/Rws83z8zKiYkdl98bb1+yMY
         dSZs8JQ5h+uHXcL8XqhKf+IFmyaLKuOoRr/9qcKkLwayCj9wNdnA1u+vjlyCe0Tkl41A
         /fe44A1HyIprnMUyQg/mcQ6u7Yvbq7+syPyb+k2eH9xcJxhLoqeZeuyTjZIv0okuOLHf
         S9c92m2WI60M1BnjzuqpV1J+H3dwzmeKQQM7YqRpxWecwj87Bh0ULgQ+NtzJvVc3AMe6
         iAY9JU+vBTPyl0sD4hVByxjCuqPAggXFzMla94k/e+Lk/ht9YhE+LEGWfWuF2UsYEndv
         4+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SZQxM/8L6c14zoyYaEljetpWBvkbLkTTHBa0hQabWQ=;
        b=Rs/0CiBVU4x7InFR9OVZuF5NHyBe9CiCbBuE6ZRiwmBuQ+ok/L6kd+tS3P9uhrdBMu
         I7TOsI1JYU1B6ZEewxT0VkonJhCtoWQGeM3ieEm8xOR6DNnc7HEgmoj7PM9o64GgUS9K
         VV0UT81G0BsQccmijNiousqm5wb0cd7jJjDEiD0ck0NFpIGFZ0HAWfWnw3fGlY0E2NVr
         gNDgcptxT5QtarLq1RsCrsXNE+8KmwwwH7tAIXVz4mHYozU/oZOXvxfLFTH/NwvVjVbI
         6HNKcHyCJtwckdL2xVjlL+HdHtNnsZiWp8U8exeVm0p5+lPIQJawfWSZioebPW1XQRNK
         8ypA==
X-Gm-Message-State: ANhLgQ2BxmVDlJR8J6D4AZKKrbSyzF17aNpxb5MC1zzl0WgicYimLchc
        r0GFMkeShigIw+sLlw0NiLIqt0z2Ubg=
X-Google-Smtp-Source: ADFU+vv7mUndEx8pk9XXf3SsKPRjuoIW+7G7Le9nof9v6N4LhN+OHhh+2itRNEshTI3wYieLcdG+rg==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr1365091wrc.120.1585342064342;
        Fri, 27 Mar 2020 13:47:44 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z129sm9661450wmb.7.2020.03.27.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 13:47:43 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 4/4] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Fri, 27 Mar 2020 16:47:11 -0400
Message-Id: <20200327204711.10614-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327204711.10614-1-alcooperx@gmail.com>
References: <20200327204711.10614-1-alcooperx@gmail.com>
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
index 5a5332b3591d..978f3a574f64 100644
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

