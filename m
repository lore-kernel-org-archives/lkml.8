Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E55C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC85320674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qfwac1tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgESIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:20:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54826 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:20:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04J8KVUw104110;
        Tue, 19 May 2020 03:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589876431;
        bh=99xg+f+DsihApuSq8GEWJaX4IKZmwEVE27Km+1QV/ZQ=;
        h=From:To:CC:Subject:Date;
        b=qfwac1tRvCz+5L3MJ0XtyWmLq7zlTLebllBuBPNX+Z7fLGrphH/HrwZXdsT7se6Dk
         IwVuJQXIE1HDLPCVZcH7ODiW+uKMuw6gUy0uT+GKgI5Lm0QD4rSvqGfoFleNmKsGTC
         kQQPN2BLbmbjGnZ3P6VIQnsUKSJPCVExTGPbyqC8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04J8KVAZ078580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 03:20:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 03:20:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 03:20:31 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04J8KSv3095476;
        Tue, 19 May 2020 03:20:28 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <t-kristo@ti.com>, <faiz_abbas@ti.com>,
        <nm@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am654-main: Update otap-del-sel values
Date:   Tue, 19 May 2020 13:50:27 +0530
Message-ID: <20200519082027.5726-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the latest AM65x Data Manual[1], a different output tap
delay value is optimum for a given speed mode. Update these values.

[1] http://www.ti.com/lit/gpn/am6526

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

v3: Updated values to the latest data manual revision

v2: Updated to the latest mainline kernel

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 11887c72f23a..056130a126f9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -244,7 +244,17 @@
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		ti,otap-del-sel = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0x0>;
+		ti,otap-del-sel-sdr25 = <0x0>;
+		ti,otap-del-sel-sdr50 = <0x8>;
+		ti,otap-del-sel-sdr104 = <0x7>;
+		ti,otap-del-sel-ddr50 = <0x5>;
+		ti,otap-del-sel-ddr52 = <0x5>;
+		ti,otap-del-sel-hs200 = <0x5>;
+		ti,otap-del-sel-hs400 = <0x0>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
-- 
2.17.1

