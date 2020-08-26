Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C69C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DCE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598459643;
	bh=5begK13A57C1a458MwTLaxrZjgC2tYsW7SVnYewFwTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vIcv7ovd9i/xTN7U7WwaNaSNmXTqSRZ4IKqsjIPH1qXUkhhCDDszfP5oprPT4s8n
	 IHahjlcOakKuNl23rEgkMxW1HIuqBA/2LotGrQLSHW009qxVzmp3/Kgk91Tkn/GlRm
	 Z21HVkYfELz7weAyvZxl1gPGQnXj0LxiIiDQpQB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHZQeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgHZQd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:33:56 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18F12083B;
        Wed, 26 Aug 2020 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459635;
        bh=5begK13A57C1a458MwTLaxrZjgC2tYsW7SVnYewFwTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYaU41dKqb3+xdt/QB5khsH4+oUOJF73nS0Njn18r6JLblV9KFDTaGDM/RklQdRKa
         AOKDgt2qGySpjbaWUo+Lm1ZJdCxq2dZiw0i9Asf90MRsNkTOgzLiNS/+DfZ5PmQ+KE
         7kxXm3wM2lZcl8NJDq6NNild6F8dRHDFBsLYtYpQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/5] ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
Date:   Wed, 26 Aug 2020 22:03:37 +0530
Message-Id: <20200826163340.3249608-3-vkoul@kernel.org>
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
Fixes: a87a6653a28c ("ASoC: rt1308-sdw: add rt1308 SdW amplifier driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/rt1308-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index b0ba0d2acbdd..56e952a904a3 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -684,8 +684,8 @@ static int rt1308_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	regmap = devm_regmap_init_sdw(slave, &rt1308_sdw_regmap);
-	if (!regmap)
-		return -EINVAL;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	rt1308_sdw_init(&slave->dev, regmap, slave);
 
-- 
2.26.2

