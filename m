Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA41206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgF2CyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:54:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39332 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgF2CyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:54:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E37E200ECA;
        Mon, 29 Jun 2020 04:54:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 89C47200ECB;
        Mon, 29 Jun 2020 04:54:00 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6290402A0;
        Mon, 29 Jun 2020 10:53:55 +0800 (SGT)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, qiang.zhao@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [Patch V2] arm64: dts: ls1028a: Add DSPI flash nodes for  LS1028a-qds
Date:   Mon, 29 Jun 2020 10:46:34 +0800
Message-Id: <20200629024634.14582-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add the DSPI flash nodes into fsl-ls1028a-qds.dts

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2
   - correct commit msg

 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 85 +++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index dd69c5b..e4f00c2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -107,6 +107,91 @@
 	};
 };
 
+&dspi0 {
+	bus-num = <0>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&dspi1 {
+	bus-num = <1>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash@2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
-- 
2.7.4

