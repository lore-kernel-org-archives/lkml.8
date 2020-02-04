Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A6C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9579F21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgBDXEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:04:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:22705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDXEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:04:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="264017965"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 15:04:48 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v2 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Date:   Tue,  4 Feb 2020 15:01:53 -0800
Message-Id: <cover.1580848931.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tiger Lake platform supports 8 sub-states/low power modes of S0ix. Add
debugfs entries to pmc_core driver to access low power mode registers
and residencies.

Patch 1: Add debugfs entry to access sub-state residencies
Patch 2: Add debugfs entry for low power mode status registers
Patch 3: Refactor the driver by removing redundant code
Patch 4: Remove slp_s0 attributes from tgl_reg_map
Patch 5: Add an additional parameter to pmc_core_lpm_display_map()
Patch 6: Dump low power status registers on an S0ix.y failure
Patch 7: Add debugfs support to access live status registers

Changes since v1:
1) Rebased it on for-next branch to make sure patch series apply
   cleanly.

Gayatri Kammela (7):
  platform/x86: intel_pmc_core: Add debugfs entry to access sub-state
    residencies
  platform/x86: intel_pmc_core: Add debugfs entry for low power mode
    status registers
  platform/x86: intel_pmc_core: Refactor the driver by removing
    redundant code
  platform/x86: intel_pmc_core: Remove slp_s0 attributes from
    tgl_reg_map
  platform/x86: intel_pmc_core: Add an additional parameter to
    pmc_core_lpm_display()
  platform/x86: intel_pmc_core: Dump low power status registers on an
    S0ix.y failure
  platform/x86: intel_pmc_core: Add debugfs support to access live
    status registers

 drivers/platform/x86/intel_pmc_core.c | 301 +++++++++++++++++++++++---
 drivers/platform/x86/intel_pmc_core.h |  28 +++
 2 files changed, 302 insertions(+), 27 deletions(-)

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
-- 
2.17.1

