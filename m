Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06884C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE97920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgFWJSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:18:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:45826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732081AbgFWJSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:18:03 -0400
IronPort-SDR: tn6FDmtGC7C0OBd0SChjElrCC3fxSjXleDlDyJgFeILZ6xcUqIzii3VlazI4yybhRK+BCgqdLK
 tyEKH09bIPcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228682358"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="228682358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 02:18:01 -0700
IronPort-SDR: oQ2PXqOTHakAJqIPjIt0manH1QGCuU6ht7/b6NrbFiy2RQGGuzc/mAm3ojaUyyjtCYSvDDYYhQ
 PJ6p7ksSh+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="293142002"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2020 02:17:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/5] soundwire: cadence: allocate/free dma_data in set_sdw_stream
Date:   Tue, 23 Jun 2020 05:23:31 +0800
Message-Id: <20200622212332.16277-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The current memory allocation is somewhat strange: the dma_data is
allocated in set_sdw_stream, but released in the intel DAI
shutdown. This no longer works with the multi-cpu implementation,
since the dma_data is released in the dai shutdown which takes place
before the dailink shutdown.

Move to a more symmetric allocation where the dma_data is allocated
with non-NULL SoundWire stream, and conversely released when a NULL
stream is provided - for consistency with the stream startup and
shutdown operations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 52 ++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 5c0df066bfc6..24eafe0aa1c3 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1439,25 +1439,49 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dma_data *dma;
 
-	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
-	if (!dma)
-		return -ENOMEM;
+	if (stream) {
+		/* first paranoia check */
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			dma = dai->playback_dma_data;
+		else
+			dma = dai->capture_dma_data;
 
-	if (pcm)
-		dma->stream_type = SDW_STREAM_PCM;
-	else
-		dma->stream_type = SDW_STREAM_PDM;
+		if (dma) {
+			dev_err(dai->dev,
+				"dma_data already allocated for dai %s\n",
+				dai->name);
+			return -EINVAL;
+		}
 
-	dma->bus = &cdns->bus;
-	dma->link_id = cdns->instance;
+		/* allocate and set dma info */
+		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
+		if (!dma)
+			return -ENOMEM;
 
-	dma->stream = stream;
+		if (pcm)
+			dma->stream_type = SDW_STREAM_PCM;
+		else
+			dma->stream_type = SDW_STREAM_PDM;
 
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dai->playback_dma_data = dma;
-	else
-		dai->capture_dma_data = dma;
+		dma->bus = &cdns->bus;
+		dma->link_id = cdns->instance;
 
+		dma->stream = stream;
+
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			dai->playback_dma_data = dma;
+		else
+			dai->capture_dma_data = dma;
+	} else {
+		/* for NULL stream we release allocated dma_data */
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			kfree(dai->playback_dma_data);
+			dai->playback_dma_data = NULL;
+		} else {
+			kfree(dai->capture_dma_data);
+			dai->capture_dma_data = NULL;
+		}
+	}
 	return 0;
 }
 EXPORT_SYMBOL(cdns_set_sdw_stream);
-- 
2.17.1

