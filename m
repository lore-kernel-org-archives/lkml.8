Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83AB206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGGTGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:06:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:54574 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgGGTGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:06:31 -0400
IronPort-SDR: 7X9P4rrHbYuJYz+EPaI8BDRSpWiW5xAJa5dUMNV7HTKfhf1UasqU5+NJIXDCLN177UQGqB8ex6
 co8IKsd/5UaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135924046"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135924046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:30 -0700
IronPort-SDR: uh+HBu5nNaNv7QyJbYnc8PvUZeF/0aNoLn4RjBUK4bfhF0S3OmmdDOhGa7EGlklPfWC0/U5wcb
 NX3fQnWzJgcA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="268278517"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:06:29 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/13] ASoC: atmel: fix kernel-doc
Date:   Tue,  7 Jul 2020 14:06:00 -0500
Message-Id: <20200707190612.97799-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning

Kernel-doc is not used in one file and missing argument in the second.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

