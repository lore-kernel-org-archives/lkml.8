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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79B92072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pS8GM38x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgICNkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:40:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgICNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083D0MX0043864;
        Thu, 3 Sep 2020 08:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599138022;
        bh=kMNiIkBaUV2TaceAbEBwgnU+wNXItG09qohQvECb3oE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pS8GM38x9tHHQ8eEfNguNSjLOzxkfVkbPumQWSiHuRZUuQ6enZX3OvRFlX/M5Uo4u
         pkLCJAvlg/5EzZAMTWUIQ+8tgEkBfcCwWhXBGG+SND2LfCkJfYUhfqo5vq0N2cflmx
         bFkZCRflfgzRJB5TXO3ezt1RwxlYZR/jBZD4ZxZE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083D0MnS028029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:00:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:00:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:00:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083D0LQl084907;
        Thu, 3 Sep 2020 08:00:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/8] arm64: dts: ti: k3-am65*: Use generic gpio for node names
Date:   Thu, 3 Sep 2020 08:00:10 -0500
Message-ID: <20200903130015.21361-4-nm@ti.com>
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

Use gpio@ naming for nodes following standard conventions of device
tree (section 2.2.2 Generic Names recommendation in [1]).

[1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3

Suggested-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
Change:
v2: No functional change, picked reviews and acks
v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-2-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index d53d1ead4bb6..a2fc508e59a6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -661,7 +661,7 @@
 		};
 	};
 
-	main_gpio0:  main_gpio0@600000 {
+	main_gpio0: gpio@600000 {
 		compatible = "ti,am654-gpio", "ti,keystone-gpio";
 		reg = <0x0 0x600000 0x0 0x100>;
 		gpio-controller;
@@ -676,7 +676,7 @@
 		clock-names = "gpio";
 	};
 
-	main_gpio1:  main_gpio1@601000 {
+	main_gpio1: gpio@601000 {
 		compatible = "ti,am654-gpio", "ti,keystone-gpio";
 		reg = <0x0 0x601000 0x0 0x100>;
 		gpio-controller;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index a1ffe88d9664..0765700a8ba8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -80,7 +80,7 @@
 		ti,interrupt-ranges = <0 712 16>;
 	};
 
-	wkup_gpio0: wkup_gpio0@42110000 {
+	wkup_gpio0: gpio@42110000 {
 		compatible = "ti,am654-gpio", "ti,keystone-gpio";
 		reg = <0x42110000 0x100>;
 		gpio-controller;
-- 
2.17.1

