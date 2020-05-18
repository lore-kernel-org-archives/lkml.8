Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FD920674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8DuRMtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgERIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgERIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:21:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30258C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:21:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so8293323wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ke8BoO5EmHk4SIG95iemEMZnR5BDFJSAvPbDzk3LsE=;
        b=y8DuRMtZ5m32J99ssZXJXSq+X+AfOmJ+8dm6KSocF9Z7GTbedT/x+AWJ7/buNAr3pg
         Lc4iDOZnNKa1b971lpHeSODJhZ4KsL7pg3cd7aNHPsLWp+woLitHcV75oXe/SFMpFWH6
         mRETIVp45P9yo8Vo9q/avbqmc59f2lnBmAsRsoyJV/oWG0W9PRJE5a53kk1GMfdahNzp
         h090VIAv9PNzyF+oVrlPFrp3oBdB27BDMGL8b36Wy4DkS9m435f3D3if4j6tR0cRQfhC
         OnVMJiDqXESB8zrBykPNUJIbFiwQqwRHG2yZRbwCdOYvKuT2iI0SkwgGXHSRhw29Fo9U
         mGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ke8BoO5EmHk4SIG95iemEMZnR5BDFJSAvPbDzk3LsE=;
        b=HSfe+6rzOB1TkOLrNgihr+u5hWx9C4UxIpDdkcoibC2IWkVje1w1wxaJi8m0fvgBLO
         DH5nSEAo12pGPr6uUUwwKg6e5u18tMxnkvp6k8OHbkyub4ZXFix1Epz7fnNW3tzjg2Ou
         Cmr+NRjgq4EiPoh8jGJ3b+wgWiD7uFVf3HsmzsedbtFkpwzvKdBs4CS82bJhUpvuQxRY
         svsCteXov0bXfl7fsRqeW+2sOZqcEYxFDAV5hWZaloaJVAGxRqY6bHNoAOMbVeYAQHjt
         pOwU5gXUucxgxThwfMmdumPiuAIN47lcU4mjsT2dhnkHpOTbyNFFFe4q3sacAc7SGq8o
         lOEA==
X-Gm-Message-State: AOAM530cmIylmTvYnj084QkTrMtnqVvdLhERvvG3CHOAeeBkYZidcloR
        x4HHbVqeDFyd6EmljoWyCO8NNw==
X-Google-Smtp-Source: ABdhPJz3/vAFGGLjGfXRhTYtndwC2SARogPWWAdkeE9QbQBVTa6G6s3MYYvtL+u+txx74j1Lpr8f7w==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr6593049wmc.116.1589790092914;
        Mon, 18 May 2020 01:21:32 -0700 (PDT)
Received: from localhost.localdomain ([37.120.32.219])
        by smtp.gmail.com with ESMTPSA id x184sm15849567wmg.38.2020.05.18.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 01:21:32 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v3] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm APQ8016 SBC + D3Camera mezzanine
Date:   Mon, 18 May 2020 10:21:29 +0200
Message-Id: <20200518082129.2103683-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
the Dragonboard 410c with the D3Camera mezzanine expansion board.

The D3Camera mezzanine ships in a kit with a OmniVision 5640 sensor module,
which is what this DT targets.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

Changes since v2:
 - Vinod: Change copyright assignment to Linaro

Changes since v1:
 - Vinod: Changed license to GPL+BSD
 - Vinod: Changed copyright year to 2020
 - Nico: Changed name of mezzanine to d3camera

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../boot/dts/qcom/apq8016-sbc-d3camera.dts    | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index cc103f7020fd..3f95b522694e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
new file mode 100644
index 000000000000..752e5ec47499
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "apq8016-sbc.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. APQ 8016 SBC w/ D3Camera Mezzanine";
+	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
+};
+
+&cci_i2c0 {
+	/delete-node/ camera_rear@3b;
+
+	camera_rear@76 {
+		compatible = "ovti,ov5640";
+		reg = <0x76>;
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
+		status = "ok";
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
-- 
2.25.1

