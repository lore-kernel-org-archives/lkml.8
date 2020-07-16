Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C80E2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgGPPPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:15:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgGPPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:15:10 -0400
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AB2852A5297;
        Thu, 16 Jul 2020 16:15:08 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     alsa-devel@alsa-project.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 1/2] ASoC: fsl_asrc: make sure the input and output clocks are different
Date:   Thu, 16 Jul 2020 17:13:52 +0200
Message-Id: <20200716151352.193451-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716151352.193451-1-arnaud.ferraris@collabora.com>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current clock selection algorithm might select the same clock for
both input and output. This can happen when, for instance, the output
sample rate is a multiple of the input rate.

This patch makes sure it always selects distinct input and output
clocks.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl_asrc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 02c81d2e34ad..6d43cab6c885 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -608,8 +608,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
 {
 	struct fsl_asrc_pair_priv *pair_priv = pair->private;
 	struct asrc_config *config = pair_priv->config;
-	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
-	int clk_rate, clk_index;
+	int rate[2], select_clk[2], clk_index[2]; /* Array size 2 means IN and OUT */
+	int clk_rate;
 	int i = 0, j = 0;
 
 	rate[IN] = in_rate;
@@ -618,11 +618,12 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
 	/* Select proper clock source for internal ratio mode */
 	for (j = 0; j < 2; j++) {
 		for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
-			clk_index = asrc_priv->clk_map[j][i];
-			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
+			clk_index[j] = asrc_priv->clk_map[j][i];
+			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index[j]]);
 			/* Only match a perfect clock source with no remainder */
 			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
-			    (clk_rate % rate[j]) == 0)
+			    (clk_rate % rate[j]) == 0 &&
+			    (j == 0 || clk_index[j] != clk_index[j-1]))
 				break;
 		}
 
-- 
2.27.0

