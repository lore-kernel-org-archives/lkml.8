Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24DA20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbgFXCvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:51:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43706 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbgFXCu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:50:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1454D1A012B;
        Wed, 24 Jun 2020 04:50:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9988C1A0171;
        Wed, 24 Jun 2020 04:50:53 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D77FB402A6;
        Wed, 24 Jun 2020 10:50:48 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, ran.wang_1@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [v3 4/4] arm: dts: ls1021a: add ftm_alarm0 DT node
Date:   Wed, 24 Jun 2020 10:45:01 +0800
Message-Id: <20200624024501.15974-4-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624024501.15974-1-biwen.li@oss.nxp.com>
References: <20200624024501.15974-1-biwen.li@oss.nxp.com>
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
Change in v3:
	- sort alphabetically

Change in v2:
	- use generic name

 arch/arm/boot/dts/ls1021a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 760a68c..f7b19c4 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -59,6 +59,7 @@
 		ethernet0 = &enet0;
 		ethernet1 = &enet1;
 		ethernet2 = &enet2;
+		rtc1 = &ftm_alarm0;
 		serial0 = &lpuart0;
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
@@ -1002,5 +1003,19 @@
 			big-endian;
 		};
 
+		rcpm: power-controller@1ee2140 {
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
2.7.4

