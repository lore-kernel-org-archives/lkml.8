Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C5C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346672082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgBYRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:01:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:25248 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:01:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 09:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="317139620"
Received: from sorin-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.45.43])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2020 09:00:54 -0800
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
Subject: [PATCH 0/3] SoundWire: ASoC interfaces for multi-cpu dais and DisCo helpers
Date:   Tue, 25 Feb 2020 11:00:38 -0600
Message-Id: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches prepare the support of multi-cpu dais for
synchronized playback and capture. We remove an unused set of
prototypes and add a get_sdw_stream() callback prototype currently
missing (the implementation will come later as part of the
synchronized playback)

The last exposes macros used internally, so that they can be reused to
extract information from the _ADR 64-bit values in SOF platform
drivers and related machine drivers.

I think it's simpler if all these simple patches are merged through
the SoundWire tree. With the additional changes to remove the platform
drivers and the merge of interrupt handling, that will result in a
single immutable tag provided to Mark Brown.

Pierre-Louis Bossart (3):
  soundwire: cadence: remove useless prototypes
  ASoC: soc-dai: add get_sdw_stream() callback
  soundwire: add helper macros for devID fields

 drivers/soundwire/bus.c            | 21 +++++----------------
 drivers/soundwire/cadence_master.h |  8 --------
 include/linux/soundwire/sdw.h      | 23 +++++++++++++++++++++++
 include/sound/soc-dai.h            | 21 +++++++++++++++++++++
 4 files changed, 49 insertions(+), 24 deletions(-)

-- 
2.20.1

