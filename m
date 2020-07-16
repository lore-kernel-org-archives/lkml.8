Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C8C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9A12076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGQDEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:62908 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgGQDEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:41 -0400
IronPort-SDR: AwlRHPLTrih0MjCuF+ILO5VXva8W4zeHZTf1ztAQedv4AfI4EgAepqK/JuEVpjST0FsKkSNTCg
 Au0hngT0JT7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129613949"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129613949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:39 -0700
IronPort-SDR: T2RKwTAkLJpyJWFnA7zQrkmA/IOU/vUAoTD5L1DP24cZ0+0J2Kr+D4GbwQm23YowDTSaKbjCH5
 AOtfMhqhHN0Q==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699820"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 9/9] Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx
Date:   Thu, 16 Jul 2020 23:09:47 +0800
Message-Id: <20200716150947.22119-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
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
index 8d3992f9fcdd..047252a91c9e 100644
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

