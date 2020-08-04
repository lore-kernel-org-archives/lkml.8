Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058A722B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHDVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:47:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:7503 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgHDVrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:47:20 -0400
IronPort-SDR: dAHEpdbbxbSrU/HbrwqIYQnGOl8zfw/B/mNnTNdYjjyCT6MEIVJhsDInD3RCbnxmG1q0bZQg50
 Iz9NP2BUi9EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="140326369"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="140326369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 14:47:18 -0700
IronPort-SDR: E69qndROsJ7odBbDVZe7C4viqsnpXK8xXPfW4UkRpid6b9n+f17CO9CJIBnrabJtG0Y/2xhSrs
 0in+wJJMr1tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="330737829"
Received: from marshy.an.intel.com ([10.122.105.159])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 14:47:16 -0700
From:   richard.gong@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH] arm64: dts: agilex: increase shared memory size to 32Mb
Date:   Tue,  4 Aug 2020 17:01:32 -0500
Message-Id: <1596578492-13263-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Increase the shared memory size from 16Mb to 32Mb so that we can properly
handle the image authorization for 12+ Mb RBF/JIC files.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 9d7f19e..d81dd86 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -20,7 +20,7 @@
 
 		service_reserved: svcbuffer@0 {
 			compatible = "shared-dma-pool";
-			reg = <0x0 0x0 0x0 0x1000000>;
+			reg = <0x0 0x0 0x0 0x2000000>;
 			alignment = <0x1000>;
 			no-map;
 		};
-- 
2.7.4

