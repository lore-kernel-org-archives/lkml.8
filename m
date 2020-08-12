Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA779C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8604D206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoCPqFd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHLUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:21:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FDC061383;
        Wed, 12 Aug 2020 13:20:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m71so1597404pfd.1;
        Wed, 12 Aug 2020 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZlYqHVX3AGBBK6l8zlqS+306syUnx3hCohlnRD0iMkM=;
        b=VoCPqFd+gsMxkaXdfyJpRc+EGaq7h9IdHKHP0UqWqYRVaj2o8TbQLuOd9xfTfR2owP
         5IkYrInzMX6pXYMsBVviiI+fTrOsUvGGhACeEFZaoiwPB8tnp9NWEq/5NsSHG8CMTtEe
         VVg/xILtjqdLbYXzEpjvawEHEQb/Ra/tLmhPvOamu7THENoobjlOvW2a43IKlsooY3Y7
         IMyVBJ2kgYA3IvaH90Oygg100mq03hdWfdOYdxe/DXQXN0xnSlDVVvDcMncgzONGi7jo
         rVc9eFvB+iioePiYMLOTXit6GSCr07dYX4WpUTifNOrp7xNsMMWkP09N4hfH0eHv33+W
         9n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZlYqHVX3AGBBK6l8zlqS+306syUnx3hCohlnRD0iMkM=;
        b=jGAAJYn1kNOhqrzxd4ZQgk2PANAruR4eZts12WuHsbcI70ZfD44AItW2gKQbh4fOIM
         tN4G/XjF+KpOktKwCzhNTelePvlD/fBkSVc7gIcyg4f5NbD4pt2IVxs3F/10W+eI1bwO
         b/Q2L3mGAXmji1MTq+xmeZWdMyRbtGRLq6dGWa3dVqkp0F63G00+kR5lbXoF9RRuNxyL
         zyip6fF5d4/KwsCS9fA7AI4EaWuTHamGJH1G7XAp+/6gWvxhasZNqH3rc6fgBzgoEMVc
         WoM39spfsclcusL1sb0rD/u0vsXU7ffwO730Ws1hZ8KJr5mArbIPKouLzqSEfJuSInlT
         DL9w==
X-Gm-Message-State: AOAM530RJlIOm0ATpFPy9S6dyPLLeiCkRdj3YKJ9ZvTez+dKx7jTHhcM
        Oc9HuFeC5FFRkPk+qgkU96yPa9Ap
X-Google-Smtp-Source: ABdhPJxsfwcRaPxZjqTkOGUv/RiRbejbFGQa6SjbnNeOG9mjx+3XSgYAZ/9yDtcr1D/1pubSFz7z8w==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr1057102pfa.295.1597263658793;
        Wed, 12 Aug 2020 13:20:58 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 75sm3292999pfx.187.2020.08.12.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:20:58 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <al.cooper@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/3] usb: Add Kconfig and Makefile changes to build brcmstb-usb-pinmap
Date:   Wed, 12 Aug 2020 16:20:18 -0400
Message-Id: <20200812202018.49046-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812202018.49046-1-alcooperx@gmail.com>
References: <20200812202018.49046-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <al.cooper@broadcom.com>

Add Kconfig and Makefile changes to build brcmstb-usb-pinmap and
update MAINTAINERS for the new driver.

refs #SWLINUX-5537

Signed-off-by: Al Cooper <al.cooper@broadcom.com>
---
 MAINTAINERS               | 8 ++++++++
 drivers/usb/host/Kconfig  | 4 ++++
 drivers/usb/host/Makefile | 1 +
 3 files changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..3a44ac61899b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3527,6 +3527,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 F:	drivers/usb/host/ehci-brcm.*
 
+BROADCOM BRCMSTB USB PIN MAP DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/brcm,usb-pinmap.yaml
+F:	drivers/usb/host/brcmstb-usb-pinmap.c
+
 BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
 M:	Al Cooper <alcooperx@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1cb3004ea7b2..9c285053bb0c 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -109,12 +109,16 @@ endif # USB_XHCI_HCD
 config USB_EHCI_BRCMSTB
        tristate
 
+config BRCM_USB_PINMAP
+       tristate
+
 config USB_BRCMSTB
 	tristate "Broadcom STB USB support"
 	depends on (ARCH_BRCMSTB && PHY_BRCM_USB) || COMPILE_TEST
 	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
 	select USB_EHCI_BRCMSTB if USB_EHCI_HCD
 	select USB_XHCI_PLATFORM if USB_XHCI_HCD
+	select BRCM_USB_PINMAP
 	help
 	  Enables support for XHCI, EHCI and OHCI host controllers
 	  found in Broadcom STB SoC's.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index bc731332fed9..0e63ef94790d 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -90,3 +90,4 @@ obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
 obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
+obj-$(CONFIG_BRCM_USB_PINMAP)	+= brcmstb-usb-pinmap.o
-- 
2.17.1

