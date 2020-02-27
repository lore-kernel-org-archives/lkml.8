Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57FDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC772072D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYWmfDre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgB0XFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:05:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40826 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbgB0XFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:05:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so415371plp.7;
        Thu, 27 Feb 2020 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19Xkcz/2H7qw7NdRum+txTMYsSNMU8ssTmnGDdLyQzE=;
        b=HYWmfDreKAagDtTfzCvCE3tlM9ZiFz4+YpaXXD77EylMhM03FMpcAbda6nXMVkjrrU
         pz9GlPrziB2LoEQ6s73O3c/gJvIFHayLB0mragbmpeKRXQTlBPLsEdYQOkmZtg6SuPPW
         ZVC8lhzo+T/nAWVU4AQQnEp0Lmb8RfXMilfBpvkBZUCC7eAsN113YKs7JGc5amm0fiju
         n1PM/0Qmb8weImH0r+Pqch3Nqk39vWdCL1oOTqbYiVU7V64vh79ViP07yEc5J7WJjw8Q
         Md8oq1UUY0tA0wxW19mpFlWkqnx0CtrIhWFq5Jouu3vNp4BU5utZ9MqSeTg3MTOffxD/
         42WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19Xkcz/2H7qw7NdRum+txTMYsSNMU8ssTmnGDdLyQzE=;
        b=uYe3YMdG1WdgupiT3cQu4j+bdIzKg0MPq6+33Varl9CB0MZsMELXLuzswgrvMo9rAz
         k4KWjs3oije6vHHfVQtO/oFlzmafiPOoYuyprz7eQOAIL7hx/sc+nvR4FbCojJCrUg3B
         OfvGuQhbQBXyVm2eDRrTOKBqdS1GHTIu6c8/A1V7zc9dcvp928Ca3anxHj0Pksn+tbwP
         q9+UVt9NDpC2LhcK0ikxo7WxJYeKGel4Cl6FDwk1HrLLwvJ9Ed2n91lYuoUw1yu92hR1
         bgeU1e2i7q2kyWZ/R4oEfxpkSRV9aMzByAQkPBqOPgMKT5g++srlWIIe6Iw1IJQlLfIh
         tBeQ==
X-Gm-Message-State: APjAAAXMDVUiHtnYW9f+K8+d53c4RZVyQoR2HI7lWyjq3DPVJLf7lKl3
        aBAi3LyZs6X2s81nQL4hl4Y=
X-Google-Smtp-Source: APXvYqwaMyyWZohLLJCgnVR1nzQc5p/L96oyA99s9NZ7i/vWyQiAg0V2mpU/TCWnBSkf3jPwZ39cFA==
X-Received: by 2002:a17:90a:8915:: with SMTP id u21mr1367639pjn.87.1582844722784;
        Thu, 27 Feb 2020 15:05:22 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id w2sm8275975pfw.43.2020.02.27.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:05:22 -0800 (PST)
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
Subject: [PATCH v5 4/7] ARM: dts: aspeed-g6: add usb functions
Date:   Thu, 27 Feb 2020 15:05:04 -0800
Message-Id: <20200227230507.8682-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227230507.8682-1-rentao.bupt@gmail.com>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
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
 No change in v3/v4/v5.
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

