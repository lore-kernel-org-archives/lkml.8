Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF93FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88783208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158803;
	bh=OPhMEgAvEvfOWq7Mq9EL3bba8jafo9Py2dTfZOjWes0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J05jjhhVoj62XBH538EW1uH6DFN5k9IjnWb0msCDLiTxY913sIDZbL/3rItMjQaKn
	 dX1RoCa6WnTr933N3er5eHymvMQzFCW+EIsm9OgD9alfRFsN2i3j84FhbJsqC+gO7x
	 edoN67YYYq37AS+wTKey8Pje3iOdgkk6Ve35XXV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgFZIGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgFZIGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4328620836;
        Fri, 26 Jun 2020 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158796;
        bh=OPhMEgAvEvfOWq7Mq9EL3bba8jafo9Py2dTfZOjWes0=;
        h=From:To:Cc:Subject:Date:From;
        b=SV3p+r8ooxv+GPp3wL5iA/+vUM9F4uLwD0YV6NnoF6pNui9eb3ZG4/v7PIB0zi/XB
         hEwm8Xit3kP/JvoJSdTSqM9rBUciEAWEu86R5Q/TJEqvqbLvinTC9ELtXU8xsdZgA+
         zK2ij4k/qW4cHwm+Ad5HE8AHZBz/zTPiM1XBD75Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:31 +0200
Message-Id: <20200626080631.4134-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache@a02000: $nodename:0:
        'l2-cache@a02000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx35.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index e15408794d83..aba16252faab 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -59,7 +59,7 @@
 		interrupt-parent = <&avic>;
 		ranges;
 
-		L2: l2-cache@30000000 {
+		L2: cache-controller@30000000 {
 			compatible = "arm,l210-cache";
 			reg = <0x30000000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 346a52fc96d9..3a0e222a1ab8 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -245,7 +245,7 @@
 			interrupt-parent = <&intc>;
 		};
 
-		L2: l2-cache@a02000 {
+		L2: cache-controller@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
 			interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index e2d25328b579..eb8aeaa5ccab 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -126,7 +126,7 @@
 			interrupt-parent = <&intc>;
 		};
 
-		L2: l2-cache@a02000 {
+		L2: cache-controller@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
 			interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 3d1a689f5dec..554a31ea9c07 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -126,7 +126,7 @@
 			interrupt-parent = <&intc>;
 		};
 
-		L2: l2-cache@a02000 {
+		L2: cache-controller@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 430c21aa88bf..537561446a5f 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -173,7 +173,7 @@
 			interrupt-parent = <&intc>;
 		};
 
-		L2: l2-cache@a02000 {
+		L2: cache-controller@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

