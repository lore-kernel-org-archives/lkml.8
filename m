Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FFC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46B924673
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOAJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:09:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:8608 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgAOAJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 16:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="273468527"
Received: from emkilgox-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.0.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 16:09:33 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/10] soundwire: bus: fix race conditions, add suspend-resume
Date:   Tue, 14 Jan 2020 18:08:34 -0600
Message-Id: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing mainline code for SoundWire does not handle critical race
conditions, and does not have any support for pm_runtime suspend or
clock-stop modes needed for e.g. jack detection or external VAD.

As suggested by Vinod, these patches for the bus are shared first -
with the risk that they are separated from their actual use in Intel
drivers, so reviewers might wonder why they are needed in the first
place.

For reference, the complete set of 90+ patches required for SoundWire
on Intel platforms is available here:

https://github.com/thesofproject/linux/pull/1692

These patches are not Intel-specific and are likely required for
e.g. Qualcomm-based implementations.

All the patches in this series were generated during the joint
Intel-Realtek validation effort on Intel reference designs and
form-factor devices. The support for the initialization_complete
signaling is already available in the Realtek codecs drivers merged in
the ASoC tree (rt700, rt711, rt1308, rt715)

Pierre-Louis Bossart (8):
  soundwire: bus: fix race condition with probe_complete signaling
  soundwire: bus: fix race condition with enumeration_complete signaling
  soundwire: bus: fix race condition with initialization_complete
    signaling
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: bus: add helper to clear Slave status to UNATTACHED
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: bus: don't treat CMD_IGNORED as error on ClockStop

Rander Wang (2):
  soundwire: bus: fix io error when processing alert event
  soundwire: bus: add clock stop helpers

 drivers/soundwire/bus.c       | 509 ++++++++++++++++++++++++++++++++--
 drivers/soundwire/bus.h       |   9 +
 drivers/soundwire/bus_type.c  |   5 +
 drivers/soundwire/slave.c     |   4 +
 include/linux/soundwire/sdw.h |  24 ++
 5 files changed, 526 insertions(+), 25 deletions(-)

-- 
2.20.1

