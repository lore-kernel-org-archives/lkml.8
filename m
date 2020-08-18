Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94492C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A63F2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHROfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:35:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:50397 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgHROfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:13 -0400
IronPort-SDR: cxfQu3nABFlxs71gkB/Q+PeY9qd3yzhGgYUT7k9pBmqCwBJ+hTafUogvGUQY8DguR3aqA3e/WW
 1Gqw24C2iPEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="134972061"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="134972061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:12 -0700
IronPort-SDR: wocKKZzVhI3sF2f0xlsRaWqstQJiY0+OiFswM4jwM6bZ5waBkYSJGHqaIJuDxcp0uGPmQy3II1
 +/vC68wElUog==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830239"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:08 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 00/11] soundwire: intel: add multi-link support
Date:   Tue, 18 Aug 2020 10:41:09 +0800
Message-Id: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables multi-link support for Intel platforms.

Bard Liao (1):
  soundwire: intel: Only call sdw stream APIs for the first cpu_dai

Pierre-Louis Bossart (10):
  soundwire: intel: disable shim wake on suspend
  soundwire: intel: ignore software command retries
  soundwire: intel: add multi-link support
  soundwire: intel: add missing support for all clock stop modes
  soundwire: bus: update multi-link definition with hw sync details
  soundwire: intel: add multi-link hw_synchronization information
  soundwire: stream: enable hw_sync as needed by hardware
  soundwire: intel: add dynamic debug trace for clock-stop invalid
    configs
  soundwire: intel: pass link_mask information to each master
  soundwire: intel: don't manage link power individually

 drivers/soundwire/intel.c      | 309 ++++++++++++++++++++++++++++-----
 drivers/soundwire/intel.h      |   2 +
 drivers/soundwire/intel_init.c |   1 +
 drivers/soundwire/stream.c     |  15 +-
 include/linux/soundwire/sdw.h  |   6 +
 5 files changed, 282 insertions(+), 51 deletions(-)

-- 
2.17.1

