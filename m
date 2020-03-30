Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C51C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92092072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="DW7/jlyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgC3QqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:46:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50690 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgC3QqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:46:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so2270772wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u01MPjpNUTMHsez0F0H9AHhzrsoSor9pky3lmIVAZDI=;
        b=DW7/jlyTETqYLrHSlgXGb4d3tNoy5Y5EkVfjvrxMevne+lKoL7RdSRcKV/YxnjuIsY
         j6LQQbArr/wwBGbKORvp1TRl/KxTuVRT5iOlyyOrG6mgMtmrYbKzrGJ+exhnnyUXblMw
         OOk/TxraD577MVrYZ85w+3hrnKq2R1xYuTJ2tLr8FbQjAnxS0+aozz36cSXwnjJPcmNw
         pJrHYiNh3UVwUICHIu3/QqGzOpXQjT788b0ZnS9igtUAfKFW4uhpBnAEAJGN+9YBoG7K
         AObmGcTmAjJI/O9bHCpBm6h34Iy7Sgi2dg1gsd4d+R5VpBdNzbjb3rTfHsrlNmFe2d9v
         NbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u01MPjpNUTMHsez0F0H9AHhzrsoSor9pky3lmIVAZDI=;
        b=FE72u1dLNRAN5uwXsfHsL3xUAJAAgkxvfShfQF9BWwqk18gSfe46f4MlmLZN8SXkEz
         PToXY1/ELXTTNsWCwgSSlKllCay4z0+QvjREfWXu4SQj7aYv9M6/HSQll8N8qX9ba4k3
         LUNGMMarsw8MQJh/2fg1WOM5A7JURFWW1e0I5/5UY8lIhbCN2vAqGV8gNzdJDe3GlaB7
         7iEEkCgtjasgVTLKjyFyWKz6uYZPElh6+NKq+E3WM1mUUlxx4AznYFG3aHaOegqTVhuf
         p3Et+a8e0vJd3BmS7lcYror3s1+WhQLVmamO3MrlNd8g1yZgKkJAN6AiUSNvQOfikDuc
         WhTg==
X-Gm-Message-State: ANhLgQ0soJE0i482FoBQ7FbK83qeOQY0hIi+zZNumxt41RdozUzmbULB
        rRAlvqYItmZ4dzHQ2GCcn3+qig==
X-Google-Smtp-Source: ADFU+vuLKI27cJ4EToB73D4/54U6nwIjhdYCL+6daR5BNyCULI+4LUEX65XizZCgokPo0e4zUlBmXw==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr147042wme.115.1585586760265;
        Mon, 30 Mar 2020 09:46:00 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-177.xnet.hr. [88.207.96.177])
        by smtp.googlemail.com with ESMTPSA id h2sm146711wmb.16.2020.03.30.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:45:59 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v5 3/3] ARM: dts: qcom: ipq4019: add USB devicetree nodes
Date:   Mon, 30 Mar 2020 18:43:31 +0200
Message-Id: <20200330164328.2944505-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330164328.2944505-1-robert.marko@sartura.hr>
References: <20200330164328.2944505-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Since we now have driver for the USB PHY, lets add the necessary nodes to DTSI.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 20 +++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 74 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index 418f9a022336..2ee5f05d5a43 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -109,5 +109,25 @@ wifi@a000000 {
 		wifi@a800000 {
 			status = "ok";
 		};
+
+		usb3_ss_phy: ssphy@9a000 {
+			status = "ok";
+		};
+
+		usb3_hs_phy: hsphy@a6000 {
+			status = "ok";
+		};
+
+		usb3: usb3@8af8800 {
+			status = "ok";
+		};
+
+		usb2_hs_phy: hsphy@a8000 {
+			status = "ok";
+		};
+
+		usb2: usb2@60f8800 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index bfa9ce4c6e69..ee45253361cb 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -576,5 +576,79 @@ wifi1: wifi@a800000 {
 					  "legacy";
 			status = "disabled";
 		};
+
+		usb3_ss_phy: ssphy@9a000 {
+			compatible = "qcom,usb-ss-ipq4019-phy";
+			#phy-cells = <0>;
+			reg = <0x9a000 0x800>;
+			reg-names = "phy_base";
+			resets = <&gcc USB3_UNIPHY_PHY_ARES>;
+			reset-names = "por_rst";
+			status = "disabled";
+		};
+
+		usb3_hs_phy: hsphy@a6000 {
+			compatible = "qcom,usb-hs-ipq4019-phy";
+			#phy-cells = <0>;
+			reg = <0xa6000 0x40>;
+			reg-names = "phy_base";
+			resets = <&gcc USB3_HSPHY_POR_ARES>, <&gcc USB3_HSPHY_S_ARES>;
+			reset-names = "por_rst", "srif_rst";
+			status = "disabled";
+		};
+
+		usb3@8af8800 {
+			compatible = "qcom,dwc3";
+			reg = <0x8af8800 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&gcc GCC_USB3_MASTER_CLK>,
+				 <&gcc GCC_USB3_SLEEP_CLK>,
+				 <&gcc GCC_USB3_MOCK_UTMI_CLK>;
+			clock-names = "master", "sleep", "mock_utmi";
+			ranges;
+			status = "disabled";
+
+			dwc3@8a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x8a00000 0xf8000>;
+				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb3_hs_phy>, <&usb3_ss_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				dr_mode = "host";
+			};
+		};
+
+		usb2_hs_phy: hsphy@a8000 {
+			compatible = "qcom,usb-hs-ipq4019-phy";
+			#phy-cells = <0>;
+			reg = <0xa8000 0x40>;
+			reg-names = "phy_base";
+			resets = <&gcc USB2_HSPHY_POR_ARES>, <&gcc USB2_HSPHY_S_ARES>;
+			reset-names = "por_rst", "srif_rst";
+			status = "disabled";
+		};
+
+		usb2@60f8800 {
+			compatible = "qcom,dwc3";
+			reg = <0x60f8800 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&gcc GCC_USB2_MASTER_CLK>,
+				 <&gcc GCC_USB2_SLEEP_CLK>,
+				 <&gcc GCC_USB2_MOCK_UTMI_CLK>;
+			clock-names = "master", "sleep", "mock_utmi";
+			ranges;
+			status = "disabled";
+
+			dwc3@6000000 {
+				compatible = "snps,dwc3";
+				reg = <0x6000000 0xf8000>;
+				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_hs_phy>;
+				phy-names = "usb2-phy";
+				dr_mode = "host";
+			};
+		};
 	};
 };
-- 
2.26.0

