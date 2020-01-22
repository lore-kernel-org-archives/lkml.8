Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8EC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC78B2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZnJ4iPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgAVS5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:57:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgAVS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:56:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so242321wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yws95nmaJZSmNzRJG51ZJDH/5MHh+qOjv+20GRqLWDg=;
        b=vZnJ4iPZ59f0fnLvjpTpglKMUam+smVSpL1yV9BVjGNp6xiw4sx/uUHhWvtctLMXJq
         faBo50ev/bAB6ZtNDkCBWjgbRXNkNi2BULhkrwOmOyczwzccOu0x5Q03ZjXbgJFPNyEE
         ZpqJ+yKC4e8QgTAEvj8KMhqJV2EGSQ/kTx1j2nBjQ7t2mtBiWHsA7D+3VLdMnGjOg4MC
         eg0DSKsDgowfnYpnqmFWwNBlBbmUZzFFLcP97i4uTxqbVAzaZ19C25G4FylUZ/XCRjb9
         /Cmm4WneylhMLASeHCaQBlfKuBRxFrxXlkaEk70iRB/yd6/9Dd7NeTJmy/lUn3MV0g3P
         JO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yws95nmaJZSmNzRJG51ZJDH/5MHh+qOjv+20GRqLWDg=;
        b=S0A318UbWW2tPB7gMPCEMf0NXpZr9wFZ+FYprGU/qECK5U6W6nzsiJU5xhIq8gyZjx
         KKDWvZzelXY93/H9jeuaOgtsDjy9PIPsaeQDGpH5aCqsX3+IIMhOWiy6ViwgntK5aISv
         joak/4Y4E2y90WkE8KNFsjh3exVaH/7QolDARmhTgmcaj7ttLDoLBtNdAOSnIAUpFztI
         TiqTKTxmsU24tNKF+zXdsFEindTNMcxVWnXD7v+31IJrEp2Xpqos9bNvG3Dq/5Nf15HN
         +tQDOb3Py36DMoJc7ofeXG8ksSlX3XPocWdYEpltQHfx3qU/m79Xb2XQqFUd/4oP0lSt
         Kgcw==
X-Gm-Message-State: APjAAAXc7js5AD5l8Qr46ck0lG8Pjl6mEFyceA1l0CW3RtE0DTtObFYN
        yWqkBUCdf0XhTW5lIybQSRqWgw==
X-Google-Smtp-Source: APXvYqwMR3wvYTUmeAvdj4H6+sCYEjV4Z7c6gYmKvbiOaaunUeGRjD8Nbs4wkgIMKzYOJrV1UsNviA==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr12507414wrt.366.1579719389239;
        Wed, 22 Jan 2020 10:56:29 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q15sm58590390wrr.11.2020.01.22.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:56:28 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 13/19] arm64: dts: qcom: qcs404-evb: Define VBUS detect pin
Date:   Wed, 22 Jan 2020 18:56:04 +0000
Message-Id: <20200122185610.131930-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
References: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VBUS present/absent is presented to the SoC via a GPIO on the EVB. Define
the pin mapping for later use by gpio-usb-conn.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 501a7330dbc8..6d53dc342f97 100644
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
@@ -270,6 +272,18 @@ rclk {
 	};
 };
 
+&pms405_gpios {
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

