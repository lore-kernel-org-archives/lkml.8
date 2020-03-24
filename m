Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E463C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30032076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHsHf9RC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgCXP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:58:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54064 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgCXP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:58:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so3793655wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPYOl9OSvnlb7pbajpjD/KFcLeeFx7WRfchUdrcylgw=;
        b=YHsHf9RCWJ9Rkt8w6oePRTlQPhaIlN8o9yI18GdZk6d549IZQI9P0+hsaofIYyEuYJ
         Pu4WSGVwS4cBplZPuQ3WqdbIeCm+pJ8I7Q55t8f5yS57f49NCTL6DeIx97+mL4ijqlXM
         Sy+4gHnjl43p9nDSLap7RJ3f7oMqOMH7TO1cruo0H8JyPGX9id6qeoDIJzaTjBskAav7
         uQu6aJZCeEM/zClNuaDzR74lg++HuvFmB41duTI54392uEqAuGclZmUHHpfCUabph7fX
         BFrXxCxj3bYBkmJuiK7X8NVRLWhBcm8zMQchXuJ3gpD9r3GZhHgLzqyaMcFTyTbxfKVf
         ufJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPYOl9OSvnlb7pbajpjD/KFcLeeFx7WRfchUdrcylgw=;
        b=WJsTp7t2qYUabKkla21a52MZEeFHiKX7IxQnxda2UGdBP+0gVFVw/RkCXEDYHcQm/w
         1ILiC0J/ptFnP8CHckEqb8Xx4ulVkezG+qskz4zDz2WQAXPeq8Cx8IblQCaEPDi6Lj/F
         52wOMqLY68E6Rvya1VLqNf9xDQ6BxEmprJYJRlJRpLBu0ESnny6UYI0qXNGV5nvmab9t
         5eOB2Sfb2AiUPEikjbI0fgP7JQDN5Uk37X286kJYd90XmnejQFpzI4tc5FfWPhU/5zVO
         7oz/lYKtT7bZaLKOdH5JJmJOodnRw3puSQdfjfdWWE9hkRn82pn9HC3pnUlg/qLUeoUG
         /zGA==
X-Gm-Message-State: ANhLgQ10XI5ofCMNN2buqenOcq2f5e9YQINYrEAxf4cfZfeuCuSpcSPU
        EWbgvkP6TIcBtsUGuf7aMRL0LA==
X-Google-Smtp-Source: ADFU+vuZkUbQmRe+H1djjQ4pvSEQwOP24JfoxEbqOVwByz2BSkhjvCiifE7uaI//6oPP5ccMUuMJrA==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr6657099wme.49.1585065531892;
        Tue, 24 Mar 2020 08:58:51 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e15d:2127:89a:e5dc])
        by smtp.gmail.com with ESMTPSA id t124sm4993321wmg.13.2020.03.24.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:58:51 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v3 2/6] arm64: dts: apq8016-sbc: Add CCI/Sensor nodes
Date:   Tue, 24 Mar 2020 16:58:38 +0100
Message-Id: <20200324155843.10719-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324155843.10719-1-robert.foss@linaro.org>
References: <20200324155843.10719-1-robert.foss@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
 - Reference CCI by label
 - Don't use generic node names
 - Move regulator nodes out of /soc
 - Use CCI label and move node out of /soc
 - Use reference for camss and move node out of /soc
 - Use reference for cci-i2c0 and move out of /cci
 - Disable camera_read by default, since no mezzanine board is guaranteed


 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 76 +++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 037e26b3f8d5..d98c7e9e6eb9 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -51,6 +51,30 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	camera_vdddo_1v8: camera_vdddo_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	camera_vdda_2v8: camera_vdda_2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	camera_vddd_1v5: camera_vddd_1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
 	reserved-memory {
 		ramoops@bff00000{
 			compatible = "ramoops";
@@ -538,6 +562,58 @@ button@0 {
 	};
 };
 
+&camss {
+	status = "ok";
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@0 {
+			reg = <0>;
+			csiphy0_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2>;
+				remote-endpoint = <&ov5640_ep>;
+				status = "okay";
+			};
+		};
+	};
+};
+
+&cci {
+	status = "ok";
+};
+
+&cci_i2c0 {
+	camera_rear@3b {
+		compatible = "ovti,ov5640";
+		reg = <0x3b>;
+
+		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_rear_default>;
+
+		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		clock-frequency = <23880000>;
+
+		vdddo-supply = <&camera_vdddo_1v8>;
+		vdda-supply = <&camera_vdda_2v8>;
+		vddd-supply = <&camera_vddd_1v5>;
+
+		/* No camera mezzanine by default */
+		status = "disabled";
+
+		port {
+			ov5640_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pm8916_0: pm8916@0 {
 		pon@800 {
-- 
2.25.1

