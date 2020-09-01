Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A515C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801FD2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIBDAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:00:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:23996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgIBDAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:00:04 -0400
IronPort-SDR: Vc7SL6jAqb6/jGHK8mLUmBQvHqmZlqPuh5Y/fzIQBCaN5GTYjuHg9XU7AZowFMPbqTd/wYuxyl
 kfG0pbcNDAbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860106"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 20:00:03 -0700
IronPort-SDR: GREZdfE6O4YCP5rqbgSo15xy0SFNXBT+oegSmZVc14nhs5xx+NvL9DvqEZgPp6nhd5ZgSKT/1t
 /aHnvi/8Fodg==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588154"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 06/10] soundwire: intel: add multi-link hw_synchronization information
Date:   Tue,  1 Sep 2020 23:05:52 +0800
Message-Id: <20200901150556.19432-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

set the flags as required by hardware implementation

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8634d33c388c..272826973426 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1400,7 +1400,14 @@ int intel_master_startup(struct platform_device *pdev)
 		dev_dbg(dev, "Multi-link is disabled\n");
 		bus->multi_link = false;
 	} else {
+		/*
+		 * hardware-based synchronization is required regardless
+		 * of the number of segments used by a stream: SSP-based
+		 * synchronization is gated by gsync when the multi-master
+		 * mode is set.
+		 */
 		bus->multi_link = true;
+		bus->hw_sync_min_links = 1;
 	}
 
 	/* Initialize shim, controller */
-- 
2.17.1

