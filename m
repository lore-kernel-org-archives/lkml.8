Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342372088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGBQ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:59:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:59104 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGBQ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:59:15 -0400
IronPort-SDR: Venz8AuZJix2lEhlmojyhzQ6WG0BbyJ/U+AhZ2JwUr8mv/sWpcz8d1KwZY7yUrtF6KGIHnbc4D
 8hKmybcVXqIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146051787"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="146051787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:14 -0700
IronPort-SDR: 9mpoW28nlvswRk4tGoP5yhadeIfybkNCkh+pHtUoF1yDhJ5DNtvqihrsfp41GPhxH0JnjPu6kM
 EWhcGOe2XmqA==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="426014841"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 09:59:13 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] ASoC: atmel: fix kernel-doc
Date:   Thu,  2 Jul 2020 11:58:54 -0500
Message-Id: <20200702165901.164100-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning

Kernel-doc is not used in one file and missing argument in the second.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/atmel/atmel-pcm-dma.c | 2 +-
 sound/soc/atmel/atmel_ssc_dai.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index cb03c4f7324c..0a2e956232af 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -44,7 +44,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 	.buffer_bytes_max	= 512 * 1024,
 };
 
-/**
+/*
  * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
  *
  * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0f18dfb85bfe..6a63e8797a0b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -887,6 +887,7 @@ static int asoc_ssc_init(struct device *dev)
 
 /**
  * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
+ * @ssc_id: SSD ID in [0, NUM_SSC_DEVICES[
  */
 int atmel_ssc_set_audio(int ssc_id)
 {
-- 
2.25.1

