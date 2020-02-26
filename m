Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81CC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8071924650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdROPMg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBZXEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39871 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgBZXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id l7so124345pff.6;
        Wed, 26 Feb 2020 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j14U6e4SZ5/bLzKusf4O48IBiLZ4+5mU3b6iUsqR1xQ=;
        b=tdROPMg7AEKdtwwE9QymwJ0g9qsWLn7bn2gtI6QlqMCrStrbzvnhTcqPFlkpLc6Can
         8RTLdPjfGZAeoJHpu5b0cvuSfO/BrYa/6Xx6qJ/XR5W75q1+c9HjV9ymwkjG/qOhKPeq
         FcK/BeIYhOzShUtMi/FJWY+OWIZwvvwsKWlrRiS7AmjDD4EUQDxIU0cOCMxKciXZtLkj
         Omj3DRzVKWnOQ5v+M+sEXfQadRKvpQx/loMQdv3PrEegVlAO2t2HEieqUBid4OiTO3dy
         fpq6u6b9n2PfHN84+KRJd2jrw0UHJ5Qr8+PNSGcy7Jm0gOuCR84v+q77f+vaXeVPCgH4
         7zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j14U6e4SZ5/bLzKusf4O48IBiLZ4+5mU3b6iUsqR1xQ=;
        b=CGL0Rs/F5hUEAi0ljbXSBWLg4BbD056phLWW21OrnCneKJohp5MYglkS9ED9s9qAsi
         FyB7WgYQ1UH/wLRAdv4zYsV5B6RCXS4FZa2YuvcfMUbTF+lStmRsu8HIQf5JIDgK4VrU
         vxQ+FSH2/Z+K6ejPMr4PyPXTgLWSo3oGyCN7GXrEmaBZw7iSiDRc5EbkXKS1e2hMBet+
         Mp+UaWFOQgeXY4tUujYkiCw/Nj3xNeM3ZUrSQxb9t38z0UKyuOQ1oX+spfRl6Y9bqGld
         KCbkmf7UgPlZ7OzqtY0wD2ZwvJWwSACwf5974+J/FpQN+V8PmwYRJZmM8W4gmsDinY9t
         Oqcw==
X-Gm-Message-State: APjAAAUccppkWCVlv7s89mkMTZ7v3SZV6YEBf8mwmEVrw8aLbnj/ikVK
        dKlAU4gf31telbXnrvpRW1g=
X-Google-Smtp-Source: APXvYqyTnN0VihWoI5MbSjHLs+rZ/lsqHA3p8qM8oJK2nZlc6LKx6yIcl0r2TnpiWehPi3daZvIE1Q==
X-Received: by 2002:a63:5b1e:: with SMTP id p30mr935911pgb.71.1582758247007;
        Wed, 26 Feb 2020 15:04:07 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:04:06 -0800 (PST)
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
Subject: [PATCH v4 4/7] ARM: dts: aspeed-g6: add usb functions
Date:   Wed, 26 Feb 2020 15:03:43 -0800
Message-Id: <20200226230346.672-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226230346.672-1-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add USB components and according pin groups in aspeed-g6 dtsi.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 No change in v3/v4.
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

