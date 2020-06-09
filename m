Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B12C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3534F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="VQS/zNvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgFITlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389300AbgFITkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:40:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B3C08C5CA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:40:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so18643935qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WcoXpI3zumFD6GXBhxwQCLvdm8lNnHTHO06BBAcncnY=;
        b=VQS/zNvjUY0GpD9fegTplksKEVAPxp7x8c7YMIdAbszDtBycBHClZWCut9e7oOTzHu
         thobLB6Y+gmWg2bRW1yyGgqfyJvH665H8D4WVMP0O0/RZMzIlzc255SvDd1tSAAFtCcH
         HkmkqbJ2zueib2m/lzkn5qg/4RwiEazuGNM5gV2DkcVRdOB1BSE/MntWLfoFaEpkWvZ9
         FeWGCdAB7TC7WG/YGu7fXjPRbTHSidXHpWNXUI/+tD83vBbvo/Lou5eON1YCVDBf1tPi
         Tg0HIYrRvWm4efcrrSZRQyRAEXEJNqM0DSRmVu0rHNDjHtvuwuNznBQXZm2tbKRcRdvZ
         8t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WcoXpI3zumFD6GXBhxwQCLvdm8lNnHTHO06BBAcncnY=;
        b=Cpuo3hR+XQEQeps63mKeZNrqOe6ErW/L3GpmKpsUPsqbHthQWPVwjnz3QZO7ZQ3mPl
         oJS9xEyrtrDEdAp/wMxHEkeY+hiB7kkgD5fhq9E+wzYzsfjv3ZddltpC1j6rNKfPbKYd
         I5DBa84e/2NdCHxwdIKy8J8IhfQJ5Ji9s6naagDskISYEBSK3jVwc5LUmMBZzOO14Abu
         0Fzpt5VudRi6yY8J3zbFuUDH4RzDcf+McsMt2f38qCVkDWbRekJjnv8R7iWtTsorGdzK
         1/Nc8o/mIPvVgGO7uTdzmeBcCMP0gf5hrw3Fq0Ip9tYTmY8gawP+01ZYvQrHix6qU8AD
         LxmA==
X-Gm-Message-State: AOAM530m84nf+DXsP41GkBeVoarHMfAJH7KEGv6tpznN0KKI/yo84Elk
        gbbDgh7SIPHTibVu7ZH9dq2uZg==
X-Google-Smtp-Source: ABdhPJzpDokLrIZrlzjwSAlshLGYWWNYq60vxKNh1Rb/+VWx7hNAVRLwtdygaEZ6nDkCe9cKJF4Pqg==
X-Received: by 2002:ac8:341a:: with SMTP id u26mr30392217qtb.36.1591731639481;
        Tue, 09 Jun 2020 12:40:39 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id v8sm10513181qto.21.2020.06.09.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:40:39 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
Date:   Tue,  9 Jun 2020 15:40:23 -0400
Message-Id: <20200609194030.17756-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200609194030.17756-1-jonathan@marek.ca>
References: <20200609194030.17756-1-jonathan@marek.ca>
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
index 5b48dbaee2d8..f928ef9fa3a3 100644
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

