Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F019620674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGVIbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:31:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:10111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVIbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:31:45 -0400
IronPort-SDR: 2n3+5PlxtgGS8qOKaq5R/rBx9WRv1Jw+yG/IsK+oJMTOArr/RzOUzFcn/hxvuAinKO/rmH3jcn
 HwJcnVmjQK6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147787941"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="147787941"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:44 -0700
IronPort-SDR: zMd+VLFpbMOrJmmWr/9BSElL1yk2Edq9WGb8p9IFUybiVaKfRysjU8cvlhfZYv/fzhlv65NTuv
 mVVb800E6W5Q==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="432303114"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 01:31:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 00/13] soundwire: intel: add power management support
Date:   Wed, 22 Jul 2020 04:37:10 +0800
Message-Id: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds power management support for Intel soundwire links.

Bard Liao (1):
  soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
    resuming

Pierre-Louis Bossart (10):
  soundwire: intel: Add basic power management support
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
 drivers/soundwire/intel.c          | 448 ++++++++++++++++++++++++++++-
 drivers/soundwire/intel.h          |   2 +
 drivers/soundwire/intel_init.c     |  19 +-
 4 files changed, 465 insertions(+), 8 deletions(-)

-- 
2.17.1

