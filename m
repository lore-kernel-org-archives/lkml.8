Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA01C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C372078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgFOOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:14:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:34462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgFOOOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:14:06 -0400
IronPort-SDR: Rg4rbE70YBB0lRZKozeCjrGZJaCYCYuMt8TQ9CHo9IvmDC0FPC/DiOk1C+YyV0BfrvYV1MXO/H
 5xxUUwhCOoWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:14:05 -0700
IronPort-SDR: FK6Doo0pad3ZqG23ryY2kjg47LjDN6k11ZgJOwjID2AHLtM6jprU5IeGDlYWjirPgjH6iycimd
 6Y3zupR8rKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476029192"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 07:14:04 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 0/4] extend svc and rsu drivers for new RSU features 
Date:   Mon, 15 Jun 2020 09:29:04 -0500
Message-Id: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Patches have been internally reviewed by colleagues at Intel.

DCMF = Decision Configuration Management Firmware. The max retry parameter
is the maximum times the images is allowed to reload itself before giving
up and starting RSU failover flow.

Extend Intel Stratix10 service layer and Remote System Update (RSU)
drivers to get decision configuration management firmware (DCMF) versions
and max retry parameter value.

Add 5 device attributes to Intel Stratix10 Remote System Update (RSU)
sysfs interface.

Correct the incorrect flag value for COMMAND_RECONFIG_FLAG_PARTIAL and
increase FPGA reconfig timeout values.

Richard Gong (4):
  firmware: stratix10-svc: correct reconfig flag and timeout values
  firmware: stratix10-svc: extend svc to support new RSU features
  firmware: stratix10-rsu: extend rsu driver for new features
  firmware: rsu: add device attributes to sysfs interface

 .../testing/sysfs-devices-platform-stratix10-rsu   |  36 +++++
 drivers/firmware/stratix10-rsu.c                   | 166 ++++++++++++++++++++-
 drivers/firmware/stratix10-svc.c                   |  17 +++
 include/linux/firmware/intel/stratix10-smc.h       |  43 ++++++
 .../linux/firmware/intel/stratix10-svc-client.h    |  17 ++-
 5 files changed, 269 insertions(+), 10 deletions(-)

-- 
2.7.4

