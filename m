Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF3C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3524680
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgELX9jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgAOONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:13:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbgAOONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so7439wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9NPS5QGribeTtMFFZTTzMj+ynOYdzhVsWBEen9DiAQ=;
        b=bgELX9joHOCF4c8wcg5bLvZ9uHtZsi/3FsyK//KbYPrUw6pN7LvXNBNEYrxRO70Rop
         nn+AUaycmrXtYvRkeR229xqVRDf2p3kJhulb6igviGwnVBB+42wXPIqCsJraKKpEeWJ1
         CNeSvEpPmTnxXV7Koldzqb7XJl9y2viuiic6LeLAjr+xw2fdEeXszuCLtRfgyLkuHhRt
         eeMH73fnDAijT9U+X3STFKKzoU1lUx/oEfciCREPiErwhsKX249VKOAmAsMJolHzANSI
         SdBZfet0PZITXICNmLt778RTkTaL1pspzH57s9CdzN2nlTXpK8PDU5ajo3mSRh7uSy8D
         LEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9NPS5QGribeTtMFFZTTzMj+ynOYdzhVsWBEen9DiAQ=;
        b=XXEoPrn3sqGuX5aQkAdVXa1I3FVsDiq+/NDr27+GyusszdKxt5TZLJp3QKFaxGwoDL
         mZyoL+CV+pSHw3zQE3AfldfbiQJ/G4A9szBr9+bjdrq12Ed8+X/LzdARYdEwvscLYx7i
         wzj5TfJSnnK2N/7lxMe7rJk0WozuopO/ZbYNh8ZXnpIvDYFBt3e28HCeH2uZGuGxxB/1
         zEZcVvUYS2VvnHttrBDqGBd5XT2WvASei9QVznWNwfApCiOn22Z/XJAJcEOLVAfXu+1A
         Ol33DZtwyyXGa8j2Kp+M4/q346OOQJsx6RnCP4WuJKvbu0CNXMYWcLrqZFQ3snXDGtYU
         2HBg==
X-Gm-Message-State: APjAAAUP09rCheVzGrjG0UvtoXjTfOa4439rgG7Z5hW8Jd0iOG0ZGdTs
        wPzu6Mz6BWQbZliZdntu5yDtN2x21vk=
X-Google-Smtp-Source: APXvYqw76gxyIdAYFEPqMKjvpzCtwovsDXs6SfcdlT6dpAzF6V+7DXdlLmrcgH28IHX9zjYJMtFEPg==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr35195527wmj.170.1579097610665;
        Wed, 15 Jan 2020 06:13:30 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:30 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 19/19] arm64: dts: qcom: qcs404-evb: Enable primary USB controller
Date:   Wed, 15 Jan 2020 14:13:33 +0000
Message-Id: <20200115141333.1222676-20-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
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
2.24.0

