Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2384C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6DB206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qIMuOCjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgIAWbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:31:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49672 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIAWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:31:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081MV67Q120514;
        Tue, 1 Sep 2020 17:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598999466;
        bh=8Jko1+J2Ql6Hyoq21qmTef4+a94rP1K1LzshdhILRXU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qIMuOCjnVH6fV0aVeVSTjk0aBt9DzXDd4iLrA4Y0NJYefbq1tZ/u6KYMlzv80Nzw1
         W8mLh12cfWFNA6rntCAHKIXSPjBMuetjXNM0nNrLwIQCnoiSkLHUlEnqn264XFmU1j
         5auIMfRRRqGFDs3wGmO7nd4Iep3y+B4mmcm47UDI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081MV6wB053958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 17:31:06 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 17:31:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 17:31:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081MV5sQ025371;
        Tue, 1 Sep 2020 17:31:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/7] arm64: dts: ti: k3-*: Use generic pinctrl for node names
Date:   Tue, 1 Sep 2020 17:30:55 -0500
Message-ID: <20200901223059.14801-4-nm@ti.com>
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

Use pinctrl@ naming for nodes following standard conventions of device
tree (section 2.2.2 Generic Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 03e28fc256de..9c96e3f58c86 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -134,7 +134,7 @@
 		};
 	};
 
-	main_pmx0: pinmux@11c000 {
+	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c000 0x0 0x2e4>;
 		#pinctrl-cells = <1>;
@@ -142,7 +142,7 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_pmx1: pinmux@11c2e8 {
+	main_pmx1: pinctrl@11c2e8 {
 		compatible = "pinctrl-single";
 		reg = <0x0 0x11c2e8 0x0 0x24>;
 		#pinctrl-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 0765700a8ba8..bb498be2f0a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -39,7 +39,7 @@
 		reg = <0x43000014 0x4>;
 	};
 
-	wkup_pmx0: pinmux@4301c000 {
+	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		reg = <0x4301c000 0x118>;
 		#pinctrl-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 00a36a14efe7..1d2a7c05b6f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -327,7 +327,7 @@
 		};
 	};
 
-	main_pmx0: pinmux@11c000 {
+	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x0 0x11c000 0x0 0x2b4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index c4a48e8d420a..9ad0266598ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -53,7 +53,7 @@
 		reg = <0x0 0x43000014 0x0 0x4>;
 	};
 
-	wkup_pmx0: pinmux@4301c000 {
+	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c000 0x00 0x178>;
-- 
2.17.1

