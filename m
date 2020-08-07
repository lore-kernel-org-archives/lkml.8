Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F85BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC4A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gJfiHdAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHGMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:44:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36770 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHGMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:44:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 077CiMrb062525;
        Fri, 7 Aug 2020 07:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596804262;
        bh=SA/mjyJ9qsKYdqzDY+hhaGKzabuGPeWkwbkzS+s7smg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gJfiHdAavSwDlpcYenGNF5i6AEoGG1Oq9ba86fYZwdn2qVnm10Niz+wRRUmbDSZom
         eZTQ75uIT5nH1sKCiTI0rxam61a7sVZhVoIDjF2HFNVmHciFYZUEMcPkTFpfclI4Ug
         oxZqwFidRmE9XbtuveHZ6KzORe9J4I4N9kObCby0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 077CiMHO000445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Aug 2020 07:44:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 7 Aug
 2020 07:44:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 7 Aug 2020 07:44:22 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 077CiCeH072818;
        Fri, 7 Aug 2020 07:44:20 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node
Date:   Fri, 7 Aug 2020 18:14:07 +0530
Message-ID: <20200807124407.12604-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807124407.12604-1-vigneshr@ti.com>
References: <20200807124407.12604-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 SoM has a HyperFlash connected to HyperBus memory controller. But
HyperBus is muxed with OSPI, therefore keep HyperBus node disabled.
Bootloader will detect the mux and enable the node as required.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 22fc50bd5c4c4..0984977f381ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -27,3 +27,39 @@ secure_ddr: optee@9e800000 {
 		};
 	};
 };
+
+&wkup_pmx0 {
+	mcu_fss0_hpb0_pins_default: mcu-fss0-hpb0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0, PIN_OUTPUT, 1) /* (B6) MCU_OSPI0_CLK.MCU_HYPERBUS0_CK */
+			J721E_WKUP_IOPAD(0x4, PIN_OUTPUT, 1) /* (C8) MCU_OSPI0_LBCLKO.MCU_HYPERBUS0_CKn */
+			J721E_WKUP_IOPAD(0x2c, PIN_OUTPUT, 1) /* (D6) MCU_OSPI0_CSn0.MCU_HYPERBUS0_CSn0 */
+			J721E_WKUP_IOPAD(0x30, PIN_OUTPUT, 1) /* (D7) MCU_OSPI0_CSn1.MCU_HYPERBUS0_RESETn */
+			J721E_WKUP_IOPAD(0x8, PIN_INPUT, 1) /* (B7) MCU_OSPI0_DQS.MCU_HYPERBUS0_RWDS */
+			J721E_WKUP_IOPAD(0xc, PIN_INPUT, 1) /* (D8) MCU_OSPI0_D0.MCU_HYPERBUS0_DQ0 */
+			J721E_WKUP_IOPAD(0x10, PIN_INPUT, 1) /* (C7) MCU_OSPI0_D1.MCU_HYPERBUS0_DQ1 */
+			J721E_WKUP_IOPAD(0x14, PIN_INPUT, 1) /* (C5) MCU_OSPI0_D2.MCU_HYPERBUS0_DQ2 */
+			J721E_WKUP_IOPAD(0x18, PIN_INPUT, 1) /* (A5) MCU_OSPI0_D3.MCU_HYPERBUS0_DQ3 */
+			J721E_WKUP_IOPAD(0x1c, PIN_INPUT, 1) /* (A6) MCU_OSPI0_D4.MCU_HYPERBUS0_DQ4 */
+			J721E_WKUP_IOPAD(0x20, PIN_INPUT, 1) /* (B8) MCU_OSPI0_D5.MCU_HYPERBUS0_DQ5 */
+			J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
+			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
+		>;
+	};
+};
+
+&hbmc {
+	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
+	 * appropriate node based on board detection
+	 */
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_fss0_hpb0_pins_default>;
+	ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* 64MB Flash on CS0 */
+		 <0x1 0x0 0x5 0x04000000 0x800000>; /* 8MB RAM on CS1 */
+
+	flash@0,0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x0 0x0 0x4000000>;
+	};
+};
-- 
2.28.0

