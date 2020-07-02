Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C30DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C5520720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGBQpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:45:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:18403 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGBQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:45:03 -0400
IronPort-SDR: pENGjzsCP7O8ih6C0x2Pr8VdhpNYmA1C55eKQHKY6FoMpWp1ngFiYUdSJ4CecY+p8UF8WQfs/q
 fO8UhIlcZsvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231818069"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="231818069"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:45:03 -0700
IronPort-SDR: 55JSYJfEAirEpQGX8m61LC72zU3dPAQkWfo+hjwAiahw9qj89VdpJPDSqCtqrfgPV+W9iRAZXB
 UTf50ZBEgKUA==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426011117"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:45:02 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] ASoC: amd: raven: acp3x-pcm-dma: remove unused-but-set variable
Date:   Thu,  2 Jul 2020 11:44:32 -0500
Message-Id: <20200702164433.162815-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
References: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning. The variable prtd is not used, remove.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1f0fe5aaab1d..17290c829c4b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -301,13 +301,11 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
 static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_soc_component *component,
 					   struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *prtd;
 	struct i2s_stream_instance *rtd;
 	u32 pos;
 	u32 buffersize;
 	u64 bytescount;
 
-	prtd = substream->private_data;
 	rtd = substream->runtime->private_data;
 
 	buffersize = frames_to_bytes(substream->runtime,
-- 
2.25.1

