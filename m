Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D2C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D229D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgELKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:07:15 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:33718 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:07:14 -0400
Received: from localhost.localdomain ([93.22.148.175])
        by mwinf5d78 with ME
        id dm782200V3nHaxZ03m78v6; Tue, 12 May 2020 12:07:11 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 May 2020 12:07:11 +0200
X-ME-IP: 93.22.148.175
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linus.walleij@linaro.org, lee.jones@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: ux500: mop500: Fix some refcounted resources issues
Date:   Tue, 12 May 2020 12:07:05 +0200
Message-Id: <20200512100705.246349-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 issues here:
   - if one of the 'of_parse_phandle' fails, calling 'mop500_of_node_put()'
     is a no-op because the 'mop500_dai_links' structure has not been
     initialized yet, so the referenced are not decremented
   - The reference stored in 'mop500_dai_links[i].codecs' is refcounted
     only once in the probe and must be decremented only once.

Fixes: 39013bd60e79 ("ASoC: Ux500: Dispose of device nodes correctly")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/ux500/mop500.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 2873e8e6f02b..cdae1190b930 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -63,10 +63,11 @@ static void mop500_of_node_put(void)
 {
 	int i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 2; i++)
 		of_node_put(mop500_dai_links[i].cpus->of_node);
-		of_node_put(mop500_dai_links[i].codecs->of_node);
-	}
+
+	/* Both links use the same codec, which is refcounted only once */
+	of_node_put(mop500_dai_links[0].codecs->of_node);
 }
 
 static int mop500_of_probe(struct platform_device *pdev,
@@ -81,7 +82,9 @@ static int mop500_of_probe(struct platform_device *pdev,
 
 	if (!(msp_np[0] && msp_np[1] && codec_np)) {
 		dev_err(&pdev->dev, "Phandle missing or invalid\n");
-		mop500_of_node_put();
+		for (i = 0; i < 2; i++)
+			of_node_put(msp_np[i]);
+		of_node_put(codec_np);
 		return -EINVAL;
 	}
 
-- 
2.25.1

