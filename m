Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E3120720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="rvDrzBL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgF2VTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390850AbgF2VSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:18:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B05C08C5DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e11so16716599qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqAKdt3lk82f18skm9MplMyKRKUbc8f3Yv5d4peK0Jw=;
        b=rvDrzBL9oaRTkSU8SAuukT7QJGwLhUxfnRkpZyTxizAiY2e1Oc9XwwHlfKMx3hGqH4
         qKrI3U5yFITYIQ2sDbGiuy5SJf6HriSjuR91C6KSwLgvpfDvslIaAjLROikcCUGjWajo
         /UBq2Faf3OnLFFW44PtiMpELZcC18/BstZRsO2cJ4p82nuc/wSsYNI+xdXr5UmUcZRek
         0kxVQLes0GgOUMOqyOjTt4iMPKNDTj/FKE/X+vUJXYBrfp3dnT+5/ybTOWnjXJB+zTQv
         rETIimQQXZxW6CHct5Z44YGKqtPShKjmkWpifUbwNEprdfUhSrfD8ZUwDurhnYthYqgI
         5dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqAKdt3lk82f18skm9MplMyKRKUbc8f3Yv5d4peK0Jw=;
        b=lQaL6hei/F1zA+YsQGRc1Q94rmmDAvLm0k94MpPQ8zMK+kxDicVvcRx4Q/5AhkYlL8
         W3AJ7o7gv5QvBvT4CgBsIE30B1xLsaa9ZwPSGKU7KjbX+wnNuazKKfFV7/MGwmd5GdF9
         VUbcGoVsDk7IQd8KcdRzCmGg7zXp4srXkpnvURhQ8CLilmZE8O88d+0RuJ/HW48THwvD
         yQyA71EeYWsxx13lc2XoEbqoeAbZUKwFA3q+qcsRJEkOvYPIAnLBm734AaFJXcIbaicM
         6SF0SSyGQVxqtO/IXfDyRRwqPukfXX5VrFZ8wvDifF71pLmbhJjMDwWXMCZksiArf2qt
         WbDw==
X-Gm-Message-State: AOAM530j703a8cKSEgUsgN1UbXhI8/djb4x4VjRjT02WCJeu2VRS64Qt
        qOPmJXFhRPpITVfkzWzsUNzeGQ==
X-Google-Smtp-Source: ABdhPJxtxXrGlb2/SgwPt1Qw/HppXJZfUbvqhID8en/5+D27ODSQmM73PZs7HHgKGHkw1d9zdk1VKQ==
X-Received: by 2002:a37:43cb:: with SMTP id q194mr16855201qka.154.1593465532255;
        Mon, 29 Jun 2020 14:18:52 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b196sm1169078qkg.11.2020.06.29.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:18:51 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 12/13] arm64: dts: qcom: add sm8150 GPU nodes
Date:   Mon, 29 Jun 2020 17:17:18 -0400
Message-Id: <20200629211725.2592-13-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200629211725.2592-1-jonathan@marek.ca>
References: <20200629211725.2592-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings up the GPU. Tested on HDK855 by running vulkan CTS.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 136 +++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index f928ef9fa3a3..2be39eb0ce7f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+#include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -540,6 +541,141 @@ glink-edge {
 			};
 		};
 
+		gpu: gpu@2c00000 {
+			/*
+			 * note: the amd,imageon compatible makes it possible
+			 * to use the drm/msm driver without the display node,
+			 * make sure to remove it when display node is added
+			 */
+			compatible = "qcom,adreno-640.1",
+				     "qcom,adreno",
+				     "amd,imageon";
+			#stream-id-cells = <16>;
+
+			reg = <0 0x2c00000 0 0x40000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0 0x401>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+
+			/* note: downstream checks gpu binning for 675 Mhz */
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-675000000 {
+					opp-hz = /bits/ 64 <675000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+
+				opp-585000000 {
+					opp-hz = /bits/ 64 <585000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				opp-499200000 {
+					opp-hz = /bits/ 64 <499200000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+				};
+
+				opp-427000000 {
+					opp-hz = /bits/ 64 <427000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-345000000 {
+					opp-hz = /bits/ 64 <345000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-257000000 {
+					opp-hz = /bits/ 64 <257000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+			};
+		};
+
+		gmu: gmu@2c6a000 {
+			compatible="qcom,adreno-gmu-640.1", "qcom,adreno-gmu";
+
+			reg = <0 0x2c6a000 0 0x30000>,
+			      <0 0xb290000 0 0x10000>,
+			      <0 0xb490000 0 0x10000>;
+			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_CX_GMU_CLK>,
+			         <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "ahb", "gmu", "cxo", "axi", "memnoc";
+
+			power-domains = <&gpucc GPU_CX_GDSC>,
+					<&gpucc GPU_GX_GDSC>;
+			power-domain-names = "cx", "gx";
+
+			iommus = <&adreno_smmu 5 0x400>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
+		gpucc: clock-controller@2c90000 {
+			compatible = "qcom,sm8150-gpucc";
+			reg = <0 0x2c90000 0 0x9000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		adreno_smmu: iommu@2ca0000 {
+			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
+			reg = <0 0x2ca0000 0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_AHB_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+			         <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+			clock-names = "ahb", "bus", "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		tlmm: pinctrl@3100000 {
 			compatible = "qcom,sm8150-pinctrl";
 			reg = <0x0 0x03100000 0x0 0x300000>,
-- 
2.26.1

