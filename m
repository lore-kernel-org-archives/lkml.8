Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C354AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8377D21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uNTY2J/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgIGKjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:39:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgIGKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:38:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087AcP8Z129252;
        Mon, 7 Sep 2020 05:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599475105;
        bh=LfWnPdukmI4UVXisdn8CMXNSF6EpXlkrbNPmBv96xGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uNTY2J/9d4C9/Yo1tL6Jp0pDq3oxErvrgGZslzC95DvVMzc7z60q77HCi+WmbVOaE
         p8ufuSfs3VcwAc0IEwbmKzrspC1qaXIS276xKCyBA7YVDtykH8uFMf8I+ry5zGUZa5
         1vVBFUGW6BksQ59OgHBXfIGmFQ+alCloHq3Xz6Xg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087AcP8r017734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 05:38:25 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 05:38:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 05:38:24 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087AcCOs085251;
        Mon, 7 Sep 2020 05:38:22 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/6] arm64: dts: ti: k3-j7200-main: Add USB controller
Date:   Mon, 7 Sep 2020 13:38:08 +0300
Message-ID: <20200907103810.9870-5-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907103810.9870-1-rogerq@ti.com>
References: <20200907103810.9870-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j7200 has on USB controller instance. Add that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index e08839306ec9..f1dd309e6b06 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -331,4 +331,34 @@
 		no-1-8-v;
 		dma-coherent;
 	};
+
+	usbss0: cdns_usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		dma-coherent;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 288 12>, <&k3_clks 288 3>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 288 12>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 288 13>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

