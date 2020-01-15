Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCEFC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C162124656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gs/z4tk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgAOONf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:13:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAOON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so15893240wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAQIBEtAB539ew/tof0mNoTYE3sNhscOlsV6pfoQF5g=;
        b=gs/z4tk4uFXXpj/yR4pB6Y9QVxyxwScRANH5ordeJtq8PSbgKFB4RS0FmPEndaNOby
         idsxHHb+xh0XR7tA+nsp+f73HnB0SIKRMWzbLQIy1MPD1zYGnGc7Gi4on33Dqg3SxtSs
         I2mFJf47QTsU0r37z588nkk1sKl//Rc6r0f2EX90EmZnJ0EWSkQbeaeYMYrUGiPtrFFF
         EFQUQQIEXBhARL4asIi7vRhf4bjU67B4PLotwT6jfw8+IDgEu33xSFja/esqsDtDexMN
         KEanjCsHPesyOLZrnA3QKbuklE1CMcHj4VRrrtH3qijobgMMNtwEf/Q/CRDyD6rdsKfo
         i6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAQIBEtAB539ew/tof0mNoTYE3sNhscOlsV6pfoQF5g=;
        b=njKzhXs++UB2mZJz4xLPMoDRCQtWKtYbCzslF5o8kDoBoWbUWs3DZKNs2xH2oErr7v
         bXi2c5lhwV7c1prSp3pbvS67ClSLDjB3sQ3I9sQqV/0pTKbThwqtN/meripdD1qEkk8F
         4h9lUwgxE5vArZ/difpm9nYvB090Z83J6J+Av06elxo++TV08nE7Mm/PSc1WGHYrmBST
         T/8iNXwdN5cWW2BuZu7/Jxpc3M0gmqALsfyIrf9PienQbuDMbZRGpXO7zOfdqkoHe0Ec
         QTNpI3vKVja5Tm2F4elPsPSuhN+EF+Gfb7mdpCL9DD5ECANqMHvtcJa9cO1TONj+Xsow
         Denw==
X-Gm-Message-State: APjAAAU9PNcJmVBd+Uhzy9FO8TCyMP4oKv8NnSmlI0d3mEcLxDWgAHev
        4GD+Cr6baXrtr/mRaoDTE5t6FQ==
X-Google-Smtp-Source: APXvYqzBNIB6sLizgF8/elzXx2JKJwR3Qm2h8MtVZZ6TJ6hyaGw3jAbQWdFFHKTn2qlDFLT5G/I1vQ==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr32581677wrq.348.1579097607065;
        Wed, 15 Jan 2020 06:13:27 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:26 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 16/19] arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
Date:   Wed, 15 Jan 2020 14:13:30 +0000
Message-Id: <20200115141333.1222676-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
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
2.24.0

