Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D38C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 03:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA4206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 03:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCIDg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 23:36:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:5773 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCIDg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 23:36:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 20:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,531,1574150400"; 
   d="scan'208";a="414670446"
Received: from pg-nxl3.altera.com ([10.142.129.93])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2020 20:36:56 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Chee Hong Ang <chee.hong.ang@intel.com>
Subject: [PATCH] arm64: dts: increase the QSPI reg address for Stratix10 and Agilex
Date:   Mon,  9 Mar 2020 11:36:49 +0800
Message-Id: <20200309033649.15208-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joyce Ooi <joyce.ooi@intel.com>

This patch increases the reg addresses for QSPI boot and QSPI rootfs for
Stratix10 and Agilex to cater for the increased size of kernel Image.

Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    6 +++---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index fb11ef0..f6c4a15 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -178,12 +178,12 @@
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
+				reg = <0x0 0x03FE0000>;
 			};
 
-			qspi_rootfs: partition@4000000 {
+			qspi_rootfs: partition@3FE0000 {
 				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
+				reg = <0x03FE0000 0x0C020000>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 44d38af..ac6e51b 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -129,12 +129,12 @@
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x034B0000>;
+				reg = <0x0 0x03FE0000>;
 			};
 
-			qspi_rootfs: partition@34B0000 {
+			qspi_rootfs: partition@3FE0000 {
 				label = "Root Filesystem - JFFS2";
-				reg = <0x034B0000 0x0EB50000>;
+				reg = <0x03FE0000 0x0C020000>;
 			};
 		};
 	};
-- 
1.7.1

