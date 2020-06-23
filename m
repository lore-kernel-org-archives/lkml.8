Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4ADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF4B2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbgFXF37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:29:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:59032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXF36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:29:58 -0400
IronPort-SDR: c9Y8SbSsts0A+8R6Ae+KiLU1Su6hbFY2PHe4+V201YZ8+yZ2JzuuVguq/yRq6FP34f/qPsqc73
 FJWjgISzhTNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124597037"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="124597037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:29:58 -0700
IronPort-SDR: 14rUsAqnY/CsCOHKN/2Q+3sVDWQksR/qZ5io6U8OjRUBlKWILaXzuZVtw8LVDrUI8SDZm6AjoG
 NwOju7NG6ALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="452513215"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:29:54 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/9] soundwire: intel: revisit SHIM programming
Date:   Wed, 24 Jun 2020 01:35:37 +0800
Message-Id: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does some cleanup, revisits SHIM programming sequences,
and merges Soundwire interrupt handlers/threads.

Bard Liao (2):
  soundwire: intel/cadence: merge Soundwire interrupt handlers/threads
  Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx

Pierre-Louis Bossart (6):
  soundwire: intel: reuse code for wait loops to set/clear bits
  soundwire: intel: revisit SHIM programming sequences.
  soundwire: intel: introduce a helper to arm link synchronization
  soundwire: intel: introduce helper for link synchronization
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()
  soundwire: intel_init: use EXPORT_SYMBOL_NS

Rander Wang (1):
  soundwire: intel: add wake interrupt support

 drivers/soundwire/cadence_master.c  |  18 +-
 drivers/soundwire/cadence_master.h  |   4 +
 drivers/soundwire/intel.c           | 389 ++++++++++++++++++++++------
 drivers/soundwire/intel.h           |   9 +
 drivers/soundwire/intel_init.c      | 101 +++++++-
 include/linux/soundwire/sdw_intel.h |   2 +
 6 files changed, 425 insertions(+), 98 deletions(-)

-- 
2.17.1

