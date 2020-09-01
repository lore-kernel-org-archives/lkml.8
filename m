Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF58EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56332083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIAEn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:43:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:24048 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAEnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:43:55 -0400
IronPort-SDR: VG3fkZriJv0D4bK6Hoygj6RhzLy1xDX8yS0tC46xAcr3z7bU0LTR5RV4L7ln/12rPyUmDcmI/y
 t84FliQ2Zhhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144793078"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="144793078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 21:43:54 -0700
IronPort-SDR: IyBBK6IFHlTt3wTtQdJqppllBx22tFM4ZLpw1qna7jLd309NI4GG+LZFNUcv/EPqdskVQ2QVlw
 Om1RHmrcRLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="314599666"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2020 21:43:52 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v8 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Date:   Tue,  1 Sep 2020 12:41:59 +0800
Message-Id: <20200901044201.20978-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901044201.20978-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200901044201.20978-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c
to make drivers/phy/intel directory more generic for future use.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Ramuthevar Vadivel Murugan
<vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/phy/intel/Kconfig                              | 10 +++++-----
 drivers/phy/intel/Makefile                             |  4 ++--
 .../intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} |  0
 .../intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c}   |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
 rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 7b47682a4e0e..db8586c3eed8 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Phy drivers for Intel Lightning Mountain(LGM) platform
+# Phy drivers for Intel platforms
 #
-config PHY_INTEL_COMBO
-	bool "Intel ComboPHY driver"
+config PHY_INTEL_LGM_COMBO
+	bool "Intel Lightning Mountain ComboPHY driver"
 	depends on X86 || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	select MFD_SYSCON
@@ -16,8 +16,8 @@ config PHY_INTEL_COMBO
 	  chipsets which provides PHYs for various controllers, EMAC,
 	  SATA and PCIe.
 
-config PHY_INTEL_EMMC
-	tristate "Intel EMMC PHY driver"
+config PHY_INTEL_LGM_EMMC
+	tristate "Intel Lightning Mountain EMMC PHY driver"
 	depends on X86 || COMPILE_TEST
 	select GENERIC_PHY
 	help
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 233d530dadde..662385d0a366 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
-obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
+obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+= phy-intel-lgm-combo.o
+obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+= phy-intel-lgm-emmc.o
diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
similarity index 100%
rename from drivers/phy/intel/phy-intel-combo.c
rename to drivers/phy/intel/phy-intel-lgm-combo.c
diff --git a/drivers/phy/intel/phy-intel-emmc.c b/drivers/phy/intel/phy-intel-lgm-emmc.c
similarity index 100%
rename from drivers/phy/intel/phy-intel-emmc.c
rename to drivers/phy/intel/phy-intel-lgm-emmc.c
-- 
2.17.1

