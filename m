Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA39C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF31206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rHQYeGqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgGCHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:43:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55380 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGCHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:43:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0637hmPB045483;
        Fri, 3 Jul 2020 02:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593762228;
        bh=WDMC1z6jzpUNYiGQWlUKYjUaAdNa/terAf9fLOG3fwk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rHQYeGqHX02tg3eBCScRycBMpMOpSTnCZSdY5t8xWGK1tyDbNd386O/qyM7vyhQt3
         L2P/KSDUoAtUnvcYdSlgKp6uTVTUejTQTfS0lLJ2dpyBgyaEpREtBy9dFLyRwzi2zl
         8C/1awVodUikxPcgg6aBa75kUVkeVvm42YD7Fs0o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637hmGc092268;
        Fri, 3 Jul 2020 02:43:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 02:43:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 02:43:47 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637hhdp098446;
        Fri, 3 Jul 2020 02:43:45 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-common-proc-board: Remove duplicated main_i2c1_exp4_pins_default
Date:   Fri, 3 Jul 2020 10:44:42 +0300
Message-ID: <20200703074443.27142-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703074443.27142-1-peter.ujfalusi@ti.com>
References: <20200703074443.27142-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two pimux entry is present with the same name, remove one of them.

Fixes: cb27354b38f3 ("arm64: dts: ti: k3-j721e: Add DT nodes for few peripherials")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 6df823aaa37c..1f1fee85acca 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -102,12 +102,6 @@ J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
 			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
 		>;
 	};
-
-	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
-		 >;
-	};
 };
 
 &wkup_pmx0 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

