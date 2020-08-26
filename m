Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C55A2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598444917;
	bh=/MOpC+NhIeE7yP3Cu+TU1gaDxzzfBjbccydCLGWfEpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRJM5a6qMKuIImGzNa/bOR5C/zi5XL/8Sm/qRNCYGO2k9do7nZZjr4n+k+/AN070f
	 +29snRfB1z+t0iKj6yreXDxirDByZNcrhl1m79SJ5p5jhNS/UMvxVr8VsHY64J+yOO
	 QdHhF9ZlTZAWyk06a04ftSJ6JLGOetqjEDRdGTNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgHZM2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgHZM2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:28:31 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A39820838;
        Wed, 26 Aug 2020 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598444910;
        bh=/MOpC+NhIeE7yP3Cu+TU1gaDxzzfBjbccydCLGWfEpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYCkbK11g9x0Gd6qEeLpnWmpfhjSb76O3VbTWo9wfjVse4J11aHQPiy1qgGsEE0c7
         +h8HfiWsElj38o5q4dHSWNuzpFkyEatx/m5zSqbkG8GwT9CZznLhgDsxZlTmTHdCQW
         /d5nFCKmBQ4UM3ToF4f5UnmPBcdLttVBPJpUZy30=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
Date:   Wed, 26 Aug 2020 17:58:10 +0530
Message-Id: <20200826122811.3223663-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826122811.3223663-1-vkoul@kernel.org>
References: <20200826122811.3223663-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
failure which should be checked with IS_ERR. Also use PTR_ERR for
Date: Wed, 26 Aug 2020 17:45:58 +0530
Subject: [PATCH 3/4] ASoC: rt711: Fix return check for devm_regmap_init_sdw()

devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
failure which should be checked with IS_ERR. Also use PTR_ERR for
returning error codes.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: 320b8b0d13b8 ("ASoC: rt711: add rt711 codec driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/rt711-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 45b928954b58..7efff130a638 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -452,8 +452,8 @@ static int rt711_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	sdw_regmap = devm_regmap_init_sdw(slave, &rt711_sdw_regmap);
-	if (!sdw_regmap)
-		return -EINVAL;
+	if (IS_ERR(sdw_regmap))
+		return PTR_ERR(sdw_regmap);
 
 	regmap = devm_regmap_init(&slave->dev, NULL,
 		&slave->dev, &rt711_regmap);
-- 
2.26.2

