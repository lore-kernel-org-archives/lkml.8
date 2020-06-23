Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F1CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC0D206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbgFXFaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:30:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:18252 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXFaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:30:22 -0400
IronPort-SDR: mau8QxQKBsY2drSairiJIomzmz92s8ody4+hibI9Bi2gmXMXon5atMqzlYJfPbiMNwmxWwsNUn
 h7Z5YP/LZahg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124007096"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="124007096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:30:21 -0700
IronPort-SDR: dNNG/FjxZNNvO92lWI4QFllYq59j9TOUC3fQy9jseazoWzXQf0pfVLlAsAEwlVcbG7wc5+yczg
 qKkFU99mtWqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="452513461"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:30:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 5/9] soundwire: intel_init: add implementation of sdw_intel_enable_irq()
Date:   Wed, 24 Jun 2020 01:35:42 +0800
Message-Id: <20200623173546.21870-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
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

