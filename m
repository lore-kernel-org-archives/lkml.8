Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43916C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F2620708
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A1QOU0s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgIGJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:05:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56354 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgIGJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:05:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08795RIf124534;
        Mon, 7 Sep 2020 04:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469527;
        bh=ULNn4ZI9/GT34H0QowpCbasQ+rRkc9n66eikBz1aXLg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A1QOU0s7Kb8Cb/GYp0FXOIZyBYBYro567oRP3h4yi9VzBkqEQe6n9cFuUmj4ZvZrm
         gD5y297Adr+qdiUsfs5LthJ1YGtU2cF4oj1u2288OR22DTN3XNZ0mmItigy0HMkLoV
         PyriZ5RgmrAEfTHYrLALgae7hZ+PJu0MF1UJHfQY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08795RU7103488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 04:05:27 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 04:05:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 04:05:26 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08795LSo000843;
        Mon, 7 Sep 2020 04:05:24 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
Date:   Mon, 7 Sep 2020 14:35:19 +0530
Message-ID: <20200907090520.25313-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907090520.25313-1-faiz_abbas@ti.com>
References: <20200907090520.25313-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MMC/SD controller nodes present on TI's j7200 SoCs.

There are two nodes:
        1. sdhci0 (8 bit bus width, 200 MHz, HS200, 200 MBps)
        2. sdhci1 (4 bit bus width, 50 MHz, HS, 25 MBps)

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 0a87fa3ea5f0..1702ac0bbf40 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -273,4 +273,41 @@
 		clocks = <&k3_clks 193 1>;
 		power-domains = <&k3_pds 193 TI_SCI_PD_EXCLUSIVE>;
 	};
+
+	main_sdhci0: sdhci@4f80000 {
+		compatible = "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit";
+		reg = <0x0 0x04f80000 0x0 0x260>, <0x0 0x4f88000 0x0 0x134>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 91 3>, <&k3_clks 91 0>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x0>;
+		ti,strobe-sel = <0x77>;
+		ti,trm-icp = <0x8>;
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		dma-coherent;
+	};
+
+	main_sdhci1: sdhci@4fb0000 {
+		compatible = "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit";
+		reg = <0x0 0x04fb0000 0x0 0x260>, <0x0 0x4fb8000 0x0 0x134>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&k3_clks 92 2>, <&k3_clks 92 1>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x5>;
+		ti,otap-del-sel-ddr50 = <0xc>;
+		no-1-8-v;
+		dma-coherent;
+	};
 };
-- 
2.17.1

