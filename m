Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A8C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509C320735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMObaJ9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEGRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgEGRed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:34:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA2C05BD43;
        Thu,  7 May 2020 10:34:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l25so3116560pgc.5;
        Thu, 07 May 2020 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dq0TqQky1nAFrd/UmJjerH5DUbLlLnhiDz64ca0nS+c=;
        b=hMObaJ9HVlxG4n50o2vuRSuTVFtvgZLe+ePsZg7M8zjQkrYrF+8G8f/nYRGdUE9FTF
         dxwSJBgOTxtx6eUlgXDFnsYLjyDMxu7miTpRn+Bv1wUIenabI2pBkbuRPWXXrSs4+rgy
         wxVQVr5yWk6hdXQvB8AnN+KSskiLZv6jYBC3/S/TwWeFxEeeqo+KB/ao2w9GtrXy4wgM
         YGaPADwdAy7TEYuAJ/L8nVY1yuOysSUPKdYItmwWFCs1b+mlgAGdCM36BA8xoBRhN9QM
         OOBlXg346uqzRvvs+sRFhfk8FhDsz33ZLuU+8N7R9YwViHN+EADi8Uwo4WRv5mwmzW7l
         5bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dq0TqQky1nAFrd/UmJjerH5DUbLlLnhiDz64ca0nS+c=;
        b=LfQWD6WiNz/wTUD28fWjoCClUKd5xnIcq8V78pYAavweuN6rq7I4wWW3cFzZVCnKxk
         BuWqXGv5cxrY7SMCIWq/SZE5BhvwZboFN20V9oOlgqRDw2D1PUTyJnVhuARkLX7AVYdR
         fqHXyABzH7xUHlwqicsFb+1Qcn/8+y5uXORFroV6SzdT3gc6J32/H0RQjALRCH2xoZd2
         dqAXMHJALiaSw5pQtf+QC4EPRHxxL0E2n/xvdZCakuTo6abgfkV60A0/b4uaa1/73Jg1
         xB9JcQeVqQrRbOODrtfvJ4fQHT8zWik1Yobc9sQcIdSpEGPgQfbkmNCWRDd+eF+t2jEY
         Klxw==
X-Gm-Message-State: AGi0Pua3IKl6WMPjWrdUHFM98AngX6geTMXHyCPc3LTXr0pxYt1irobO
        EdXcuTaHXXRjgkWL8sczHY/T+cKuUpk=
X-Google-Smtp-Source: APiQypIV3Zm1S08mHH3bE+Xr9aHuLn6KCNX2TslhsTuRJ25Q+UiXwN6CeT1GXiSTkb1EwjNl93DdTw==
X-Received: by 2002:a63:b51b:: with SMTP id y27mr11346880pge.400.1588872871533;
        Thu, 07 May 2020 10:34:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y14sm5368802pff.205.2020.05.07.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:34:31 -0700 (PDT)
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
Subject: [PATCH v7 1/5] usb: xhci: Change the XHCI link order in the Makefile
Date:   Thu,  7 May 2020 13:34:04 -0400
Message-Id: <20200507173408.20754-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507173408.20754-1-alcooperx@gmail.com>
References: <20200507173408.20754-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
devices and OHCI handles <2.0 devices. Currently the Makefile
has XHCI linking at the bottom which will result in the XHIC driver
initalizing after the EHCI and OHCI drivers and any installed 3.0
device will be seen as a 2.0 device. Moving the XHCI linking
above the EHCI and OHCI linking fixes the issue.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/Makefile | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index b191361257cc..a7f0b8ff7179 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -37,6 +37,16 @@ endif
 
 obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
 
+# NOTE: BRCMSTB systems require that xhci driver be linked before the
+# ehci/ohci drivers because they share a port and need the XHCI driver
+# to come up first to properly enumerate 3.0 devices.
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

