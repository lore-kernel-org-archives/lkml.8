Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1066A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H61TS3Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBJPeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:34:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36778 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgBJPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:34:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AFXaRu018605;
        Mon, 10 Feb 2020 09:33:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581348816;
        bh=kraOaUvBzE4RhyqAmIw9/UceGvGGSH27DUD+H1Apd00=;
        h=From:To:CC:Subject:Date;
        b=H61TS3XgF/QHeD6JlS3lUTygXaiMrbmGqY2jar3YcIGgKwf3JQjEpBYEJKVZW7fj+
         r6Pn8kEHPmjM1yqPY49l8X1W4IB6VIFPKC6QX+ML75oQoIg0YQma+D5bCfE1nC7xqe
         JnehaWaXbokHdHKsaVj6DUpDuXGVi2kz2Ebzmi24=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AFXaX3115596;
        Mon, 10 Feb 2020 09:33:36 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 09:33:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 09:33:36 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AFXXAi054822;
        Mon, 10 Feb 2020 09:33:34 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>
CC:     <lars@metafoo.de>, <alsa-devel@alsa-project.org>,
        <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] ALSA: dmaengine_pcm: Consider DMA cache caused delay in pointer callback
Date:   Mon, 10 Feb 2020 17:33:36 +0200
Message-ID: <20200210153336.10218-1-peter.ujfalusi@ti.com>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
Hi,

Changes since v2:
- align the substream->runtime users to use runtime.
- added Reviewed-by from Takashi-san

Changes since v1:
- use bytes_to_frames() for the DMA delay calculation
- Drop changes to soc-pcm

5.6-rc1 now have support for reporting the DMA cached data.
With this patch we can include it to the delay calculation.
The first DMA driver which reports this is the TI K3 UDMA driver.

Regards,
Peter

 sound/core/pcm_dmaengine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 5749a8a49784..9d4f48cfe47f 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -240,6 +240,7 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
 snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct dma_tx_state state;
 	enum dma_status status;
 	unsigned int buf_size;
@@ -250,9 +251,12 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 		buf_size = snd_pcm_lib_buffer_bytes(substream);
 		if (state.residue > 0 && state.residue <= buf_size)
 			pos = buf_size - state.residue;
+
+		runtime->delay = bytes_to_frames(runtime,
+						 state.in_flight_bytes);
 	}
 
-	return bytes_to_frames(substream->runtime, pos);
+	return bytes_to_frames(runtime, pos);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

