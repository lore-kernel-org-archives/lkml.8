Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01928C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B48214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FO7SyaVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgCCKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:17:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49462 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgCCKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:17:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AHcnO068885;
        Tue, 3 Mar 2020 04:17:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583230658;
        bh=TGnhlZSxlmC3GNaDXilXxq+nAKLTMymSv9AzgV/+0Os=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FO7SyaVMGcf/zp16y48FRS4sguR14X7CrAPGUoNBFYASEMu2uzDZQuCgFcFqikfxg
         0KbIW+kD1ZsR+TxDxzw6Za6rx4nDVjwzEM6d5jWzzD41manw3IOjmOvPKQ81ZA/md8
         1EygcXAn+HCsasEWte9gtp2HLOi37cN0WHp+IKzo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023AHcAO017430;
        Tue, 3 Mar 2020 04:17:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:17:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:17:38 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023AHONg004649;
        Tue, 3 Mar 2020 04:17:36 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
Date:   Tue, 3 Mar 2020 12:17:21 +0200
Message-ID: <20200303101722.26052-6-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303101722.26052-1-rogerq@ti.com>
References: <20200303101722.26052-1-rogerq@ti.com>
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
index 7a5c3d4adadd..f057322b8c11 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -59,6 +59,7 @@
 	main_usbss0_pins_default: main_usbss0_pins_default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x290, PIN_OUTPUT, 0) /* (U6) USB0_DRVVBUS */
+			J721E_IOPAD(0x210, PIN_INPUT, 7) /* (W3) MCAN1_RX.GPIO1_3 */
 		>;
 	};
 
@@ -310,16 +311,43 @@
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

