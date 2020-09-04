Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D7DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378E1206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599229280;
	bh=2Wnf/fBW90s75jgjSqUHyNX5dw8LYUh80HL0PzEdIM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMq4DbUaAzYorbMLhm5tnwXeZkV+gnTduyjZKvkFbypQv0xgX6dlMslKizw9A5jm9
	 ibZ10iAOGBAMXZqqL+MbIEaj6LkHlAEbiyL8PBnhGzbWgLoCivUDfX90qm7hDSjRV0
	 /fumhMXsg5NdBiD5DesX5oBf6x7uP9H5l26TGTPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgIDOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbgIDNmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:42:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE612098B;
        Fri,  4 Sep 2020 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599226220;
        bh=2Wnf/fBW90s75jgjSqUHyNX5dw8LYUh80HL0PzEdIM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jauvZCEckkfWlgGScUXaZfvmC5WL2pnegVvaPVWGUeM5MU9kx4kpsrJGfRplm00do
         FQtjhTkKhbpR/GnN/1/6R/r/mLis/lAk0I4XZRpc+CuGPAmeIOuKsLt5asCDs/q7DW
         D4wxSzSWDYwDwdHMov8VOj2Y8M0tLSt4T2zre4ws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 12/16] arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
Date:   Fri,  4 Sep 2020 15:30:05 +0200
Message-Id: <20200904120257.803687094@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904120257.203708503@linuxfoundation.org>
References: <20200904120257.203708503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

commit 679f71fa0db2d777f39c7a5af7f7c0689fc713fa upstream.

commit 742af7e7a0a1 ("arm64: tegra: Add Tegra210 support")

Tegra210 uses separate SDMMC_LEGACY_TM clock for data timeout and
this clock is not enabled currently which is not recommended.

Tegra SDMMC advertises 12Mhz as timeout clock frequency in host
capability register.

So, this clock should be kept enabled by SDMMC driver.

Fixes: 742af7e7a0a1 ("arm64: tegra: Add Tegra210 support")
Cc: stable <stable@vger.kernel.org> # 5.4
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Link: https://lore.kernel.org/r/1598548861-32373-5-git-send-email-skomatineni@nvidia.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1116,8 +1116,9 @@
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA210_CLK_SDMMC1>;
-		clock-names = "sdhci";
+		clocks = <&tegra_car TEGRA210_CLK_SDMMC1>,
+			 <&tegra_car TEGRA210_CLK_SDMMC_LEGACY>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
@@ -1144,8 +1145,9 @@
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0200 0x0 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA210_CLK_SDMMC2>;
-		clock-names = "sdhci";
+		clocks = <&tegra_car TEGRA210_CLK_SDMMC2>,
+			 <&tegra_car TEGRA210_CLK_SDMMC_LEGACY>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
 		pinctrl-names = "sdmmc-1v8-drv";
@@ -1161,8 +1163,9 @@
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0400 0x0 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA210_CLK_SDMMC3>;
-		clock-names = "sdhci";
+		clocks = <&tegra_car TEGRA210_CLK_SDMMC3>,
+			 <&tegra_car TEGRA210_CLK_SDMMC_LEGACY>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
@@ -1184,8 +1187,9 @@
 		compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0600 0x0 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA210_CLK_SDMMC4>;
-		clock-names = "sdhci";
+		clocks = <&tegra_car TEGRA210_CLK_SDMMC4>,
+			 <&tegra_car TEGRA210_CLK_SDMMC_LEGACY>;
+		clock-names = "sdhci", "tmclk";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
 		pinctrl-names = "sdmmc-3v3-drv", "sdmmc-1v8-drv";


