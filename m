Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72CDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CCD207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHaBVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:21:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:18361 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgHaBV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:21:26 -0400
IronPort-SDR: U6TJDC6WfLZphU8uulIKxUR8tnbGtRa0ZCNdQiEJ77NBdp+/u9W5NMozUu2VlvAoNb8JbQer9E
 SWlusUn/roHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144639107"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="144639107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:21:26 -0700
IronPort-SDR: geFNoiApp43dnDgzKUTSISJDdK+49HGeZhvMkDE7Q2iLoriMbnUuTRV4OSqO50qEGzA3/wIwgm
 z21n+lY+x9SA==
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="476529179"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:21:22 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v3 0/3] ASoC: soundwire: fix port_ready[] dynamic allocation
Date:   Sun, 30 Aug 2020 21:27:39 +0800
Message-Id: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code allocates memory for the total number of ports.
This only works if the ports are contiguous, but will break if e.g. a
Devices uses port0, 1, and 14. The port_ready[] array would contain 3
elements, which would lead to an out-of-bounds access. Conversely in
other cases, the wrong port index would be used leading to timeouts on
prepare.

This can be fixed by allocating for the worst-case of 15
ports (DP0..DP14). In addition since the number is now fixed, we can
use an array instead of a dynamic allocation.

Changes in v3:
- Add ASoC tag in the cover letter title.
- Edit the title and commit message of the third patch for better
  understanding.

Changes in v2:
- Split patches into sdw and asoc patches. Please note that "soundwire:
  fix port_ready[] dynamic allocation in mipi_disco" and "ASoC: codecs:
  fix port_ready[] dynamic allocation in ASoC codecs" should be merged
  at the same time.

Pierre-Louis Bossart (3):
  soundwire: add definition for maximum number of ports
  soundwire: fix port_ready[] dynamic allocation in mipi_disco
  ASoC: codecs: soundwire: remove port_ready[] usage from codecs.

 drivers/soundwire/mipi_disco.c  | 18 +-----------------
 drivers/soundwire/slave.c       |  4 ++++
 include/linux/soundwire/sdw.h   |  5 +++--
 sound/soc/codecs/max98373-sdw.c | 15 +--------------
 sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
 sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
 sound/soc/codecs/rt700-sdw.c    | 15 +--------------
 sound/soc/codecs/rt711-sdw.c    | 15 +--------------
 sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------
 9 files changed, 14 insertions(+), 120 deletions(-)

-- 
2.17.1

