Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE40C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FF820692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgDGGqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:46:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58386 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgDGGqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:46:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE67920039D;
        Tue,  7 Apr 2020 08:46:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56D92201016;
        Tue,  7 Apr 2020 08:46:40 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F480402EE;
        Tue,  7 Apr 2020 14:46:34 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, ran.wang_1@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND 4/4] arm: dts: ls1021a: add ftm_alarm0 DT node
Date:   Tue,  7 Apr 2020 14:42:51 +0800
Message-Id: <20200407064251.39244-4-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407064251.39244-1-biwen.li@oss.nxp.com>
References: <20200407064251.39244-1-biwen.li@oss.nxp.com>
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

