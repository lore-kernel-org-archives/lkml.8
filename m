Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1038AC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D735A2468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzGzNrF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgB1GdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:33:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33348 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgB1GdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:33:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1001446pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkEbZBsxGEThjxYxGgqBaNrj1wvJ8iaeS+bs8Ztam2I=;
        b=rzGzNrF/Rg3EkWxdteAPXEfTHCj9bCkeTByedr4Hf/MCRPNCnQzxPbK0yH1T8b/bIQ
         vG3T2ioCoQVTKAkmB5zt0r8gmD4lij35lpAzYLdrzPsq/gaSy9Qup3mSy/G+57GbHpF4
         LEtWNQ0MiSb7elILS8/fLFGTgK9DNLpcVNsiplVV0kFEdiwdeHR4F3NzzmSCCym4Mo7F
         nTP1aQmcMsS5ddOKD038zrAU64VwwX7UvJQdfdL+aStf9BfKc5r5MvPmbjpVWDTDslzW
         7iz0cgNRK84pd1bq64Nk3xajYW7WMSuV/UFtxV4+u3/VrELWcxbxQgbLQ4UtG3dGj+4k
         p+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkEbZBsxGEThjxYxGgqBaNrj1wvJ8iaeS+bs8Ztam2I=;
        b=oAs7E83sZlBnOfNtA7SvHaapZGKOo0+C1uyzWnyOKmCYp5K9gRmaqIisOaj7ay/KGg
         stC9nNzkRMyYDUFXpVs/+YjYkIekaD+I2WvxAw9UY75Il2jKNZOohHh2D4C+171oyyv/
         6Xq5/VzYrg5MCu7B7EMt+P1Iv8SktJIdUtvtPNesH2KqbT3LGBwkbKKQvHUzCtaIDNY9
         FpFHgT4kD0JPn6BRpggAwKxq42UcEGQfLFJBn4Rgbi8dGflCzJfVl88TUucR035NbECW
         0n4cVPj+RtN6k8lMm5XreJYFfj/slUftjj7keAHBrnSK/jp26wW80m5/BqjTYMSZx52z
         svUg==
X-Gm-Message-State: APjAAAVAKdBZUA1S5JPIDjjmwEdzvCrBuobjyOOBaesvfEcUmluZZGou
        wdbdLPOKWi+a1NHyRQy8wDxh4D1HtIA=
X-Google-Smtp-Source: APXvYqw7RMpAfoT1rtWKgIuWXZ4gzLaSRjWPE9Nu5HnIAuaJ0wxx69K8YobmDiXTDBdb/EtHCR306Q==
X-Received: by 2002:a63:7c16:: with SMTP id x22mr3091016pgc.335.1582871587136;
        Thu, 27 Feb 2020 22:33:07 -0800 (PST)
Received: from localhost ([103.249.89.56])
        by smtp.gmail.com with ESMTPSA id 4sm10048207pfn.90.2020.02.27.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:33:06 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: qcom: msm8916:: Add qcom,tsens-v0_1 to msm8916.dtsi compatible
Date:   Fri, 28 Feb 2020 12:02:41 +0530
Message-Id: <8cea8c0036703bcc4dd2b87a8ca3913c4a28d16e.1582871139.git.amit.kucheria@linaro.org>
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
Reviewed-by: Vinod Koul <vkoul@kernel.org>
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

