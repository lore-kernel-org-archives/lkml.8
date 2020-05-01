Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A265C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EB9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nF0S/Ix3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgEAUux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:50:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35706 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgEAUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:50:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041KoieY011974;
        Fri, 1 May 2020 15:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588366244;
        bh=zmQ0mjzGNhW44pzXDpOCBwmzSMzXitLMH0t78LayFRo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nF0S/Ix38BDUbVni4UF5hUi0K7uCbsifRRM/jh3syZaznBXvqxSXmacpSyMRbzpjt
         VuV3PLF1BFZLCt9vXOhARlyYVrEJT+aqsvRuIF/korBdmL28wxDCCenSErk9+92qdg
         MQty+aEfn/Gtujm14vmrPQKawEpSAG+Lp23trVYc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041KoiuX088859
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 15:50:44 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 15:50:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 15:50:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041KohVA026568;
        Fri, 1 May 2020 15:50:44 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 4/7] arm64: dts: ti: k3-am65-mcu: add cpsw cpts node
Date:   Fri, 1 May 2020 23:50:08 +0300
Message-ID: <20200501205011.14899-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501205011.14899-1-grygorii.strashko@ti.com>
References: <20200501205011.14899-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the TI AM65x SoC Common Platform Time Sync (CPTS).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 353d1e2532a7..0e773e0b3f89 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -247,5 +247,24 @@
 			clock-names = "fck";
 			bus_freq = <1000000>;
 		};
+
+		cpts {
+			clocks = <&mcu_cpsw_cpts_mux>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 570 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+
+			mcu_cpsw_cpts_mux: refclk-mux {
+				#clock-cells = <0>;
+				clocks = <&k3_clks 118 5>, <&k3_clks 118 11>,
+					<&k3_clks 118 6>, <&k3_clks 118 3>,
+					<&k3_clks 118 8>, <&k3_clks 118 14>,
+					<&k3_clks 120 3>, <&k3_clks 121 3>;
+				assigned-clocks = <&mcu_cpsw_cpts_mux>;
+				assigned-clock-parents = <&k3_clks 118 5>;
+			};
+		};
 	};
 };
-- 
2.17.1

