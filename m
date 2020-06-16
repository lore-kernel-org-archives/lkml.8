Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C109B208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgFPSYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:24:52 -0400
Received: from v6.sk ([167.172.42.174]:47594 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbgFPSYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:04 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D84756162B;
        Tue, 16 Jun 2020 18:24:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 05/13] ARM: dts: mmp2: Add Audio SRAM
Date:   Tue, 16 Jun 2020 20:23:33 +0200
Message-Id: <20200616182341.944473-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616182341.944473-1-lkundrak@v3.sk>
References: <20200616182341.944473-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This memory is region is where the two-channel audio DMA can pump sound
samples into the SSPA's internal FIFO.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 9e77f685fb188..da2c92328464e 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -413,6 +413,15 @@ ssp4: spi@d4039000 {
 			};
 		};
 
+		asram: sram@e0000000 {
+			compatible = "mmio-sram";
+			reg = <0xe0000000 0x10000>;
+			ranges = <0 0xe0000000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
+
 		soc_clocks: clocks {
 			compatible = "marvell,mmp2-clock";
 			reg = <0xd4050000 0x2000>,
-- 
2.26.2

