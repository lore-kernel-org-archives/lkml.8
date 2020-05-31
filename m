Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C389206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFAGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:15:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:41317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFAGP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:15:58 -0400
IronPort-SDR: 1uwv5+lHGETNCW4LCkWswyNYEhMOub8qsBr7iIKzHkAFqSjWqJCwTI6axwGL3hQhhcfj1Y92Ak
 MrnHxB9oVOzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:15:58 -0700
IronPort-SDR: nmadn5veDRO5Dv6gVAXiuAbigDySDzXCE866r6js5rSatxxVjSRwGTEPx6Ygr+XH/v6QcUcxgT
 JTLQzeas+k2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470208739"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 23:15:54 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 4/6] soundwire: intel_init: use devm_ allocation
Date:   Mon,  1 Jun 2020 02:21:00 +0800
Message-Id: <20200531182102.27840-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
References: <20200531182102.27840-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Make error handling simpler with devm_ allocation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index e87f17240547..f9d190157c47 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -42,9 +42,6 @@ static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 		link++;
 	}
 
-	kfree(ctx->links);
-	ctx->links = NULL;
-
 	return 0;
 }
 
@@ -96,14 +93,15 @@ static struct sdw_intel_ctx
 
 	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(&adev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return NULL;
 
 	ctx->count = count;
-	ctx->links = kcalloc(ctx->count, sizeof(*ctx->links), GFP_KERNEL);
+	ctx->links = devm_kcalloc(&adev->dev, ctx->count,
+				  sizeof(*ctx->links), GFP_KERNEL);
 	if (!ctx->links)
-		goto link_err;
+		return NULL;
 
 	link = ctx->links;
 
@@ -146,9 +144,8 @@ static struct sdw_intel_ctx
 	return ctx;
 
 pdev_err:
+	ctx->count = i;
 	sdw_intel_cleanup_pdev(ctx);
-link_err:
-	kfree(ctx);
 	return NULL;
 }
 
@@ -216,7 +213,6 @@ void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
 void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
 	sdw_intel_cleanup_pdev(ctx);
-	kfree(ctx);
 }
 EXPORT_SYMBOL(sdw_intel_exit);
 
-- 
2.17.1

