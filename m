Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD82C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE038206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u84fygdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgDXSVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:21:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62FC09B048;
        Fri, 24 Apr 2020 11:21:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e26so11609664wmk.5;
        Fri, 24 Apr 2020 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAYQCmL6IU2xY3DJLIY0s7M6/A1t7zEK7ce+EUTohJo=;
        b=u84fygdIrsBH86qD5SGKghp8DXnyg7qSkbkmLvLVWlwrhonzzdwSW1AYHFK2yC/R69
         flipLGa2VPJBxThDXoOGxXceU68RpDespacc5xLSVhQuQrggJfatmOb3NS8uqhOYjjHK
         Ik8EwKPUQ+yevL2z43tW5Ns1QKy33nWsAPcXkosdOoJ1sCHRInDMfUemRBoUoanJvqBh
         MzVSsQqJzwGEADQ9ezgfUJjXTp6RnkXL7CM++U8+PpgAAsAglMXPgYMYN/0ZBYagHU+q
         CNlrZmZ/7cdf1e1QeBs2xHdoRHYW3ugIgJX1sUCWfLG2LeiHDRppV19l8Q7QBIadWLe6
         Wh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAYQCmL6IU2xY3DJLIY0s7M6/A1t7zEK7ce+EUTohJo=;
        b=YCPgUwlUsWjaiY+p5QKJPskmClKU2X5uZcESYtNYMHu+WTIu0Wong47qSibDYfrcww
         VeYXc+OHBJM0JnRbQJGksyjFJ7b9ZzPl35as9smIMEw+tQ5FbDEVHjrAXr0wdNa3mSyX
         qT1psPFcMYH7Py1FhzdS8ft1F3zqdx2G9MTtmSf5SQWmpeMNQMlaXz+DxSAe3AP4T1R5
         SchFJXwcJqTWh10jCec1jriACU5X9aoCO//kpJ0RrXwfPpV6H3AK9u5jAPMJFJFbyl7X
         ukIPHT6qodxhadTM8FVnOrY2qa/fCnTnAMen3Ee+WT7ZMQh4AZf9RBaXPtKrS0rwTWvB
         yQjQ==
X-Gm-Message-State: AGi0PuZYpxOwuu3wfblgga3RGhil+DCMxatOKcP13daHKMz5GeJgb4Ol
        HveXBtua+33nIi7L+YWPhpHTUiunWeKdmA==
X-Google-Smtp-Source: APiQypLUjLMhouWE33cxL9vt13Udxx8+F7+VXu6HcQFVF3uBl85CsetfpYO5KrT/E0cXXHX9BYHFwA==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr11193868wmb.17.1587752500199;
        Fri, 24 Apr 2020 11:21:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:2413:8140:d480:18da:1e39:90cf:b88b])
        by smtp.gmail.com with ESMTPSA id f8sm9338788wrm.14.2020.04.24.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:21:39 -0700 (PDT)
From:   Adrian Pop <pop.adrian61@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrian Pop <pop.adrian61@gmail.com>
Subject: [PATCH 2/2] arm: dts: stm32f769-disco: Enable MIPI DSI display support
Date:   Fri, 24 Apr 2020 21:21:39 +0300
Message-Id: <20200424182139.32190-1-pop.adrian61@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32f769-disco features a 4" MIPI DSI display: add support for it.

Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
---
 arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 93c063796780..202bb6edc9f1 100644
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
+			size = <0x10F000>;
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
index 1626e00bb2cb..30ebbc193e82 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -153,3 +153,53 @@ &usbotg_hs {
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
+		reg = <0>; /* dsi virtual channel (0..3) */
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
+	dma-ranges;
+	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
-- 
2.26.2

