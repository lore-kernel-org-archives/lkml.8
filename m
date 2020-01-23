Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE370C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A724673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cpDYBLG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAWLpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51748 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAWLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:45:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00NBisCA098625;
        Thu, 23 Jan 2020 05:44:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579779894;
        bh=FNcobQYsMgJmD3mcDnCu1EKfN5SCQ6gDGMEphE7602o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cpDYBLG0v0HqonYNQtzhzn3lPuD4p35J33tyeUiql8CDO4g9locwUAT3Z7+saQN3u
         avqEKYj7kCCTo2U3y3JdFENYUZNPbP+yk3Pu62QK6Tr1d1XeR0T0tac1tJX6jfrEs1
         c9+2Sv0LtHdTGk1fS4ZgLLN2n4/PxMtfwfMGWut8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00NBis91051377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 05:44:54 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 05:44:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 05:44:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NBijBF114078;
        Thu, 23 Jan 2020 05:44:50 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <lokeshvutla@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/9] arm64: dts: ti: k3-am65-main: Move secure proxy under cbass_main_navss
Date:   Thu, 23 Jan 2020 13:45:21 +0200
Message-ID: <20200123114528.26552-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123114528.26552-1-peter.ujfalusi@ti.com>
References: <20200123114528.26552-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure proxy (NAVSS0_SEC_PROXY0) is part of the Navigator Subsystem.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 972e14bf9478..c21315c43c55 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -51,17 +51,6 @@ gic_its: gic-its@1820000 {
 		};
 	};
 
-	secure_proxy_main: mailbox@32c00000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg-names = "target_data", "rt", "scfg";
-		reg = <0x00 0x32c00000 0x00 0x100000>,
-		      <0x00 0x32400000 0x00 0x100000>,
-		      <0x00 0x32800000 0x00 0x100000>;
-		interrupt-names = "rx_011";
-		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
 	serdes0: serdes@900000 {
 		compatible = "ti,phy-am654-serdes";
 		reg = <0x0 0x900000 0x0 0x2000>;
@@ -414,6 +403,17 @@ inta_main_udmass: interrupt-controller@33d00000 {
 			ti,sci-rm-range-global-event = <0x1>;
 		};
 
+		secure_proxy_main: mailbox@32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x32c00000 0x00 0x100000>,
+			      <0x00 0x32400000 0x00 0x100000>,
+			      <0x00 0x32800000 0x00 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		hwspinlock: spinlock@30e00000 {
 			compatible = "ti,am654-hwspinlock";
 			reg = <0x00 0x30e00000 0x00 0x1000>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

