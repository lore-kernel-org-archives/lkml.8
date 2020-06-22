Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2522120738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbgFWJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:17:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:45826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbgFWJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:17:45 -0400
IronPort-SDR: 5mv4vhj2ieh6EtVjPCnOoSExZUKMvKzWHbgP2dL3waiZVgJha9zmZGvQCwGV+d1WvXe+Jd7khk
 a0f435Uk71Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228682240"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="228682240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 02:17:45 -0700
IronPort-SDR: 2kj/eADqW2B3uTAOl55PSr3BlU1DyZYy+sucwVHhVgIPMgaibb7jrUZB/V9eiQCu6+oLcdebpP
 25C/lwg++/xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="293141959"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2020 02:17:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: handle stream at the dailink level
Date:   Tue, 23 Jun 2020 05:23:27 +0800
Message-Id: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, stream is handled at the dai level. But we have to handle
stream at the dailink level in the multi-cpu dailink usage.

Pierre-Louis Bossart (5):
  soundwire: intel: implement get_sdw_stream() operations
  soundwire: stream: add helper to startup/shutdown streams
  soundwire: intel: remove stream allocation/free
  soundwire: cadence: allocate/free dma_data in set_sdw_stream
  soundwire: intel: don't free dma_data in DAI shutdown

 drivers/soundwire/cadence_master.c | 52 ++++++++++++-----
 drivers/soundwire/intel.c          | 82 +++++++--------------------
 drivers/soundwire/stream.c         | 90 ++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h      |  2 +
 4 files changed, 149 insertions(+), 77 deletions(-)

-- 
2.17.1

