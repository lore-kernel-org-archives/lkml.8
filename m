Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1875C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9534C20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIEV1848"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgEKThT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731586AbgEKThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AF5C061A0C;
        Mon, 11 May 2020 12:37:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so12453960wrn.6;
        Mon, 11 May 2020 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=egDbjx4i60tyIfoIHmSfvSBTjfuuqWNL6ee0lZwkILc=;
        b=MIEV1848iC9ubENv8qw7uFDtYPjAp4xEX8AIjia7hbAdIfW9dP/og8bobYOS1DegI6
         U16ZgG1T3zJ8uBAGVwjyUghKbrmjaBkzRbkzj7YW+Sewtm/l8Ft40Lr8bHHZ+2m2Q20P
         rwixhZlo/Q1XhdaLawYWvkG0IlG6mDjBMgOhJATDv7T624Axf5pGXDpF63CJR+7wROfy
         TK9e1cUYPg53DgRIIMKj2IqZ6lQVOkrvsI6smWplgZvewLKDy4nMWxNiKltUJopht1B8
         nT9KEBpsxuai8+eiWc4HQw2aexU0usz2ybUspRcurOB6+jJYlsJpsEQfUgViG313bMqY
         HJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=egDbjx4i60tyIfoIHmSfvSBTjfuuqWNL6ee0lZwkILc=;
        b=Rt81RBjBAvwx26IiXLpBV632fB0Sef8ctQKwEqM6nzIHAas0GhLB1YDlfWBhq1wXux
         mzVdnAvnC1ayOJnKNSjDSUwsn6So2SpragWOCS9R4U4A6DC3eRLYfF1a4eK7Zks7Y2kn
         UsN6RpFFBjvWPwt/P8ntM1wjwEJjMiWVuPbzoeD1hK1nHGwVonR3Kj/Ec90vGnGFP+Yi
         zmc+PKRdFgXH1XTmHDhD8vkE1pYe5ZMw8hHkI2QjG2jkqq3j1c5W2ZiTfd2rA8wQFDEG
         hD8zRv4BXsc881lgxk745WYlxUk4SFwRFEE+/tbLtRpefxI3mACYJ+FhZb9jhIMzs8ea
         Tk9w==
X-Gm-Message-State: AGi0PuY6e7xJ3ng/mxAjx2GQ+KbqAUHqeWX6HKmlVp1saPVtH0Jy57Hs
        UBfjQDPFUIBNLza96ejZ2WLsFtdNdp4=
X-Google-Smtp-Source: APiQypL1kt5hwbojUcSXit65ybe12pN3tCBWV5mjBE4EdaEWWQ9/NBZUmh2fxa2DxPGG+8Iq1x/Obg==
X-Received: by 2002:adf:afd6:: with SMTP id y22mr20368179wrd.417.1589225833975;
        Mon, 11 May 2020 12:37:13 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o203sm11529030wme.12.2020.05.11.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:13 -0700 (PDT)
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
Subject: [PATCH v9 5/5] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Mon, 11 May 2020 15:36:43 -0400
Message-Id: <20200511193643.30926-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511193643.30926-1-alcooperx@gmail.com>
References: <20200511193643.30926-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the build system changes needed to get the Broadcom STB XHCI,
EHCI and OHCI functionality working. The OHCI support does not
require anything unique to Broadcom so the standard ohci-platform
driver is being used. Also update MAINTAINERS.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS               |  8 ++++++++
 drivers/usb/host/Kconfig  | 20 ++++++++++++++++++++
 drivers/usb/host/Makefile |  1 +
 3 files changed, 29 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091ec22c1a23..e5e44b595bc4 100644
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

