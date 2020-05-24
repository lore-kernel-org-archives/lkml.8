Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5081FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF89207F7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="ePhIIRRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgEXCiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 22:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbgEXCiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 22:38:22 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D2C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:38:22 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d1so6620455qvl.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMEu1b3J/IwojZRDEpMoRuW51PykNI3if017dbvv18g=;
        b=ePhIIRRDke9NnAitzlb7qIgG3CGZd4fhekruRDV1xJykdXlkDwcIGSmMSDOHw+W/Zu
         T3R9DCCiWsmQga4DS4Ij6e8LdC/rkcbUdjEJn3OYUhf1210P/GIjgySHFxSB6Ro61/JJ
         id4GtGiBNkULDHl1oh/wO/K+NKFS+FxRDfmDOpuPb5GEZXyfpKbRwd+yHCpVGu1KmlLF
         dt0vjtglLjJCe06IYkgQ44LJOW+iGH1H2V9+Z5alqFaRiuvNHI1ykxEhvU7QL3ox7dBw
         iaOrnXQjUKS22gFtTHVMTeNoDXmrVt+deVu08NlJQJsAXsgNksCVaWGO9UPyHzOZmXBw
         zHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMEu1b3J/IwojZRDEpMoRuW51PykNI3if017dbvv18g=;
        b=T+p6Zc/Wkh0stjXDnZsGHNTFVvbbU/bpm9WQitnarEEH2olZAh3frtolJDhv5c/37s
         3IwEOzB+1JlqdPF8/IQSvCZWdWNHY8QvLA4daaMa0zX+wtqWAGzMyZVK5fV00wRcHoop
         z7ZkGRyNKGh4Ng7x6QtW8zxWQEeUU4+F3VnK+uRtYGe0GRyFXCEXvrplcK0W5vPO3DHU
         D4j1l86ZhAOnfrl4OOq5HLpXkTfk+X3QkvwZstVoAXxRK3rzyJOKHT3OFesJHdIDIJSZ
         EG00uuoUg65bDVBHwsio0q/iHzHZCL8lbJUMxnOCDMsZzlglN4taldJraUNKP9dUOy8U
         3Hgw==
X-Gm-Message-State: AOAM5336T1GiwszAsHzqZMmgw5b2vF5va/61XQ398fW634R11Ta9D14Z
        QLNqycqD3eBGVafb5UMWsWPnHg==
X-Google-Smtp-Source: ABdhPJxahyXYVwfeBQTZEHTN0kE/gPfpRU/KkewlPOuIgOOC0QbeRiA7pfWLsiGeIAYkXPYqXy0pWg==
X-Received: by 2002:ad4:56f1:: with SMTP id cr17mr595101qvb.91.1590287901954;
        Sat, 23 May 2020 19:38:21 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id e3sm11187666qtj.25.2020.05.23.19.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 19:38:21 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
Date:   Sat, 23 May 2020 22:38:09 -0400
Message-Id: <20200524023815.21789-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524023815.21789-1-jonathan@marek.ca>
References: <20200524023815.21789-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dts nodes for the secondary USB controller and related PHY nodes.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 89 ++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index acb839427b12..903514fc299f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -636,6 +636,19 @@ usb_1_hsphy: phy@88e2000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
+		usb_2_hsphy: phy@88e3000 {
+			compatible = "qcom,sm8150-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
+			reg = <0 0x088e3000 0 0x400>;
+			status = "disabled";
+			#phy-cells = <0>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+		};
+
 		usb_1_qmpphy: phy@88e9000 {
 			compatible = "qcom,sm8150-qmp-usb3-phy";
 			reg = <0 0x088e9000 0 0x18c>,
@@ -671,6 +684,37 @@ usb_1_ssphy: lanes@88e9200 {
 			};
 		};
 
+		usb_2_qmpphy: phy@88eb000 {
+			compatible = "qcom,sm8150-qmp-usb3-uni-phy";
+			reg = <0 0x088eb000 0 0x200>;
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
+
+			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3_PHY_SEC_BCR>;
+			reset-names = "phy", "common";
+
+			usb_2_ssphy: lane@88eb200 {
+				reg = <0 0x088eb200 0 0x200>,
+				      <0 0x088eb400 0 0x200>,
+				      <0 0x088eb800 0 0x800>,
+				      <0 0x088eb600 0 0x200>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_uni_phy_pipe_clk_src";
+			};
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8150-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -716,6 +760,51 @@ usb_1_dwc3: dwc3@a600000 {
 			};
 		};
 
+		usb_2: usb@a8f8800 {
+			compatible = "qcom,sm8150-dwc3", "qcom,dwc3";
+			reg = <0 0x0a8f8800 0 0x400>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			dma-ranges;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
+				      "sleep", "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq",
+					  "dm_hs_phy_irq", "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_SEC_GDSC>;
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+
+			usb_2_dwc3: dwc3@a800000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x0a800000 0 0xcd00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				iommus = <&apps_smmu 0x160 0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				phys = <&usb_2_hsphy>, <&usb_2_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sm8150-aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x100000>;
-- 
2.26.1

