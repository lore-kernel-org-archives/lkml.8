Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC573C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CED206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbgFYGQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:16:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:9023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390012AbgFYGQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:16:38 -0400
IronPort-SDR: je6UlQHOi3pzwqyCLS2AKBiu0TAZYxi53K+Iz3+Pe7UvJBnyf8eOgbbwXG7r1y2eoLYbJMo/oa
 t+1rgQYMN68A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="144822072"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="144822072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 23:16:37 -0700
IronPort-SDR: cJtxhBROQ84vdsAvE/8PtlKBxRdig6xDRvIPgmr33r85fxC5y5nykdDYPSGhpipSicF1pEbTkW
 uYwPGPR0yrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="319658730"
Received: from workstation312.sc.intel.com ([172.25.206.196])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2020 23:16:37 -0700
From:   Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
To:     platform-driver-x86@vger.kernel.org, andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        gayatri.kammela@intel.com,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Arava Jairaj <jairaj.arava@intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH] platform/x86: intel_pmc_core: update TGL's LPM0 reg bit map name
Date:   Wed, 24 Jun 2020 23:16:16 -0700
Message-Id: <20200625061616.85278-1-sathyanarayana.nujella@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMC debug tools use lpm0's 23rd bit to reflect Main PLL, not just
Audio PLL. So, update tgl_lpm0 debug reg bit map name.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Arava Jairaj <jairaj.arava@intel.com>
Acked-by: David E. Box <david.e.box@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index d2a5d4c36715..60bf93638f55 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -415,7 +415,7 @@ static const struct pmc_bit_map tgl_lpm0_map[] = {
 	{"PCIe_Gen3PLL_OFF_STS",		BIT(20)},
 	{"OPIOPLL_OFF_STS",			BIT(21)},
 	{"OCPLL_OFF_STS",			BIT(22)},
-	{"AudioPLL_OFF_STS",			BIT(23)},
+	{"MainPLL_OFF_STS",			BIT(23)},
 	{"MIPIPLL_OFF_STS",			BIT(24)},
 	{"Fast_XTAL_Osc_OFF_STS",		BIT(25)},
 	{"AC_Ring_Osc_OFF_STS",			BIT(26)},
-- 
2.27.0

