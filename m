Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A413F20716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRDXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:63964 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgHRDXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:13 -0400
IronPort-SDR: detyl8IJJyRj/h0Tt25xkLObltL0Fge78eMG7hgzP8KoAtVjK70OQPthtmiHFgM6BskEw0tjbT
 I6CxFtUJv++Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806464"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:13 -0700
IronPort-SDR: dBqri11ZwARXckzMCI9IAK9ShWp/IapE+rA0W6ovd1YbrdwL8AyUCbE5EkLYuHqkC6zgbr+udy
 IXui0HcAJUBQ==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084518"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:09 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 00/12] soundwire: intel: add power management support
Date:   Mon, 17 Aug 2020 23:29:11 +0800
Message-Id: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds power management support for Intel soundwire links.

Changes in v2:
- Move "#include <linux/pm_runtime.h>" to the first required patch.
- Fit debug log in single line. 

Bard Liao (1):
  soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
    resuming

Pierre-Louis Bossart (9):
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: intel: fix race condition on system resume
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: intel: pm_runtime idle scheduling
  soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
  soundwire: intel: add CLK_STOP_NOT_ALLOWED support
  soundwire: intel_init: handle power rail dependencies for clock stop
    mode
  soundwire: intel: support clock_stop mode without quirks

Rander Wang (2):
  soundwire: intel: add CLK_STOP_BUS_RESET support
  soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET

 drivers/soundwire/cadence_master.h |   4 +
 drivers/soundwire/intel.c          | 363 ++++++++++++++++++++++++++++-
 drivers/soundwire/intel.h          |   2 +
 drivers/soundwire/intel_init.c     |  19 +-
 4 files changed, 382 insertions(+), 6 deletions(-)

-- 
2.17.1

