Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1235C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23624676
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgBNCRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:17:16 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55968 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgBNCRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:17:15 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 071E41A2A28;
        Fri, 14 Feb 2020 03:17:14 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B361C1A4762;
        Fri, 14 Feb 2020 03:17:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 062AC402E0;
        Fri, 14 Feb 2020 10:16:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/5] ARM: dts: imx6sx: make kpp node name generic
Date:   Fri, 14 Feb 2020 10:11:31 +0800
Message-Id: <1581646293-31096-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581646293-31096-1-git-send-email-Anson.Huang@nxp.com>
References: <1581646293-31096-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, use "keypad" instead of "kpp" for kpp node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 84cbd79..4b5a276 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -559,7 +559,7 @@
 				gpio-ranges = <&iomuxc 0 148 10>, <&iomuxc 10 169 2>;
 			};
 
-			kpp: kpp@20b8000 {
+			kpp: keypad@20b8000 {
 				compatible = "fsl,imx6sx-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4

