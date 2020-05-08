Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A3420A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnAVIHm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEHVUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgEHVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6BC061A0C;
        Fri,  8 May 2020 14:20:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so3544596wrt.9;
        Fri, 08 May 2020 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPpfdrDWyIyJoF1ulwtJ3Qw81WLSoebaZdFuuGZoDek=;
        b=OnAVIHm0tfjIc2NibvMhJwLGl2CL40M3yxtSeUuzYhavYsy87/kPDPXF4y/UIcR3Nz
         /G13c0MgHhdkrpgPqXpchbCcYG2J4L2iJlaqsSldny2oCX2NjeUufnZRbdOkPj69ls1H
         c3fhBHRH/CV3d64GynddHyZygq8loDBU1/yNC5ostKqkOBdjdBhYvkZOjAHRQEB4xS2o
         T+wfhh7knyeVHsKiYFM6jjlJ+EqChpE4GcR7M3BWG4dBrIfVUXi0RzNoCBPi/rOiDTYj
         L7KA4Roa5VSdyz0UbU+Y54ZcJxCxaTsl32+jBQGdLnzkliC/8LrQTtYFSb/8/WGbihgR
         mNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPpfdrDWyIyJoF1ulwtJ3Qw81WLSoebaZdFuuGZoDek=;
        b=mueeeN150aWvAUd0gFEySHdnU/auCZWAo6Hzn2sJEYmHz9tQ2ps47NlQLoBOEnWZf0
         9DGP8+rHMI52nuETd1xT+VbCFYeU3UG1ktTwcsY7y4JWjC7+nSxdX/wqY9BEuFv9OOin
         pIBpts5/TGAQa0wMA996u8/tlFMMWJVmj3dtAa3iFO+pkqweEnl29EzVmikA87sybHLt
         xMmEQtKldzYqQ8CBvp4YdeEIWeldJvooGwsWUmdSlR4E+hLt2OhqG/GAK5rYw3c7wlXe
         cTBBznd0/eUNnNrHLuWWTxQdpcyLEI5DUk2GNZJmYF9NEdwbhyvroupNgL51+8wMYOMc
         6Huw==
X-Gm-Message-State: AGi0PubLU+o/RhvAi+F96Tg7KQg6LIDpnUPsPzNZndwVc8Wz+THUytHL
        TiJjp/M2Mho6xgnT98QwexGOkBX0wZ0=
X-Google-Smtp-Source: APiQypKbsNs1EGz2yStUD4V1y76G1Omvs2yge9aFnapbHsI3Mw9hhhSdpUGSwXKYyotjxPwcNjlLJQ==
X-Received: by 2002:adf:f487:: with SMTP id l7mr4358463wro.381.1588972809267;
        Fri, 08 May 2020 14:20:09 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n9sm4669705wrv.43.2020.05.08.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:20:08 -0700 (PDT)
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
Subject: [PATCH v8 5/5] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Fri,  8 May 2020 17:19:29 -0400
Message-Id: <20200508211929.39020-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508211929.39020-1-alcooperx@gmail.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
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

