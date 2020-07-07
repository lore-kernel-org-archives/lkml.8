Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A349C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DE9206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGGTGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:54574 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgGGTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:34 -0400
IronPort-SDR: 8A6FjQN5Hj1eWUd6TxSiD9oSZBENy6BwQ2Cc4tan3CEG70C/0y3oVwqYQAT750emVRHES+Iy4f
 JOgFW5Rmp2Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135924055"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135924055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:33 -0700
IronPort-SDR: dSqgsiz0zeNqOlpMv2DOPgEuMFMnfOjMcLS2tGjIfZ2AqEdWEdnxDmSRVStHkVdh/kQIN7y7Sh
 vmIAtGj3UzMA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278527"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:32 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/13] ASoC: samsung: pcm: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:06:02 -0500
Message-Id: <20200707190612.97799-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings - missing fields in structure

Credits to Sylwester Nawrocki for the pclk and cclk descriptions.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index a5b1a12b3496..45dfc534c6c7 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -104,8 +104,13 @@
 
 /**
  * struct s3c_pcm_info - S3C PCM Controller information
+ * @lock: Spin lock
  * @dev: The parent device passed to use from the probe.
  * @regs: The pointer to the device register block.
+ * @sclk_per_fs: number of sclk per frame sync
+ * @idleclk: Whether to keep PCMSCLK enabled even when idle (no active xfer)
+ * @pclk: the PCLK_PCM (pcm) clock pointer
+ * @cclk: the SCLK_AUDIO (audio-bus) clock pointer
  * @dma_playback: DMA information for playback channel.
  * @dma_capture: DMA information for capture channel.
  */
-- 
2.25.1

