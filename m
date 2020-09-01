Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B823C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A890206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBC40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:56:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:49594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIBC4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:56:25 -0400
IronPort-SDR: Iftd7/tx/YhQ93G7NuN589vT95sn2A0yIbgjeus/oGI6zU89RRZaJh8ZwbwuZrn4sijTP+PQ/E
 hvNpR/Zcmd6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221528363"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="221528363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:23 -0700
IronPort-SDR: jBgxsSqL2oXJ/4EVq/a9gAZ4Edsb+NYd7YoMISZkZS6tdjBfayU4rHaIkvU+ySPF7v5UTEbSGS
 w5UMrrgpw8VA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477457229"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:19 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
Date:   Tue,  1 Sep 2020 23:02:33 +0800
Message-Id: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw stream operation APIs can be called once per stream. dailink
callbacks are good places to call these APIs.

Pierre-Louis Bossart (7):
  ASoC: soc-dai: clarify return value for get_sdw_stream()
  soundwire: stream: fix NULL/IS_ERR confusion
  soundwire: intel: fix NULL/ERR_PTR confusion
  ASOC: Intel: sof_sdw: add dailink .trigger callback
  ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
  soundwire: intel: remove .trigger operation
  soundwire: intel: remove stream handling from .prepare and .hw_free

 drivers/soundwire/intel.c        | 60 ++++-------------------
 drivers/soundwire/stream.c       |  2 +-
 include/sound/soc-dai.h          |  3 +-
 sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 54 deletions(-)

-- 
2.17.1

