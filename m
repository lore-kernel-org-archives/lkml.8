Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72AEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F26220715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWEbtLQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBGURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBGURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:17:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so3800564wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNnWmRJxPTDDJICmaDWfmQ5x36dMwtg4YdELGjqA9ik=;
        b=MWEbtLQiYvUgQTaO0f2+DPCMHPErF+JAX2Jgg92/A6fMhnM8JYDAbZZfwdidiGff4s
         blSnvHSMKUYJxRoQhmzV5+PDqPhZaTNSDqrhPrueSmHa24zV/p0ueTwEZBpRM9v875A4
         sNupnvMUn9II88d+p5qbsfPtdEzQUQMmBJUhVE8GRaaZQGRxQbi2Oip1WP88ikworh2h
         4ceSHcCOwkPNZmRuOXf1LIVSoz+qBej54KDaz7SlTeh7NhudujTFf1qS3iTEsE9Sji14
         +5LtRcb4oTji9Qd3V5K4fOVnv9oNxCe5BRC2TTJOVScVjAPbug2Ab2ibHB05OU1rRvXw
         jsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNnWmRJxPTDDJICmaDWfmQ5x36dMwtg4YdELGjqA9ik=;
        b=rwIxrIyYYbH7D3YoYXmok0fV6OVB5eLsqXhRIhjcn/xUINtA3zonR/EF6L7DJOxEk2
         D8DztWy7bPLBwgejj0jPtUnOXcVMRbucA0Avz2KOTiRoIIqUej0b6dU0ZGaZd7NV6zhA
         dhVVYu35z8V56cqC7fM9iX27UE5WtbgBRZmODGVtUcavdnxgUSDYWnDMEWsQHnvaJfNP
         TDbSKutMKbsw0j8dj8x/J7gDONQ+LZmPKsR1nGTO3hJCgji3El7C+Qe7l4IRX0ovrcTQ
         C60/nNAHWfdlLWTKEtKXyXe5eMdYE3Jb55czgwxiygUA42vYoki/9p50GWKa9or8atO0
         CN7Q==
X-Gm-Message-State: APjAAAXdwrB+lYWE+wuP/31kTHsKgSJFfUIcDj6uUBlkvdgf1FKArnHx
        CDcKBeCkaArvgcl8TC88ePeEhg==
X-Google-Smtp-Source: APXvYqyxnMeYVbAGPzr99m/PFZD6OBfvN/l5cAvXKxvT4aMsR+7fARxTEj+M0F1sxpthdAuOalLOZg==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr7810wmg.151.1581106626293;
        Fri, 07 Feb 2020 12:17:06 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:17:05 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 14/18] arm64: dts: qcom: qcs404-evb: Define VBUS pins
Date:   Fri,  7 Feb 2020 20:16:50 +0000
Message-Id: <20200207201654.641525-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines VBUS detect and VBUS boost for the QCS404 EVB.

Detect:
VBUS present/absent is presented to the SoC via a GPIO on the EVB. Define
the pin mapping for later use by gpio-usb-conn.

Boost:
An external regulator is used to trigger VBUS on/off via GPIO. This patch
defines the relevant GPIO in the EVB dts.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 501a7330dbc8..b6147b5ab5cb 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -4,6 +4,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include "qcs404.dtsi"
 #include "pms405.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	aliases {
@@ -270,6 +272,26 @@ rclk {
 	};
 };
 
+&pms405_gpios {
+	usb_vbus_boost_pin: usb-vbus-boost-pin {
+		pinconf {
+			pins = "gpio3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <1>;
+		};
+	};
+	usb3_vbus_pin: usb3-vbus-pin {
+		pinconf {
+			pins = "gpio12";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			power-source = <1>;
+		};
+	};
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.0

