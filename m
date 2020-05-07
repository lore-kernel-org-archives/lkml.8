Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD0FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B2420735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+q+VPJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEGRep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728003AbgEGRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:34:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B44C05BD43;
        Thu,  7 May 2020 10:34:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 7so4062755pjo.0;
        Thu, 07 May 2020 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPpfdrDWyIyJoF1ulwtJ3Qw81WLSoebaZdFuuGZoDek=;
        b=l+q+VPJf0AqTmc1n+v80+kTMlTK2z8npyK82OZfZ/9x/TOF1BzCAl2PQ70xUHvMDpQ
         8uZIuUt3gx5UjJ7qVIm8vO368Zqk+LKpZqoQB9Lvz4Kjb+tgM9ViIsc48W+C39T6g4ye
         yfR+UH6TQzzTJTiafMhWOCfdcFHWXtjX8IVw39LgjLqJ2w6vHGwkrFUvyKbcO54wR1i9
         skBln5pPuZAApexgE7HfQX6k55kd/Lkt6fpeVcvNn7QrMnMY6ywQGRapZUiUuq49NqLj
         nfNAAEz+/tRjZPThHV+InM9L1e83fQ1c+adoLjoYfZuOtq80duRilt9LRoe8FvWihLDn
         tpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPpfdrDWyIyJoF1ulwtJ3Qw81WLSoebaZdFuuGZoDek=;
        b=UmWcC9Ol+wVuIgXFHAB3nAJQ2NESARJo0mDsmXrBEz4acZUdSDofEhjAV+T5aQzOsM
         MsLmCH/rLHRlhGpxsYj0BRW1KvjPrByslukbAgx8PO5+ZQVhqv25rrOGZZpnMrmxlHPc
         Kj3WxXAgmxAARCIBowMTvDLbsVn+wSWioQhbm4a1vN/qzjhBC+SFWxXS/HIpqWzlfiD0
         30F1ohHgFsiNQm6GDJrXS2c1+fSJJvDj9j71tT4AunlMEX0aAzxOggEzpESBeDJ7w0Xm
         J2kjQZ21zSnQfbHl11QGQq3pNUeXpp5P/yO62lw8j81ANeG4ZGG+9Wed0kIXRgDw3SlK
         oQpA==
X-Gm-Message-State: AGi0PuaUAbO99oEalIKUJBhDld29IS8QGgKnPRjyblwpxFh6d9I9eI57
        dwOy8vFzr0hFnqS1HzEGz6j8h5vlt88=
X-Google-Smtp-Source: APiQypL3czYk300rpBGKg2G+mjGxZ5lSkGhjC6H19yktBCHPl5NOAmYDW2y9mD2Ze8Q84xRxXPwWFQ==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr1307791pja.82.1588872879825;
        Thu, 07 May 2020 10:34:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y14sm5368802pff.205.2020.05.07.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:34:39 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v7 5/5] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Thu,  7 May 2020 13:34:08 -0400
Message-Id: <20200507173408.20754-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507173408.20754-1-alcooperx@gmail.com>
References: <20200507173408.20754-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the build system changes needed to get the Broadcom STB XHCI,
EHCI and OHCI functionality working. The OHCI support does not
require anything unique to Broadcom so the standard ohci-platform
driver is being used. Also update MAINTAINERS.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS               |  8 ++++++++
 drivers/usb/host/Kconfig  | 20 ++++++++++++++++++++
 drivers/usb/host/Makefile |  1 +
 3 files changed, 29 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..fb55300c2a84 100644
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
index 55bdfdf11e4c..973386bbb522 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -97,6 +97,26 @@ config USB_XHCI_TEGRA
 
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
+	  Enables support for XHCI, EHCI and OHCI host controllers
+	  found in Broadcom STB SoC's.
+
+	  To compile these drivers as modules, choose M here: the
+	  modules will be called ohci-platform.ko, ehci-brcm.ko and
+	  xhci-plat-hcd.ko
+
+	  Disabling this will keep the controllers and corresponding
+	  PHYs powered down.
+
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
 	depends on HAS_DMA && HAS_IOMEM
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a7f0b8ff7179..265e26cf9209 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_TEGRA)	+= ehci-tegra.o
+obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
-- 
2.17.1

