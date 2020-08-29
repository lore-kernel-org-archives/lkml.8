Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5362DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3786D207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uWi6GKrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH2SmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:42:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgH2SmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:42:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07TIg8kK048450;
        Sat, 29 Aug 2020 13:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598726528;
        bh=CvLfEDBP1cV+XJ98X1HPprMDsVRKMQGtAYqZfAsenXI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uWi6GKrcTazD/ZFHQrF3V08YZ25iCz9odOa0AGVNARdzr0IRjOgSS/EpgBwBXui9+
         flO8FJKIfaH/btwjZ5SudCNsWpWh16bRjCGd3Os6RSUM+6axYvDxH38UBenMScOowp
         0EXVp5lHKJssXtzQ3pj86Pd+tMt1YEKX5VAg0ShU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07TIg8wU028214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 13:42:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 29
 Aug 2020 13:42:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 29 Aug 2020 13:42:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07TIg6EZ055968;
        Sat, 29 Aug 2020 13:42:06 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 3/3] arm64: dts: ti: k3-am65: ringacc: drop ti,dma-ring-reset-quirk
Date:   Sat, 29 Aug 2020 21:41:39 +0300
Message-ID: <20200829184139.15547-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829184139.15547-1-grygorii.strashko@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete "ti,dma-ring-reset-quirk" Ringacc DT property.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 24ef18fe77df..245c0d534ff1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -590,7 +590,6 @@
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
-			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <187>;
 			msi-parent = <&inta_main_udmass>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 51ca4b4d4c21..64c5192796c7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -135,7 +135,6 @@
 			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
-			ti,dma-ring-reset-quirk;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <195>;
 			msi-parent = <&inta_main_udmass>;
-- 
2.17.1

