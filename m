Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14AFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825A320771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhXBAjOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGBR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgGBRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:25:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC7C08C5C1;
        Thu,  2 Jul 2020 10:25:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so16749212ejx.0;
        Thu, 02 Jul 2020 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKcCJcC7Q8PJoAnihwGAVpWoMYH3cBF0KesdV2Y/nys=;
        b=FhXBAjOqlpaiC3ecnywt7k95es1/ZcfGA2/Gx5kmRKXUkyFJUnS9n9AKAKBNfVEFZu
         l4kdLm+DrynoKo9ekZIcOqixss6+IcrN03lfi6UVV9JqFh/R1YHSDsOqvy/jfYgCjHKh
         RKiNjq14ffb2BZZmdIxNh86k98oCaLiI8/jFJfWn/roJ6rhoYreJvRlffrGJ9NkM3UUA
         8MgNfuJ+gvf3/B5eXepTWwLdO9ktFHxu2q7QJa6V+y1uAfTJ56RI4kUSD30d4pCKViaA
         u5W5efPo+o5uI3Dkgkuovaxet2I4Nv2SZnvsdV1etAWmRwW/0NCntDejkYeoPlTiLNoC
         cU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKcCJcC7Q8PJoAnihwGAVpWoMYH3cBF0KesdV2Y/nys=;
        b=N6ivL5RZmyy31+9CEwA4O9bLS+XhRRxtkyJNFz3+hQqXxqoPBFFeixjr2TeW8e5DLI
         Hu3XZjpSDQN3bLAC4L4YxrP+VJ19DwhkkJYNjZs3KLDv48iHOXDE3G/g2XKGEa7Hyyek
         0a/mvj8y5r/WACHGoi56nb0aqFvZndUMSnjkDgNBJTqeFPz82cvu8NeSVlUpAzLi9GOe
         cE86Veffp9bsUSVje9CoDvxes2HdKRLWdeDQ63CWTY1C61yaGGHKjhsSO1VFekQM0qYl
         SIJf6W9B5TDbXY4mwTlmnej8Qi4InQGCa+K/LuXJoaiVQrw+JydsKYPRdJfR/vSA6031
         OlTQ==
X-Gm-Message-State: AOAM530PtaQGSUXWA4mRx8c8rL/vbzbcjNZq/6VJak75Gz+9KOHdCDZ7
        /ycXkVtuK6vCRMycKInTkRU=
X-Google-Smtp-Source: ABdhPJxtGmXlNc6yvDyDRwEnvG2TlYq3vDDk0QPmRiikQO1uJuM5hDhP7g7t9l1Vpp7ZexHL4J5WnQ==
X-Received: by 2002:a17:907:426c:: with SMTP id nx20mr28068480ejb.548.1593710757680;
        Thu, 02 Jul 2020 10:25:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:2413:8140:6d80:2142:c138:da0:5086])
        by smtp.gmail.com with ESMTPSA id p4sm7427033eji.123.2020.07.02.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 10:25:57 -0700 (PDT)
From:   Adrian Pop <pop.adrian61@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrian Pop <pop.adrian61@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: stm32: Enable MIPI DSI display support.
Date:   Thu,  2 Jul 2020 20:27:14 +0300
Message-Id: <20200702172714.158786-2-pop.adrian61@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702172714.158786-1-pop.adrian61@gmail.com>
References: <20200702172714.158786-1-pop.adrian61@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32f769-disco features a 4" MIPI DSI display: add support for it.
On Cortex-M7 DMA can't use cached memory. For this reason I use a dedicated
memory pool for DMA with no-cache attribute which is located at the end of
 RAM.

Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
---
 arch/arm/boot/dts/stm32f746.dtsi      | 34 +++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts | 49 +++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 93c063796780..577a812ca01c 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -48,6 +48,19 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			linux,dma-default;
+			no-map;
+			reg = <0xc0f00000 0x100000>;
+		};
+	};
+
 	clocks {
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
@@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
 	};
 
 	soc {
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			interrupts = <98>;
+			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			status = "disabled";
+		};
+
 		timer2: timer@40000000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000000 0x400>;
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index 1626e00bb2cb..a9e81b49809c 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -153,3 +153,52 @@ &usbotg_hs {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_in_panel>;
+			};
+		};
+
+	};
+
+	panel: panel {
+		compatible = "orisetech,otm8009a";
+		reg = <0>;
+		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
+		status = "okay";
+
+		port {
+			dsi_in_panel: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
-- 
2.27.0

