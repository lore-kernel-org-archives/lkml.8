Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550C620706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHYRR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:17:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:23064 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHYRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:17:19 -0400
IronPort-SDR: kRqIpSnhXWQcofIeM1V4mQrxUB29X9hpSBgRxiLiBev+MLakKiLK5SMTtpQxi5zqo2RBpRYg4/
 35sMQxY+lTBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136221306"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136221306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:12 -0700
IronPort-SDR: 3J5sB4kkc2mN1d+nqB4YZ35SH7MpSKKoj/cNPuNppRPv27Ipcoqi3wILTGipjJ7zwU5QWHYHcY
 ZOSzYywA4m9A==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="331478405"
Received: from bgarring-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.4.243])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:10 -0700
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
Subject: [PATCH 0/4] regmap: add SoundWire 1.2 MBQ support
Date:   Tue, 25 Aug 2020 12:16:52 -0500
Message-Id: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of the upstream contribution of SDCA (SoundWire Device
Class for Audio) ASoC codec drivers [1] [2], add regmap support
SoundWire 1.2 MBQ support. The MBQ (Multi-Byte Quantity) registers
need to be handled in a different way from regular 8-bit SoundWire
registers, their main application is going to be for volume/gain
controls.

The 3rd patch was initially suggested for inclusion in the SoundWire
tree, and was modified to add more background information in the
commit message as requested by Vinod Koul.

Pierre-Louis Bossart (4):
  regmap: sdw: move to -EOPNOTSUPP
  regmap: sdw: add required header files
  soundwire: SDCA: add helper macro to access controls
  regmap: sdw: add support for SoundWire 1.2 MBQ

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-sdw-mbq.c    | 102 ++++++++++++++++++++++++
 drivers/base/regmap/regmap-sdw.c        |   8 +-
 include/linux/regmap.h                  |  20 +++++
 include/linux/soundwire/sdw_registers.h |  13 +++
 6 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.25.1

