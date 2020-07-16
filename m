Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA40C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3F62076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGQDED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:31657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgGQDED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:03 -0400
IronPort-SDR: s+67tBcBZllaRw/O70WGLoDZLianKQksJIFVZG+i1irwe+CJBo/JiFspLr0i6R3Nwzc7dhRIBE
 wonJPfqgSl9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148689925"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="148689925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:02 -0700
IronPort-SDR: ywMe01TW6qSUwlNgupdvLxqbSS99qKFod0EJeccht8t5JvVg2itmSmWQ1VSFYNV67ZviM9LxNF
 YF4LPmAOGlEA==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699609"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:03:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/9] soundwire: intel: revisit SHIM programming
Date:   Thu, 16 Jul 2020 23:09:38 +0800
Message-Id: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does some cleanup, revisits SHIM programming sequences,
and merges Soundwire interrupt handlers/threads.

changes in v2:
 - Resume M device instead of S device in intel_master_process_wakeen_event
   function. See the comment in intel_master_process_wakeen_event() in
   detail.

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
 drivers/soundwire/intel.c           | 381 +++++++++++++++++++++-------
 drivers/soundwire/intel.h           |   9 +
 drivers/soundwire/intel_init.c      | 101 +++++++-
 include/linux/soundwire/sdw_intel.h |   2 +
 6 files changed, 417 insertions(+), 98 deletions(-)

-- 
2.17.1

