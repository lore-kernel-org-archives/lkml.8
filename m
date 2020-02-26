Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B4C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C3424687
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtHw7wnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgBZL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:58:26 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37149 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBZL6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:58:25 -0500
Received: by mail-pf1-f171.google.com with SMTP id p14so1359797pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+p6H2ZNLGX3Lb58Cw5KgycQ+ehTxEdhQmQiKBPEVO+U=;
        b=FtHw7wntugTsPmJA8Hv3zkGUse9AWcGVV8zfyXX1B0JrMASYVUKJakSuXEn1KrB/Pt
         QIJPr2O0Db6sMohzyf4Gk4QUWD+CRjxabGbVkiPvunYbGWjEWNad+6L8k3MGD6rPIzeg
         crg5ft/qyvJbZXcpAL8TjXfOurxwlVVEEKwYbD/7h/MDXb14KLx2HFo4j06Y0BUKMg2u
         nbPImhLQkdKGl91GVn+9aTwGlss+u2DuzQeOi/3j+kw32pQmUaJv88hrUaQha80g1+H6
         Ez7IWRDcccSudwp3zpclmLEeKUTmJf0mZrlGSCnykgJl6Lv7vcQNmZKd+Zwx19ATFELr
         WGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+p6H2ZNLGX3Lb58Cw5KgycQ+ehTxEdhQmQiKBPEVO+U=;
        b=Rn2lTMjJ54vuprcAO5IJpNoPt+PcVQ+xJqoNrqgJA9+d/j7QG+RCxS+WdU/GhCUroJ
         RoFUV7NUZ6seBXtJrHKCKWMoGxWXxxulax82mYzAAY1kZkqq4xPftgkAgtZuilc2dhA/
         6aDrUIuf5nKeMm8P4iYUjbB45aJX4JeOTYNPvWv4cfSZ9+Ma6RjTWZ0SKDc02iIY2HhJ
         fKEjYHzA1t14+1TejPjtsOASOg4d7nLoix0DtQuh4OM6nRDcy62/m9oUvkbjgspAKgzq
         ydGQeiubJv9LDV84x/GjqQvEDdc29QyFs5CMf8rKlNOKFNI0HXZYtUHwUeOVLWto7t+W
         PyFg==
X-Gm-Message-State: APjAAAVyBLL8x6sKSEy0H58bGVFcJed0h2f6smOO4Az9C7ABb+w+nR6F
        zTO96hIUnW7gyilQb42WBEeCsjZyr8o=
X-Google-Smtp-Source: APXvYqywc/mWcONmOZQDx7IkryRxv4cAGf6uuMuuBdzU/6cdnFQDr+fm+1zRmkgIXjTHYcL43CXdfA==
X-Received: by 2002:a63:5423:: with SMTP id i35mr3544009pgb.179.1582718303501;
        Wed, 26 Feb 2020 03:58:23 -0800 (PST)
Received: from localhost ([2401:4900:1b38:7f42:3530:df3:7e53:a029])
        by smtp.gmail.com with ESMTPSA id c188sm2893557pfb.151.2020.02.26.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:58:22 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: thermal: tsens: Add qcom,tsens-v2 to msm8996.dtsi compatible
Date:   Wed, 26 Feb 2020 15:01:13 +0530
Message-Id: <4e337c4a4194bb15f9efec67821f38504de1704c.1582705101.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582705101.git.amit.kucheria@linaro.org>
References: <cover.1582705101.git.amit.kucheria@linaro.org>
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

