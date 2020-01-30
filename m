Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E59C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2399C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3JEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:04:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:25981 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgA3JEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:04:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 01:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,381,1574150400"; 
   d="scan'208";a="318142003"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2020 01:04:05 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v4 0/2] clk: intel: Add a new driver for a new clock controller IP
Date:   Thu, 30 Jan 2020 17:04:01 +0800
Message-Id: <cover.1580374761.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds clock driver for Clock Generation Unit(CGU) of
Lightning Mountain(LGM) SoC.

Patch 1 adds common clock framework based clock driver for CGU.
Patch 2 adds bindings document & include file for CGU.

These patches are baselined upon Linux 5.5-rc1 at below Git link:
git git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

v4:
- Add drivers/clk/x86/Kconfig file which got missed in v3 by mistake.

v3:
- Address review concerns:
  Add Kconfig entry in x86 folder instead of modifying clk/Kconfig. (Andy Shevchenko)
  Fix coding style/convention related concerns. (Andy Shevchenko)
  Improve description, licensing info, rename node name correctly in dt bindings
  document & remove CLK_NR_CLKS from dt-bindings header file. (Stephen Boyd)
  Fix a build warning reported by kbuild test robot & Nathan Chancellor
- Add few new clocks & rename few existing clocks.
- Add more ops for ddiv & divider clk_ops.
- Fix few minor bugs.
- Use CLK_IS_CRITICAL flag for clocks which shall never be disabled.

v2:
- Move the driver to x86 folder.
- Remove syscon usage.
- Remove regmap based access. Use direct readl()/write() instead. Add spinlocks.
- Change all enum values to capitals.
- Rename all data structures & functions from intel_* to lgm_*.
- Remove multiple header files. Keep only one header file.
- Make probe fail when any of the clk/pll registration fails.
- Fix few bugs with clk_init_data assignement.
- Address review concerns for code quality/style/convention.

v1:
- Initial version.


Rahul Tanwar (1):
  dt-bindings: clk: intel: Add bindings document & header file for CGU

rtanwar (1):
  clk: intel: Add CGU clock driver for a new SoC

 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  40 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/x86/Kconfig                            |   8 +
 drivers/clk/x86/Makefile                           |   1 +
 drivers/clk/x86/clk-cgu-pll.c                      | 189 ++++++
 drivers/clk/x86/clk-cgu.c                          | 714 +++++++++++++++++++++
 drivers/clk/x86/clk-cgu.h                          | 309 +++++++++
 drivers/clk/x86/clk-lgm.c                          | 466 ++++++++++++++
 include/dt-bindings/clock/intel,lgm-clk.h          | 165 +++++
 9 files changed, 1893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
 create mode 100644 drivers/clk/x86/Kconfig
 create mode 100644 drivers/clk/x86/clk-cgu-pll.c
 create mode 100644 drivers/clk/x86/clk-cgu.c
 create mode 100644 drivers/clk/x86/clk-cgu.h
 create mode 100644 drivers/clk/x86/clk-lgm.c
 create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h

-- 
2.11.0

