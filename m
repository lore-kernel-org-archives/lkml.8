Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D5A2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgIDIki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:40:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:5910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIDIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:40:35 -0400
IronPort-SDR: ztIRsJEBFy6vj2ywCyx4lJF+YVm6DnCUbPmk6eO10llPiqKHJ/izyj5sE5Ri2yEGn6Gh+eiCwv
 AfVCAw2OBlJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137763263"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="137763263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:40:34 -0700
IronPort-SDR: SArn5SKMBnPwKqdjUimlbTiMJ8yKzoB0sqc6YHLrl13UwYQRYsnXSyM+29UpGwYUMcBUyYVz0r
 GtBjRVdL8u9w==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="478402057"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:40:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/3] ASoC: Add sdw stream operations to dailink ops.
Date:   Fri,  4 Sep 2020 04:46:47 +0800
Message-Id: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sdw stream operation APIs can be called once per stream. Move these
operations to dailink ops. The linked series is "soundwire: Remove sdw
stream operations from Intel soundwire dai".

Pierre-Louis Bossart (3):
  ASoC: soc-dai: clarify return value for get_sdw_stream()
  ASOC: Intel: sof_sdw: add dailink .trigger callback
  ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback

 include/sound/soc-dai.h          |  3 +-
 sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.17.1

