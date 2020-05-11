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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77905C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C00206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Kcij4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgEKThJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731200AbgEKThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3646C061A0C;
        Mon, 11 May 2020 12:37:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w19so5937412wmc.1;
        Mon, 11 May 2020 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VGLGSTcVeBfvS+Xc677uifViDuw5g0GT7tsHPQPjttc=;
        b=E8Kcij4dQAHO8VBx7noujUr90q2JRsOhfPjlKGCQEMrCpsRsILe5BHxxrfpHA+qD1C
         LRDVFrzBHOsK8wb2FeCvG97IJX7mtcljEVhw2PtLin6llGiDM5lLw/SaGWucJVXKBzdf
         HOgWAQZgQoMaIe/zbQ0/EtKodvTm057LC8ReEDwEwcb4hj57z4kVk4G+yd4xQ8nrewf7
         Y0Cnn9IOx10pfBbstP71SE/WUHpBwz0yQsKEeZPK++H0U182Oru3Pqw/Z9CBVop5c8jU
         OpZNccPw313pR740viCY2SOTs8/OQ/Qzh4EZKCHWXyq/9yzJoUVRKAW3YRMJZpzP93+O
         sUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VGLGSTcVeBfvS+Xc677uifViDuw5g0GT7tsHPQPjttc=;
        b=mqXsnSx+qFmNDKwRJHXnN3Ol9/Yg/gnvjK/l4tDCni+FfyrEbsvILtULa0R179PuPa
         PmkAiFcyi2oj22i3KPRRRMg2I+weL7yWPtSLEQYmgk88VH6O5L3Ft7eKO5Q6IMRzATC3
         Dm7haFebTE+RQO2R31+0wPOPNKP4nWQitMB1+vZWUqziVVjnnCeH5qO0PK1kJWGSVN+L
         LJZSGuO3U7Teff6fp5YfaHD+SajfFOoAYzi82F4biCD+Swac9ptbmSmw4S6X1e8cs0cl
         1Fn0jn31V5L0gmL8L1C1+Anar1HWwZ2+GUg60Pso+vCcqw3ThPXCQC8v/sK4rLuA5RI/
         StFA==
X-Gm-Message-State: AGi0PuaFHHW4f2iTHIKr3Ew4BXJi7Lv7uzPlJGXVdW61hJZI+andDtFq
        pH9VxxT4DGpdVGYs79jmqWe+yn0yWh0=
X-Google-Smtp-Source: APiQypJp0r8kyv9IKS5CxMCuiOU9txyPLDUGSNIgGqHQhv5ugqZgdvBOxFJLZsyLvpBRcQern3NbyQ==
X-Received: by 2002:a1c:4b16:: with SMTP id y22mr33132809wma.170.1589225824300;
        Mon, 11 May 2020 12:37:04 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o203sm11529030wme.12.2020.05.11.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:03 -0700 (PDT)
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
Subject: [PATCH v9 1/5] usb: xhci: Change the XHCI link order in the Makefile
Date:   Mon, 11 May 2020 15:36:39 -0400
Message-Id: <20200511193643.30926-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511193643.30926-1-alcooperx@gmail.com>
References: <20200511193643.30926-1-alcooperx@gmail.com>
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

