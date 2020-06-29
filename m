Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB4620720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464150;
	bh=s00t8QAICtoS+oej5Dnz47NSxZXSwZMp0RvcKaYJvGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xlk24Ibh78qIpdNTr1WCHmavrq1Iym1LW1liCaGoQdstkLdPZqQ9/H3fFjVnf4/uF
	 3GHG+p3zOXM6tMQeMwJnPZubyTTasOWjzU7N1Ue9bzp9fBlSi6DzbSgn9sdHW/Y5co
	 4LiztDwX0WzAsTivcFY0iWPY5hTacjooWVaN8B+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbgF2Uzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389939AbgF2Uzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:55:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E782071A;
        Mon, 29 Jun 2020 20:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593464141;
        bh=s00t8QAICtoS+oej5Dnz47NSxZXSwZMp0RvcKaYJvGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT1cJRPXEdX91MeClkRsPqigq1yiDEPTP20KyaT3+in2wGS3jfjUiGUlhfhmB40Qu
         jTfgJ2pSG0qVl4S9RI6hqKau9K4b9+vzIQ/QXXVYim2vm4VnFk8J/5hQqZ4CqOQGp6
         2HMOzlz6fKqpme2tVo8FkuCRC2tX60UgWFXVf278=
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
Subject: [PATCH 4/4] ARM: dts: exynos: Align DMA controller bus node name with dtschema
Date:   Mon, 29 Jun 2020 22:44:42 +0200
Message-Id: <20200629204442.17336-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629204442.17336-1-krzk@kernel.org>
References: <20200629204442.17336-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMBA is a bus so name the node with DMA controllers just as "bus" to fix
dtschema warnings like:

    amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 arch/arm/boot/dts/exynos4.dtsi    | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi | 2 +-
 arch/arm/boot/dts/exynos5410.dtsi | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 044e5da64a76..71010417b16f 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -418,7 +418,7 @@
 			status = "disabled";
 		};
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d2779a790ce3..ed22d60570a7 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -669,7 +669,7 @@
 			status = "disabled";
 		};
 
-		amba: amba {
+		amba: bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6135af7ef39..98299ed38b7c 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -679,7 +679,7 @@
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 		};
 
-		amba {
+		bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2eab80bf5f3a..a55b1a5f1a1c 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -189,7 +189,7 @@
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		amba {
+		bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b672080e7469..c3de26ac79dd 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -433,7 +433,7 @@
 			power-domains = <&mau_pd>;
 		};
 
-		amba {
+		bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-- 
2.17.1

