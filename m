Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B5C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6124656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7BXho3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBZL6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:58:32 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34326 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBZL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:58:31 -0500
Received: by mail-pf1-f181.google.com with SMTP id i6so1365468pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPkKnyITMi7kXeWtbSlS/aIAUZOsi+vJbY5BLkxXdmQ=;
        b=q7BXho3MER91BYoSM7ZxFTBBAxzMlvZ1q0Yk47po4Wvj0Cc0eLOaKYVMV8Q6cpMIok
         TpQLs6TP1k05LIhzfvVfjkslkrwRBJAVpOVwgb8t40/2LzR4ZilDjPK79QbyBBHerIY3
         bpDv/smKFTaeQs0mooDMzL9vThHb579io6ZQOJgFMuk+Zh0zCraepLQR0U/Sc0vmGsJg
         wiI1BWsWa3uiJTdaVF4pTcaC87NCa1MadgXGqtVjqxhuZjXBq2lWRVrwWwFLgwEZb8Wl
         50Pkbmq2MyHPWYk5X48YJUkDiQiv6VAdLHpp8Xqi4b4O5N6+F5mIxf2sH9R+lCxOY2IX
         tKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPkKnyITMi7kXeWtbSlS/aIAUZOsi+vJbY5BLkxXdmQ=;
        b=tSWw7NzDJ9d+1GhsRlQDspHAOc6XsWyz/GUxICtANSBao7GfadaAr8SQEyDfOWs+DB
         hOsb+lj/tAxLLeC9g2DvZU2n4shxE7BZwXIv5fWBOJ9pZ9wxwehyCUGhKtvBxs9dXRV3
         mf645jmMvsn1UoFOjZaMnJ704xcScvDAKaB/YMccqan2NkaN6rrQLqPNxg1YwVXAaBEb
         FG6wOGUzj3tr6uGb9Vcdqo3Tkc7QrbGVenX1Mc93uqR6K0yh1hFMUPEU05NU0m67GpnU
         Gu0ke7+JvDv5prfgvNQd1ltTKhZXKOp4QLDVOwmGScsUXxW8+C5EEv/eQTDebKoP5WwF
         L3PA==
X-Gm-Message-State: APjAAAXkYgVrIEcWPyyq2isI2KYjxzzXFLfX+/hkwBQYxu0wzKWUYg4f
        w25Fi7NLFTvH68onvz5ZJiVhP+OcKVc=
X-Google-Smtp-Source: APXvYqyAwBWs2W6AYgIUWs8Q01aW/TGfyDQTaU/xJ9kSZLluYVEiiIouadrDmBlXt/kqoSH0iXbiQg==
X-Received: by 2002:a63:8148:: with SMTP id t69mr802349pgd.187.1582718309433;
        Wed, 26 Feb 2020 03:58:29 -0800 (PST)
Received: from localhost ([2401:4900:1b38:7f42:3530:df3:7e53:a029])
        by smtp.gmail.com with ESMTPSA id z4sm2612966pfn.42.2020.02.26.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:58:28 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: thermal: tsens: Add qcom,tsens-v0_1 to msm8916.dtsi compatible
Date:   Wed, 26 Feb 2020 15:01:12 +0530
Message-Id: <ab6a982bd9bcbc76262cd9ca5dd6ea10cf45b8a1.1582705101.git.amit.kucheria@linaro.org>
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

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9f31064f2374..1748ea3f4b4f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -860,7 +860,7 @@
 		};
 
 		tsens: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8916-tsens";
+			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-- 
2.20.1

