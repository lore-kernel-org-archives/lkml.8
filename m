Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1255C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A25214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNB0eR4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBGURM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37115 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgBGURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:17:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so400631wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Kx77RkRZ6BLkxPPbqLY1opgnPyzoSH+OO3s+PAvU9w=;
        b=NNB0eR4gF6D0akB/wLDQi7VF/G5bIzb4qKIfynYdFaZ8eTK+nyksf4OrlNCNSWq4eN
         KRa2Oyj4VLS97PAlV/QkoMEGde8ibAoR0X520f2kpy7mZPrV6g5iPywabTYNghPWzrhT
         MxWJ67kXwItgti4oSjPqWXq14BFZQqgOJAH6zYs2UU9lyzm0fnn9fUSRaYRPWjF0Z2Db
         dPdWEaiijpGMiSLrFdNVdnQZljOuQHN6XlwqvoZHSCv4esNNqTa2fo1bnUa/nGXGoh1q
         xyoQagw2WIgXTm7N4LRbDsgtmThwMnraMQgWui+YfHnHS5hb9qLT14F/ALxkL+yE+kwE
         RrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Kx77RkRZ6BLkxPPbqLY1opgnPyzoSH+OO3s+PAvU9w=;
        b=En1kUTfilbx9NLLp5moEqM/q1YFKMue1dxDF2k4pogKqxQpv3nYoq0MDlX6kgiNEVH
         BQEeR8YjNz+Xw+ogNGSKPt4UbekLBYzH5mnN7v8Lzn/MQdPOngNmqKbkDJ0f+hOL8JbU
         sutsm/FqpuN+mzI3NRWZ6BXWuKa2BUIAePGzZF1uL5q+cyyJJ0mc2SAkrGkB1rUbNi2g
         Xf0sDyog80mcmrNjj1KuXCHw2uedgCsYudHRWhAqIdDlSX/zEcuBm4etOMsYp7fVnFIn
         EDSaPPJM36IRcK+rfFdh2oFt5W2LV90h6ULv0ZgrYLRogBJi/scaj0O5AsA6suaTx3+b
         adqg==
X-Gm-Message-State: APjAAAUY/nJa37YpojYUUcTVn4YEYvIjzfpWRbsPYPlTv+x9+D9FvVL0
        FWNpnTQ7fhEaGRu1ZJ9AH/x9LQ==
X-Google-Smtp-Source: APXvYqyy9kx88k9/7jnobOn8K+q/1HXrmCbZ7g4EgrcNIObDg4TNQBpwDP1md3U93qBrLs5DOr57DA==
X-Received: by 2002:adf:df90:: with SMTP id z16mr678252wrl.273.1581106628513;
        Fri, 07 Feb 2020 12:17:08 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:17:07 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 16/18] arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
Date:   Fri,  7 Feb 2020 20:16:52 +0000
Message-Id: <20200207201654.641525-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VBUS is supplied by an external regulator controlled by a GPIO pin. This
patch models the regulator as regulator-usb3-vbus.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index abfb2a9a37e9..01ef59e8e5b7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -33,6 +33,18 @@ vdd_esmps3_3p3: vdd-esmps3-3p3-regulator {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	usb3_vbus_reg: regulator-usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS_BOOST_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pms405_gpios 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_vbus_boost_pin>;
+		vin-supply = <&vph_pwr>;
+		enable-active-high;
+	};
 };
 
 &blsp1_uart3 {
-- 
2.25.0

