Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B35C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D3720838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBZKKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:10:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:31619 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgBZKKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:10:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="231349699"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 02:10:03 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v3 0/3] Add Intel ComboPhy driver 
Date:   Wed, 26 Feb 2020 18:09:50 +0800
Message-Id: <cover.1582709320.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Intel Combophy driver, respective yaml schemas
and a kernel API fwnode_to_regmap().
ComboPhy driver calls it to get regmap handle through firmware node.

Dilip Kota (3):
  mfd: syscon: Add fwnode_to_regmap
  dt-bindings: phy: Add YAML schemas for Intel Combophy
  phy: intel: Add driver support for Combophy

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 123 ++++
 drivers/mfd/syscon.c                               |   8 +
 drivers/phy/intel/Kconfig                          |  13 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 672 +++++++++++++++++++++
 include/dt-bindings/phy/phy-intel-combophy.h       |  10 +
 include/linux/mfd/syscon.h                         |   6 +
 7 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-combo.c
 create mode 100644 include/dt-bindings/phy/phy-intel-combophy.h

-- 
2.11.0

