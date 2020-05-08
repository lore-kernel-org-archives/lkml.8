Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4ABC54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8984A24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFtOvUkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgEHVUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:20:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E3C061A0C;
        Fri,  8 May 2020 14:20:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so11641788wmj.3;
        Fri, 08 May 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dq0TqQky1nAFrd/UmJjerH5DUbLlLnhiDz64ca0nS+c=;
        b=BFtOvUkb9cbuzMMRhdzBNK5ecXEQM9byzqclZfaTmo8jWlWrx6L9He1mdy+Oicdpmy
         C2wpLwR4YwShUVE2tDjxEsNxw630unsx/V7Exl68ovCKx9bcttuUXdQBMSPxKR1Vga8c
         TJuy7qafu2UeYOspf+o/58evciXpbWP25FqkIrxTxxyi9gQd78GAwY09T5hnNTsqitOx
         F5WTxRrtCJBTA1CRuJAdxmfq0tMEd9fRF7wDNrop93QCpEtTGvkE+WNVbecX5icnEnlP
         tU9o50N90gD97YxKR08fEFe6vAXu90Agi8XRvmqx/s/75UxkNXQM0DUBJygnNdQE9GDg
         dPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dq0TqQky1nAFrd/UmJjerH5DUbLlLnhiDz64ca0nS+c=;
        b=CrZVpPkbJLzjnBDX0Js4D/aVBzZdHcvP0EqWfwo5W5flgDCr3zXzLt3rqoe2aMcsIX
         wYQbbU3MN5P0Kq/IANNxBTeXAHIv5Kcf7/sp0+03bDm2Q1JOniS8HQOKtpKLAU4DAuRm
         TvR41uKcOEK5KEIEom1fCoNKRQluryhF4QtOc2W753jl9jta65+GZJ7bPGFwwEFLMV6o
         OioIcac3F4GSpWgU8AcZNFSobsxXaIMosx2w9LG2RDuvfp/7qFQUxmXT4VTFM3M111kn
         fbpUUVv9wI61aa1cgwu0NNuIhasTloLw6ghiH5PGLwi5h51Ft/OH+bOKfjK0dyiZabyl
         FqIg==
X-Gm-Message-State: AGi0Pub+CXAiNUHz9GgiFtRfp2KxR2Px4BBnyTibIbv/BWH7uaRq7e0G
        wWO3JFyP8h8z75wXUg/FMVbl76tQqdQ=
X-Google-Smtp-Source: APiQypKJ+gnuUbus38CVokjh5igSLze560rfF4SF8l36zNto5ZlMR2hFAWskJxCoVQ8iCXxb1AiSSQ==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr17145297wmn.81.1588972799227;
        Fri, 08 May 2020 14:19:59 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n9sm4669705wrv.43.2020.05.08.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:19:58 -0700 (PDT)
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
Subject: [PATCH v8 1/5] usb: xhci: Change the XHCI link order in the Makefile
Date:   Fri,  8 May 2020 17:19:25 -0400
Message-Id: <20200508211929.39020-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508211929.39020-1-alcooperx@gmail.com>
References: <20200508211929.39020-1-alcooperx@gmail.com>
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

