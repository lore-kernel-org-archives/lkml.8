Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E78C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5B2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnkSITsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgAOOOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:14:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgAOONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so15855590wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5lQULX+yUwHv5XMzEJucZ8DcrReQYvUY/O37J2kQ8o=;
        b=YnkSITsVTshLQV4EMf+fMMHXz6TS8qGBd1+2Q06UQtPEcF9e4+AKjLXXtOXKRMuNqT
         hlPitzrDNvivBteQaXdWMXPX2tk/cUY8YKP5rip1f7mssDVHYpW/PJPNhpIgCL10ufhr
         ydShyfBWuajwnbkn6GGm2Dj3u2q+T/Cmz9QD6632qJMxejkJnojow/6I3tpmiJRC0ukj
         Os6cVnEqWWt7ZApmQrjYFbEBgjWiTJk/Jr8BcbPdlN4K53WE6a0lMAIS/qTAbXUBEDHs
         sBa6d3tsyflBOPrxXVx2edQ2/rpyleoaeG79JpON/IghaCHizC4wZoGuhCSkPS9kwuxE
         oDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5lQULX+yUwHv5XMzEJucZ8DcrReQYvUY/O37J2kQ8o=;
        b=LLHJ19++7KZ0MMpBFmotdQfjT2LIPzsj0vl1QxGg0eo5Ig6nNxTY1eQ5QGdTJNbAJ5
         +7FKnafzyqDw3DBPSQu6LHAYzUY8jZD6TDwXhULs7huwm06yGf8gdUDZwmmhG7UreQ9y
         4YYSWsTlBE3t9Aw1O8pbI3VFDwWJmy5Ac1k2z56jULcOEtMvRbX/WFfwQuQko1pLoDsQ
         OAX5CMud41JqEoCtsH6nsd9wXC3NV3+J4GviXH7TFl1GOlbm8K3qhe3JP+gQKLfSRHd1
         ldlYMXXM/KD99VIZ9vG/ZWmn023B0OcN+GxYLHilnJshxFfsya16hK7Ayr8gxqxZ7Gob
         2fRQ==
X-Gm-Message-State: APjAAAVVGxR+UIJoGYHDr0hK78OYLVKSKlv5fTPPpshm8ntPyHCpBnYb
        +Y0fp/ZP/naox4eYk0lYjkOBUw==
X-Google-Smtp-Source: APXvYqyWlWYp1D3ymXhZOoKi85s14OXS6495ZQyTvPoUN0GVo7hIVz2r2/GZX1kxXaP58OWM51Qdzg==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr30879101wru.353.1579097603256;
        Wed, 15 Jan 2020 06:13:23 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:22 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 13/19] arm64: dts: qcom: qcs404-evb: Define VBUS detect pin
Date:   Wed, 15 Jan 2020 14:13:27 +0000
Message-Id: <20200115141333.1222676-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
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
2.24.0

