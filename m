Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B6CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BFB206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598459657;
	bh=dNR1EPkaEyjAR7zusDZlfIVj6xMA5JwWBGp6NPEmEMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XVB6pnremFKNlsAAYMZdNv5VKeftDlEVbH7fNDvnhvxoEvCJCq7PXlRBb0cBqgydC
	 XAlsJDA6G2WX2zzGjvyLMOawms5y4shcQaRMhPx41C4fZc2VcRB9bdRped1Dm6rQOo
	 /6u7azAY7s+vmrKkmj9AyeBG1gotWsPl+pnsxTps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHZQeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgHZQeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:34:06 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266CF22B40;
        Wed, 26 Aug 2020 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459645;
        bh=dNR1EPkaEyjAR7zusDZlfIVj6xMA5JwWBGp6NPEmEMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2k4UxVk2CgPkm94EyTRAZeqnQdLr/JZTgmwErPOhE4TyVV10SfCc0kgs4AHN0H6zu
         uxqFw/yJ5tlcIWgrXEtsFu5HSpu4I4FypQEpoKC3JfCNXVYdIsiRfBFeURf1MF0NQz
         Ge3Th2htsFc7xz4/sCHC9DUp6gl1Zt7wItkPwB+U=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 5/5] ASoC: rt700: Fix return check for devm_regmap_init_sdw()
Date:   Wed, 26 Aug 2020 22:03:40 +0530
Message-Id: <20200826163340.3249608-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826163340.3249608-1-vkoul@kernel.org>
References: <20200826163340.3249608-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
failure which should be checked with IS_ERR. Also use PTR_ERR for
returning error codes.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: 7d2a5f9ae41e ("ASoC: rt700: add rt700 codec driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/rt700-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 4d14048d1197..1d24bf040718 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -452,8 +452,8 @@ static int rt700_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	sdw_regmap = devm_regmap_init_sdw(slave, &rt700_sdw_regmap);
-	if (!sdw_regmap)
-		return -EINVAL;
+	if (IS_ERR(sdw_regmap))
+		return PTR_ERR(sdw_regmap);
 
 	regmap = devm_regmap_init(&slave->dev, NULL,
 		&slave->dev, &rt700_regmap);
-- 
2.26.2

