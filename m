Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47258C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E21E2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHRFlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:41:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:36469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHRFlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:41:21 -0400
IronPort-SDR: 857Kh1lZeKN0pBFnaCkPXb4EtOzazQu5PULaq4W8kHbtEgB7BC5S4EqP83FU5Yeq7RunA8/dHs
 VZjJEMuJJs5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152477966"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="152477966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:41:20 -0700
IronPort-SDR: g6/EUuBcDqKVtR4X9792NgCjrn485h26Oz/qQyg2gI//ZFCoZ7dSKphCRScbg7PYwchpU/aTOo
 +XWdZxsPjpBw==
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="471678365"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:41:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: fix port_ready[] dynamic allocation in
Date:   Tue, 18 Aug 2020 01:47:25 +0800
Message-Id: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
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

Pierre-Louis Bossart (2):
  soundwire: add definition for maximum number of ports
  soundwire: fix port_ready[] dynamic allocation in mipi_disco and ASoC
    codecs

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

