Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F5C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38F1206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMl1qQxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgELPAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgELPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:00:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A5C061A0E;
        Tue, 12 May 2020 08:00:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id a4so6282357pgc.0;
        Tue, 12 May 2020 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=egDbjx4i60tyIfoIHmSfvSBTjfuuqWNL6ee0lZwkILc=;
        b=PMl1qQxeEnhdr/kREhxZbZyPQ2+BhVcWjm5ULZhmWkaGCPBAXZOArhoywlxejNa5Yg
         ruqK5/7qeyrpFT8/x5ES6pe599we/sa3YHFdgW/BkJv/8lLJ6Q+XRM1WZvv/gETT8XyW
         nPGBO/sfTvhqkJ7etdQxmD06TdO+1joUev19ITT+wnJtB2+9CBvyV7416J7672WDL98p
         qp9yYkTr991febl9AeRS/x7xg1h+SgmvN98eraOFMNvh3IXl3Jfd4vhsnoarK5A39S9c
         vkfQGlIHLzte2CCObs4kblPw7iJs1v4NYpgpDF3zeKXdLGgPZQryVEFGr0PoY+++JZeQ
         O1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=egDbjx4i60tyIfoIHmSfvSBTjfuuqWNL6ee0lZwkILc=;
        b=D0rPytaw7u9GQITkPNV2eZuZXTIV21InjYuTH/1HTtZHWxF+AwdElT156JGaf9a1te
         orn70ZrQx0holUPSOqKkw8qOGPvRRQZ4YFw6hhyOntCL+1AKmsSE/taY7K3uemZ+xJMb
         TbPCltODW20yS+p66b2Dl4NRtnAB/+Pz9m3VGmIMoJn2kjObflJEsmsrjoURJbVr8p5J
         dcdK+EksmFgfWPFoXdEsMyCxU4eEW3yr4FzH8a/O1jQjAnSN97hhF55nIY75RdQtRGbn
         zB4epIqE9VtIR2qAdXwxBRk3YjpUxerjVDd7qgHhJ/7tqDhAQcs82vNomh63+5pfemVi
         Og5A==
X-Gm-Message-State: AGi0PuYbZBUK4W8AnVDJchTTxWsBtlkuqZ6dCcT8s5r7VsVDwhn6WeHN
        ekjvRStKP3FB/ZrmvBqkLcdqqvFs
X-Google-Smtp-Source: APiQypK5dlg1pDS0+4MtpadRcmmKuZfSQ7H8VkcJ/zHZL6tXfygQDTn71w2+3cRlfwV+6RVwR+2kyg==
X-Received: by 2002:a62:1415:: with SMTP id 21mr21061030pfu.203.1589295649709;
        Tue, 12 May 2020 08:00:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c2sm8359779pgj.93.2020.05.12.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:49 -0700 (PDT)
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
Subject: [PATCH v10 5/5] usb: host: Add ability to build new Broadcom STB USB drivers
Date:   Tue, 12 May 2020 11:00:19 -0400
Message-Id: <20200512150019.25903-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512150019.25903-1-alcooperx@gmail.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
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

