Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA83C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2086206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgCKWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:10:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:59207 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgCKWKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:10:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277550528"
Received: from fjan-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.25.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 15:10:36 -0700
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
Subject: [PATCH 0/7] SoundWire: intel: fix SHIM programming sequences
Date:   Wed, 11 Mar 2020 17:10:19 -0500
Message-Id: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The low-level register programming sequences contributed in
71bb8a1b059ecd ('soundwire: intel: Add Intel Master driver') do not
follow the internal documentation and recommended flows. It's anyone's
guess how the code might have worked. Fix and add all missing helpers
for clock-stop and hardware-based synchronization.

This patchset needs to be applied on top of "[PATCH 00/16] SoundWire:
cadence: add clock stop and fix programming sequences"

Reviewers might object that the code is provided without some required
initializations for mutexes and shim masks, they will be added as part
of the transition to sdw_master_device - still stuck as of 3/11.

Pierre-Louis Bossart (6):
  soundwire: intel: add helpers for link power down and shim wake
  soundwire: intel: reuse code for wait loops to set/clear bits
  soundwire: intel: add mutex to prevent concurrent access to SHIM
    registers
  soundwire: intel: add definitions for shim_mask
  soundwire: intel: introduce a helper to arm link synchronization
  soundwire: intel: introduce helper for link synchronization

Rander Wang (1):
  soundwire: intel: follow documentation sequences for SHIM registers

 drivers/soundwire/intel.c           | 342 ++++++++++++++++++++++------
 drivers/soundwire/intel.h           |   4 +
 include/linux/soundwire/sdw_intel.h |   2 +
 3 files changed, 277 insertions(+), 71 deletions(-)

-- 
2.20.1

