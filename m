Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78EBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD01A20724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464152;
	bh=T0SH2MBau/vAFhm4Mhmw/Rl8QEln2vPcejd7VRcavP0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XX1aSlz6fNaiePm7eRdxiUItM14f6D+F4ONEHpsmvgo6FtVcxoG+4FgF4asXZigw/
	 Teo2efLR7syNwp7X0zTnHjY5/8LfjmHtaVPMuNZ1nMJYnKH3vvXRYNfE0ec/YQnGNh
	 eeglGcsgNUwf7hmAHtGnIEQ7jdx5AWonzVG8nHrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgF2Uzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731454AbgF2Uzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:55:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AD4206F1;
        Mon, 29 Jun 2020 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593464131;
        bh=T0SH2MBau/vAFhm4Mhmw/Rl8QEln2vPcejd7VRcavP0=;
        h=From:To:Cc:Subject:Date:From;
        b=t1BWymo2kEX9aAiUgSn2GQ0D3j7aGOybDuL2/rfkLTI7enjMFY/i8loN+XZ2jazK0
         YUpCE6GQxcCy4gVj/UgZO6ojhnv/MdlQvZCwfYiQELKP/BgxRC3y0kyVKrav/L1HHo
         tGDRmHzG9g0xTD6AzRds8jIprlK/Lq9oNvUAVJZc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 1/4] arm64: dts: exynos: Add PWM interrupts on Exynos7
Date:   Mon, 29 Jun 2020 22:44:39 +0200
Message-Id: <20200629204442.17336-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required interrupts to PWM node on Exynos7.  This fixes DT schema
warning:

    pwm@136c0000: 'interrupts' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index f590891efe25..523547b3d539 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -581,6 +581,11 @@
 		pwm: pwm@136c0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x136c0000 0x100>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
 			#pwm-cells = <3>;
 			clocks = <&clock_peric0 PCLK_PWM>;
-- 
2.17.1

