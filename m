Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E5FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978BA206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G9dZshvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCLMMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:12:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48184 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:12:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02CCCGEG088695;
        Thu, 12 Mar 2020 07:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584015136;
        bh=9pLx/JDIPxBmhZiIzOkrEL6F3h1xEcuH4vs50oU5rAU=;
        h=From:To:CC:Subject:Date;
        b=G9dZshvTqhm0mnbq3AsQgZdynQYlHt+6MlcM4OtAWIrxZJrh9R3AkLRZem4sZ4TR3
         FBz0XLA0odeVLx7DyCORbaJOaAdzRcr9GJns7r4VUpT9pCdlw1WCrMy8yotjXScdC6
         boWAOaBcBK3Z7czIvjgetW3yjyKRVPZVGc6/wmQk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02CCCGT0062832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 07:12:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 07:12:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 07:12:16 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02CCCEGd053591;
        Thu, 12 Mar 2020 07:12:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e-mcu-wakeup: Add DMA entries for ADC
Date:   Thu, 12 Mar 2020 17:42:51 +0530
Message-ID: <20200312121251.4582-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA entries for ADC nodes

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 16c874bfd49a..23f8a9dbb595 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -203,6 +203,9 @@ tscadc0: tscadc@40200000 {
 		assigned-clocks = <&k3_clks 0 3>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "adc_tsc_fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
 
 		adc {
 			#io-channel-cells = <1>;
@@ -219,6 +222,9 @@ tscadc1: tscadc@40210000 {
 		assigned-clocks = <&k3_clks 1 3>;
 		assigned-clock-rates = <60000000>;
 		clock-names = "adc_tsc_fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
 
 		adc {
 			#io-channel-cells = <1>;
-- 
2.25.1

