Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B1C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQQeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:47605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgCQQeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:06 -0400
IronPort-SDR: HDuWxyEkrjoQ38KaJxRLlCHpeWH8ZO7un5qxbNYzgay9GKKu+25IEkE/dV0QqapEYh41ksuP9/
 pkDX8+Tr2LmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:34:06 -0700
IronPort-SDR: 4byRzvWkpFm4nBr7uJvK8YG7cFS6Fkjvt6HHpH+7ajiLMcrRxD5yaKgQ0/KY6XmpLDRe7XxW5r
 fY5iU6+JriFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="244533087"
Received: from aavila-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.36.39])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 09:34:02 -0700
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
Subject: [PATCH v2 00/17] SoundWire: cadence: add clock stop and fix programming sequences
Date:   Tue, 17 Mar 2020 11:33:12 -0500
Message-Id: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make progress with SoundWire support, this patchset provides the
missing support for clock stop modes, and revisits all Cadence Master
register settings. The current code is for some reason not aligned
with internal documentation and hardware recommended flows,
specifically for multi-link operation.

Changes since v1:
Removed log in is_clock_stop(), use the helper in the main
clock_stop() and change return 1->return 0.
Fixed squash issue in patch5 to remove irrelevant udelay() change
Added Patch17 to clear FIFOs and avoid pop noise

Pierre-Louis Bossart (12):
  soundwire: cadence: s/update_config/config_update
  soundwire: cadence: handle error cases with CONFIG_UPDATE
  soundwire: cadence: mask Slave interrupt before stopping clock
  soundwire: cadence: merge routines to clear/set bits
  soundwire: cadence: move clock/SSP related inits to dedicated function
  soundwire: cadence: make SSP interval programmable
  soundwire: cadence: reorder MCP_CONFIG settings
  soundwire: cadence: enable NORMAL operation in cdns_init()
  soundwire: cadence: remove PREQ_DELAY assignment
  soundwire: cadence: remove automatic command retries
  soundwire: cadence: commit changes in the exit_reset() sequence
  soundwire: cadence: multi-link support

Rander Wang (4):
  soundwire: cadence: simplifiy cdns_init()
  soundwire: cadence: add interface to check clock status
  soundwire: cadence: add clock_stop/restart routines
  soundwire: cadence: fix a io timeout issue in S3 test

randerwang (1):
  soundwire: cadence: clear FIFO to avoid pop noise issue on playback
    start

 drivers/soundwire/cadence_master.c | 282 ++++++++++++++++++++++++-----
 drivers/soundwire/cadence_master.h |   9 +-
 drivers/soundwire/intel.c          |   2 +-
 3 files changed, 249 insertions(+), 44 deletions(-)


base-commit: 0b43fef979b4664d51a09dc7e0c430ebb2d18267
-- 
2.20.1

