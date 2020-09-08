Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F8121D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvoXEciH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIHIFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgIHH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E5C061786
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:57:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so9484092pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVSf2eOrndrAFT6QUUuIacL06FJeCrpQS/XjWnR+m+g=;
        b=mvoXEciH3g8cWyPFw9lkTqVILJbvJy/xomNt+JSdkBHHQNF2MlRH3EQjTsB8fq73HL
         2OZCi1DOBNI99po5o1KJh8+/J1arFAi5xBt0YYPBLBFwx9NqCcwg5QyVZt+CFyU4APy4
         yc7mNeeXusKRsmrPx3hq6my8gSLdit/IQwU3NM0Q8MlimrqEOp8DNDuQ5G99nQ860Yh3
         GnlwLFicuh0PSeLacjzMz5W0R+65KY9RJ2tj4FsCgn2cYAQ4WTwPQAukCbnzwIrP5ylZ
         kwStDaBvKbOHy67PH4dMpLliQneKVF9eTGavJE0tB+kI1GaRpozoAnjlCxcB4yjo1L4y
         nEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVSf2eOrndrAFT6QUUuIacL06FJeCrpQS/XjWnR+m+g=;
        b=C3mrAZZTAM0pVzMyS1QgBwzLbFdAWyTC2RCIYppdYO/7KXlPJn8EE5zvbgyL0hWdJN
         XKjjY5nGMwH6Noq2QXVmzLPGwBdPpsJNCN7UcWMAX+/QrJneL4tpNp2nQg0KIWHVHXY7
         gL5337CFTEEn1KpAuOgEvv7XCvqebN0bPW0RRAAdFIhZ7OU06AgxJNpHWjO1/+oDi6EQ
         /vCcxNkPNlBQAfi0xO+w+asaM1DErjad9ia1mq7ODQRXcPLlGmniLQIkvchZsbOmi8uM
         eRp41O2cC00GG8BLz2Xmr8oXnwtmL0Yb0je7zDnTDpPBZGqEzrsJ/kdTnUONiE2ZeVsa
         2h9w==
X-Gm-Message-State: AOAM5301VUEM9xSB/cfVwwtnM70Ht2BywZ1eh2xOLATyaYLubEwC8I1Y
        w2eWvYTW1bnviHcGtZZa+sv2
X-Google-Smtp-Source: ABdhPJz/6SYkXXQgE0eri63Ih9i/RSuXmfp61Yk7DuB2kZHEvH+aPSAfVL87BCXdO2+di1y4Y24kkQ==
X-Received: by 2002:a63:2055:: with SMTP id r21mr6448504pgm.118.1599551858556;
        Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/7] arm64: dts: qcom: sm8250: Add cpufreq hw node
Date:   Tue,  8 Sep 2020 13:27:11 +0530
Message-Id: <20200908075716.30357-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add cpufreq HW device node to scale 4-Silver/3-Gold/1-Gold+ cores
on SM8250 SoCs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e7d139e1a6ce..aafb46a26a9c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -87,6 +87,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -102,6 +103,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -114,6 +116,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -126,6 +129,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -138,6 +142,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -150,6 +155,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -163,6 +169,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -175,6 +182,7 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -2076,6 +2084,20 @@
 				};
 			};
 		};
+
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,sm8250-epss";
+			reg = <0 0x18591000 0 0x1000>,
+			      <0 0x18592000 0 0x1000>,
+			      <0 0x18593000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1",
+				    "freq-domain2";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.17.1

