Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14960C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82AA206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BA5C0Wn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCXEOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:14:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgCXEOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 00:14:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id g6so6886985plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T69bRb2s79v6mVWn4EWd2/OYfDJncKnDm5jmozPySY=;
        b=BA5C0Wn7NBVQXGrmWomyQWvsPy/LeDYI1b7sL/u2hVqx3A67AwAX7cQRhv8QWhcjVK
         CNpwF1DlstGiNNaL7xIQRg/xC4iUWfOZjMm31ap9YFRArB3bl/HoCQLcxkJWno7szXW/
         bnYBxrmcKww3sEnUdxCwvpcLTB0eSUozYTIa/bobbXSWyXtNRyENTQawd2x7HJXthM1T
         AswFLeRT6N4O2QoSf8DIjEuaQR0BClr6j/WtY1cddUGVliUNLekenybuJebMBuHfp5dZ
         C4erExbp/FqY62dNyPKz5U2+wGQj5Lauigj2nn/Wa+uwDsnMox2R8Vc0ZzjNBOg+uXgp
         vptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T69bRb2s79v6mVWn4EWd2/OYfDJncKnDm5jmozPySY=;
        b=iinPuaeZrlXJ6jPPsLdHY7RGgatDXD50rVfdlkiv5TuFkDhCqaqDTb4cILsZ0hq79s
         FOEPwP43inrBAlaEHK63MpzSj+M+H0xNqqJY+DcGXkdEk4ABmZuUlF8XHq+3NJBNj/GN
         iiSmF4KUfFMVKGKB+BNczVRU4tEfMZtUksbEq8ZcH2D5w9oKepqGkERTtAGc8QPxnsbr
         /jLvcHeT4UHXvQS3WK1yYcwkHWd0dQCTbVqHlpV0hACo1QrGcSE3XHcMp6z3k5vTaxUs
         oyLkqXaAVT5VyunqsdJ5aHKUDGMxPv4I5hVRBsypc79QjD+1V2AcjOkaXYcVQTUmsK5e
         1T4g==
X-Gm-Message-State: ANhLgQ11jebJVV6/KmKTz5Ui1cmVouARkznvFl8M3AkBLscFEcHn4uim
        7erQvEgHhdEi47/c/BbbLQe1ow==
X-Google-Smtp-Source: ADFU+vs3vTtFax5gOxD9+V6KUE8KavbrNs3XGpg2sO175Mnx2sIhX9QL4nOY/bbE/Ot+Io7Q7M74EA==
X-Received: by 2002:a17:90a:5d16:: with SMTP id s22mr3094518pji.118.1585023268849;
        Mon, 23 Mar 2020 21:14:28 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n30sm6998865pgc.36.2020.03.23.21.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 21:14:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] regulator: qcom_smd: Add pmi8994 regulator support
Date:   Mon, 23 Mar 2020 21:14:24 -0700
Message-Id: <20200324041424.518160-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmi8994 is commonly found on MSM8996 based devices, such as the
Dragonboard 820c, where it supplies power to a number of LDOs on the
primary PMIC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../regulator/qcom,smd-rpm-regulator.txt      | 13 +++++
 drivers/regulator/qcom_smd-regulator.c        | 47 +++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h              |  1 +
 3 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index d126df043403..dea4384f4c03 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -26,6 +26,7 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8994-regulators"
 		    "qcom,rpm-pm8998-regulators"
 		    "qcom,rpm-pma8084-regulators"
+		    "qcom,rpm-pmi8994-regulators"
 		    "qcom,rpm-pmi8998-regulators"
 		    "qcom,rpm-pms405-regulators"
 
@@ -143,6 +144,15 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_bst_byp-supply:
+	Usage: optional (pmi8994 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 - vdd_s1-supply:
 - vdd_s2-supply:
 - vdd_s3-supply:
@@ -259,6 +269,9 @@ pma8084:
 	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
 	l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
 
+pmi8994:
+	s1, s2, s3, boost-bypass
+
 pmi8998:
 	bob
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index fff8d5fdef6a..fdde4195cefb 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -445,6 +445,44 @@ static const struct regulator_desc pm8994_lnldo = {
 	.ops = &rpm_smps_ldo_ops_fixed,
 };
 
+static const struct regulator_desc pmi8994_ftsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(350000,  0, 199, 5000),
+		REGULATOR_LINEAR_RANGE(700000, 200, 349, 10000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 350,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pmi8994_hfsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(350000,  0,  80, 12500),
+		REGULATOR_LINEAR_RANGE(700000, 81, 141, 25000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 142,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pmi8994_bby = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(3000000, 0, 44, 50000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 45,
+	.ops = &rpm_bob_ops,
+};
+
+static const struct regulator_desc pmi8994_boost = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(4000000, 0, 30, 50000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 31,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 static const struct regulator_desc pm8998_ftsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
@@ -780,6 +818,14 @@ static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pmi8994_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPB, 1, &pmi8994_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPB, 2, &pmi8994_hfsmps, "vdd_s2" },
+	{ "s2", QCOM_SMD_RPM_SMPB, 3, &pmi8994_hfsmps, "vdd_s3" },
+	{ "boost-bypass", QCOM_SMD_RPM_BBYB, 1, &pmi8994_bby, "vdd_bst_byp" },
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm8998_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8998_ftsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8998_ftsmps, "vdd_s2" },
@@ -862,6 +908,7 @@ static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8994-regulators", .data = &rpm_pm8994_regulators },
 	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
+	{ .compatible = "qcom,rpm-pmi8994-regulators", .data = &rpm_pmi8994_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
 	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
 	{}
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 9e4fdd861a51..da304ce8c8f7 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -10,6 +10,7 @@ struct qcom_smd_rpm;
 /*
  * Constants used for addressing resources in the RPM.
  */
+#define QCOM_SMD_RPM_BBYB	0x62796262
 #define QCOM_SMD_RPM_BOBB	0x62626f62
 #define QCOM_SMD_RPM_BOOST	0x61747362
 #define QCOM_SMD_RPM_BUS_CLK	0x316b6c63
-- 
2.24.0

