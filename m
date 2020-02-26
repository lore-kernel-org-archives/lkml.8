Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058BC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD722467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgB0JAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:00:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:34218 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgB0JAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:00:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 01:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="272104451"
Received: from unknown (HELO lftan) ([10.226.248.148])
  by fmsmga002.fm.intel.com with SMTP; 27 Feb 2020 01:00:21 -0800
Received: by lftan (sSMTP sendmail emulation); Thu, 27 Feb 2020 02:35:20 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Chin Liang See <chin.liang.see@intel.com>,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] arm64: dts: socfpga: agilex: Fix gmac compatible
Date:   Thu, 27 Feb 2020 02:35:18 +0800
Message-Id: <20200226183518.64673-1-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gmac compatible string to "altr,socfpga-stmmac-a10-s10". Gmac for
Agilex should use same compatible as Stratix 10.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index e1d357eaad7c..d8c44d3ca15a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -102,7 +102,7 @@
 		};
 
 		gmac0: ethernet@ff800000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
 			interrupts = <0 90 4>;
 			interrupt-names = "macirq";
@@ -118,7 +118,7 @@
 		};
 
 		gmac1: ethernet@ff802000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff802000 0x2000>;
 			interrupts = <0 91 4>;
 			interrupt-names = "macirq";
@@ -134,7 +134,7 @@
 		};
 
 		gmac2: ethernet@ff804000 {
-			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff804000 0x2000>;
 			interrupts = <0 92 4>;
 			interrupt-names = "macirq";
-- 
2.19.0

