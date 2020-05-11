Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC24C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3333D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbgEKVBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:44 -0400
Received: from v6.sk ([167.172.42.174]:52550 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732313AbgEKVBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:01:41 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B7D67610CF;
        Mon, 11 May 2020 21:01:38 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 01/11] ASoC: mmp-sspa: Flip SNDRV_PCM_FMTBIT_S24_3LE on
Date:   Mon, 11 May 2020 23:01:24 +0200
Message-Id: <20200511210134.1224532-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511210134.1224532-1-lkundrak@v3.sk>
References: <20200511210134.1224532-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_params() callback handles the 3-byte format, not
SNDRV_PCM_FMTBIT_S24_LE.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sound/soc/pxa/mmp-sspa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 3548a2634a63..1ca6afe464c4 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -362,7 +362,7 @@ static int mmp_sspa_probe(struct snd_soc_dai *dai)
 #define MMP_SSPA_RATES SNDRV_PCM_RATE_8000_192000
 #define MMP_SSPA_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
 		SNDRV_PCM_FMTBIT_S16_LE | \
-		SNDRV_PCM_FMTBIT_S24_LE | \
+		SNDRV_PCM_FMTBIT_S24_3LE | \
 		SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
-- 
2.26.2

