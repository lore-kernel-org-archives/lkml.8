Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5017AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206E7206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0gdP+gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgDHNKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53540 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgDHNKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so5089749wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCoRzaUrdhheeIlUNW47HAync5dklHonb09Mc1gGeaQ=;
        b=m0gdP+gW2L38CLkfKlAS1TDbSuutmYiyI58ZPkFL97FtWIweFVvbOIKVe+WTNSaHKA
         xkLRgN1PWfwEU61PK41yfNVb3P6jnaDql+mh9ce86e79y7CtT+GSIxI7wutR7gbwWJiK
         aZhaa9f98WnLj0Pw8euMTGIQd3N2MUdAkCL/P0bg80egMhuBb4w7JfTQPIxmjRdtE3j2
         YtAiz7lnBZ2SzjzGzc2lSCPWo2hluvX/TNBKIUYt4wybra/TqfvuaLuraV0kePIh+TIR
         bDAqPzIVQYozMf9SBkCC1qX4L4rp9+Y6DBRWZO1dLgcs2BLBSZ01I98Xnd0dLXzk4f/6
         WZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCoRzaUrdhheeIlUNW47HAync5dklHonb09Mc1gGeaQ=;
        b=mMRW4BWB4ULVnQVNBoYQGGsGFQGKbIB4aBxtvc0pOqShr+AVkQCWzdd4D6AGE3kub5
         jU0CHkXrT0NoSPxmNdhRY+i69EzK9dHZcGQfjJBhdex02VwIYUWoWtqUuFbgkjWG8dVd
         RQsNnxLhGFOrPsddSQ5KzZZoWUCMxOtyWsQOhqtAnxjRW18ecASBDI6tT55fLDVTHilM
         DJBn3TK2/od7Gl7xA8zVSKbawdOXg6eljokY9pzHxUTxrzPLjsx4BrdY1pOGJE4lh2+w
         YfmxTaHIDPI6Ooa9FbvhYO+Y1DajVfSThiz09gH7Thfc2mWhiu9l0K6NTKpYKb3bc57a
         HFEg==
X-Gm-Message-State: AGi0PubrOWz5gcMRc0/xulFvCUn/BdIwLTOdrm2RXBFndiRY8u+IU/fm
        JHNyVnLQ0KPnf6LdeVYemWWXjQ==
X-Google-Smtp-Source: APiQypI8sSJsIxwVReEYgGo7DltNbhld0IwxBkK3vozu76CjKVRzBofc5Zdgq1mBXZhSwpBQCte0ZA==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr4806161wmf.175.1586351448472;
        Wed, 08 Apr 2020 06:10:48 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id f4sm18428044wrp.80.2020.04.08.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:10:47 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, Anson.Huang@nxp.com, olof@lixom.net,
        leonard.crestez@nxp.com, geert+renesas@glider.be,
        marcin.juszkiewicz@linaro.org, valentin.schneider@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 2/6] arm64: dts: apq8016-sbc: Add CCI/Sensor nodes
Date:   Wed,  8 Apr 2020 15:09:55 +0200
Message-Id: <20200408130959.2717409-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408130959.2717409-1-robert.foss@linaro.org>
References: <20200408130959.2717409-1-robert.foss@linaro.org>
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
index 06aab44d798c..14982762088d 100644
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

