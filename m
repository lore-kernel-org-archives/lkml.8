Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF423C3F2CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D2E24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgB0WcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:32:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:48642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgB0WcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="411194785"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 14:32:18 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/8] soundwire: remove platform devices, add SOF interfaces
Date:   Thu, 27 Feb 2020 16:31:58 -0600
Message-Id: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches were already reviewed by Greg KH in an earlier
RFC. Since I only cleaned-up the error handling flow and removed an
unnecessary wrapper, I took the liberty of adding Greg's Reviewed-by
tag for these two patches.

The rest of the patches implement the interfaces required for the SOF
driver (interrupts handled with a single handler, PCI wakes and
sharing of _ADR information to select a machine driver).

When this patchset is merged, a tag will need to be shared with Mark
Brown so that we can provide the SOF patches to the ASoC tree and
enable SoundWire in builds for Intel platforms.

Bard Liao (2):
  soundwire: intel/cadence: merge Soundwire interrupt handlers/threads
  soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx

Pierre-Louis Bossart (5):
  soundwire: bus_type: add master_device/driver support
  soundwire: intel: transition to sdw_master_device/driver support
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()
  soundwire: intel_init: use EXPORT_SYMBOL_NS
  soundwire: intel: add helpers for link power down and shim wake

Rander Wang (1):
  soundwire: intel: add wake interrupt support

 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus_type.c       | 141 ++++++++++-
 drivers/soundwire/cadence_master.c |  18 +-
 drivers/soundwire/cadence_master.h |   4 +
 drivers/soundwire/intel.c          | 182 +++++++++++---
 drivers/soundwire/intel.h          |  12 +-
 drivers/soundwire/intel_init.c     | 365 +++++++++++++++++++++++------
 drivers/soundwire/master.c         | 100 ++++++++
 drivers/soundwire/slave.c          |   7 +-
 include/linux/soundwire/sdw.h      |  76 ++++++
 include/linux/soundwire/sdw_type.h |  36 ++-
 11 files changed, 819 insertions(+), 124 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

