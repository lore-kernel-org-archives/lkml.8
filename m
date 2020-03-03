Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D37A214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCCGjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:39:08 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55124 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCCGjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:39:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9150C1A13E1;
        Tue,  3 Mar 2020 07:39:06 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42C1F1A13EF;
        Tue,  3 Mar 2020 07:39:02 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 66A1A40366;
        Tue,  3 Mar 2020 14:38:41 +0800 (SGT)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 2/2] arm64: dts: lx2160aqds: Add FSPI node properties
Date:   Tue,  3 Mar 2020 12:08:32 +0530
Message-Id: <1583217512-27994-2-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583217512-27994-1-git-send-email-kuldeep.singh@nxp.com>
References: <1583217512-27994-1-git-send-email-kuldeep.singh@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx2160a-qds has 2 micron "mt35xu512aba" flashes of size 64M each
connected on A0 and B1 i.e on CS0 and CS3. Since flashes are connected
on different buses, only one flash can be probed at a time.

Add fspi node properties aligned with LX2160A-RDB fspi properties.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 1a5acf6..3b88e1e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -43,6 +43,21 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.7.4

