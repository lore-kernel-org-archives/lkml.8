Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A5C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A9D20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfenHCvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgBGB7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:59:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBGB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so941341wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Kx77RkRZ6BLkxPPbqLY1opgnPyzoSH+OO3s+PAvU9w=;
        b=AfenHCvMQ7EQykW+PXRtakMMVfMZNbR2flNXrUZqeSJsEWinzpKqMDZzjGPWumbA/y
         FoUBsjOWXnEdIM4piKlnOf+4jzEeoFITkIv89WNh9mj84nXwT9HMowLvjPoMBTZTVW5s
         S2vVPteAhCMHLXqHonIA2H+BSiJa6sNjxIyoAp7ox9qahIEZdRqqMaM/V/P+Qs/KbgM5
         XEzLd7Ygn/rN5hommxp8DmQxu4z6QcwkFvUyNEIem4FEJEetKCmWWDi08BVW8q605rPi
         HEFGUPWpHTjld5KF14QSKC0y/ZJ5Sy5t9CXX9a4HgytC70PJAnwWVNLslH4e7nntSNKk
         pkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Kx77RkRZ6BLkxPPbqLY1opgnPyzoSH+OO3s+PAvU9w=;
        b=EeB5/MGbByx3Lxpk28pfRS5kjyE/n+sJgw4x7iFzpTx8Neb/NG6vDU/7WsNO63z3L6
         RewouhymPrXs6VqCq8y4/B6OQkNKvjPt01/vJZHlbhhG7UYV82BnsjTAD9kTsZBxRWds
         6SiO6hpZoZU2yhx/FARScDbUvNQh4yhIvsIrj/usxYfNFyWTB08pp/52Dw3kQYuSCYE2
         uzA7Rn3md0iWaDzoMYfQUJRaMWiBED14maaLPJaP1FOREzE5eoMuIfts+Z/l5QDvkX2W
         nhQAlEMlK+e9rZ9Et+PuZxy8+qOrH2GW/sGExC4oYWC/DtJzTLiL4ccHfyduwJJpbJWA
         obOg==
X-Gm-Message-State: APjAAAVYnTe0Y/pOrAwoTRnHoNwtTlGHfvRFPf+NdqLzNitquBYy8asM
        /4bg2OFnizNl1zYW173MJEjrTA==
X-Google-Smtp-Source: APXvYqwdpE4xr5cnlVFTBvq32+zu+QuVclYrJLX4nilOR/tnwMIXlHi4IHGlSMIhWiGHGvJs+sqdRg==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr962289wmg.146.1581040765884;
        Thu, 06 Feb 2020 17:59:25 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 15/18] arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
Date:   Fri,  7 Feb 2020 01:59:04 +0000
Message-Id: <20200207015907.242991-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
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

