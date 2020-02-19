Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D51C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A1E21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBSM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:26:27 -0500
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:41206 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgBSM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:26:27 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 07:26:26 EST
Received: from atl4mhob25.registeredsite.com (atl4mhob25.registeredsite.com [209.17.115.122])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 01JCKq9u032131
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:20:52 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by atl4mhob25.registeredsite.com (8.14.4/8.14.4) with ESMTP id 01JCKoga042903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:20:51 -0500
Received: (qmail 9089 invoked by uid 0); 19 Feb 2020 12:20:50 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 19 Feb 2020 12:20:50 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     robh+dt@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
Date:   Wed, 19 Feb 2020 13:20:36 +0100
Message-Id: <20200219122036.24575-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bootmode override support for ZynqMP devices. Allows one to select
a boot device by running "reboot qspi32" for example. Activate config
item CONFIG_SYSCON_REBOOT_MODE to make this work.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 26d926eb1431..4c38d77ecbba 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -246,6 +246,30 @@
 			};
 		};
 
+		/* Clock and Reset control registers for LPD */
+		lpd_apb: apb@ff5e0000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0xff5e0000 0x0 0x400>;
+			reboot-mode {
+				compatible = "syscon-reboot-mode";
+				offset = <0x200>;
+				mask = <0xf100>;
+				/* Bit(8) is the "force user" bit */
+				mode-normal = <0x0000>;
+				mode-psjtag = <0x0100>;
+				mode-qspi24 = <0x1100>;
+				mode-qspi32 = <0x2100>;
+				mode-sd0    = <0x3100>;
+				mode-nand   = <0x4100>;
+				mode-sd1    = <0x6100>;
+				mode-emmc   = <0x6100>;
+				mode-usb0   = <0x7100>;
+				mode-pjtag0 = <0x8100>;
+				mode-pjtag1 = <0x9100>;
+				mode-sd1ls  = <0xe100>;
+			};
+		};
+
 		/* GDMA */
 		fpd_dma_chan1: dma@fd500000 {
 			status = "disabled";
-- 
2.17.1

