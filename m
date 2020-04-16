Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5910C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8C1221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgDQIuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:50:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:7443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgDQIub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:50:31 -0400
IronPort-SDR: yOD4ulxt+1mXOLkAA93p6a3mcYv3u/I/TMnArAtDejtWO0YYJovNfWh/WYUIiPbKz4p44j+z1D
 IR53cc9qjB6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 01:50:30 -0700
IronPort-SDR: petqKNauugCtt8HtiFFVMtSL1QAAiUZUx0Oxs6ih4y3gSqYZKe8UywgZ1+HzkwbT+VAz5jxjCR
 dMgwdcBpmPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="454661427"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 01:50:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: [RFC 0/5] soundwire: create master device and use it
Date:   Fri, 17 Apr 2020 04:55:19 +0800
Message-Id: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sdw master devices and use it instead of platform devices.

An open needs to be addressed is that should we use differrent bus type for
sdw master and slave devices?

Pierre-Louis Bossart (4):
  soundwire: bus_type: add sdw_master_device support
  soundwire: qcom: fix error handling in probe
  soundwire: qcom: add sdw_master_device support
  soundwire: intel: transition to sdw_master_device

Srinivas Kandagatla (1):
  soundwire: master: use device node pointer from master device

 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus.h            |   2 +
 drivers/soundwire/bus_type.c       |  19 +-
 drivers/soundwire/intel.c          |  98 ++++++----
 drivers/soundwire/intel.h          |   8 +-
 drivers/soundwire/intel_init.c     | 293 ++++++++++++++++++++++-------
 drivers/soundwire/master.c         | 168 +++++++++++++++++
 drivers/soundwire/qcom.c           |  59 ++++--
 drivers/soundwire/slave.c          |   8 +-
 include/linux/soundwire/sdw.h      |  60 ++++++
 include/linux/soundwire/sdw_type.h |  10 +-
 11 files changed, 601 insertions(+), 126 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.17.1

