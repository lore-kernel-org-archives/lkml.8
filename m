Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F8C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD3Gqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:46:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:56943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgD3Gqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:46:34 -0400
IronPort-SDR: V80BdiEz/JbRokzWcXFy4bMOs80BZgtG38lMljU01g6ZFl9Fohhmn74nsxmhlPmmiTtDJPvqL3
 RCN+pErGbxLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 23:46:34 -0700
IronPort-SDR: FLINvBnF6DVGFZNPKgQvB8JdisnVaRhTTCrQJRjw80Tuoy3qF63OT7zCc13sCEiU4bykvJy6Li
 aLeD2FnvNhcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="249662772"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 23:46:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: bus_type: add sdw_master_device support
Date:   Thu, 30 Apr 2020 02:51:42 +0800
Message-Id: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds sdw master devices support.

Pierre-Louis Bossart (3):
  soundwire: bus: rename sdw_bus_master_add/delete, add arguments
  soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
  soundwire: bus_type: add sdw_master_device support

 .../driver-api/soundwire/summary.rst          |  7 +-
 drivers/soundwire/Makefile                    |  2 +-
 drivers/soundwire/bus.c                       | 27 ++++---
 drivers/soundwire/bus.h                       |  3 +
 drivers/soundwire/bus_type.c                  | 19 +++--
 drivers/soundwire/intel.c                     |  9 ++-
 drivers/soundwire/master.c                    | 79 +++++++++++++++++++
 drivers/soundwire/qcom.c                      |  7 +-
 drivers/soundwire/slave.c                     |  8 +-
 include/linux/soundwire/sdw.h                 | 22 +++++-
 include/linux/soundwire/sdw_type.h            |  9 ++-
 11 files changed, 160 insertions(+), 32 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.17.1

