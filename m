Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1DC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF5F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tzD4Etlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgICNmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:42:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50430 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgICNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083D0MqY018315;
        Thu, 3 Sep 2020 08:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599138022;
        bh=DJpeR2zSM9k1Y4CHH13Y6YYK31nTkzelZoin+HSNZQM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tzD4EtlpcH9W+Ahwj8P57LvMk5fUY9R/xXTt26yrY+HBU/flxaCMmv/ZW/stk+yq5
         8rhksPr1neZ4wjFHP2AUjijzF33VCUkwAunG/rm3FR/F1fcSUj1V24eTw69pYals6X
         pnzAMEDkMRK1Zg2tYLk9mXMbe1JX/YeDyTCMphuU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083D0Mqh028033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:00:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:00:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:00:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083D0MqL061651;
        Thu, 3 Sep 2020 08:00:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/8] arm64: dts: ti: k3-am65*: Use generic clock for syscon clock names
Date:   Thu, 3 Sep 2020 08:00:11 -0500
Message-ID: <20200903130015.21361-5-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serdes and ehrpwm_tbclk nodes should be using clock@ naming for nodes
following standard conventions of device tree (section 2.2.2 Generic
Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
Change:
v2:  added ehrpwm_tbclk based on review comments.
v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-3-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a2fc508e59a6..63a1299cb0b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -327,12 +327,12 @@
 			reg = <0x00000210 0x4>;
 		};
 
-		serdes0_clk: serdes_clk@4080 {
+		serdes0_clk: clock@4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
 		};
 
-		serdes1_clk: serdes_clk@4090 {
+		serdes1_clk: clock@4090 {
 			compatible = "syscon";
 			reg = <0x00004090 0x4>;
 		};
@@ -349,7 +349,7 @@
 			reg = <0x0000041e0 0x14>;
 		};
 
-		ehrpwm_tbclk: syscon@4140 {
+		ehrpwm_tbclk: clock@4140 {
 			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
-- 
2.17.1

