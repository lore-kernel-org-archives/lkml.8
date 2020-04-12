Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F20CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630E220739
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgDLJd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:33:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59252 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgDLJdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:33:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AA53201065;
        Sun, 12 Apr 2020 11:33:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20ED320151A;
        Sun, 12 Apr 2020 11:33:51 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 71B5E402FC;
        Sun, 12 Apr 2020 17:33:46 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, ran.wang_1@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND,v1 4/4] arm: dts: ls1021a: add ftm_alarm0 DT node
Date:   Sun, 12 Apr 2020 17:29:56 +0800
Message-Id: <20200412092956.27859-4-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412092956.27859-1-biwen.li@oss.nxp.com>
References: <20200412092956.27859-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The patch add ftm_alarm0 DT node
	- add rcpm node
	- add ftm_alarm0 node
	- aliases ftm_alarm0 as rtc1

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 0855b1fe98e0..7bb7bb130b41 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -66,6 +66,7 @@
 		serial4 = &lpuart4;
 		serial5 = &lpuart5;
 		sysclk = &sysclk;
+		rtc1 = &ftm_alarm0;
 	};
 
 	cpus {
@@ -1002,5 +1003,19 @@
 			big-endian;
 		};
 
+		rcpm: rcpm@1ee2140 {
+			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1ee2140 0x0 0x8>;
+			#fsl,rcpm-wakeup-cells = <2>;
+		};
+
+		ftm_alarm0: timer0@29d0000 {
+			compatible = "fsl,ls1021a-ftm-alarm";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			reg-names = "ftm";
+			fsl,rcpm-wakeup = <&rcpm 0x20000 0x0>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
+		};
 	};
 };
-- 
2.17.1

