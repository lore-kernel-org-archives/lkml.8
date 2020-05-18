Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748C2207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgERNEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:04:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40804 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgERNEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:04:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23C541A0B0B;
        Mon, 18 May 2020 15:04:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F7A31A0B00;
        Mon, 18 May 2020 15:03:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4BF1B402AF;
        Mon, 18 May 2020 21:03:54 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx5: make src node name generic
Date:   Mon, 18 May 2020 20:54:20 +0800
Message-Id: <1589806460-19592-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589806460-19592-1-git-send-email-Anson.Huang@nxp.com>
References: <1589806460-19592-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, use "reset-controller" instead of "src" for
i.MX5 SoCs src nodes.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	- If failed to apply this patch series, try them to be based on
	  https://patchwork.kernel.org/patch/11541935/ series, I should have
	  sent them in same series, sorry for that.
---
 arch/arm/boot/dts/imx50.dtsi | 2 +-
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 567dcc5..30726bf 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -333,7 +333,7 @@
 				status = "disabled";
 			};
 
-			src: src@53fd0000 {
+			src: reset-controller@53fd0000 {
 				compatible = "fsl,imx50-src", "fsl,imx51-src";
 				reg = <0x53fd0000 0x4000>;
 				interrupts = <75>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 3f1e913..d3583aa 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -439,7 +439,7 @@
 				status = "disabled";
 			};
 
-			src: src@73fd0000 {
+			src: reset-controller@73fd0000 {
 				compatible = "fsl,imx51-src";
 				reg = <0x73fd0000 0x4000>;
 				interrupts = <75>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 0d06dbd..afa57bf 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -588,7 +588,7 @@
 				status = "disabled";
 			};
 
-			src: src@53fd0000 {
+			src: reset-controller@53fd0000 {
 				compatible = "fsl,imx53-src", "fsl,imx51-src";
 				reg = <0x53fd0000 0x4000>;
 				interrupts = <75>;
-- 
2.7.4

