Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0783FC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1712222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwJE67Do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgCKMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:35:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgCKMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:35:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so2410641wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNuzy8ycpqr3FLs4zmHBBSdqqrGsf8gVzDzvMcY50JI=;
        b=cwJE67DocEpbh5BKtuvUxtT+LM8kGi4/xJPmyjW8KDs6uDodbf8fgF9z7rrrE8/N4j
         Zft/9qqCBX3c8HGjIWMYzXpJMuQAOBcGnNdOl/NKj+046V4RK1e9VJ3G7sIWzIoEzkgV
         1zsB9PjEjSLpn6E9KR95nB9ZzakygZH/BxEXDiuX2XubDV1/wlo3xDfijcYP36uRpC+8
         GmsHW2AEz1p9K27im9xGCpsN+bjsPSDj/gEI+JYrp1LgLzTT2mziix5hJwi1VrTX7bA0
         OTVuac56ZI53DK/Jn/P9b6fZN/QWB66O/RmhSksbTAdegbPx/wrD6yKN/6B8eABSXEtK
         yroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNuzy8ycpqr3FLs4zmHBBSdqqrGsf8gVzDzvMcY50JI=;
        b=FK2QwaBj4vacncB/5XFMAcuO2KJB/CrIgAgp1BYtzbvOSeP2PpHd58zGGzOOlN2ODm
         sY6ZpfKMMe4nb/PRMAwTQsYWcByfdFOIVpoKjP22WHdxzvhNrsqwHh3/y5mZ/szmtdSi
         9TFRz9llQTv5nfNOhpFeeaoHoGCMUo3rl5qjr/sGLvFlQeJmU+dmNZhBSeDf8e5oAjqv
         Z4INyq3lrXPOBAPFRiVN6++5/mzassgpkyN6KQSeWNZ3Zuim+7j5Dj9TjU2ACks4WCgx
         tfsmrP5VXTygK9wpzjzrUJqQ7U3sFpw19rnTCsVQmA1k2+wa2isUG+T0X+QZvm95Abr9
         ztRQ==
X-Gm-Message-State: ANhLgQ3l19QB5HaeQZv8qyaTPu0Th6Gy1gEGDNY4VSeivvIKJ00mPpiZ
        1eTSMGGVQ6VLlEEbRsDohr3SgQ==
X-Google-Smtp-Source: ADFU+vs4BEZokW6i2VW9147V1l12EpLto/m3bG4MOwCtWbE4q/Zuimm9URFd7dry6hdivmMrBJcGlA==
X-Received: by 2002:adf:f002:: with SMTP id j2mr4457829wro.296.1583930108514;
        Wed, 11 Mar 2020 05:35:08 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:9087:3e80:4ebc:ae7b])
        by smtp.gmail.com with ESMTPSA id m25sm7822732wml.35.2020.03.11.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:35:08 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v1 2/6] arm64: dts: apq8016-sbc: Add CCI/Sensor nodes
Date:   Wed, 11 Mar 2020 13:34:57 +0100
Message-Id: <20200311123501.18202-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311123501.18202-1-robert.foss@linaro.org>
References: <20200311123501.18202-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

Add cci device to msm8916.dtsi.
Add default 96boards camera node for db410c (apq8016-sbc).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 037e26b3f8d5..a3e6982f4f93 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -495,6 +495,81 @@
 		wcnss@a21b000 {
 			status = "okay";
 		};
+
+		camera_vdddo_1v8: fixedregulator@0 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vdddo";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		camera_vdda_2v8: fixedregulator@1 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vdda";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-always-on;
+		};
+
+		camera_vddd_1v5: fixedregulator@2 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vddd";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-always-on;
+		};
+
+		cci@1b0c000 {
+			status = "ok";
+			i2c-bus@0 {
+				camera_rear@3b {
+					compatible = "ovti,ov5640";
+					reg = <0x3b>;
+
+					enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
+					reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&camera_rear_default>;
+
+					clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+					clock-names = "xclk";
+					clock-frequency = <23880000>;
+
+					vdddo-supply = <&camera_vdddo_1v8>;
+					vdda-supply = <&camera_vdda_2v8>;
+					vddd-supply = <&camera_vddd_1v5>;
+
+					/* No camera mezzanine by default */
+					status = "okay";
+
+					port {
+						ov5640_ep: endpoint {
+							clock-lanes = <1>;
+							data-lanes = <0 2>;
+							remote-endpoint = <&csiphy0_ep>;
+						};
+					};
+				};
+			};
+		};
+
+		camss@1b00000 {
+			status = "ok";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					csiphy0_ep: endpoint {
+						clock-lanes = <1>;
+						data-lanes = <0 2>;
+						remote-endpoint = <&ov5640_ep>;
+						status = "okay";
+					};
+				};
+			};
+		};
 	};
 
 	usb2513 {
-- 
2.20.1

