Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B322EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F2220674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFCDuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:50:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37276 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgFCDuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B73D200CD6;
        Wed,  3 Jun 2020 05:50:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F6FD200CC3;
        Wed,  3 Jun 2020 05:50:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 81F9C402DF;
        Wed,  3 Jun 2020 11:50:05 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: fsl_easrc: Fix -Wunused-but-set-variable
Date:   Wed,  3 Jun 2020 11:39:40 +0800
Message-Id: <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obtained with:
$ make W=1

sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_rs_ratio':
sound/soc/fsl/fsl_easrc.c:182:15: warning: variable 'int_bits' set but not used [-Wunused-but-set-variable]
  unsigned int int_bits;
               ^
sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_ctx_organziation':
sound/soc/fsl/fsl_easrc.c:1204:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^
sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_release_context':
sound/soc/fsl/fsl_easrc.c:1294:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^
Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index f227308a50e2..7d8bf9d47842 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -179,22 +179,21 @@ static int fsl_easrc_set_rs_ratio(struct fsl_asrc_pair *ctx)
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
 	unsigned int in_rate = ctx_priv->in_params.norm_rate;
 	unsigned int out_rate = ctx_priv->out_params.norm_rate;
-	unsigned int int_bits;
 	unsigned int frac_bits;
 	u64 val;
 	u32 *r;
 
 	switch (easrc_priv->rs_num_taps) {
 	case EASRC_RS_32_TAPS:
-		int_bits = 5;
+		/* integer bits = 5; */
 		frac_bits = 39;
 		break;
 	case EASRC_RS_64_TAPS:
-		int_bits = 6;
+		/* integer bits = 6; */
 		frac_bits = 38;
 		break;
 	case EASRC_RS_128_TAPS:
-		int_bits = 7;
+		/* integer bits = 7; */
 		frac_bits = 37;
 		break;
 	default:
@@ -1201,7 +1200,6 @@ static int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
 static int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv;
-	struct device *dev;
 	struct fsl_asrc *easrc;
 
 	if (!ctx)
@@ -1209,7 +1207,6 @@ static int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
 
 	easrc = ctx->asrc;
 	ctx_priv = ctx->private;
-	dev = &easrc->pdev->dev;
 
 	/* input interleaving parameters */
 	regmap_update_bits(easrc->regmap, REG_EASRC_CIA(ctx->index),
@@ -1291,13 +1288,11 @@ static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
 	unsigned long lock_flags;
 	struct fsl_asrc *easrc;
-	struct device *dev;
 
 	if (!ctx)
 		return;
 
 	easrc = ctx->asrc;
-	dev = &easrc->pdev->dev;
 
 	spin_lock_irqsave(&easrc->lock, lock_flags);
 
-- 
2.21.0

