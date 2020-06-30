Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81ACD20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGAGie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:38:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:38225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:38:33 -0400
IronPort-SDR: AHG+H5PpVI2EGg0PXtLU8jjZhM+Wn3YnOPzkT8PZoe3fBRWqcMIBZXU+2TWJXp1qTbQY+/DH7y
 0Czot3pOKCDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146485938"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146485938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:20 -0700
IronPort-SDR: ToSCKp88eW9y02/v3lQVp5dgFcLZuDbjRIsnu2UT/WB68T7ZgGXPl9jsU/wQhnf0lnAXodnlK7
 ousKrBw0A8gA==
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="454946463"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/5] soundwire: handle stream at the dailink level
Date:   Wed,  1 Jul 2020 02:43:51 +0800
Message-Id: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, stream is handled at the dai level. But we have to handle
stream at the dailink level in the multi-cpu dailink usage.

changes in v2:
 - Add kernel doc
 - Use single line trace log

Pierre-Louis Bossart (5):
  soundwire: intel: implement get_sdw_stream() operations
  soundwire: stream: add helper to startup/shutdown streams
  soundwire: intel: remove stream allocation/free
  soundwire: cadence: allocate/free dma_data in set_sdw_stream
  soundwire: intel: don't free dma_data in DAI shutdown

 Documentation/driver-api/soundwire/stream.rst | 11 ++-
 drivers/soundwire/cadence_master.c            | 52 +++++++---
 drivers/soundwire/intel.c                     | 82 ++++------------
 drivers/soundwire/stream.c                    | 98 +++++++++++++++++++
 include/linux/soundwire/sdw.h                 |  2 +
 5 files changed, 167 insertions(+), 78 deletions(-)

-- 
2.17.1

