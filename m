Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245DDC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB1F246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1ZB3TRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgB1CIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgB1CIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id l7so854694pff.6;
        Thu, 27 Feb 2020 18:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5BfOwLn24yvtIE0e0iNKJsx3NaZL6cHt2dZJZg1w+Y=;
        b=Z1ZB3TRkP9NyXosyv0V9Jpv45jz0nTrP8690jhwQdAaqR4GfMSQMylzM1DMC3MJ0S4
         TR6c3i+3RQO4KOBsqutoeF0TVEfVWHSi4rnOpnq23u/Kk5IUOt6nxFTaQmmYTqMH6lWl
         4SRalwA2yv1e0SEBRYuKbJwZ7haa81rNQY0pg5CXMizf/3CO5UqeUI560n+ljt45mXXi
         TB7bh6SZBfAEUCg7WQ82GPMV5Yss16z2u620qIL/J/2nhYdBCqHafcEoGg0wsz6ujDk/
         CTPz7pvnz3KE1RU6RlUrwTC7dbdgRwu/xO0wwYSl+eqcceai0VmuTdzrNtMw8NGhYee3
         y42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5BfOwLn24yvtIE0e0iNKJsx3NaZL6cHt2dZJZg1w+Y=;
        b=HUMurObkHvJ25/q/Z51oiujphbCiD3BJOfG1psdIQFJ1fz452KoDLC01Uh9ZWcrwgO
         i0o2gGrPnCJD7JcENCWiHM4jqsRWW2KZRCd6Q008mAlTC+8TfHPKT6JJq37q9AboYTR6
         RIyuxcxFU8vw/23cjqWTbqUl2sFa2K6bNmyhMFy1wyWWhU+lWitSB8k89LmgbHUWVAcF
         FDMVrHvQUno01JB1guB6rMGYpNxaMDs3MedgQRDBxEXU79SSf3/0UkGaYd7wUYHG5zp+
         c5+1+jI6Ma4dRaF+wOCqvDX83yMen2plzrL6sGfGuS6xYqTw3D+HGvt/VvsoWNSl0d1v
         8GbQ==
X-Gm-Message-State: APjAAAVp3jiyI/q55i8kHnhInzxKI3MWUvNryr4gRE18BQu4i0/t8Iup
        bOjRUZ7D8eY5fVVJM6t8t18=
X-Google-Smtp-Source: APXvYqxQSv9GvVWs7XjlCA2xwI/xPuFEG7LBg5g6iIOje1WR0bgOkhLW4rcGdmv8Xn/kC6GUaiJtfw==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr1961347pfp.97.1582855693677;
        Thu, 27 Feb 2020 18:08:13 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id k24sm4931972pgm.61.2020.02.27.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:08:13 -0800 (PST)
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
Subject: [PATCH v6 4/7] ARM: dts: aspeed-g6: add usb functions
Date:   Thu, 27 Feb 2020 18:07:54 -0800
Message-Id: <20200228020757.10513-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228020757.10513-1-rentao.bupt@gmail.com>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
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
 No change in v3/v4/v5/v6.
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

