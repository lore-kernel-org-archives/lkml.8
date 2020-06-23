Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5509BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2AA2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbgFXFas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:30:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:1697 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbgFXFap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:30:45 -0400
IronPort-SDR: +PfI0qPQi9c351f7eOCpJgeKttqxLzLU83Ze/9klFMSSpcrlIOTMeXuoPLwBs6YnBu9TLAfVZC
 b01wii542rgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132755881"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="132755881"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:30:45 -0700
IronPort-SDR: YHZbXwFMmJMd1fC8ZZkZVKSQwJO+OCQaDr50XMc5njX1ODc/gEjJ9ey/TZZbyFPUHvGqSGvqtv
 TN22WHx0/Zdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="452513619"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:30:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 9/9] Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx
Date:   Wed, 24 Jun 2020 01:35:46 +0800
Message-Id: <20200623173546.21870-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save ACPI information in context so that we can match machine driver
with sdw _ADR matching tables.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index eff4e385bb59..6502a5e82229 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -188,7 +188,11 @@ static struct sdw_intel_ctx
 	struct sdw_intel_link_res *link;
 	struct sdw_intel_ctx *ctx;
 	struct acpi_device *adev;
+	struct sdw_slave *slave;
+	struct list_head *node;
+	struct sdw_bus *bus;
 	u32 link_mask;
+	int num_slaves = 0;
 	int count;
 	int i;
 
@@ -265,6 +269,26 @@ static struct sdw_intel_ctx
 		link->cdns = platform_get_drvdata(pdev);
 
 		list_add_tail(&link->list, &ctx->link_list);
+		bus = &link->cdns->bus;
+		/* Calculate number of slaves */
+		list_for_each(node, &bus->slaves)
+			num_slaves++;
+	}
+
+	ctx->ids = devm_kcalloc(&adev->dev, num_slaves,
+				sizeof(*ctx->ids), GFP_KERNEL);
+	if (!ctx->ids)
+		goto err;
+
+	ctx->num_slaves = num_slaves;
+	i = 0;
+	list_for_each_entry(link, &ctx->link_list, list) {
+		bus = &link->cdns->bus;
+		list_for_each_entry(slave, &bus->slaves, node) {
+			ctx->ids[i].id = slave->id;
+			ctx->ids[i].link_id = bus->link_id;
+			i++;
+		}
 	}
 
 	return ctx;
-- 
2.17.1

