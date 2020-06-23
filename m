Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB2FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0952072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbgFXFa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:30:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:46151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXFa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:30:28 -0400
IronPort-SDR: qai4v/7qzrk08LdnHvhK7owsNZey9d0TYB9y+T301wmmcVukRBR8CpNaIbIVt+3aZQgLO2vN6c
 PQkwOxXbWs3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205847687"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="205847687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:30:28 -0700
IronPort-SDR: PM9E4C+XGCHuONMvxAOSM7ZRXVMN3bQ3IiLdf9ub+67hMyVWHZrUYmuHk5bafKix2WaFFO+/Zv
 Cx5FI8BWBZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="452513519"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:30:21 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 6/9] soundwire: intel_init: use EXPORT_SYMBOL_NS
Date:   Wed, 24 Jun 2020 01:35:43 +0800
Message-Id: <20200623173546.21870-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Make sure all symbols in this soundwire-intel-init module are exported
with a namespace.

The MODULE_IMPORT_NS will be used in Intel/SOF HDaudio modules to be
posted in a separate series.

Namespaces are only introduced for the Intel parts of the SoundWire
code at this time, in future patches we should also add namespaces for
Cadence parts and the SoundWire core.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d8f0c1472f1f..ad3175272e88 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -164,7 +164,7 @@ void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
 
 	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
 }
-EXPORT_SYMBOL(sdw_intel_enable_irq);
+EXPORT_SYMBOL_NS(sdw_intel_enable_irq, SOUNDWIRE_INTEL_INIT);
 
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
@@ -353,7 +353,7 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
 
 	return sdw_intel_scan_controller(info);
 }
-EXPORT_SYMBOL(sdw_intel_acpi_scan);
+EXPORT_SYMBOL_NS(sdw_intel_acpi_scan, SOUNDWIRE_INTEL_INIT);
 
 /**
  * sdw_intel_probe() - SoundWire Intel probe routine
@@ -370,7 +370,7 @@ struct sdw_intel_ctx
 {
 	return sdw_intel_probe_controller(res);
 }
-EXPORT_SYMBOL(sdw_intel_probe);
+EXPORT_SYMBOL_NS(sdw_intel_probe, SOUNDWIRE_INTEL_INIT);
 
 /**
  * sdw_intel_startup() - SoundWire Intel startup
@@ -383,7 +383,7 @@ int sdw_intel_startup(struct sdw_intel_ctx *ctx)
 {
 	return sdw_intel_startup_controller(ctx);
 }
-EXPORT_SYMBOL(sdw_intel_startup);
+EXPORT_SYMBOL_NS(sdw_intel_startup, SOUNDWIRE_INTEL_INIT);
 /**
  * sdw_intel_exit() - SoundWire Intel exit
  * @ctx: SoundWire context allocated in the probe
@@ -394,7 +394,7 @@ void sdw_intel_exit(struct sdw_intel_ctx *ctx)
 {
 	sdw_intel_cleanup(ctx);
 }
-EXPORT_SYMBOL(sdw_intel_exit);
+EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Intel Soundwire Init Library");
-- 
2.17.1

