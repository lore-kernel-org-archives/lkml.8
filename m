Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F862176B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PzyPJyS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgIGPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:13:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33200 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbgIGOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:52:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087EqMgk063159;
        Mon, 7 Sep 2020 09:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599490342;
        bh=Q3Wbvw1ixlX5BnpkCnuZ3eeFtrKa/gCrbIv74+GHMb0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PzyPJyS+6ttXON1FRU7RLTeu/EMjPo36rieY7xXwasQncNoKT/EfZIdEOONx2WOaq
         4Z5ytyHMqKhJX0kTImi16Wg2dQvjLE0iJSX12g2ITrmd2S87Qqvg3ZwWWLY22U/IhK
         z7bXg4izNiPJ9QtaoFXW7c9s97Ow9q0WlXrejtfs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087EqMni034616;
        Mon, 7 Sep 2020 09:52:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 09:52:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 09:52:21 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087EqEEN010923;
        Mon, 7 Sep 2020 09:52:19 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/6] arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
Date:   Mon, 7 Sep 2020 17:52:09 +0300
Message-ID: <20200907145213.30788-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907145213.30788-1-rogerq@ti.com>
References: <20200907145213.30788-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SERDES lane control mux registers are present in the
CTRLMMR space.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 1702ac0bbf40..e72c7a0ccad5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -18,6 +18,21 @@
 		};
 	};
 
+	scm_conf: scm-conf@100000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0 0x00100000 0 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x00100000 0x1c000>;
+
+		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
+					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

