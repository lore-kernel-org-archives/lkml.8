Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AD3217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgBNIH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:07:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:51351 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgBNIH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:07:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 00:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="227519464"
Received: from unknown (HELO lftan) ([10.226.248.101])
  by orsmga008.jf.intel.com with SMTP; 14 Feb 2020 00:07:54 -0800
Received: by lftan (sSMTP sendmail emulation); Fri, 14 Feb 2020 02:00:28 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Chin Liang See <chin.liang.see@intel.com>,
        Tien Fong Chee <tien.fong.chee@intel.com>,
        linux-kernel@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] ARM: dts: socfpga: arria10: Increase boot partition size for NAND
Date:   Fri, 14 Feb 2020 02:00:27 +0800
Message-Id: <20200213180027.9239-1-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase boot partition size to 32MB to support bigger size kernel image
and FPGA bitstream.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
index 9bd9e04c7361..9aa897b79544 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -16,11 +16,11 @@
 
 		partition@0 {
 			label = "Boot and fpga data";
-			reg = <0x0 0x1C00000>;
+			reg = <0x0 0x02000000>;
 		};
 		partition@1c00000 {
 			label = "Root Filesystem - JFFS2";
-			reg = <0x1C00000 0x6400000>;
+			reg = <0x02000000 0x06000000>;
 		};
 	};
 };
-- 
2.19.0

