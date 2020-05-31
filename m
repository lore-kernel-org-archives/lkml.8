Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF61206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFAGPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:15:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:41317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAGPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:15:41 -0400
IronPort-SDR: GCri7pg7GOqTqTDuSkO0mKovjhjGoC86+pavTVASK7S3K5VkCfG0niMJKViqJ8qmoKX0IeJvPi
 cDGfY+M+d2cA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:15:41 -0700
IronPort-SDR: NQOJu57jWeC+5P//WyPvrqjGOmuxbwGW9lqoKQe0i1L9lmpip4v9sRSyFUtLo8vibJYI6eftM2
 3lKkcvMpE0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470208623"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:15:37 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/6] soundwire: intel: transition to 3 steps initialization
Date:   Mon,  1 Jun 2020 02:20:56 +0800
Message-Id: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to split the original "soundwire: intel: transition to 3
steps initialization" patch into different patches for better review.
It also address comments from Vinod.

Pierre-Louis Bossart (6):
  soundwire: intel: cleanups for indirections/logs
  soundwire: intel: clarify drvdata and remove more indirections
  soundwire: intel_init: remove useless test
  soundwire: intel_init: use devm_ allocation
  soundwire: intel_init: pass link information as platform data
  soundwire: intel: transition to 3 steps initialization

 drivers/soundwire/intel.c      | 138 +++++++++--------
 drivers/soundwire/intel.h      |  13 ++
 drivers/soundwire/intel_init.c | 261 ++++++++++++++++++++++++++-------
 3 files changed, 295 insertions(+), 117 deletions(-)

-- 
2.17.1

