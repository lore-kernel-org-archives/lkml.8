Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F17C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5694B206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhGRjwGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgG1MBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgG1MA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:00:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2ECC061794;
        Tue, 28 Jul 2020 05:00:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g11so8594744ejr.0;
        Tue, 28 Jul 2020 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffWqQU26EKVHaH4j5TG8VdhwKZhWQGA8HNUdkfskr1g=;
        b=XhGRjwGTZha6i/yTV+XGzgtJ19Gpn6Af6MpVejeJZv1Ob0nHEtEPTmGQvdHj3wWeZA
         OJZRDvM6CrenC/peuCellSxg58Q4YTrRF1dHzSaa3fgYzUmbHlyyskhKISTaJ+sLl0Gy
         DfDy1rkA0aRQtYqOIixVSIWH7sBRc1B5idFtHZTITgoTOQ0hfWv1gcGbIdF+boZ1DoAu
         3p7P28gHeupe8x3ElEg43Wi7QvNT9fift1ztA3iKy+3XzofKPQEIaDz1/0ghSRQpXe+U
         /P9e6pouDZGt/j4cNvXT3TlGcB3uuegPRs2iBiaiY084iDzgAyK8sNnGEHgcbTc3mnTK
         28Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffWqQU26EKVHaH4j5TG8VdhwKZhWQGA8HNUdkfskr1g=;
        b=IsfMU3g70eiRBBqp1KIV2gKI7M6I42SfKXbeE9KlYM3SFikGQNB5dZWkQhwU3AMZV8
         G/K6Vf0Toj8cW547bvFd/iwykpdo86TvnhZKsvy7XQLQe2p7VvVSJ/tW5h6Mr7sftNif
         NsdWbQ55xuTN9YHe/Yqq9s3vNJ+zxezhdz9ssGxeUf1DiDmCirbe2voftcvclPoZrgWA
         ZsjUu1XrkCq7GJmlLdF3b1SMybMlMmX+N4kOdAFi259KhnqK9omv0VERXqiLe1p8L2x/
         6NIcwnzYZ5aSMNjWKAf7OAPJrxUTTPbLdvnJQ7XU8bPIrEE2QIbp0QsLT9dCeSpp3KIH
         25ug==
X-Gm-Message-State: AOAM53232v38bdlU4SUzNuIvdmp9V5Gn7DCqmV1utONccmGJjoSHRwMw
        Gii/E8eEWJuUcE2Uuy3hp2A=
X-Google-Smtp-Source: ABdhPJySGywHKrMDtAGMCMCJezKcwlgt4bsxbE49z3gC/dJPNUvkaEKJIGl938aoMrw8a1SBIpiq/w==
X-Received: by 2002:a17:906:3789:: with SMTP id n9mr26589606ejc.512.1595937655665;
        Tue, 28 Jul 2020 05:00:55 -0700 (PDT)
Received: from localhost.localdomain (abad207.neoplus.adsl.tpnet.pl. [83.6.167.207])
        by smtp.googlemail.com with ESMTPSA id m20sm9066959ejk.90.2020.07.28.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 05:00:55 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     konradybcio@gmail.com
Cc:     lauren.kelly@msn.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/9] arm64: dts: qcom: msm8992: Add support for SDHCI2
Date:   Tue, 28 Jul 2020 14:00:40 +0200
Message-Id: <20200728120049.90632-2-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728120049.90632-1-konradybcio@gmail.com>
References: <20200728120049.90632-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will let us use SD cards on our devices.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 188fff2095f1..9b42ac42b171 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -269,6 +269,28 @@ sdhc_1: sdhci@f9824900 {
 			status = "disabled";
 		};
 
+		sdhc_2: sdhci@f98a4900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+				<&gcc GCC_SDCC2_AHB_CLK>,
+				<&xo_board>;
+			clock-names = "core", "iface", "xo";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
+			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		blsp1_uart2: serial@f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
@@ -573,6 +595,42 @@ i2c13_sleep: i2c13-sleep {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			sdc2_clk_on: sdc2-clk-on {
+				pins = "sdc2_clk";
+				bias-disable;
+				drive-strength = <16>;
+			};
+
+			sdc2_clk_off: sdc2-clk-off {
+				pins = "sdc2_clk";
+				bias-disable;
+				drive-strength = <2>;
+			};
+
+			sdc2_cmd_on: sdc2-cmd-on {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_cmd_off: sdc2-cmd-off {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
+			sdc2_data_on: sdc2-data-on {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_data_off: sdc2-data-off {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
 		};
 	};
 
-- 
2.27.0

