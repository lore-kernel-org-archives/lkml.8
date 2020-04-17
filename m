Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354BC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FD6221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+z1H6qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgDQHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgDQHBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:01:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F5C0610D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so632427pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5yt6ZDVqr+7QSHc88Bnrv499SbQQkOFM9/QQvODlrQ=;
        b=i+z1H6qc1RQjl8dF/ZQWkrj1LOmONZiANWqZQj2D1MApZKXOwpspT+eAloxxqIWDgb
         2lxvRDCuJUmPo5f5TTlJ8mQBdorfC+3Sb+nANtWH/ShuFGYtSopy6PHdifjCPMZVjFw0
         AlpaM40+KsDeja6zYbzc2ZmmTZHvG3PuGI2VjJzpwekWr1/xHwTCLj2eRw2dd++Kcv8e
         Xzje+GzPKMh1Dk+AEFwcOENQ6LqmvYTKIHbkteGRf9J1pkfjaBWgL+y1r0LghOq1kuNM
         xnXo6BRHouV9DGEgGcOsahVlGL65Hf3d4c/zFgk9eZUDuLcAnx4GX+ynjLehVLKhyejD
         ijew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5yt6ZDVqr+7QSHc88Bnrv499SbQQkOFM9/QQvODlrQ=;
        b=kZXp/pGVy57mbzq1XKCm9MqY0tyCXFJRl5ucN/8fJfqhbhqi4nPrFO92HBuf6RjoAF
         a+IZTm4Gr4hcQSslUXmV5RZxLvikjvDLi+ISomYg31RPr/ZbPnJ92f1eXfplYU4zj3Vt
         iU/uIm0OiGjjCKGKJRuSJSn34ybRB2nCGZUC7xlGXe7jQ4rriMYV2tuWmlzrKrOEff0M
         3XpSqEv9qcy8qNiY3oB7w6JbdjRXG31BpoC0Wp9nyowNOjfLYN4TN2wA2KFJDlful6gD
         AqPhNjzgiHPL9G/ynwq8G1zx+Jjrv8kzUZbVVWNHyGbF4pibzuU3apG4OdZf+7dewioM
         u7BQ==
X-Gm-Message-State: AGi0PuZnqoBT7uUoknaT2RoUuKpUvOtfdBKy/AVly4M+uCmLWOjfJESz
        NfiFuSGO7So6jWGEQrr8yh5hJw==
X-Google-Smtp-Source: APiQypKAPouxJUj8ZEHXCCyGsr9aFHrJPhULvsgTpcyEK+wS31hk0TH+VbwkpYL+s3wPwKVaYlchtA==
X-Received: by 2002:a17:90a:68cb:: with SMTP id q11mr2759270pjj.15.1587106873385;
        Fri, 17 Apr 2020 00:01:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c125sm18561609pfa.142.2020.04.17.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:01:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: db820c: Add vdd_gfx and tie it into mmcc
Date:   Fri, 17 Apr 2020 00:00:43 -0700
Message-Id: <20200417070044.1376212-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
References: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
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

Changes since v1:
- Polished commit message
- vdd_gfx -> vdd-gfx

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi        |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 4692b7ad16b7..fc23b381c5e4 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -251,6 +251,10 @@ &mdss {
 	status = "okay";
 };
 
+&mmcc {
+	vdd-gfx-supply = <&vdd_gfx>;
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

