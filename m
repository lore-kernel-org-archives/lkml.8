Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A500C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD620658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0OOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:14:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56675 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgC0OOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:14:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jHpkk-000887-46; Fri, 27 Mar 2020 14:14:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp3x-pcm-dma: clean up two indentation issues
Date:   Fri, 27 Mar 2020 14:14:29 +0000
Message-Id: <20200327141429.269191-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of statements that are not indented correctly,
add in the missing tab and break the lines to address a checkpatch
warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index d62c0d90c41e..e362f0bc9e46 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -458,7 +458,8 @@ static int acp3x_resume(struct device *dev)
 			reg_val = mmACP_I2STDM_ITER;
 			frmt_val = mmACP_I2STDM_TXFRMT;
 		}
-	rv_writel((rtd->xfer_resolution  << 3), rtd->acp3x_base + reg_val);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + reg_val);
 	}
 	if (adata->capture_stream && adata->capture_stream->runtime) {
 		struct i2s_stream_instance *rtd =
@@ -474,7 +475,8 @@ static int acp3x_resume(struct device *dev)
 			reg_val = mmACP_I2STDM_IRER;
 			frmt_val = mmACP_I2STDM_RXFRMT;
 		}
-	rv_writel((rtd->xfer_resolution  << 3), rtd->acp3x_base + reg_val);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + reg_val);
 	}
 	if (adata->tdm_mode == TDM_ENABLE) {
 		rv_writel(adata->tdm_fmt, adata->acp3x_base + frmt_val);
-- 
2.25.1

