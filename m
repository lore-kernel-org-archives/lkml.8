Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4442072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbgFXFaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:30:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:59032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXFaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:30:02 -0400
IronPort-SDR: WYqBgP8APv2zSPNwH4Q8pGsITDEQyUIgeAc6LgufJ0AAtfNR1CDtoqtIgq5bfEW2nvF0BGNfqy
 Be/iHkvPteMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124597091"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="124597091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:30:02 -0700
IronPort-SDR: /YXuIUhNkNjNpiuyXCOM96a/xMVp2Ev2JwKD0G4s5SBW3XUyaQv1OLBsHE4fe1bVkYNkIykq3Q
 DkJaSxG5J1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="452513257"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:29:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/9] soundwire: intel: reuse code for wait loops to set/clear bits
Date:   Wed, 24 Jun 2020 01:35:38 +0800
Message-Id: <20200623173546.21870-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
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

