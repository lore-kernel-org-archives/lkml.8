Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6328AC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420ED20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbgEKVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:02:16 -0400
Received: from v6.sk ([167.172.42.174]:52574 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732356AbgEKVBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:01:49 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D4555610D2;
        Mon, 11 May 2020 21:01:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 07/11] ASoC: mmp-sspa: Prepare/unprepare the clocks
Date:   Mon, 11 May 2020 23:01:30 +0200
Message-Id: <20200511210134.1224532-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511210134.1224532-1-lkundrak@v3.sk>
References: <20200511210134.1224532-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver enables the clocks without preparing them and disables
without unpreparing afterwards. Fix that.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sound/soc/pxa/mmp-sspa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 7a706b1d2588..a66e594b1072 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -92,8 +92,8 @@ static int mmp_sspa_startup(struct snd_pcm_substream *substream,
 {
 	struct sspa_priv *sspa = snd_soc_dai_get_drvdata(dai);
 
-	clk_enable(sspa->sysclk);
-	clk_enable(sspa->clk);
+	clk_prepare_enable(sspa->sysclk);
+	clk_prepare_enable(sspa->clk);
 
 	return 0;
 }
@@ -103,8 +103,8 @@ static void mmp_sspa_shutdown(struct snd_pcm_substream *substream,
 {
 	struct sspa_priv *sspa = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable(sspa->clk);
-	clk_disable(sspa->sysclk);
+	clk_disable_unprepare(sspa->clk);
+	clk_disable_unprepare(sspa->sysclk);
 
 }
 
@@ -458,7 +458,7 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 		clk_put(sspa->audio_clk);
 		return PTR_ERR(sspa->sysclk);
 	}
-	clk_enable(sspa->audio_clk);
+	clk_prepare_enable(sspa->audio_clk);
 	sspa->dai_fmt = (unsigned int) -1;
 	platform_set_drvdata(pdev, sspa);
 
@@ -485,7 +485,7 @@ static int asoc_mmp_sspa_remove(struct platform_device *pdev)
 {
 	struct sspa_priv *sspa = platform_get_drvdata(pdev);
 
-	clk_disable(sspa->audio_clk);
+	clk_disable_unprepare(sspa->audio_clk);
 	clk_put(sspa->audio_clk);
 	clk_put(sspa->sysclk);
 	return 0;
-- 
2.26.2

