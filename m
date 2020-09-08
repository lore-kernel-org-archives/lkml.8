Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EDF21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIIBjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:39:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:57624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgIIBjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:39:06 -0400
IronPort-SDR: /aBGlbq/CJlgv0IwlBSgU9JSRNudPqvs7n4dI/p+8kYx2xhHFYq+5IchEQZ6hOUtjtDAwEnjcB
 RdIJHzVXhmLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137770870"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="137770870"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:05 -0700
IronPort-SDR: fzCmra/vckW9qethiegEd1+Mr9kpTpU4a9eY9jld6IgqwdkseVuRaE69ErhOmkdKXSH4PSUwmy
 tzJUHUh8xVkQ==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="449018077"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:01 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/7] ASoC/soundwire: filter out invalid PARITY errors
Date:   Tue,  8 Sep 2020 21:45:14 +0800
Message-Id: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some codecs may report fake PARITY errors in the initial state. This
series will filter them out.

Pierre-Louis Bossart (7):
  ASoC/soundwire: bus: use property to set interrupt masks
  soundwire: bus: filter-out unwanted interrupt reports
  soundwire: slave: add first_interrupt_done status
  soundwire: bus: use quirk to filter out invalid parity errors
  ASoC: codecs: realtek-soundwire: ignore initial PARITY errors
  soundwire: bus: export broadcast read/write capability for tests
  soundwire: cadence: add parity error injection through debugfs

 drivers/soundwire/bus.c            | 93 ++++++++++++++++++++++++------
 drivers/soundwire/bus.h            |  4 ++
 drivers/soundwire/cadence_master.c | 86 +++++++++++++++++++++++++++
 drivers/soundwire/slave.c          |  1 +
 include/linux/soundwire/sdw.h      |  9 +++
 sound/soc/codecs/max98373-sdw.c    |  3 +
 sound/soc/codecs/rt1308-sdw.c      |  3 +
 sound/soc/codecs/rt5682-sdw.c      |  5 ++
 sound/soc/codecs/rt700-sdw.c       |  5 ++
 sound/soc/codecs/rt711-sdw.c       |  5 ++
 sound/soc/codecs/rt715-sdw.c       |  5 ++
 sound/soc/codecs/wsa881x.c         |  1 +
 12 files changed, 202 insertions(+), 18 deletions(-)

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
2.17.1

