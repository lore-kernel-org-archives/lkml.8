Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A84208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGBQ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:59:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:59104 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGBQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:59:17 -0400
IronPort-SDR: BAfNz9QjIxM4hviekXuKzpvIou4cW/M2Dqyflo0dheBYq6+ORrvpWZX/RfQmxFMQNP4EuyT9nQ
 Dj2uzvgSkbRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146051806"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146051806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:17 -0700
IronPort-SDR: wEF9qJzaf6TeuPOOnpKKMcU4n9bk0ixvdpL11kIjIeWlshMqafM9F0rsp/gYA+SuGfS/YX1yiQ
 s/s5ybkY6u/Q==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426014861"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:16 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] ASoC: samsung: pcm: fix kernel-doc
Date:   Thu,  2 Jul 2020 11:58:56 -0500
Message-Id: <20200702165901.164100-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warnings - missing fields in structure

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index a5b1a12b3496..86eefbc89e9e 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -104,8 +104,13 @@
 
 /**
  * struct s3c_pcm_info - S3C PCM Controller information
+ * @lock: Spin lock
  * @dev: The parent device passed to use from the probe.
  * @regs: The pointer to the device register block.
+ * @sclk_per_fs: number of sclk per frame sync
+ * @idleclk: Whether to keep PCMSCLK enabled even when idle(no active xfer)
+ * @pclk: the pclk pointer
+ * @cclk: the clck pointer
  * @dma_playback: DMA information for playback channel.
  * @dma_capture: DMA information for capture channel.
  */
-- 
2.25.1

