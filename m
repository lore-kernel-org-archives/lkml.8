Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3220714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfNV1tpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgGUBZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGUBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:25:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2AC0619D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:25:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so837155pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3SL61dihAHKQ5Ht3JKZwsIf+MYk0kZQ06Zncr9exNUs=;
        b=pfNV1tpV1MiM7maphlEeXhHlc27jPtO3X0mWiOfbKEo1uVuTLEnPavTfmEqpHGXlG0
         kI5nChADivSZJ/Y5dch6ZFhiNJmbFGziSNY1dzW6EuAyuogXajsDh41XX3k4UuqZ8bXT
         Ls+h7Od/DacwDZ81hHBvZ2vmDPcL9rCM5nklhKAVog77j07GHoEAFc1P0rN+7YlyAdv6
         Wy0iwIBMoWSYuM1Aye2ixh+j+35yRxpY6r9xP46QU20f6vLpdhNCW+eiCZwzVIqwWatQ
         bjyP7XkrDYDAIEfrGerZrfNIZCnT5xjCZHAwTXlzcZyo+bhXGyX81PH1VNzgyuEiv9DZ
         ACtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3SL61dihAHKQ5Ht3JKZwsIf+MYk0kZQ06Zncr9exNUs=;
        b=DhPcstAnWoL0mbGBU4JEH2p0XMLMjq7FbcznRqulhITdHrNHoHTz7dX3aEunAlPRRS
         nEmgFGsNC1LxLhiR1B9/xeEtKJwIlgIRmPHxhuouAF5jvT7CN2DsavdVZZwCEkXlIync
         42xRKgOsxyJITB6AVbklh2LtvCkD3Dr80rm57XYUKs/P3eIEcucexU+VqCTmetue+tPl
         JqVdZe3sCyIXyrPLCh2Gsb/z9kYWahQT+LLR/ABw9nv6UJExwlPSpg567XRW2MqSaTQE
         s2KLUBU+YT9l25aKWqxBkdtTqIsiOT1wxlmbywpv7CoebpB2N/jaSKsi0YZP9AwBLROl
         EJCg==
X-Gm-Message-State: AOAM533JhC374OiKUf9nJBBvBHJoNdq5dGZ/uU7GFyJ5VzBwk0sEaHE+
        wQSXFbhLQIqQ7lPajQ9Fq7O/kyX/jA0=
X-Google-Smtp-Source: ABdhPJwp1ovg1df0tjWgNFcVMOrW2Xk42aBPcKAUAtGy7Z5/5lUywtIy9nlBAHwvFtwWWyB4Um4tTg==
X-Received: by 2002:a17:902:c3cb:: with SMTP id j11mr10058164plj.324.1595294751414;
        Mon, 20 Jul 2020 18:25:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x13sm17571067pfj.122.2020.07.20.18.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:25:50 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RESEND][PATCH] dts: hi3660: Add support for basic usb gadget on Hikey960
Date:   Tue, 21 Jul 2020 01:25:47 +0000
Message-Id: <20200721012547.83743-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic core dwc3, usb phy and rt1711h nodes for
usb support on Hikey960.

This does not enable the mux/hub functionality on the board, so
the USB-A host ports will not function, but does allow the USB-C
port to function in gadget mode (unfortunately not in host, as
the hub/mux functionality is needed to enable vbus output to
power devices in host mode).

This is based on an old patch originally by Yu Chen.

Cc: Yu Chen <chenyu56@huawei.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts    | 72 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     | 34 +++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index e035cf195b19..ff392a47562c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	model = "HiKey960";
@@ -526,6 +527,48 @@
 &i2c1 {
 	status = "okay";
 
+	rt1711h: rt1711h@4e {
+		compatible = "richtek,rt1711h";
+		reg = <0x4e>;
+		status = "ok";
+		interrupt-parent = <&gpio27>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_cfg_func>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
+				PDO_VAR(5000, 5000, 1000)>;
+			op-sink-microwatt = <10000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@1 {
+					reg = <1>;
+					usb_con_ss: endpoint {
+						remote-endpoint = <&dwc3_ss>;
+					};
+				};
+			};
+		};
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rt1711h_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+		};
+	};
+
 	adv7533: adv7533@39 {
 		status = "ok";
 		compatible = "adi,adv7533";
@@ -612,3 +655,32 @@
 		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
 	};
 };
+
+&dwc3 { /* USB */
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phy_type = "utmi";
+	snps,dis-del-phy-power-chg-quirk;
+	snps,lfps_filter_quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,tx_de_emphasis_quirk;
+	snps,tx_de_emphasis = <1>;
+	snps,dis_enblslpm_quirk;
+	snps,gctl-reset-quirk;
+	usb-role-switch;
+	role-switch-default-mode = "host";
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&rt1711h_ep>;
+		};
+
+		dwc3_ss: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index c39b78989ff9..d25aac5e0bf8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1152,6 +1152,40 @@
 				};
 			};
 		};
+
+		usb3_otg_bc: usb3_otg_bc@ff200000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+
+			usb_phy: usb-phy {
+				compatible = "hisilicon,hi3660-usb-phy";
+				#phy-cells = <0>;
+				hisilicon,pericrg-syscon = <&crg_ctrl>;
+				hisilicon,pctrl-syscon = <&pctrl>;
+				hisilicon,eye-diagram-param = <0x22466e4>;
+			};
+		};
+
+		dwc3: dwc3@ff100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff100000 0x0 0x100000>;
+
+			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
+				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+			clock-names = "ref", "bus_early";
+
+			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
+			assigned-clock-rates = <229000000>;
+
+			resets = <&crg_rst 0x90 8>,
+				 <&crg_rst 0x90 7>,
+				 <&crg_rst 0x90 6>,
+				 <&crg_rst 0x90 5>;
+
+			interrupts = <0 159 4>, <0 161 4>;
+			phys = <&usb_phy>;
+			phy-names = "usb3-phy";
+		};
 	};
 };
 
-- 
2.17.1

