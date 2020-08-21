Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A263C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC6E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHULuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:50:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:14297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbgHULju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:39:50 -0400
IronPort-SDR: /Wfruz/qXJM8WIdoI74mtKMHo3clJGG1ITzH6caVSDCcbu0QjaUTW9VZIMCW8y5dmFXQO470X/
 lw6GmjkP6DFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143305575"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143305575"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 04:39:41 -0700
IronPort-SDR: s6yK3Yzxk2aSzl8qQCdfQVYrzLre+gZ+9nReAKJkYqYIf1G8pV4fScPQ+8Ej3nKFeguKKzPoqp
 OS33SLYrzNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327740411"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 04:39:39 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Date:   Fri, 21 Aug 2020 19:37:45 +0800
Message-Id: <20200821113747.2912-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c
to make drivers/phy/intel directory more generic for future use.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
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

