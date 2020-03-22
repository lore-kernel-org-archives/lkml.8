Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58BC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8581E20714
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tP5OkVBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCVL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:26:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56756 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:26:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02MBQYtm124964;
        Sun, 22 Mar 2020 06:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584876394;
        bh=rV6bGvKdd7JY4+Ufo6jMxHjB1DmFUcKzhVpTmeJSLAw=;
        h=From:To:CC:Subject:Date;
        b=tP5OkVBeQuE7+WpLRLZDUel/rOm/9pMNqeasGR3reqRjDBP9t9+XWKbZAQ8wRviRi
         jv0m7DZ/P9jf9+vJdoZ+taSZdgIxFqp9ELK4OAPXniVaxqnNXOTAj8O5lUr25Bw8MB
         jU3fWDDrM5pm6/4uBTmuTivzKME7takpiwt5HpaI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02MBQYCP081146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Mar 2020 06:26:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 22
 Mar 2020 06:26:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 22 Mar 2020 06:26:34 -0500
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02MBQV5b089468;
        Sun, 22 Mar 2020 06:26:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65-main: Add ehrpwm nodes
Date:   Sun, 22 Mar 2020 16:56:30 +0530
Message-ID: <20200322112630.25541-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for all ehrpwm instances present on AM654 EVM.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

clk driver and bindings has been merged to clk-next tree.

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e5df20a2d2f9..da6427bed801 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -285,6 +285,12 @@ serdes_mux: mux-controller {
 			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
 					<0x4090 0x3>; /* SERDES1 lane select */
 		};
+
+		ehrpwm_tbclk: syscon@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
 	};
 
 	dwc3_0: dwc3@4000000 {
@@ -742,4 +748,58 @@ csi2_0: port@0 {
 			};
 		};
 	};
+
+	ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3000000 0x0 0x100>;
+		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 40 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3010000 0x0 0x100>;
+		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 41 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3020000 0x0 0x100>;
+		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 42 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3030000 0x0 0x100>;
+		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 43 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3040000 0x0 0x100>;
+		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 44 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3050000 0x0 0x100>;
+		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 45 0>;
+		clock-names = "tbclk", "fck";
+	};
 };
-- 
2.25.2

