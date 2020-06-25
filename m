Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79437C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA7820789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgPRy86R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407036AbgFYSNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406015AbgFYSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:13:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD1C08C5DB;
        Thu, 25 Jun 2020 11:13:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so6879723ejb.2;
        Thu, 25 Jun 2020 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+puFNw9Af4Mq8TedQJihgmoj5SF8nSnYlnfkgvsEedk=;
        b=kgPRy86RCjK61P4JzPLhTuqMYAvNraZVLKP9tulRjVRduZf4MVUIK44FoyDWK5AN9W
         YV6rGvqWVCa54W06UOkIFe4I6EDB4OzEXbk5D4/X9wkSA+BFgvmnJM1WSFiOh+qRXnY0
         Ag5jExA0eHugUoGee6cecz76WvIUKzeFvn/wNaaD9aHRdQHYiT0dlwvos2CuCSQ6HUL/
         sYW0WvWtsEbCpk8ZJ5VW78jUSNet/mhjH/EXd/D6UdF4mB4bfIyRTjY1Zhqcem8V6Ix0
         SBX0vmZAyq6OaxD2zc5CmhLJmSn16+EcVDfpvT82XCMz2luOX19POnLemzTi1/fT8ZHa
         fS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+puFNw9Af4Mq8TedQJihgmoj5SF8nSnYlnfkgvsEedk=;
        b=jN46w9bSVMY5RmIuOkl8FfMKwg22kI7nKja3o6p6tLZC7numcjTIO20Qw5SwarK8S4
         GdkIYvcVlEeXHIj+puZ5l15j5FII1zvHPw2yHejlRfVxSUd24zfSswcLBnnvnMqjrYtF
         D1TwK3X/DBGi/xNjQNiTyPYaTit8lZyUzIpB/x8QIKVB2+bHfhOXMBxk4Ui0f60Nxmxo
         tLoYwzYaei0MCB1neF/xCZh7EQWTCJtz/I06fNPxdOjw4444HeCN3RMTJkRF+pCEajvx
         UOVFf6NymjNKdV1copE+sElQ+zTDTDjtcCOzeKUjLeBZ25rd9Dyf1wZLlArSCgbPjuUl
         Ju6g==
X-Gm-Message-State: AOAM532Bo3yrvOe+AzkVHvZjeR0sd0FkM7aUlD7rRfSwV1uasY/jf3Gh
        Xa9wmHygpYib3kZ5CTKMlww=
X-Google-Smtp-Source: ABdhPJxViezGSDGGke+gHlt8fABhYW3e4W/dtt5RdAruP1Pc+E/AZUuQ9/bu6TP3GaLIGKtoQQnntQ==
X-Received: by 2002:a17:906:2b88:: with SMTP id m8mr32248780ejg.509.1593108792100;
        Thu, 25 Jun 2020 11:13:12 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id p4sm19511112edj.64.2020.06.25.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:13:11 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] arm64: dts: qcom: msm8992: Fix SDHCI1
Date:   Thu, 25 Jun 2020 20:12:50 +0200
Message-Id: <20200625181303.129874-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625181303.129874-1-konradybcio@gmail.com>
References: <20200625181303.129874-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit ensures the correct IRQ type is set
and disables the device by default.
The mmc-hs400-1_8v property is also moved to
Bullhead as it might not be present on all boards.

The node has been renamed to sdhci@ instead of mmc@
and the phandle was changed to sdhc_1 to comply with
the newer DTS style.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts   |  6 ++++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi            | 16 +++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
index a2de69292d28..1061fd5404aa 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
@@ -271,3 +271,9 @@ pm8994_l32: l32 {
 		};
 	};
 };
+
+&sdhc_1 {
+	status = "okay";
+
+	mmc-hs400-1_8v;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 43b2e4cd26f0..8ef1cb8ba8ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -158,18 +158,19 @@ frame@f9028000 {
 			};
 		};
 
-		sdhci1: mmc@f9824900 {
+		sdhc_1: sdhci@f9824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
-			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
-					<GIC_SPI 138 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				<&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+				<&gcc GCC_SDCC1_AHB_CLK>,
+				<&xo_board>;
+			clock-names = "core", "iface", "xo";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on
@@ -179,8 +180,9 @@ sdhci1: mmc@f9824900 {
 
 			regulator-always-on;
 			bus-width = <8>;
-			mmc-hs400-1_8v;
-			status = "okay";
+			non-removable;
+
+			status = "disabled";
 		};
 
 		blsp1_uart2: serial@f991e000 {
-- 
2.27.0

