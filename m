Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38634C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1859A20838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFLHs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:48:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38546 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgFLHsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:48:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C7779200922;
        Fri, 12 Jun 2020 09:48:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9378200037;
        Fri, 12 Jun 2020 09:48:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 91748402FB;
        Fri, 12 Jun 2020 15:48:38 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 2/4] ASoC: dmaengine_pcm: export soc_component_to_pcm
Date:   Fri, 12 Jun 2020 15:37:49 +0800
Message-Id: <429c6ae1f3c5b47eb893f475d531d71cdcfe34c0.1591947428.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DPCM case, Front-End needs to get the dma chan which has
been requested by Back-End and reuse it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/dmaengine_pcm.h         | 11 +++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b65220685920..8c5e38180fb0 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -161,4 +161,15 @@ int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 
 #define SND_DMAENGINE_PCM_DRV_NAME "snd_dmaengine_pcm"
 
+struct dmaengine_pcm {
+	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
+	const struct snd_dmaengine_pcm_config *config;
+	struct snd_soc_component component;
+	unsigned int flags;
+};
+
+static inline struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
+{
+	return container_of(p, struct dmaengine_pcm, component);
+}
 #endif
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f728309a0833..80a4e71f2d95 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -21,18 +21,6 @@
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(31)
 
-struct dmaengine_pcm {
-	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
-	const struct snd_dmaengine_pcm_config *config;
-	struct snd_soc_component component;
-	unsigned int flags;
-};
-
-static struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
-{
-	return container_of(p, struct dmaengine_pcm, component);
-}
-
 static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
 	struct snd_pcm_substream *substream)
 {
-- 
2.21.0

