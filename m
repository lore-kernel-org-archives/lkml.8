Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF885C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CFB208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgFPSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:24:09 -0400
Received: from v6.sk ([167.172.42.174]:47648 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbgFPSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:06 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 072436162C;
        Tue, 16 Jun 2020 18:24:05 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 06/13] ARM: dts: mmp2: Add DMA nodes
Date:   Tue, 16 Jun 2020 20:23:34 +0200
Message-Id: <20200616182341.944473-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a 16-channel peripheral DMA controller along with two-channel
audio DMA engines.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index da2c92328464e..b349f4f35706b 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -192,6 +192,24 @@ camera1: camera@d420a800 {
 				clock-output-names = "mclk";
 				status = "disabled";
 			};
+
+			adma0: dma-controller@d42a0800 {
+				compatible = "marvell,adma-1.0";
+				reg = <0xd42a0800 0x100>;
+				interrupts = <48>;
+				#dma-cells = <1>;
+				asram = <&asram>;
+				iram = <&asram>;
+				status = "disabled";
+			};
+
+			adma1: dma-controller@d42a0900 {
+				compatible = "marvell,adma-1.0";
+				reg = <0xd42a0900 0x100>;
+				interrupts = <48>;
+				#dma-cells = <1>;
+				status = "disabled";
+			};
 		};
 
 		apb@d4000000 {	/* APB */
@@ -201,6 +219,14 @@ apb@d4000000 {	/* APB */
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			dma-controller@d4000000 {
+				compatible = "marvell,pdma-1.0";
+				reg = <0xd4000000 0x10000>;
+				interrupts = <48>;
+				#dma-channels = <16>;
+				status = "disabled";
+			};
+
 			timer0: timer@d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
-- 
2.26.2

