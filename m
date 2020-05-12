Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D89EC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6D206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ9H2eVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgELPAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:00:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F8C061A0C;
        Tue, 12 May 2020 08:00:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so5486889pll.9;
        Tue, 12 May 2020 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VGLGSTcVeBfvS+Xc677uifViDuw5g0GT7tsHPQPjttc=;
        b=IJ9H2eVuU84NMXD4CyvIoc6owHhQmsSaPlKl992UWfp0tMGpIC3djlIdJaFIz4iXwi
         PQYKPF51TWF/8pY0AQYUMzhcg/sdxu6K2KORfpmO6NX7MwdkasgemrArk11tTa/ApE3g
         vgQ/UlK1SnREpjm9AU5lBPsALjJakDjJodcJi0veiaqVDkaKRZQbZSkbtxsa0OP+EeeM
         niVY19TdLl8d4eGgaLLTWdmOwv3LnJbUwV5mAGNMOMf76bF4W/51aXqvC5LuiYiCJ/u5
         Eebt4vlE2WBb61lCGFtxym604edWYz1z+0Zntky69YpqgBT3G2235aUY3VpOhm/5Ukb3
         3TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VGLGSTcVeBfvS+Xc677uifViDuw5g0GT7tsHPQPjttc=;
        b=FN5VpwnwJ6qTdBpf81TnSxabsTvoFh4U/+g9C0se2XHIcH2qkYJXsh/8rwmv4PXQj9
         5EUkavSk7RWMVSuGTvmHRc0YD8io//YgNr89JltXRFxCy6ihaRxBY/8HmLYUD+jvl2jP
         zwnFrl8ADYKRTVLB7p08gyFn77KvsZeQqGv3B5/O+6ofOcrjsiurY1AhKhhDrebDH4Ei
         7jn0ojH2CZv+QFh/1TLvJUbxFuQfOq4fBXecmfxbbTrF13dI6lrMQ05QRZ6hipK+ql42
         0CU9yAPT8MfuDFV+aRcnG60czNdfRiqD30kX9Wb3jxqrarpC2E9JwpySFg3r5i1ysC5F
         AReg==
X-Gm-Message-State: AGi0PuZABKMGQ9KA/oUxZB+luSumSFLWQx6kRb0ZWy5Owe73PTqxxjJo
        m3iLufASVkOSBv7N+fKnZX9xmw4bnr0=
X-Google-Smtp-Source: APiQypIJjeyHdHpiwG+qHKfYSDOn/QCTXWSDO6Fj0NctMoV9b4jaJNvOzuh/NAYaxIW1Kkt4kKtpDw==
X-Received: by 2002:a17:90a:e38c:: with SMTP id b12mr30629444pjz.102.1589295641575;
        Tue, 12 May 2020 08:00:41 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c2sm8359779pgj.93.2020.05.12.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:40 -0700 (PDT)
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
Subject: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the Makefile
Date:   Tue, 12 May 2020 11:00:15 -0400
Message-Id: <20200512150019.25903-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512150019.25903-1-alcooperx@gmail.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
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

