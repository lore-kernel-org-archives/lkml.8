Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB0C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3083520728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 07:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYH2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 03:28:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60194 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYH2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:28:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6E9C1A06DF;
        Sat, 25 Apr 2020 09:28:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23C031A06D6;
        Sat, 25 Apr 2020 09:28:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 43266402D5;
        Sat, 25 Apr 2020 15:28:00 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before dereferencing "ctx" in fsl_easrc_hw_free()
Date:   Sat, 25 Apr 2020 15:19:29 +0800
Message-Id: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
drivers" from Apr 16, 2020, leads to the following Smatch complaint:

sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
warn: variable dereferenced before check 'ctx' (see line 1527)

sound/soc/fsl/fsl_easrc.c
  1526          struct fsl_asrc_pair *ctx = runtime->private_data;
  1527          struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
                                                      ^^^^^
Dereference

  1528
  1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
                    ^^^
This check is too late, to prevent a NULL dereference.

  1530                  ctx_priv->ctx_streams &= ~BIT(substream->stream);
  1531                  fsl_easrc_release_context(ctx);

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 97658e1f4989..20326bffab64 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1524,9 +1524,14 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *ctx = runtime->private_data;
-	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
+	struct fsl_easrc_ctx_priv *ctx_priv;
 
-	if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
+	if (!ctx)
+		return -EINVAL;
+
+	ctx_priv = ctx->private;
+
+	if (ctx_priv->ctx_streams & BIT(substream->stream)) {
 		ctx_priv->ctx_streams &= ~BIT(substream->stream);
 		fsl_easrc_release_context(ctx);
 	}
-- 
2.21.0

