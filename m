Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770DFC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgBNCPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:15:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57202 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgBNCPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:15:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D10E202E36;
        Fri, 14 Feb 2020 03:15:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBDFA20979D;
        Fri, 14 Feb 2020 03:15:45 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 286AA40313;
        Fri, 14 Feb 2020 10:15:39 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 4/5] ARM: dts: imx6ul: make gpt node name generic
Date:   Fri, 14 Feb 2020 10:10:10 +0800
Message-Id: <1581646211-30995-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581646211-30995-1-git-send-email-Anson.Huang@nxp.com>
References: <1581646211-30995-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, use "timer" instead of "gpt" for gpt node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- improve commit subject, no patch change.
---
 arch/arm/boot/dts/imx6ul.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 1ffd7a5..2864d24 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -430,7 +430,7 @@
 				status = "disabled";
 			};
 
-			gpt1: gpt@2098000 {
+			gpt1: timer@2098000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -704,7 +704,7 @@
 				reg = <0x020e4000 0x4000>;
 			};
 
-			gpt2: gpt@20e8000 {
+			gpt2: timer@20e8000 {
 				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
 				reg = <0x020e8000 0x4000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4

