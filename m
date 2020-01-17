Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4CCC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5CA2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579275891;
	bh=ksCdeyZf1OujLULLh6WNfoSYO1VXtKGdYCnEl73i1p4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SqE5EmZwxd9Rx0mugiuQHF7lFcdbcbmnbGCUeyi1h3m1xry1yeK0jYrQ+rTvsWr3z
	 423WUXPSngCCtk3dqzwoHS157+b0idwFi2kJ9kt3ONeKUTPSN4emDj7yN3WsgdipY2
	 R59ccRP5oiWVl3u6fe+uZHL3ON62gtw7wmgKOq5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAQPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:44:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAQPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YLlnZQ7obo9hm7ntSycOnGTHd4uSo2u5L5NqtVkSEhU=; b=vlNXxdigELV6
        g+TmlfBvaYktTTmvTvB6lO2W01Mpb4sLJoFC4eT8H1IX+DWWgMIyZYRF9NlCFLurMoewuBxZNMCZj
        ENwui7VJMvxkrKTb25IdXUylDXd9EAoxHsIFp/5e3UqL4qr8BnMVFHJ7AS8HK0m42A8LQOcPuPAEU
        r0bMo=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnA-0006s0-1O; Fri, 17 Jan 2020 15:44:12 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B1237D02BD9; Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jack Yu <jack.yu@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt715: fix return value check in rt715_sdw_probe()" to the asoc tree
In-Reply-To: <20200117024149.75515-1-weiyongjun1@huawei.com>
Message-Id: <applied-20200117024149.75515-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt715: fix return value check in rt715_sdw_probe()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f9f5bbf5783cd63369d3e6c8cf27e2bd7c5ac2c3 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 17 Jan 2020 02:41:49 +0000
Subject: [PATCH] ASoC: rt715: fix return value check in rt715_sdw_probe()

In case of error, the function devm_regmap_init() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Fixes: d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20200117024149.75515-1-weiyongjun1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 18868e4ae6e8..6d892c44c522 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -535,8 +535,8 @@ static int rt715_sdw_probe(struct sdw_slave *slave,
 
 	regmap = devm_regmap_init(&slave->dev, NULL, &slave->dev,
 		&rt715_regmap);
-	if (!regmap)
-		return -EINVAL;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	rt715_init(&slave->dev, sdw_regmap, regmap, slave);
 
-- 
2.20.1

