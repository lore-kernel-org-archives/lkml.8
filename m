Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C7DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06562075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QGSgLCyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGJTE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:04:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50014 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgGJTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:02:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Qhh024832;
        Fri, 10 Jul 2020 14:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594407746;
        bh=sN1g4cqo1Aq2bCsd+grKG6xPau517lgjK4Sgbn4Xfds=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QGSgLCyDHG6EeI6RSeYw5WPfkLrYertzg2+3ulwUn06bbt669Bp8YLJvo/vy/ayOI
         TgP21RfNl09LRhSNNLlMY2VwFcKpDMXJ3fVRDtLzdurbiI2GMI/AOube4iDe0KqHe0
         oPTatyVZb32bITf5Ac+Uiigx/dyh6npbumfUiDjU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06AJ2QU5102709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 14:02:26 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 14:02:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 14:02:26 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Gm5043446;
        Fri, 10 Jul 2020 14:02:23 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add support for SD card
Date:   Sat, 11 Jul 2020 00:32:15 +0530
Message-ID: <20200710190215.30938-3-faiz_abbas@ti.com>
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

With silicon revision 2.0, add support for SD card on the am65x-evm.
Boards with silicon revision 1.0 are susceptible to interface issues
because of erratas i2025 and i2026[1] and are recommended to disable
this node.

[1] Am654x Silicon Revision 1.0 errata: https://www.ti.com/lit/pdf/sprz452

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 9fc7898a6a3b..84aeb4761ac0 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -167,6 +167,19 @@
 		>;
 	};
 
+	main_mmc1_pins_default: main_mmc1_pins_default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0) /* (C27) MMC1_CLK */
+			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP, 0) /* (C28) MMC1_CMD */
+			AM65X_IOPAD(0x02d0, PIN_INPUT_PULLUP, 0) /* (D28) MMC1_DAT0 */
+			AM65X_IOPAD(0x02cc, PIN_INPUT_PULLUP, 0) /* (E27) MMC1_DAT1 */
+			AM65X_IOPAD(0x02c8, PIN_INPUT_PULLUP, 0) /* (D26) MMC1_DAT2 */
+			AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP, 0) /* (D27) MMC1_DAT3 */
+			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0) /* (B24) MMC1_SDCD */
+			AM65X_IOPAD(0x02e0, PIN_INPUT, 0) /* (C24) MMC1_SDWP */
+		>;
+	};
+
 	usb1_pins_default: usb1_pins_default {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8) USB1_DRVVBUS */
@@ -299,6 +312,17 @@
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
+/*
+ * Because of erratas i2025 and i2026 for silicon revision 1.0, the
+ * SD card interface might fail. Boards with sr1.0 are recommended to
+ * disable sdhci1
+ */
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
 
 &dwc3_1 {
 	status = "okay";
-- 
2.17.1

