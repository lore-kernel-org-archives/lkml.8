Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5ADC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712F206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgCKSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:41:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:27194 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbgCKSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 11:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441776196"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 11:41:36 -0700
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
Subject: [PATCH 00/16] SoundWire: cadence: add clock stop and fix programming sequences
Date:   Wed, 11 Mar 2020 13:41:12 -0500
Message-Id: <20200311184128.4212-1-pierre-louis.bossart@linux.intel.com>
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

 drivers/soundwire/cadence_master.c | 297 ++++++++++++++++++++++++-----
 drivers/soundwire/cadence_master.h |   9 +-
 drivers/soundwire/intel.c          |   2 +-
 3 files changed, 261 insertions(+), 47 deletions(-)


base-commit: 5de79ba865d7770c3bdde7c266ed425832764aac
-- 
2.20.1

