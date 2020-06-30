Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A3C2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGAGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:38:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:38225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:38:34 -0400
IronPort-SDR: db/Uf1/R3YxCfBIZylSwOZt+QGCH1bTeNz2lOsu+AiJeDamFzvOIKvPQ3JT7eibbBSNQV4/Iat
 zbAgOQh4AqqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146485958"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146485958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:32 -0700
IronPort-SDR: th0Rc9ycr4PsgW9J+Ta1FX/TTYaedarOg0luY5rG0+CFLagN/tW7/uXKl5pTu2QS6QOBX4U7Dq
 fCjck19EBfTg==
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="454946858"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/5] soundwire: intel: remove stream allocation/free
Date:   Wed,  1 Jul 2020 02:43:54 +0800
Message-Id: <20200630184356.24939-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
References: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

To support streaming across multiple links, the stream allocation/free
needs to be at the dailink level, not the dai.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 57 +--------------------------------------
 1 file changed, 1 insertion(+), 56 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3f2f23cf8020..2e1e1088a743 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -625,57 +625,6 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  * DAI routines
  */
 
-static int sdw_stream_setup(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sdw_stream_runtime *sdw_stream = NULL;
-	char *name;
-	int i, ret;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		name = kasprintf(GFP_KERNEL, "%s-Playback", dai->name);
-	else
-		name = kasprintf(GFP_KERNEL, "%s-Capture", dai->name);
-
-	if (!name)
-		return -ENOMEM;
-
-	sdw_stream = sdw_alloc_stream(name);
-	if (!sdw_stream) {
-		dev_err(dai->dev, "alloc stream failed for DAI %s", dai->name);
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	/* Set stream pointer on CPU DAI */
-	ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
-	if (ret < 0) {
-		dev_err(dai->dev, "failed to set stream pointer on cpu dai %s",
-			dai->name);
-		goto release_stream;
-	}
-
-	/* Set stream pointer on all CODEC DAIs */
-	for (i = 0; i < rtd->num_codecs; i++) {
-		ret = snd_soc_dai_set_sdw_stream(asoc_rtd_to_codec(rtd, i), sdw_stream,
-						 substream->stream);
-		if (ret < 0) {
-			dev_err(dai->dev, "failed to set stream pointer on codec dai %s",
-				asoc_rtd_to_codec(rtd, i)->name);
-			goto release_stream;
-		}
-	}
-
-	return 0;
-
-release_stream:
-	sdw_release_stream(sdw_stream);
-error:
-	kfree(name);
-	return ret;
-}
-
 static int intel_startup(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
@@ -683,8 +632,7 @@ static int intel_startup(struct snd_pcm_substream *substream,
 	 * TODO: add pm_runtime support here, the startup callback
 	 * will make sure the IP is 'active'
 	 */
-
-	return sdw_stream_setup(substream, dai);
+	return 0;
 }
 
 static int intel_hw_params(struct snd_pcm_substream *substream,
@@ -852,9 +800,6 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	kfree(dma->stream->name);
-	sdw_release_stream(dma->stream);
-
 	return 0;
 }
 
-- 
2.17.1

