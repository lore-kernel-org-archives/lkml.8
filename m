Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7141420747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgGAGig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:38:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:38225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgGAGie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:38:34 -0400
IronPort-SDR: QkFpVEXBaWTUVzFs+1HffiH649fFKqU8+MNlbKIFnbl25PmcpJ0Gj2fu7F6KX8roghH0pAQNe+
 WNLwrf3AZlYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146485942"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146485942"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:24 -0700
IronPort-SDR: DopED51pkOpFQqTZBuHlCOqKafRIlM3nrgJFXIkKKeMri/KfRg2V2Ls2iVMlHAo5JPn1gQgKRy
 BatCnWKMcLMg==
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="454946614"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:20 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/5] soundwire: intel: implement get_sdw_stream() operations
Date:   Wed,  1 Jul 2020 02:43:52 +0800
Message-Id: <20200630184356.24939-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
References: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This is needed to retrieve the information when the stream is
allocated at the dai_link level.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 950e4cf09f2a..3f2f23cf8020 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -883,6 +883,22 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 	return cdns_set_sdw_stream(dai, stream, false, direction);
 }
 
+static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
+				  int direction)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dma = dai->playback_dma_data;
+	else
+		dma = dai->capture_dma_data;
+
+	if (!dma)
+		return NULL;
+
+	return dma->stream;
+}
+
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
@@ -891,6 +907,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
+	.get_sdw_stream = intel_get_sdw_stream,
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
@@ -901,6 +918,7 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
+	.get_sdw_stream = intel_get_sdw_stream,
 };
 
 static const struct snd_soc_component_driver dai_component = {
-- 
2.17.1

