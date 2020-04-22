Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C910C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4302206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bZSquppg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgDVJQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:16:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:16:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03M9FwCm087485;
        Wed, 22 Apr 2020 04:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587546958;
        bh=BQ/cRWU4dnpOH6S1NiL/L2cnray6cYMuybskcFcQh6U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bZSquppgn2vJw6cmj+Eg14pCHZ6Kb4l0ahAjOeIdFMST1XBQDLAclBNeNKnJ382Tl
         uFz3cSILRn3bC76zTyHg9BdWLSUvGyOFJcX0NGtp248HxHQqoLf5QoPQmFD+IyRggc
         xivTwyDSxt6pTDPZ/EIS+4rO1gAOv1gTt9K3M8ss=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M9Fw6u082467;
        Wed, 22 Apr 2020 04:15:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Apr 2020 04:15:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Apr 2020 04:15:58 -0500
Received: from deskari.lan (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03M9FpLM050948;
        Wed, 22 Apr 2020 04:15:56 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j721e-common-proc-board: add assigned clks for DSS
Date:   Wed, 22 Apr 2020 12:15:12 +0300
Message-ID: <20200422091512.950-3-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422091512.950-1-tomi.valkeinen@ti.com>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSS related clock muxes are set via assigned-clocks in a way which
provides us:

VP0 - DisplayPort SST
VP1 - DPI0
VP2 - DSI
VP3 - DPI1

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 98e5e17e3ff7..6df823aaa37c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -472,3 +472,23 @@
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&phy0>;
 };
+
+&dss {
+	/*
+	 * These clock assignments are chosen to enable the following outputs:
+	 *
+	 * VP0 - DisplayPort SST
+	 * VP1 - DPI0
+	 * VP2 - DSI
+	 * VP3 - DPI1
+	 */
+
+	assigned-clocks = <&k3_clks 152 1>,
+			  <&k3_clks 152 4>,
+			  <&k3_clks 152 9>,
+			  <&k3_clks 152 13>;
+	assigned-clock-parents = <&k3_clks 152 2>,	/* PLL16_HSDIV0 */
+				 <&k3_clks 152 6>,	/* PLL19_HSDIV0 */
+				 <&k3_clks 152 11>,	/* PLL18_HSDIV0 */
+				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

