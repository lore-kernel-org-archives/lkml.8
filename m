Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B5020787
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586875588;
	bh=550yDRRNFH/KAKBnw/zzOaMx4yYeCB4m9knrvjHhjMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UDLRjAhk9ECfwzf725ZRnqT9xy9LfoKugs4JMfixZadXrwwGidc1Xq1C/TBzAnlAr
	 R6BapNuQSZQyZjTb9m3BtpKgFUn1nD4683Ab9aPEagt2iHrRxs8We1CbTxHwULMkBL
	 OPlZEDRdDgAv1xfxmZjudR2vuAKQPNA/xhbzKxyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404783AbgDNOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404554AbgDNOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:46:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C512076D;
        Tue, 14 Apr 2020 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586875569;
        bh=550yDRRNFH/KAKBnw/zzOaMx4yYeCB4m9knrvjHhjMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tQXk7Bs2mmJoHSR0U1aT1XOibvgfQAeB0u3K7jGl7yto1Qe3iqVCOLvuygK6ZCPej
         d2jkNnJYllIIcikjYkc/wjVnjEPcfMc9DeYGghPL9VsHXcqxTji2fujd7y4bdjxMF6
         DqmIziBSu59Kj5cQwWn5h70iRpTu8E1Zdzef+B0Q=
Date:   Tue, 14 Apr 2020 15:46:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        srinivas.kandagatla@linaro.org, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: qcom: common: Silence duplicate parse error messages" to the asoc tree
In-Reply-To:  <20200406003229.2354631-1-bjorn.andersson@linaro.org>
Message-Id:  <applied-20200406003229.2354631-1-bjorn.andersson@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: common: Silence duplicate parse error messages

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From d0c56b307f37fd21e2424d3c210e5d85831dd132 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Sun, 5 Apr 2020 17:32:29 -0700
Subject: [PATCH] ASoC: qcom: common: Silence duplicate parse error messages

All error paths in qcom_snd_parse_of() prints more specific error
messages, so silence the one in apq8096_platform_probe() and
sdm845_snd_platform_probe() to avoid spamming the kernel log.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200406003229.2354631-1-bjorn.andersson@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 4 +---
 sound/soc/qcom/sdm845.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index d55e3ad96716..287ad2aa27f3 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -116,10 +116,8 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-	if (ret) {
-		dev_err(dev, "Error parsing OF data\n");
+	if (ret)
 		goto err;
-	}
 
 	apq8096_add_be_ops(card);
 	ret = snd_soc_register_card(card);
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index b2de65c7f95c..68e9388ff46f 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -559,10 +559,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-	if (ret) {
-		dev_err(dev, "Error parsing OF data\n");
+	if (ret)
 		goto parse_dt_fail;
-	}
 
 	data->card = card;
 	snd_soc_card_set_drvdata(card, data);
-- 
2.20.1

