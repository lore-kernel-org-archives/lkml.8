Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC782086A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbgEYHxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:53:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40574 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgEYHxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:53:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D0681A01FA;
        Mon, 25 May 2020 09:53:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C5A31A01EF;
        Mon, 25 May 2020 09:53:31 +0200 (CEST)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4150A402BC;
        Mon, 25 May 2020 15:53:26 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: add one more thermal zone support
Date:   Mon, 25 May 2020 15:38:27 +0800
Message-Id: <20200525073827.13272-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 thermal zones in ls1028a soc. Current dts only
includes one. This patch adds the other thermal zone node
in dts to enable it.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 055f114cf848..bc6f0c0f85da 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -129,11 +129,31 @@
 	};
 
 	thermal-zones {
-		core-cluster {
+		ddr-controller {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
 
+			trips {
+				ddr-ctrler-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				ddr-ctrler-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		core-cluster {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+
 			trips {
 				core_cluster_alert: core-cluster-alert {
 					temperature = <85000>;
-- 
2.17.1

