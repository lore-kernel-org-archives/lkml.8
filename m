Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA90C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9828D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFVIhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:37:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40276 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFVIhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:37:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 12D09200917;
        Mon, 22 Jun 2020 10:37:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 530D720091C;
        Mon, 22 Jun 2020 10:37:02 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3E4C6402CA;
        Mon, 22 Jun 2020 16:36:58 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, qiang.zhao@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [RESEND PATCH 2/2] arm64: dts: lx2160a: add DT node for all DSPI controller
Date:   Mon, 22 Jun 2020 16:31:09 +0800
Message-Id: <20200622083109.3441-2-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622083109.3441-1-qiang.zhao@nxp.com>
References: <20200622083109.3441-1-qiang.zhao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhua Han <chuanhua.han@nxp.com>

Add device tree node for first flash (CS0) connected
to all dspi controller.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 3b88e1e..2d1fe6c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -35,6 +35,42 @@
 	status = "okay";
 };
 
+&dspi0 {
+	status = "okay";
+
+	dflash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi1 {
+	status = "okay";
+
+	dflash1: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+
+	dflash2: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
 &esdhc0 {
 	status = "okay";
 };
-- 
2.7.4

