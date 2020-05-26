Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2115C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1032075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgEZIpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:45:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:61868 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgEZIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:45:01 -0400
IronPort-SDR: Ki3z+1WgNfjC7KKxRHuOhd0bqIatf55tOjxbrrlj56DsEM/Xb5Q64esk5W4+WKjrq8e8Bmft4W
 u7QIp15zG8sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 01:45:00 -0700
IronPort-SDR: pIW+1899icms35CvI7TILPT9rghumRkDFUatvOV23OOrQX/R/d2NRPuQm96VvFE6oYqk5Ysfwx
 U7Ckdc4wua7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="442003884"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2020 01:44:58 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 1/1] phy: intel: Fix compilation error on FIELD_PREP usage
Date:   Tue, 26 May 2020 16:43:20 +0800
Message-Id: <d8a71fafa408f273fe63b64481448c29c450fa83.1590477581.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIELD_PREP expects mask variable datatype as unsigned long and constant.
Make the mask argument in combo_phy_w32_off_mask () as unsigned long const
datatype.

Error reported as:
In file included from include/linux/build_bug.h:5,
from include/linux/bitfield.h:10,
from drivers/phy/intel/phy-intel-combo.c:8:
drivers/phy/intel/phy-intel-combo.c: In function 'combo_phy_w32_off_mask':
include/linux/bitfield.h:52:28: warning: comparison is always false due to limited range of data type [-Wtype-limits]

include/linux/compiler.h:350:38: error: call to '__compiletime_assert_37' declared with attribute error: FIELD_PREP: mask is not constant
94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");          |   ^~~~~~~~~~~~~~~~
drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro 'FIELD_PREP'
137 |  reg_val |= FIELD_PREP(mask, val);
|             ^~~~~~~~~~

Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/phy/intel/phy-intel-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
index c2a35be4cdfb..05b7d724ceb0 100644
--- a/drivers/phy/intel/phy-intel-combo.c
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -128,7 +128,7 @@ static int intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
 }
 
 static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
-					  u32 mask, u32 val)
+					  unsigned long const mask, u32 val)
 {
 	u32 reg_val;
 
-- 
2.11.0

