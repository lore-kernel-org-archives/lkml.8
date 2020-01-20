Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC422314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snHrV5Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgATQbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:31:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37584 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgATQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:31:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so109552wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ounN3zi0imbgKpbsfEs2C8qMeNLcd0eRtq+ghfuGYQw=;
        b=snHrV5UaYtwhG/1mAVN0g28aL9pRgZSRxNWIJxcloONV8g7TtwkXz34qevv4b0+Djv
         vWumO8D7s9MvaSs5Tf1v1CB2potRm0RonWfHiG/kqsHCVUVmsPTD80waSHX4kSLpRGXx
         rsN5lf64PMmnWzwhT/SAP2PC9AmkeCv04uQIFp4U6UmraQOeDNddTYea0pawPYPYHsMB
         7A/ovV5aRQa/CH0ZWmzUOlXmE7T2/zzy4rkh+cjSVLyIjy7EFSe7SoJg/tgqEBDieLmR
         jQ3j1M09/ad7iVO1iqsYob66HSOO8ELeoO/xUeSV61osw0WC+I9tv19yPDQPCgVlY9Q0
         VZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ounN3zi0imbgKpbsfEs2C8qMeNLcd0eRtq+ghfuGYQw=;
        b=ZAtn1HxqCArOW6q6AYs7z3PQ6fP9DnhY43dAobFHE6G1FmWcKv+UZOuy/kiGPvr9tS
         SAJms1BGdrf+w1itJRyPqpk8mJQp5VzHm/f1kBFMm64J4BEiWgdaqmlbE5elVO9UePNz
         ssJ58dnZp5gzaFKloY4iSO8RutXDOZAy93+Lsp2ulYN/VRF/JMTrX8Sxgeg1h0H/gTFt
         vk+Xa1/YDTXUpLPXGTVz/2Pb5UV/vKfohyGXbK9ia+rhJK5jprymiFMKQIgEYsaScFC7
         wqhQBUloWU0LK4j+YHaJjW+nn+GvETDlxtpwIq2Z4GVMK904mnEjXBzjQ6mDvTvPZQCP
         JBsA==
X-Gm-Message-State: APjAAAUCyvhEFymlsIbEIoSklsqtzFXN1qSETndbz1optaymKPaKSUQk
        lYE9NNOEleDdo6O14lxAhMjB3w==
X-Google-Smtp-Source: APXvYqzqsAek5dun0Q5RAufnmOHfcCIBKXxyArSOYStiBxShzYVWPSCgi4DM0fNIw6sSdilZeVHxxw==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr291642wrr.309.1579537864214;
        Mon, 20 Jan 2020 08:31:04 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:31:03 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 14/19] arm64: dts: qcom: qcs404-evb: Define VBUS boost pin
Date:   Mon, 20 Jan 2020 16:31:11 +0000
Message-Id: <20200120163116.1197682-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 6d53dc342f97..b6147b5ab5cb 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -273,6 +273,14 @@ rclk {
 };
 
 &pms405_gpios {
+	usb_vbus_boost_pin: usb-vbus-boost-pin {
+		pinconf {
+			pins = "gpio3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <1>;
+		};
+	};
 	usb3_vbus_pin: usb3-vbus-pin {
 		pinconf {
 			pins = "gpio12";
-- 
2.25.0

