Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1597207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDbUMqwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGJTDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:03:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:02:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Nq6071197;
        Fri, 10 Jul 2020 14:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594407743;
        bh=97j5aaL8zaGmvMAo4Y9ttCJ8+X62FhrTxWROvGclG4c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DDbUMqwaZUEHBJFy2GDfyGMvMJPg3MVESv4X1tsNlrcOSECMCsxt+WGunxVdBmqzd
         VTfde6bFoHhlxxfYbrKtKknfzJaQY3iLF82767F7dx9nk3mf6XcldqM/LaMQOI01jL
         8zkUXfXw69vpkuM4Lc7A7HG5MwGftHY17hlHYzbM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06AJ2N8i002836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 14:02:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 14:02:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 14:02:22 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Gm4043446;
        Fri, 10 Jul 2020 14:02:20 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65-main: Add support for sdhci1
Date:   Sat, 11 Jul 2020 00:32:14 +0530
Message-ID: <20200710190215.30938-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710190215.30938-1-faiz_abbas@ti.com>
References: <20200710190215.30938-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 2nd SDHCI controller on TI's AM654x SoCs.
Although it supports upto SDR104 (100 MBps @ 200 MHz) speed mode,
only enable support upto High Speed (25 MBps @ 50 MHz) for now.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 3a4effee8fba..dfb429bed56d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -259,6 +259,30 @@
 		dma-coherent;
 	};
 
+	sdhci1: sdhci@4fa0000 {
+		compatible = "ti,am654-sdhci-5.1";
+		reg = <0x0 0x4fa0000 0x0 0x260>, <0x0 0x4fb0000 0x0 0x134>;
+		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0x0>;
+		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr50 = <0x8>;
+		ti,otap-del-sel-sdr104 = <0x7>;
+		ti,otap-del-sel-ddr50 = <0x4>;
+		ti,otap-del-sel-ddr52 = <0x4>;
+		ti,otap-del-sel-hs200 = <0x7>;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		dma-coherent;
+		no-1-8-v;
+	};
+
 	scm_conf: scm_conf@100000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0 0x00100000 0 0x1c000>;
-- 
2.17.1

