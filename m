Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8FCC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D0A20707
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIBC46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:56:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:49594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbgIBC4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:56:48 -0400
IronPort-SDR: H4K2c5vdM4dNHduGkgBHxhmJxVJyPiZJbRQzentWvzhk5JazkWQdx/+MNcbc4vbqcJ9SSKl/5H
 zJBAUX4e9kVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221528387"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="221528387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:47 -0700
IronPort-SDR: vENoVZho5q0tjfgz/0WduM04h9mHi5k60nxyL1OATxWm9K0T1eqriCsAtqoWo8cMD1BaBAjjT+
 MkE0noA68WOw==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477457317"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: intel: remove .trigger operation
Date:   Tue,  1 Sep 2020 23:02:39 +0800
Message-Id: <20200901150240.19288-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that the stream trigger is handled at the dai-link level, there is
no need for a dai-level trigger any longer.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index bbfb86ffa653..39d3186335ac 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -977,43 +977,6 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
-			 struct snd_soc_dai *dai)
-{
-	struct sdw_cdns_dma_data *dma;
-	int ret;
-
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s", __func__);
-		return -EIO;
-	}
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = sdw_enable_stream(dma->stream);
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
-		ret = sdw_disable_stream(dma->stream);
-		break;
-
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret)
-		dev_err(dai->dev,
-			"%s trigger %d failed: %d",
-			__func__, cmd, ret);
-	return ret;
-}
-
 static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
@@ -1115,7 +1078,6 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
-	.trigger = intel_trigger,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
@@ -1126,7 +1088,6 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
-	.trigger = intel_trigger,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
-- 
2.17.1

