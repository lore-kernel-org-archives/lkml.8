Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA0920849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgESGUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:20:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:58873 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgESGUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:20:37 -0400
IronPort-SDR: B8GVevo2zZ5KICf7e9HMjfqUxmouIW+3DqWbRf/DIpwb1JB7MEhePxcVuI8X+T9mJ8ZP5p1P+r
 q/tdxlfspjwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 23:20:36 -0700
IronPort-SDR: Nf+Du/6M7CmBt2i9fTBEvY+YxJ6xuNV1gd2fVC7ugPPM9iCojGi3YdOe6m5gCKVs5usY8OeLWg
 iwEQspdsBmVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="267779133"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 23:20:33 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v9 0/3] Add Intel ComboPhy driver
Date:   Tue, 19 May 2020 14:19:18 +0800
Message-Id: <cover.1589868358.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Intel ComboPhy driver, respective yaml schemas

Changes on v9:
Add Acked-By: Vinod Koul <vkoul@kernel.org>

Fix compiler warning
drivers/phy/intel/phy-intel-combo.c:229:6: warning: cb_mode may be used
uninitialized in this function [-Wmaybe-uninitialized]
   ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
   ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/intel/phy-intel-combo.c:204:24: note: cb_mode was declared here
   enum intel_combo_mode cb_mode;

Changes on v8:
  As per PHY Maintainer's request add description in comments for doing
  register access through register map framework.

Changes on v7:
  As per System control driver maintainer's inputs remove
    fwnode_to_regmap() definition and use device_node_get_regmap()
    
Changes on v6:
  Rebase patches on the latest maintainer's branch
  https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7
Dilip Kota (3):
  dt-bindings: phy: Add PHY_TYPE_XPCS definition
  dt-bindings: phy: Add YAML schemas for Intel ComboPhy
  phy: intel: Add driver support for ComboPhy

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
 drivers/phy/intel/Kconfig                          |  14 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 632 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   1 +
 5 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

-- 
2.11.0

