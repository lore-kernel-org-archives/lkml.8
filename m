Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E65CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6332720719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SRYDLt31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbgDBUt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:49:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59874 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:49:56 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 032Knl2X031602;
        Thu, 2 Apr 2020 15:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585860587;
        bh=3s3uKTykRkS9kvOJuO+sK5EfvBWc0ZC1mqdTEizQqsE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SRYDLt31feQpTScbbbc970+B8xPARECfKsy/tzBfq47lKkX2qM1zVVa1FBoj8VUss
         BO1llofX0DDHilVxkxel2LSNr6PY0I7nr0WKIdPoNt1p/4n4OTynamb4WpzNumNiM9
         upUTL2BmyfdaufXKJPOkDPDZJM29wsaHDIuyE6HI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 032KnlfQ004454;
        Thu, 2 Apr 2020 15:49:47 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 2 Apr
 2020 15:49:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 2 Apr 2020 15:49:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 032Knl71001533;
        Thu, 2 Apr 2020 15:49:47 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v19 10/18] ARM: dts: imx6dl-yapp4: Add reg property to the lp5562 channel node
Date:   Thu, 2 Apr 2020 15:43:03 -0500
Message-ID: <20200402204311.14998-11-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402204311.14998-1-dmurphy@ti.com>
References: <20200402204311.14998-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reg property to each channel node.  This update is
to accomodate the multicolor framework.  In addition to the
accomodation this allows the LEDs to be placed on any channel
and allow designs to skip channels as opposed to requiring
sequential order.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 80ed5f16a76e..fe1a723b4dc9 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -258,29 +258,35 @@ leds: led-controller@30 {
 		reg = <0x30>;
 		clock-mode = /bits/ 8 <1>;
 		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		chan0 {
+		chan@0 {
 			chan-name = "R";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
+			reg = <0>;
 		};
 
-		chan1 {
+		chan@1 {
 			chan-name = "G";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
+			reg = <1>;
 		};
 
-		chan2 {
+		chan@2 {
 			chan-name = "B";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
+			reg = <2>;
 		};
 
-		chan3 {
+		chan@3 {
 			chan-name = "W";
 			led-cur = /bits/ 8 <0x0>;
 			max-cur = /bits/ 8 <0x0>;
+			reg = <3>;
 		};
 	};
 
-- 
2.25.1

