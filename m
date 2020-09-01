Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1361C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEB9206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBC7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:59:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:23978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgIBC7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:59:42 -0400
IronPort-SDR: DWtrw/OBO4jisod5UQOrcv4+BN1nW7DemJf/+XgWzc8dnp5LKXNzI+mc3X3KMKz/iU+aFpmyA3
 YsxnBP6SGe0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860077"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:41 -0700
IronPort-SDR: X1MPTE871sdBV602QOuRg/Z+4KIzvdTh0vbysOTn9EZ6QIu/qCWFWvZsTZttAQuaUDrKxNd09Y
 e4XfPd5FfGoA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588046"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:37 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 00/10] soundwire: intel: add multi-link support
Date:   Tue,  1 Sep 2020 23:05:46 +0800
Message-Id: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables multi-link support for Intel platforms.

Changes in v2:
- Remove the "soundwire: intel: Only call sdw stream APIs for the first
  cpu_dai" patch form this series. We will move the sounwdire stream
  operations to machine driver in another series.
- Update the commit message and title of "soundwire: intel: add error log
  for clock-stop invalid configs"

Pierre-Louis Bossart (10):
  soundwire: intel: disable shim wake on suspend
  soundwire: intel: ignore software command retries
  soundwire: intel: add multi-link support
  soundwire: intel: add missing support for all clock stop modes
  soundwire: bus: update multi-link definition with hw sync details
  soundwire: intel: add multi-link hw_synchronization information
  soundwire: stream: enable hw_sync as needed by hardware
  soundwire: intel: add error log for clock-stop invalid configs
  soundwire: intel: pass link_mask information to each master
  soundwire: intel: don't manage link power individually

 drivers/soundwire/intel.c      | 264 ++++++++++++++++++++++++++++-----
 drivers/soundwire/intel.h      |   2 +
 drivers/soundwire/intel_init.c |   1 +
 drivers/soundwire/stream.c     |  15 +-
 include/linux/soundwire/sdw.h  |   6 +
 5 files changed, 243 insertions(+), 45 deletions(-)

-- 
2.17.1

