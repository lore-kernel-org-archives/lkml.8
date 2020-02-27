Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6960D24650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgB0Wcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:32:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:48657 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgB0Wce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:32:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 14:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="411194857"
Received: from azeira-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.147.250])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2020 14:32:32 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 6/8] soundwire: intel: add helpers for link power down and shim wake
Date:   Thu, 27 Feb 2020 16:32:04 -0600
Message-Id: <20200227223206.5020-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These routines are required for power management

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d5533564195a..eafa2016c76d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -362,6 +362,59 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	return ret;
 }
 
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 wake_en, wake_sts;
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		intel_writew(shim, SDW_SHIM_WAKEEN,
+			     (SDW_SHIM_WAKEEN_ENABLE << link_id));
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+
+		/* Clear wake status */
+		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
+	}
+}
+
+static int intel_link_power_down(struct sdw_intel *sdw)
+{
+	int link_control, spa_mask, cpa_mask, ret;
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	/* Link power down sequence */
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
+	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
+	link_control &=  spa_mask;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	if (ret < 0)
+		return ret;
+
+	sdw->cdns.link_up = false;
+	return 0;
+}
+
 /*
  * PDI routines
  */
-- 
2.20.1

