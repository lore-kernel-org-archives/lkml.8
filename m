Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792FD2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGQDEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:31657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgGQDEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:06 -0400
IronPort-SDR: /Iyt7D43X8NQfgibE9BQ+1+TXLBRZ0qVQpuqN//uiM+UPYdQtv+lrQ26Pa0AfkLl1lo2FW240R
 0RQrZwugCzDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148689944"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="148689944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:06 -0700
IronPort-SDR: PDBkzEMNcosW783jzHv0ctBKt97TzZYGJO80pteqKqoCw+UEuopVWgPNFehbPQ5zNmyIZicQUw
 gfMGc1Zo8y4g==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699627"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:02 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/9] soundwire: intel: reuse code for wait loops to set/clear bits
Date:   Thu, 16 Jul 2020 23:09:39 +0800
Message-Id: <20200716150947.22119-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Refactor code and use same routines on set/clear

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 45 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 7a65414e5714..8c7ae07c0fe1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -123,40 +123,33 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
 	writew(value, base + offset);
 }
 
+static int intel_wait_bit(void __iomem *base, int offset, u32 mask, u32 target)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	do {
+		reg_read = readl(base + offset);
+		if ((reg_read & mask) == target)
+			return 0;
+
+		timeout--;
+		usleep_range(50, 100);
+	} while (timeout != 0);
+
+	return -EAGAIN;
+}
+
 static int intel_clear_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (!(reg_read & mask))
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, 0);
 }
 
 static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (reg_read & mask)
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, mask);
 }
 
 /*
-- 
2.17.1

