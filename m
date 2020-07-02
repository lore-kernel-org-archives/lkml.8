Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A43720772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgGBOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbgGBOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:23:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D270C08C5C1;
        Thu,  2 Jul 2020 07:23:10 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 962A12A5EC1;
        Thu,  2 Jul 2020 15:23:08 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] ASoC: fsl_asrc: always use ratio for conversion
Date:   Thu,  2 Jul 2020 16:22:34 +0200
Message-Id: <20200702142235.235869-4-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when not in "Ideal Ratio" mode, ASRC can use an internally measured
ratio, which greatly improves the conversion quality.

This patch ensures we always use at least the internal ratio.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl_asrc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 75df220e4b51..65e7307a3df0 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -451,7 +451,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
 			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
-			   ASRCTR_USRi_MASK(index), 0);
+			   ASRCTR_USRi_MASK(index), ASRCTR_USR(index));
 
 	/* Set the input and output clock sources */
 	regmap_update_bits(asrc->regmap, REG_ASRCSR,
@@ -493,8 +493,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
 
 	/* Enable Ideal Ratio mode */
 	regmap_update_bits(asrc->regmap, REG_ASRCTR,
-			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
-			   ASRCTR_IDR(index) | ASRCTR_USR(index));
+			   ASRCTR_IDRi_MASK(index), ASRCTR_IDR(index));
 
 	fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
 
-- 
2.27.0

