Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8EC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932C820575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCpXh2fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgCKTPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38269 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbgCKTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id t11so4138428wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47KQ0uBhMgSfs+pVz0N7P1Kw9ZJJ2uyL5JhG+zaRjW0=;
        b=qCpXh2fkFbrvr5cV8QjHLGtgDCrf0qcVP1esiN1MVtJ9xpx0yjQ9PsybxgF6g3Vjfn
         i7uOhHkAfvcTH7poALh+5cviwx3xLiVpBos0EPmg8oOP8ASC488t/tSsGCniCFylGw+m
         vWv9zhLYQws60sgBnBDxBgXsgAIp/Xl6T9PVLO/bpTu/xwOIzi/vW0c6jh2jptNHApYs
         TIW+Gu6hU7qpRTZxLaBMae2+PPAPv55rCy/4mtgBa2MzgXPihnFGVjf0Dj70bkVR1SMF
         WGx+ScvrPKTP4W50DFmooqsOexxFq+h3/Dt+DmWrqpiRK1j+TqHUoCsx4AL/9ZsdRhw9
         37eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47KQ0uBhMgSfs+pVz0N7P1Kw9ZJJ2uyL5JhG+zaRjW0=;
        b=pNB/pODeAGHxeSfthqeWIh6+aK3V5U1Rv84xHtqeNAngA3H2gybi5ObaJLr2B6G0CU
         LpJ9qSydunnnPiDIjiq92jLZybP9ycGMuUaxRrcq2hwXgfx/UqS6FSUg1F2toqPbTzFJ
         vUxLTE3vATjRo0rJDPfoKVkJb7Qfn8nyrp/URTiRrKTnG443XJD9mbQdDIJoRaS4lLzX
         btCaV9g4xsy2Wmg4UXA4D6CY99yANhFO9CJiCp/czIUJVH5+xsV7xcTNGsWWD8bCh5MQ
         brXxJBeg0qkhiT7RX7kAP+bKgfstWIAwAYeoLtLaZwWI0wC0uJ1VqC/YC2L4OXQ09IsW
         C7wg==
X-Gm-Message-State: ANhLgQ2t8OOykgE2QeCuRaPBXAhyj6JFwpN22sRx/tJCXWZ+Rsdv5soo
        sZGkBaXSHAFTlV4oY1/Q3ZJ60A==
X-Google-Smtp-Source: ADFU+vvxxkr6+nqmnkmdFJ6KJwj1fyz01yG7HOCgMxGGUqsEDhIOk7ctqKHYW5uIUEJ3zvDYFqlVjw==
X-Received: by 2002:a05:6000:189:: with SMTP id p9mr5952091wrx.391.1583954103296;
        Wed, 11 Mar 2020 12:15:03 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c85sm9687437wmd.48.2020.03.11.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:15:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, robh@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/6] arm64: dts: qcom: qcs404: Add USB devices and PHYs
Date:   Wed, 11 Mar 2020 19:15:12 +0000
Message-Id: <20200311191517.8221-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
References: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

QCS404 sports HS and SS USB controllers based on dwc3 block with two HS
PHYs and one SS PHY. Add nodes for these devices and enable them for
EVB board.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 100 +++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4ee1e3d5f123..d3347ce2b94f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -323,6 +323,48 @@ rpm_msg_ram: memory@60000 {
 			reg = <0x00060000 0x6000>;
 		};
 
+		usb3_phy: phy@78000 {
+			compatible = "qcom,usb-ss-28nm-phy";
+			reg = <0x00078000 0x400>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "ref", "ahb", "pipe";
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "com", "phy";
+			status = "disabled";
+		};
+
+		usb2_phy_prim: phy@7a000 {
+			compatible = "qcom,usb-hs-28nm-femtophy";
+			reg = <0x0007a000 0x200>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "ahb", "sleep";
+			resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+				 <&gcc GCC_USB2A_PHY_BCR>;
+			reset-names = "phy", "por";
+			status = "disabled";
+		};
+
+		usb2_phy_sec: phy@7c000 {
+			compatible = "qcom,usb-hs-28nm-femtophy";
+			reg = <0x0007c000 0x200>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "ahb", "sleep";
+			resets = <&gcc GCC_QUSB2_PHY_BCR>,
+				 <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
+			reset-names = "phy", "por";
+			status = "disabled";
+		};
+
 		qfprom: qfprom@a4000 {
 			compatible = "qcom,qfprom";
 			reg = <0x000a4000 0x1000>;
@@ -486,6 +528,64 @@ glink-edge {
 			};
 		};
 
+		usb3: usb@7678800 {
+			compatible = "qcom,dwc3";
+			reg = <0x07678800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_SYS_NOC_USB3_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "core", "iface", "sleep", "mock_utmi";
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+			status = "disabled";
+
+			dwc3@7580000 {
+				compatible = "snps,dwc3";
+				reg = <0x07580000 0xcd00>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy_sec>, <&usb3_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				dr_mode = "otg";
+			};
+		};
+
+		usb2: usb@79b8800 {
+			compatible = "qcom,dwc3";
+			reg = <0x079b8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>,
+				 <&gcc GCC_PCNOC_USB2_CLK>,
+				 <&gcc GCC_USB_HS_INACTIVITY_TIMERS_CLK>,
+				 <&gcc GCC_USB20_MOCK_UTMI_CLK>;
+			clock-names = "core", "iface", "sleep", "mock_utmi";
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			assigned-clock-rates = <19200000>, <133333333>;
+			status = "disabled";
+
+			dwc3@78c0000 {
+				compatible = "snps,dwc3";
+				reg = <0x078c0000 0xcc00>;
+				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy_prim>;
+				phy-names = "usb2-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				dr_mode = "peripheral";
+			};
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
-- 
2.25.1

