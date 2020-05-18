Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA13C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C086820708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgESFiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:38:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:13606 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgESFiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:38:07 -0400
IronPort-SDR: J0D1LK3Bhr649MmKWJC/sKPKrFp1IUPPxWqFs+H2i+QnLK7+Vlq7bkR8m9AFj34FfLEaxY8P1f
 0Rlx+wSqBK0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:38:06 -0700
IronPort-SDR: N+3DXfa7REA6Lxc8dVmdsiyma4Gf3XTYenGfx9UEfzHaqG5TFpRRL6oIQAIpeo88DQb6QnqFL/
 dUwQJieYZcKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288836499"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:02 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 0/5] soundwire: bus_type: add sdw_master_device support
Date:   Tue, 19 May 2020 01:43:17 +0800
Message-Id: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sdw master devices support.

changes in v2:
 - Allocate sdw_master_device dynamically
 - Use unique bus id as master id
 - Keep checking parent devices
 - Enable runtime_pm on Master device

Bard Liao (2):
  soundwire: bus: add unique bus id
  soundwire: master: add runtime pm support

Pierre-Louis Bossart (3):
  soundwire: bus: rename sdw_bus_master_add/delete, add arguments
  soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
  soundwire: bus_type: add sdw_master_device support

 .../driver-api/soundwire/summary.rst          |  7 +-
 drivers/soundwire/Makefile                    |  2 +-
 drivers/soundwire/bus.c                       | 47 ++++++++--
 drivers/soundwire/bus.h                       |  3 +
 drivers/soundwire/bus_type.c                  | 19 ++--
 drivers/soundwire/intel.c                     |  9 +-
 drivers/soundwire/master.c                    | 88 +++++++++++++++++++
 drivers/soundwire/qcom.c                      |  7 +-
 drivers/soundwire/slave.c                     |  8 +-
 include/linux/soundwire/sdw.h                 | 24 ++++-
 include/linux/soundwire/sdw_type.h            |  9 +-
 11 files changed, 191 insertions(+), 32 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.17.1

