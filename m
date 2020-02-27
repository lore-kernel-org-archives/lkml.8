Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12484C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A924650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgB0Wcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:32:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:48662 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730530AbgB0Wci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="411194895"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 14:32:36 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 8/8] soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx
Date:   Thu, 27 Feb 2020 16:32:06 -0600
Message-Id: <20200227223206.5020-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Save ACPI information in context so that we can match machine driver
with sdw _ADR matching tables.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 91ec91127f2a..60d6d844ee4a 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -74,6 +74,8 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 
 	kfree(ctx->links);
 	ctx->links = NULL;
+	kfree(ctx->ids);
+	ctx->ids = NULL;
 
 	return 0;
 }
@@ -188,7 +190,11 @@ static struct sdw_intel_ctx
 	struct acpi_device *adev;
 	struct sdw_master_device *md;
 	unsigned long time;
+	struct sdw_slave *slave;
+	struct list_head *node;
+	struct sdw_bus *bus;
 	u32 link_mask;
+	int num_slaves = 0;
 	int count;
 	int i;
 
@@ -261,6 +267,25 @@ static struct sdw_intel_ctx
 		link->md = md;
 
 		list_add_tail(&link->list, &ctx->link_list);
+		bus = &link->cdns->bus;
+		/* Calculate number of slaves */
+		list_for_each(node, &bus->slaves)
+			num_slaves++;
+	}
+
+	ctx->ids = kcalloc(num_slaves, sizeof(*ctx->ids), GFP_KERNEL);
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
2.20.1

