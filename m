Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328FCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C61208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EqXCp9hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEHIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:30:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47926 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgEHIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:30:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488U39x039926;
        Fri, 8 May 2020 03:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926604;
        bh=n5ZSPjhEIIkUp9d3Jl7xGHJ5hBMzchVvaKvoKXO74cU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EqXCp9hdkFWTdh7pRfMQrGepudXdbcIB22Osyu1KzjM/JayhnAFhxBlJxWS1m/5ei
         z8lpqaB1FRBA8WVhQV3qPet346PRaIME2K6ZQOkW9wIxh8IjCYDK2f7358blrlyKGV
         ozWAXKiljX9kr8+KKyTyNNLkJuVM+wdP5PLruCok=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0488U3Mp103526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 03:30:03 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:56 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TdnF073953;
        Fri, 8 May 2020 03:29:54 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 6/7] arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
Date:   Fri, 8 May 2020 11:29:36 +0300
Message-ID: <20200508082937.14171-7-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508082937.14171-1-rogerq@ti.com>
References: <20200508082937.14171-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 supports super-speed mode on the EVM. Enable that.
On the EVM, USB0 uses SERDES3 for super-speed lane.

Since USB0 is a type-C port, it needs to support lane swapping
for cable flip support. This is provided using SERDES lane
swap feature. Provide the Type-C cable orientation GPIO
to the SERDES Wrapper driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 98e5e17e3ff7..55c98688eceb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -60,6 +60,7 @@
 	main_usbss0_pins_default: main_usbss0_pins_default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
+			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
 	};
 
@@ -335,16 +336,43 @@
 	status = "disabled";
 };
 
+&usb_serdes_mux {
+	idle-states = <1>, <0>; /* USB0 to SERDES3, USB1 to SERDES1 */
+};
+
+&serdes_ln_ctrl {
+	idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
+		      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
+		      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
+		      <SERDES3_LANE0_USB3_0_SWAP>, <SERDES3_LANE1_USB3_0>,
+		      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
+};
+
+&serdes_wiz3 {
+	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_HIGH>;
+};
+
+&serdes3 {
+	serdes3_usb_link: link@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz3 1>, <&serdes_wiz3 2>;
+	};
+};
+
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
-	ti,usb2-only;
 	ti,vbus-divider;
 };
 
 &usb0 {
 	dr_mode = "otg";
-	maximum-speed = "high-speed";
+	maximum-speed = "super-speed";
+	phys = <&serdes3_usb_link>;
+	phy-names = "cdns3,usb3-phy";
 };
 
 &usbss1 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

