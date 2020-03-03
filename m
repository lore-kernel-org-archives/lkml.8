Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5EDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459ED2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYK3uZec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCCGYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:24:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55466 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgCCGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id a18so876991pjs.5;
        Mon, 02 Mar 2020 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W5ipZYCqarch+VFCrahnwIr0sUcrx3kRehbQUYG33BE=;
        b=TYK3uZec7Gwsf+BtY9KIVxpawRiII17N9ErzrWeN4dBss1Hhc9KbZlIiCckDDM8rxN
         DjLtncGeV5zar3nOteLiv6s4YTcZNkBp43WwEhnmVSP52LOUHY1pQZ7ADYhwg8Mo0asc
         wKDYHwMapgEMzshWQkgGwqZJ0zkrsRQVccdvUOoXch+xMmIKhqlgilK6llqbrkbCGWlW
         pqYCsvksjgGS6fahMz7hECyVwVOnxpv6kY20W8TB1s+qHkgaDIuYtyH/QsUXsutpIeei
         mbUYJMA9PJSprDQnGgfG9YITOm96yheZXFRSnk+CgJaUMS7ajDLnWscImfgeqsf6PgMp
         VyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W5ipZYCqarch+VFCrahnwIr0sUcrx3kRehbQUYG33BE=;
        b=lJeTW80FF/ijGTGMzqXZib72IqH6ihKayL1Z1afdKGdO4M273u0jyYUhrm7Efp5JVb
         i0fxV/LR2wxQJCySy7z2VxU8mjq7bObnW8YEwxeaMH+uhMMk6iVCW9JO8k7iF2NMuIFR
         4amVN9jD26r05HuQR4p6Xc1J16+AuGggFTkKyDZ3RhNaSU4gpHXO6GmA30Ma+a3jtszM
         JCPdzJmBXtX5OsztTiu0ZpTANCmrVZiiIZEcrL+g/vaD63IqzYBvnQT5dejAgLhMbCKI
         9Zd0AtxJCXQGHO74cZDV4i/4BYk8ZLJ3T/wrdZPEClz4hs2TXsfVDNEf4eTAzQ7fiFe7
         VnQQ==
X-Gm-Message-State: ANhLgQ3x3BkR8P8r/uYeuqhF0NXXr61AgS5O8XaJeAeuXnOms1TzR9B7
        QijMF8ByHV4egK1INLdlMG0=
X-Google-Smtp-Source: ADFU+vtn2N7wyYr1zXGtibIMIBW9UWrBHiD3AoUltb0a1WvpOoZKu0iYGXLtVV+uJNbi7evtGORI8g==
X-Received: by 2002:a17:90a:8502:: with SMTP id l2mr2357223pjn.163.1583216631462;
        Mon, 02 Mar 2020 22:23:51 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:51 -0800 (PST)
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
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v7 4/7] ARM: dts: aspeed-g6: add usb functions
Date:   Mon,  2 Mar 2020 22:23:33 -0800
Message-Id: <20200303062336.7361-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303062336.7361-1-rentao.bupt@gmail.com>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add USB components and according pin groups in aspeed-g6 dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 No change in v3/v4/v5/v6/v7.
 Changes in v2:
   - added port/endpoint properties for vhub dt node.

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 25 +++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 45 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

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
index 796976d275e1..0a29b3b57a9d 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -245,6 +245,51 @@
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
+			aspeed,vhub-downstream-ports = <7>;
+			aspeed,vhub-generic-endpoints = <21>;
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

