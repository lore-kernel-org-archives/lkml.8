Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5336C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3672089D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgE0K6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:58:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:1060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgE0K6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:58:18 -0400
IronPort-SDR: htHU4qojEVa2UkwuWtFY/6CAyC2zlYcTVShxYvSn0NvUXAlwcUFgJ9tmsNV6mm2oeF5YcLTozv
 GFYURf6juTMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 03:58:17 -0700
IronPort-SDR: SSM8m4SpIHQYK59YcX31N0HpcNSXqCBcy3HFpE3oqKeROm5SAS1221iYJfNpdu+Q2gQzTthRGu
 6GD+y+FqaJ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="442478017"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2020 03:58:15 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        rdunlap@infradead.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 1/1] phy: intel: Fix compilation error on FIELD_PREP usage
Date:   Wed, 27 May 2020 18:56:53 +0800
Message-Id: <8a309dd3c238efbaa59d1649704255d6f8b6c9c5.1590575358.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIELD_PREP expects constant arguments. Istead of doing FIELD_PREP
operation on the arguments of combo_phy_w32_off_mask(), pass the
final FIELD_PREP value as an argument.

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

../include/linux/compiler.h:392:38: error: call to__compiletime_assert_137
 declared with attribute error:
BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

../include/linux/bitfield.h:94:3: note: in expansion of macro __BF_FIELD_CHECK
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro FIELD_PREP
  reg_val |= FIELD_PREP(mask, val);
             ^~~~~~~~~~

Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/phy/intel/phy-intel-combo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
index c2a35be4cdfb..254ea7cba7ca 100644
--- a/drivers/phy/intel/phy-intel-combo.c
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -134,7 +134,7 @@ static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
 
 	reg_val = readl(base + reg);
 	reg_val &= ~mask;
-	reg_val |= FIELD_PREP(mask, val);
+	reg_val |= val;
 	writel(reg_val, base + reg);
 }
 
@@ -169,7 +169,7 @@ static int intel_cbphy_pcie_en_pad_refclk(struct intel_cbphy_iphy *iphy)
 		return 0;
 
 	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
-			       PCIE_PHY_CLK_PAD, 0);
+			       PCIE_PHY_CLK_PAD, FIELD_PREP(PCIE_PHY_CLK_PAD, 0));
 
 	/* Delay for stable clock PLL */
 	usleep_range(50, 100);
@@ -192,7 +192,7 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
 		return 0;
 
 	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
-			       PCIE_PHY_CLK_PAD, 1);
+			       PCIE_PHY_CLK_PAD, FIELD_PREP(PCIE_PHY_CLK_PAD, 1));
 
 	return 0;
 }
@@ -385,7 +385,7 @@ static int intel_cbphy_calibrate(struct phy *phy)
 
 	/* trigger auto RX adaptation */
 	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
-			       ADAPT_REQ_MSK, 3);
+			       ADAPT_REQ_MSK, FIELD_PREP(ADAPT_REQ_MSK, 3));
 	/* Wait RX adaptation to finish */
 	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
 				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
@@ -396,7 +396,7 @@ static int intel_cbphy_calibrate(struct phy *phy)
 
 	/* Stop RX adaptation */
 	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
-			       ADAPT_REQ_MSK, 0);
+			       ADAPT_REQ_MSK, FIELD_PREP(ADAPT_REQ_MSK, 0));
 
 	return ret;
 }
-- 
2.11.0

