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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D622C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E2A20738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sSg2vrRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIGKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:40:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58264 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgIGKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:38:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087AcTRg055826;
        Mon, 7 Sep 2020 05:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599475109;
        bh=2zTPOjt2DxVUHrxW1zXAaSYEgEGwudkN9PPctHgbrFM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sSg2vrRFFlRIDnAOi4mSPVvJsQSFX7+4xHpjYXFuZij7qeDj9gMTpwzBXOlxp8qC/
         JSwypAsQQKjzxX86Lp5tXuUD0P90outdb4HJ+d82Qoc4fllAEWOMCzlLaued2fNBOy
         VrkEJWO0NjF7ZbOvbDO85rLeUuYI5F07aenwrnd4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087AcTcK112035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 05:38:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 05:38:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 05:38:29 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087AcCOu085251;
        Mon, 7 Sep 2020 05:38:27 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 6/6] arm64: dts: ti: k3-j7200-common-proc-board: Add USB support
Date:   Mon, 7 Sep 2020 13:38:10 +0300
Message-ID: <20200907103810.9870-7-rogerq@ti.com>
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

Enable USB0 port in high-speed (2.0) mode.

The board uses lane 3 of SERDES for USB. Set the mux
accordingly.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 0ecaba600704..f4b6a5abb1b5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -42,6 +42,12 @@
 			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
 		>;
 	};
+
+	main_usbss0_pins_default: main_usbss0_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -145,3 +151,19 @@
 	idle-states = <SERDES0_LANE0_PCIE1_LANE0>, <SERDES0_LANE1_PCIE1_LANE1>,
 		      <SERDES0_LANE2_QSGMII_LANE1>, <SERDES0_LANE3_IP4_UNUSED>;
 };
+
+&usb_serdes_mux {
+	idle-states = <1>; /* USB0 to SERDES lane 3 */
+};
+
+&usbss0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	ti,vbus-divider;
+	ti,usb2-only;
+};
+
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

