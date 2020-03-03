Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697B1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9220866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzZyOfUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgCCRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:12:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36535 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730706AbgCCRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:12:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id g83so3668892wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGNTAFqXsi7D5stT0DNXt+Hv8uO5S+gOsoBxWrDsv3g=;
        b=wzZyOfUmn3V6z5p5vP7MOmOL0F5Cmh1jDgzI3QD1HjW+4XjQ8Hev1ljsBgZu1dYG7t
         IYXAnG+Moabo3pR78T0cZ926kKAZ218rmfHQxxZsZerHxft0NAPyF1g04v0RIM5NXKx9
         7etEFcEJ9yiYVk/aVi0M5xgvmOPkj3X+trPhrNuML1SkFkg1OwaVZ3Jwj66Te4DJnud2
         Fh2GJhBP9qpQ5p9mXYgsTKj1z5QgNzD6hRlyOh0Mu7oNgFba46xQc1olp9THJAybTBlK
         61MlGYnd+dw0YI086BjClDk9kqrftZdL7U30Vr9NOAR9wt47ACb5al2hN/e8BZHu91r8
         NLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGNTAFqXsi7D5stT0DNXt+Hv8uO5S+gOsoBxWrDsv3g=;
        b=O8E3Kc48Pb1Gs3vD0/8E/SOv8elirPF/+fqO0PF/GoiMOmbseCZmFM6Z4xEdNHstyV
         tY99BSEJk0BIliSoc6xTOsOSXM3ieWGtKsLly5Zsj0oceIexHaiXcTG41cVNNORjpZQB
         wq5xY14X1pG6tjaVDw1HuBKGu+dvSydvOMau3U9iJtmWdl2oy06Y7VVCuSjRnV8qrMTW
         7FK/NQcZG9x185IKcfpnt+yrA9yqEqLxkLD7+OUNbQxaKYUcLUhKrm2amCQfTuubS8Pa
         ePgP5swcMEsq3A0JGMR9y0MUPtFs/rFjMuTAlaEZ3TwriSfU0UOW76vXUai6UN79pNTt
         vOaA==
X-Gm-Message-State: ANhLgQ2VYfQ/NOVZQ03pXigBP12rPYWLDCqMhEbmfjlXRzDe6U2JbPfB
        BqxINO9oLM+JNBpRNWqCfmeFxw==
X-Google-Smtp-Source: ADFU+vvOhzRL7NuzophBFliwar9a0QIHZz0rYBsuA6eN/MXyW5ytE5FgayCW4lonuqLSp6ucIdKeuA==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr5114959wmi.188.1583255529920;
        Tue, 03 Mar 2020 09:12:09 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:12:09 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v7 14/18] arm64: dts: qcom: qcs404-evb: Define VBUS pins
Date:   Tue,  3 Mar 2020 17:11:55 +0000
Message-Id: <20200303171159.246992-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
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
index 522d3ef72df5..62ef9c34b04e 100644
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
@@ -271,6 +273,26 @@ rclk {
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
2.25.1

