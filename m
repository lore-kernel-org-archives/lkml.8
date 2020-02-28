Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB9C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E59B2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAia9GV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1GdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:33:00 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:36803 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgB1Gc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:32:59 -0500
Received: by mail-pl1-f175.google.com with SMTP id a6so855285plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0WGdBs/BRtkbt1VGWWlFtU3iVs0rs7BsxsJ0Z9JuEQ=;
        b=ZAia9GV/LWifb6zdeE5SJiRiN/n4SwcK8pV3wASoAfhP1RbYa862t+9EohzfH/xQPH
         RLF0pFbp7EDishXlm95n4HIiMxBEd3iw1Ycads7g1/WAo0rgvzew9G+1xg8k7NZTQpMO
         6UzItqBGp63a4fs/Wxj9Ja8V50xyOjH3kn+mEsm2CDORJbQuyYz0zSYFgj9qCvubSjdt
         hVvdKpKtmLTOh95UYH1wRhSHDLZIPwWw2RacSdmzJO6lGDSmBq/xhlRdrgRQSFDnpAf2
         +6juUKu2TCZd+U1wSYA+RzMC2f7gCA5+SoJd6U8tdFuxEcS1ANlK9nAa9WWCAwztkT+0
         eJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0WGdBs/BRtkbt1VGWWlFtU3iVs0rs7BsxsJ0Z9JuEQ=;
        b=sQzmDS5F+43Uvab9lOCcoxuHXzc43AuPNTI5nKxrKfewULIrDwsR6znhlOObQoDzvQ
         WD4+DtoEE2lSVfbFldJoh+HnXi6hysexYFj6rRNhrw6FJnFDLwQC8ziFx33hVniR/W61
         23/IphllxgU5UFKu/wMA83xTcKnM9oYMTwRvCID84/NwZoN3h8L7gLiyWxhfGZQIq0Ik
         7O4LDRB4iSXE2Ob3M7O1yEz37wYY92TAsG3AYKWIi1lg8iCkpeReWoLxIEgq6z/9aI65
         uNogiwjWWm+3+pO8X36up65j2NAWu1RP4fLHjcvIchtKk7wqxBPfrLdIY4sDUsutPHZU
         ITOA==
X-Gm-Message-State: APjAAAVLyEdy58FxhbwJ6QOiENIEPAytp9LPxRPHvPmC+VanknRBpO7Z
        BWq8GGgA3Nv0igkiEGKPcJNEHI/tu5o=
X-Google-Smtp-Source: APXvYqx7AUCLBuZ9ybD3qob3gdKTf/mKwDN3LwBOrf1HM/wCDoM0koyjqn/cGzXaUa0vBUGSBwOmow==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr3063278pjv.78.1582871577873;
        Thu, 27 Feb 2020 22:32:57 -0800 (PST)
Received: from localhost ([103.249.89.56])
        by smtp.gmail.com with ESMTPSA id d4sm763369pjz.12.2020.02.27.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:32:56 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
Date:   Fri, 28 Feb 2020 12:02:40 +0530
Message-Id: <8309e39737c480b0835454cbc6db345c5a27ecd4.1582871139.git.amit.kucheria@linaro.org>
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

Since qcom,sc7180-tsens is not listed in the YAML binding, we see the
following warnings in 'make dtbs_check'. Fix them.

builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible: ['qcom,sc7180-tsens',
'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
causes of the failure):
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:1: 'qcom,tsens-v0_1' was expected
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c263000: compatible:1: 'qcom,tsens-v1' was expected

builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible: ['qcom,sc7180-tsens',
'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
causes of the failure):
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:0: 'qcom,sc7180-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:1: 'qcom,tsens-v0_1' was expected
builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
thermal-sensor@c265000: compatible:1: 'qcom,tsens-v1' was expected

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index eef13b9446a8..13e294328932 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,sdm845-tsens
+              - qcom,sc7180-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.20.1

