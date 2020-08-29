Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB4CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6959207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598699544;
	bh=1rZZTHYv2srzGJyq4r3KsvCUUvcAAp36hZsvCxBAaik=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hUuayXZvZW9Zdb8niUXQXnlsjOo0UlubRKreNlbj44zB+XFVbuLk/4XCV8WG/9lAu
	 IkORBWHMvd4xRfgS8vekHzVMf0+KCm/go7OehnVnY5Ba8AGbeadtuucrDeiK+28URY
	 YjPhsTUIaVB5dLrOHI9uqKv/FNYYjeRa5s0lGeR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgH2LMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2LMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:12:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960DF207DF;
        Sat, 29 Aug 2020 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598699537;
        bh=1rZZTHYv2srzGJyq4r3KsvCUUvcAAp36hZsvCxBAaik=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5+2Zu9+0ji/9k7BPULSt0zGyr8h/eAh8E6Swaxpm1Snyc4wseqJl0n/17yvNiJak
         ZiC6vJQliFizVeC36aSg879gIi/bDZPpaGOOlYWqGPxv2yOauRnmIkyVqL4GMqeYTu
         ivcUCAn/nuyYsJpXnalLThSyDN9oipFTs8FJEp1M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arm64: dts: qcom: msm8992: Fix UART interrupt property
Date:   Sat, 29 Aug 2020 13:12:09 +0200
Message-Id: <20200829111209.32685-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"interrupt" is not a valid property.

Fixes: 7f8bcc0c4cfe ("arm64: dts: qcom: msm8992: Add BLSP2_UART2 and I2C nodes")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 188fff2095f1..8626b3a50eda 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -335,7 +335,7 @@
 		blsp2_uart2: serial@f995e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf995e000 0x1000>;
-			interrupt = <GIC_SPI 146 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_LOW>;
 			clock-names = "core", "iface";
 			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
 				<&gcc GCC_BLSP2_AHB_CLK>;
-- 
2.17.1

