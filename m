Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF8C35246
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEC0214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efT6ccLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgAaWWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:22:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39985 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAaWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:22:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so4232987pgt.7;
        Fri, 31 Jan 2020 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i4A6iS3d4v/SDXbDNLzH3HRItLiF9tqu3vO4L3thEV4=;
        b=efT6ccLLp725L6rmbzhCKHhoXCUWhEwmpCzY1M+jmHhTKSv68aEPvW/DqEUQIeY5Bb
         Ha7TcJomL0rg5YLj5Xq1aukFl6aIdrkbdV4pUmRQaT2XCAY/5i5w+KLDBYQ2R4EoW4pF
         EgBs1rHu2empMUuaQNXCM0U4M1QIurIvJubCyJxhk1IcWfsQuOADPNLu75YqMsx5OWVY
         iR3JEiyuFMRmUNQjT2Blkz8ajOFdobI7mgOOHuTM+ZIJ3dvD9NaqVad1/tTMd76JFzLe
         xyXREL2FrL6L8XsWZTAM3O3nmii846OgGb3o3Njc4BWIXNRW1O42+VuNFDDEiWlsvjZh
         WVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i4A6iS3d4v/SDXbDNLzH3HRItLiF9tqu3vO4L3thEV4=;
        b=Wo1dKGbsD7faLF3xuLLrowz5f91RdGEx+8mlPuqOh1T2SwCbdwUMEtNvjIkasglM3K
         6rhnuM3MKBXilSpPjMHnQml4tJTHyEnGIKMIRRKHJrkgg3uQRjavwhU7i9UFi0JchwoK
         TNGfEEFMe99HcumfevEUnsT3zpTRb7vYk/JXf7EebMJFf12fexpc1durm7cVvAjb1WHY
         d7NVNPpiWuIsrnhpmBcdODl//xLf+JgoHHyEYls4wVeMasVaALjjHzrBr5FkkJFGEt2h
         OV9iYsecOAsh2B2ABuN5kQUSEqTNT892ORsyvRiMTQ/Cg2hTFolJsd0SzlIcOLQpOOsw
         Ellw==
X-Gm-Message-State: APjAAAW1+0SNrxD3y7qh+EGFvWFZVEJZ8NcVVPOvNL1G6SihfVcuV9s2
        yQSchTv4ycJk5ecne/BG9Dc=
X-Google-Smtp-Source: APXvYqzsvIXic1sYRK0SB3cYQOIXBh9Yp6xjO2Hj+C+T4Jdwwae0tMAZ9/O1DNXBWbW0RMAk+sN7GA==
X-Received: by 2002:a63:1204:: with SMTP id h4mr12135526pgl.288.1580509332195;
        Fri, 31 Jan 2020 14:22:12 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:a521])
        by smtp.gmail.com with ESMTPSA id v8sm11201515pff.151.2020.01.31.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:22:11 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/3] ARM: dts: aspeed-g6: add usb functions
Date:   Fri, 31 Jan 2020 14:21:57 -0800
Message-Id: <20200131222157.20849-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131222157.20849-1-rentao.bupt@gmail.com>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add USB components and according pin groups in aspeed-g6 dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 25 ++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 43 ++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
index 045ce66ca876..7028e21bdd98 100644
--- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
@@ -1112,6 +1112,31 @@
 		groups = "UART9";
 	};
 
+	pinctrl_usb2ah_default: usb2ah_default {
+		function = "USB2AH";
+		groups = "USBA";
+	};
+
+	pinctrl_usb2ad_default: usb2ad_default {
+		function = "USB2AD";
+		groups = "USBA";
+	};
+
+	pinctrl_usb2bh_default: usb2bh_default {
+		function = "USB2BH";
+		groups = "USBB";
+	};
+
+	pinctrl_usb2bd_default: usb2bd_default {
+		function = "USB2BD";
+		groups = "USBB";
+	};
+
+	pinctrl_usb11bhid_default: usb11bhid_default {
+		function = "USB11BHID";
+		groups = "USBB";
+	};
+
 	pinctrl_vb_default: vb_default {
 		function = "VB";
 		groups = "VB";
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 5f6142d99eeb..02c21c15c19f 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -265,6 +265,49 @@
 			status = "disabled";
 		};
 
+		ehci0: usb@1e6a1000 {
+			compatible = "aspeed,ast2600-ehci", "generic-ehci";
+			reg = <0x1e6a1000 0x100>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2ah_default>;
+			status = "disabled";
+		};
+
+		ehci1: usb@1e6a3000 {
+			compatible = "aspeed,ast2600-ehci", "generic-ehci";
+			reg = <0x1e6a3000 0x100>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2bh_default>;
+			status = "disabled";
+		};
+
+		uhci: usb@1e6b0000 {
+			compatible = "aspeed,ast2600-uhci", "generic-uhci";
+			reg = <0x1e6b0000 0x100>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#ports = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+			status = "disabled";
+			/*
+			 * No default pinmux, it will follow EHCI, use an
+			 * explicit pinmux override if EHCI is not enabled.
+			 */
+		};
+
+		vhub: usb-vhub@1e6a0000 {
+			compatible = "aspeed,ast2600-usb-vhub";
+			reg = <0x1e6a0000 0x350>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2ad_default>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.17.1

