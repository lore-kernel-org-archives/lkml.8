Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52D5C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C38A2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0mXqGQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB1GdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:33:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35276 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgB1GdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:33:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so855939plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z16ZHpuypSAVdnxOxij5MvVMLN1BTwXGBSuHheXl+q8=;
        b=i0mXqGQr5GdP34akzJU2rXrJDzTsqrX/p7eCKI/ia2WYggc9Ju1+iUOP0ImylqI54T
         IKZX8AnrS+OqtZbM/AcsiLzWkA3iw+DD819cIseEZN+GSnbbddb+cAyMlijjCRPp3YTl
         dQG3CXIhIVahebgHL9zMYwpQIvpTIxC6TMZhdx3VC5FGxMkvCj5aPQ1Wfhmj9H1aBTiL
         tWAVIr6+FJf0qcpTQw1cGyEi/GaGAr4khCC7BGLEPPrzA+amdm+OYT0/j8TWtFTsNOK9
         I5BUCS1TNSU0ugPdvCzMBgqrpS1ksu1zSkdbWbeOoblsDdImhhTxBovEs0BvTG9FT18M
         Q+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z16ZHpuypSAVdnxOxij5MvVMLN1BTwXGBSuHheXl+q8=;
        b=o0Uj7x4m+1IGhja0kfs7ijenkz3lFt2G+YfprOyo69CfR3l6hAhYvB2swTs32DiHzI
         B9f4xOo7WXuH0it1UaGjBT26yxNc5AT4SGvEO6G7sp40lN6LdSp0ho+RSNyD+6tBV0DD
         Jp6T7wrASBleKdJQO1H/OT8bjWAJu2CnEQMxOtEKzcGCODQCNPDuT5/h2EvDBD/zpl/X
         Rwn1z/k9doCDPpQJUpA8X8MyJcCpcXTwA5e3z/V2jNA5UG5IG7X12U0rirCZ5m+xgRa3
         3maJ1+4VB8n4Q+Z/UDVIpJC1+DtfanWM6uxxev4tSRWlNXuehZR/0+up5j2HpfQTO41f
         l6TQ==
X-Gm-Message-State: APjAAAWcwyJilkraIiE73I0YylADud8QyEuATg8isDsMWaOm+KYK2J9d
        xeQR2QL+ikyRDkheqr3QbrGv45IaV+I=
X-Google-Smtp-Source: APXvYqw1CF+JtIMKBXwKc+VzDvcLRXgVhoVWOsCC12dQe/rihzCnhdFZbclxJc7jAwzPUcFCvD5uKg==
X-Received: by 2002:a17:902:9a48:: with SMTP id x8mr2747564plv.14.1582871592974;
        Thu, 27 Feb 2020 22:33:12 -0800 (PST)
Received: from localhost ([103.249.89.56])
        by smtp.gmail.com with ESMTPSA id d73sm9942863pfd.109.2020.02.27.22.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:33:12 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: qcom: msm8996:: Add qcom,tsens-v2 to msm8996.dtsi compatible
Date:   Fri, 28 Feb 2020 12:02:42 +0530
Message-Id: <ebaa801adade53c567857db2f74af7d2e00f935b.1582871139.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582871139.git.amit.kucheria@linaro.org>
References: <cover.1582871139.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom-tsens binding requires a SoC-specific and a TSENS
family-specific binding to be specified in the compatible string.

Since them family-specific binding is not listed in the .dtsi file, we
see the following warnings in 'make dtbs_check'. Fix them.

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7ae082ea14ea..f157cd4f53b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -446,7 +446,7 @@
 		};
 
 		tsens0: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
@@ -457,7 +457,7 @@
 		};
 
 		tsens1: thermal-sensor@4ad000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004ad000 0x1000>, /* TM */
 			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-- 
2.20.1

