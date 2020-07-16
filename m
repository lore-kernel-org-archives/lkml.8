Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC900C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF08D2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGQDEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:04:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:62877 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgGQDEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:04:23 -0400
IronPort-SDR: 96SwfvWvwl7xgZ2vpLDLi2fXuJ47I33YZkBATLMUcLD3rmSFP4yAILruQspbLIVo9VgLG4ZDOS
 oG0KEifxzq9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129613811"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="129613811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:22 -0700
IronPort-SDR: WLEZdYxuCE05hqXjI82TnIvFXbc0/ka6352oQCOM17dqjBz4bj969r4+/ERwkPKtBWmUjYU6va
 uJB8xTfVFaQg==
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460699701"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 20:04:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 5/9] soundwire: intel_init: add implementation of sdw_intel_enable_irq()
Date:   Thu, 16 Jul 2020 23:09:43 +0800
Message-Id: <20200716150947.22119-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This function is required to enable all interrupts across all links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index f50a93130d12..d8f0c1472f1f 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -142,6 +142,30 @@ sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 	return 0;
 }
 
+#define HDA_DSP_REG_ADSPIC2             (0x10)
+#define HDA_DSP_REG_ADSPIS2             (0x14)
+#define HDA_DSP_REG_ADSPIC2_SNDW        BIT(5)
+
+/**
+ * sdw_intel_enable_irq() - enable/disable Intel SoundWire IRQ
+ * @mmio_base: The mmio base of the control register
+ * @enable: true if enable
+ */
+void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
+{
+	u32 val;
+
+	val = readl(mmio_base + HDA_DSP_REG_ADSPIC2);
+
+	if (enable)
+		val |= HDA_DSP_REG_ADSPIC2_SNDW;
+	else
+		val &= ~HDA_DSP_REG_ADSPIC2_SNDW;
+
+	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
+}
+EXPORT_SYMBOL(sdw_intel_enable_irq);
+
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
 {
-- 
2.17.1

