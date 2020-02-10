Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F77EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336D120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x8MujdPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgBJOGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:06:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41074 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgBJOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:06:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AE4O7g041894;
        Mon, 10 Feb 2020 08:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581343464;
        bh=M7oV+dgNDePW9F+75A8vypX+j/v5tDexHBLLV1ccDfU=;
        h=From:To:CC:Subject:Date;
        b=x8MujdPN9PMGtYJardUmXjE4MOYPRuJh3p6eY1P17yHBEOMeOlw6pQeWroHLai4ug
         A7QzYoCcsIlnPtsG/9+M5MOzoR0oLV+LqVtayhQpyFGg0/bMKX2vMvWrJCWG4IwFQc
         Jm5wAMc/isV2eOzn737sG3Lf3p4b1niknRU5s0wE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AE4Ols086430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 08:04:24 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 08:04:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 08:04:23 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AE4Klm024323;
        Mon, 10 Feb 2020 08:04:21 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>
CC:     <lars@metafoo.de>, <alsa-devel@alsa-project.org>,
        <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused delay in pointer callback
Date:   Mon, 10 Feb 2020 16:04:23 +0200
Message-ID: <20200210140423.10232-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DMA engines can have big FIFOs which adds to the latency.
The DMAengine framework can report the FIFO utilization in bytes. Use this
information for the delay reporting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

5.6-rc1 now have support for reporting the DMA cached data.
With this patch we can include it to the delay calculation.
The first DMA driver which reports this is the TI K3 UDMA driver.

Regards,
Peter

 sound/core/pcm_dmaengine.c | 6 ++++++
 sound/soc/soc-pcm.c        | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 5749a8a49784..4f1395fd0160 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -247,9 +247,15 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 
 	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
 	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		int sample_bits = snd_pcm_format_physical_width(runtime->format);
+
 		buf_size = snd_pcm_lib_buffer_bytes(substream);
 		if (state.residue > 0 && state.residue <= buf_size)
 			pos = buf_size - state.residue;
+
+		sample_bits *= runtime->channels;
+		runtime->delay = state.in_flight_bytes / (sample_bits / 8);
 	}
 
 	return bytes_to_frames(substream->runtime, pos);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ff1b7c7078e5..58ef508d70a3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1151,7 +1151,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	}
 	delay += codec_delay;
 
-	runtime->delay = delay;
+	runtime->delay += delay;
 
 	return offset;
 }
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

