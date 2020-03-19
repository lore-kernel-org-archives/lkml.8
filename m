Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D3C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D822E20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X53gtvJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCSFkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:40:53 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34166 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgCSFkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:40:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so1899374pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwffIuMpvk4MGqf+N9hfygy8Mho+4EUVsVCSokGeAQw=;
        b=X53gtvJLmWBUrskrgljJXYHsNsA8qA7LLIjZjGx/ddYmqslDXrqXaEZJCj2qZWkTb9
         CpypERtzO85ih/v5b6/6ZC+0zhqOSCD3I9UNaFZiwwIdNffhPq1cAT7nPidTHZOMyHKT
         WM7vJFaWjdnwV/0PgMs89NSnqn/Jb5jiSe9inOaXf80SsfP/kDso2RyiF+HHEoCEm1k7
         ywpPjIP4fMNCeiBWJ1u/C4foUCnOjKSO4XcU9u4WqY+Y2Pfc6N7BOI9koVnOVy6c0yEq
         wCrkeqOSVgWTtRJMziShLlsQbPuoqXSdmizzw/+wlhCC3V4VRNKB0QM1E4o9O/6tLw8K
         V5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwffIuMpvk4MGqf+N9hfygy8Mho+4EUVsVCSokGeAQw=;
        b=SK+OEVnhODPwOQ0Pizihy2pGBhJfj2VD/sbTmWRfyghcalHKx6VDlnIvYWOLiy00xR
         5Wf939qiSXBj23jAlTOD0ssaZ1X4L+W7Nhmltvx4kz8lM/gzQ2PuxZ4oPUQWqP+ZXug9
         qP8vN/AmZRHCtfDvpY1NISGMKplV9DLEXw5ooLjo9GGTDnA6H+lGrvFuTYiTgio9H3PW
         0FlT4IrEZt9iNCcGERH/8jKrpblX/JM4cssZYFRHX+Av+gd+g5cBQeIsqViffyH2Un8B
         IXsAT4IX1vBfqn5Jj3xjghVY+6GoSqhPgmEnKrZhA5nGD1tH/Fv/VEi7gagMTkXXZG/U
         HaCg==
X-Gm-Message-State: ANhLgQ3tHN/XyWqWe0UMLSPjpW1EGcF+CEN7ZNX0YBsWKtbB7JbgEbw0
        aLQ/woaIf/XEqxQ6C4Sshtk5jQ==
X-Google-Smtp-Source: ADFU+vu9i8jbX+n972WNpB0F25HnwNcSfJC5HNFNCANPQazM0JhMj0i565gk6eYk+vMAwS88xlSXpQ==
X-Received: by 2002:a17:90a:1954:: with SMTP id 20mr2110292pjh.106.1584596445739;
        Wed, 18 Mar 2020 22:40:45 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l125sm229126pgl.57.2020.03.18.22.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 22:40:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Subject: [PATCH 3/4] arm64: dts: qcom: db820c: Add s2 regulator in pmi8994
Date:   Wed, 18 Mar 2020 22:39:01 -0700
Message-Id: <20200319053902.3415984-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Add the SPMI regulator node in the PMI8994, use it to give us VDD_GX
at a fixed max nominal voltage for the db820c and specify this as supply
for the MMSS GPU_GX GDSC.

With the introduction of CPR support the range for VDD_GX should be
expanded.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[bjorn: Split between pmi8994 and db820c, changed voltage, rewrote commit message]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi        |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 4692b7ad16b7..075cebaec3f3 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -251,6 +251,10 @@ &mdss {
 	status = "okay";
 };
 
+&mmcc {
+	vdd_gfx-supply = <&vdd_gfx>;
+};
+
 &msmgpio {
 	gpio-line-names =
 		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
@@ -688,6 +692,16 @@ pinconf {
 	};
 };
 
+
+&pmi8994_spmi_regulators {
+	vdd_gfx: s2@1700 {
+		reg = <0x1700 0x100>;
+		regulator-name = "VDD_GFX";
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
+	};
+};
+
 &rpm_requests {
 	pm8994-regulators {
 		compatible = "qcom,rpm-pm8994-regulators";
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index 21e05215abe4..e5ed28ab9b2d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -26,5 +26,11 @@ pmic@3 {
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pmi8994_spmi_regulators: regulators {
+			compatible = "qcom,pmi8994-regulators";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
-- 
2.24.0

