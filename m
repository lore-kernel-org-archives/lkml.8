Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD05C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116F2465B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUCP0iXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgATQbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:31:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55552 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgATQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:31:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so192052wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TYQNQQWESi4gKsyKl1vTO3f1E3mp/r/avow7BgHKMw=;
        b=KUCP0iXOMGojck9VBZNBRw2+JiHPhupKrykVLxkHtgMaLvcQ6j/cd2QGNjZwrezEMr
         2mUA4Fb0Fywh1IJdvlfUEfxBlnLmifohbs5MyR0IJ+S3V2kQWnfnURxjV4+Famsdnehm
         lHruyqX+VNc9hSsgiDFLLo55zf+KeMkCVdhf3jwd6tGd+aHKnw0DuhukfF8OVTZ4k6Ay
         7Af1bhjBthkJHBjjI7pTNswel5U/eeNGXu/cCwEhNvRNx2IDx9k98nNWOBzNxCDzojNp
         nvWMTt/V3BaJm8T+4B68QHz0V1QFuG6r/Jb6fJpLbxoMFybkuE4gtCR7mcxSTv0D7DI6
         7yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TYQNQQWESi4gKsyKl1vTO3f1E3mp/r/avow7BgHKMw=;
        b=oSPdXG8Lckjs3Md6bdsiJMhLyCqQA/eyr5SAtORKOSA8H7HL2dlIY8fwAc8G0bK5mI
         5iL15uECYL8ymRrjyKPRTVZSUJtRG4QfUU+exMx3ujmnGd41KjA39bR5/7OYpe/kRvLd
         3eebkpwxt9mAJG5X2cA5/sObndz7p3sFkUbwfXmoK0cMT6RcRbAQ9wQ01uX5/fYOJtN2
         mLbkhCCwBZgudfVRD+1CdVgRhmcpl/BMywyoi6eMA5JKhksMtGuxuxfPnxpIa0v+zWgU
         oj+0A4R0HLBIp5SYlwTq6VUc4uXbXLi/yWMOM0Prl5TRAB12R8m/USk8nuKC6FuMLsjt
         wGZw==
X-Gm-Message-State: APjAAAVNe9cxD6EHEN/lFX4WrpYqONwGXMWEpi/kIpgWnaiZNackhzX6
        K8ebAvrL2OYz1S49u9cZcP/27w==
X-Google-Smtp-Source: APXvYqx3mix0N3OSlbE724dBiszE0bIOQv9oqIWm0r574xwA6rZwDk5D5jD9j19ft4X5DAoq7PfbbA==
X-Received: by 2002:a05:600c:2c01:: with SMTP id q1mr142132wmg.179.1579537869792;
        Mon, 20 Jan 2020 08:31:09 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:31:09 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 19/19] arm64: dts: qcom: qcs404-evb: Enable primary USB controller
Date:   Mon, 20 Jan 2020 16:31:16 +0000
Message-Id: <20200120163116.1197682-20-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the primary USB controller which has

- One USB3 SS PHY using gpio-usb-conn
- One USB2 HS PHY in device mode only and no connector driver
  associated.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 07d6d793a922..a2cbca3a6124 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -329,6 +329,35 @@ &usb2_phy_sec {
 	status = "okay";
 };
 
+&usb3 {
+	status = "okay";
+	dwc3@7580000 {
+		usb-role-switch;
+		usb_con: gpio_usb_connector {
+			compatible = "gpio-usb-b-connector";
+			label = "USB-C";
+			id-gpio = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+			vbus-supply = <&usb3_vbus_reg>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb3_id_pin>, <&usb3_vbus_pin>;
+			status = "okay";
+		};
+	};
+};
+
+&usb2_phy_prim {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3_phy {
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.0

