Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D687FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C169A2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgFPSYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:24:16 -0400
Received: from v6.sk ([167.172.42.174]:47662 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbgFPSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:10 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D952D6162E;
        Tue, 16 Jun 2020 18:24:08 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 08/13] ARM: dts: mmp2: Add SSPA nodes
Date:   Tue, 16 Jun 2020 20:23:36 +0200
Message-Id: <20200616182341.944473-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two I2S-capable audio serial port blocks.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index dd7fba65799ea..31592acd3ef4f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -223,6 +223,32 @@ audio_clk: clocks@d42a0c30 {
 				#clock-cells = <1>;
 				status = "disabled";
 			};
+
+			sspa0: audio-controller@d42a0c00 {
+				compatible = "marvell,mmp-sspa";
+				reg = <0xd42a0c00 0x30>,
+				      <0xd42a0c80 0x30>;
+				interrupts = <2>;
+				clock-names = "audio", "bitclk";
+				clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+					 <&audio_clk 1>;
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+				#sound-dai-cells = <0>;
+				status = "disabled";
+			};
+
+			sspa1: audio-controller@d42a0d00 {
+				compatible = "marvell,mmp-sspa";
+				reg = <0xd42a0d00 0x30>,
+				      <0xd42a0d80 0x30>;
+				interrupts = <3>;
+				clock-names = "audio", "bitclk";
+				clocks = <&soc_clocks MMP2_CLK_AUDIO>,
+					 <&audio_clk 2>;
+				power-domains = <&soc_clocks MMP2_POWER_DOMAIN_AUDIO>;
+				#sound-dai-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		apb@d4000000 {	/* APB */
-- 
2.26.2

