Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE902C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB08208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIEGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 02:22:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:49017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEGWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:22:41 -0400
IronPort-SDR: WkYLCDaVrLX1WWBbZn1TvgsEmZKDplAKUyImMF+eHKkx1K884eTi+Sp3a07lu8t2TnQA2oL8U2
 Wb12FrcXnlqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145547445"
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; 
   d="scan'208";a="145547445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 23:22:38 -0700
IronPort-SDR: qBfk4V88ad0EdfwQ664HMYngiqPrwKfm/nVJvAk06BqB7KKuCwZ1dt6dXlfU8UinYPQ/N7ns/q
 l+bUQvvprtyg==
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; 
   d="scan'208";a="478804250"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 23:22:33 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
Date:   Sat,  5 Sep 2020 02:28:51 +0800
Message-Id: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sdw stream operation APIs can be called once per stream. Move these
operations to dailink ops. The linked series is "soundwire: Remove sdw
stream operations from Intel soundwire dai".

Reviewed-by: Vinod Koul <vkoul@kernel.org>

Changes in v3:
 - s/ASOC/ASoC

Pierre-Louis Bossart (3):
  ASoC: soc-dai: clarify return value for get_sdw_stream()
  ASoC: Intel: sof_sdw: add dailink .trigger callback
  ASoC: Intel: sof_sdw: add dailink .prepare and .hw_free callback

 include/sound/soc-dai.h          |  3 +-
 sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.17.1

