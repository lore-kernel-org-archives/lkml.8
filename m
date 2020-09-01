Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C76C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1981C2087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIBDAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:00:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:23996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIBDAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:00:00 -0400
IronPort-SDR: qVeSU1aWdEnpCDK4m9cBVdnuW4vfjeLCXwmLKDIMxn6qh+foPJHX+wYPIY3FqSKThNWT4qQC/y
 QfYUIbGNFUxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218860096"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="218860096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:59 -0700
IronPort-SDR: rcN5K088Nt+PHXwuEobRqiOjwrhP7Ui2uAlCwbs5vFNhaKDCvU+840R4QObVqBbi7K4KQwwrUp
 Za/1Gxszdwkw==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="283588096"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:59:56 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 05/10] soundwire: bus: update multi-link definition with hw sync details
Date:   Tue,  1 Sep 2020 23:05:51 +0800
Message-Id: <20200901150556.19432-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Hardware-based synchronization is typically required when the
bus->multi_link flag is set.

On Intel platforms, when the Cadence IP is configured in 'Multi Master
Mode', the hardware synchronization is required even when a stream
only uses a single segment. The existing code only deal with hardware
synchronization when a stream uses more than one segment so to remain
backwards compatible we add a configuration threshold. For Intel cases
this threshold will be set to one, other platforms may be able to use
the SSP-based sync in those cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..9adbe4fd7980 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -827,6 +827,11 @@ struct sdw_master_ops {
  * @multi_link: Store bus property that indicates if multi links
  * are supported. This flag is populated by drivers after reading
  * appropriate firmware (ACPI/DT).
+ * @hw_sync_min_links: Number of links used by a stream above which
+ * hardware-based synchronization is required. This value is only
+ * meaningful if multi_link is set. If set to 1, hardware-based
+ * synchronization will be used even if a stream only uses a single
+ * SoundWire segment.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -850,6 +855,7 @@ struct sdw_bus {
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
 	bool multi_link;
+	int hw_sync_min_links;
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.17.1

