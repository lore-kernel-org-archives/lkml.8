Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8662076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="ysnKismi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHRQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgHRQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:06:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19279C061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:06:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so18699842qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67bzRpoZHKJN4TvGSl4PLgugaZtDFxIwY3BiNLQUAXw=;
        b=ysnKismirQG3Tn/AWM5af8ZsuO66oyYjlC/XxOVL660MqjUFVAcXSzK/8QG+8pmW5p
         VvxFtplJo/hpwUz7BNvpln85+THAg+OSXp3do0b98244SkuJdR6JWAQ0D/fIQ3t1boq/
         pS32ajeF8bnUiuuL5G4Czk80Lfw+/9RW1hxpyN9ZriTGIlzPuftRUh7lf5j+V02r8lTk
         3QyTiDTdlzXG8hRUZnwvPmqHGsdQIfsAPOZ7bBQr8UjU60NQcaQ7dFw1jbTvoVLysE1k
         kOjD84peUIoX90nR/xEkMuF41sqlrjtXmIFS9fszVPPBgzy+04NEn222ksRXSEBjyFKe
         bL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67bzRpoZHKJN4TvGSl4PLgugaZtDFxIwY3BiNLQUAXw=;
        b=H2sh+kQBkoSD2xX+8hN1Ao60ieeUcRcBCZlRe2yA9VHM68Pki+dbwsWIrH3FWkywLM
         RYcDMPR0+rGZuQi08N8nUDwd8IQxVYybSSJ50DSndo0asMFqroFcKbUt1QZOcoKdKwAU
         r5gobsiMFmS132wmOTVmQgK12n56/Wgxwo93aGiOB/g14ACHrlI1PTCFbzJT//wzXzGi
         16UC28fo23RhLkx3pjY1i5uwLb+0sI+KMWF1sJrE7ZUjUcGSFYtntVwO9yoAftKLVWoc
         cxRvhPDcFXlWq5BQU36PRW/Yrpn5ibnOa6GrLP5ZI80aeKdDLxsr0PwzwImxh7Ua4FGs
         4hnw==
X-Gm-Message-State: AOAM5313napHQGhpV1Huu9W4tInX1GcoHaH32wbSe7LgI0NKVAMBP/Oc
        5qECxn6k6ltKZ10rSpndwoVoyA==
X-Google-Smtp-Source: ABdhPJz6YaHblVdUsO+t038UhP2eYwsT5GekIzGt1V1IH1hyXGi171nMB5ywW0xqb0tN9HseqE1rrQ==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr17419632qki.116.1597766779360;
        Tue, 18 Aug 2020 09:06:19 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 128sm21198034qkk.101.2020.08.18.09.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:06:18 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] arm64: dts: qcom: use sm8150 gpucc dt-bindings
Date:   Tue, 18 Aug 2020 12:04:44 -0400
Message-Id: <20200818160445.14008-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200818160445.14008-1-jonathan@marek.ca>
References: <20200818160445.14008-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constants were used to allow merging separately from the dt-bindings,
switch to symbolic names now that dt-bindings have landed.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index ab8680c6672e..62d49e81483e 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+#include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -621,15 +622,15 @@ gmu: gmu@2c6a000 {
 				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hfi", "gmu";
 
-			clocks = <&gpucc 0>,
-				 <&gpucc 3>,
-				 <&gpucc 6>,
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
 				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
 				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
 			clock-names = "ahb", "gmu", "cxo", "axi", "memnoc";
 
-			power-domains = <&gpucc 0>,
-					<&gpucc 1>;
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
 			power-domain-names = "cx", "gx";
 
 			iommus = <&adreno_smmu 5 0x400>;
@@ -674,12 +675,12 @@ adreno_smmu: iommu@2ca0000 {
 				<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gpucc 0>,
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
 				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
 				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
 			clock-names = "ahb", "bus", "iface";
 
-			power-domains = <&gpucc 0>;
+			power-domains = <&gpucc GPU_CX_GDSC>;
 		};
 
 		tlmm: pinctrl@3100000 {
-- 
2.26.1

