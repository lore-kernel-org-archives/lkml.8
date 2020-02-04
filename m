Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194EBC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F8920732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBDELt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:11:49 -0500
Received: from inva020.nxp.com ([92.121.34.13]:38710 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgBDELt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:11:49 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B3691C79C2;
        Tue,  4 Feb 2020 05:11:47 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 89EFA1C79BD;
        Tue,  4 Feb 2020 05:11:43 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ED2CD402CB;
        Tue,  4 Feb 2020 12:11:38 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] arm64: dts: ls1088a: support eMMC HS200 speed mode for RDB board
Date:   Tue,  4 Feb 2020 12:09:28 +0800
Message-Id: <20200204040928.32320-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add eMMC HS200 speed mode support on ls1088ardb
whose controller and peripheral circut support such capability.
And clocks dts property is needed for driver to get peripheral
clock value used for this speed mode.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 4d77b34..5633e59 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -83,6 +83,7 @@
 };
 
 &esdhc {
+	mmc-hs200-1_8v;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 5945662..ec6013a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -393,6 +393,7 @@
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
 			clock-frequency = <0>;
+			clocks = <&clockgen 2 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
-- 
2.7.4

