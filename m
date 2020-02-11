Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE65C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764020656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436204;
	bh=fKlMzTGzyouSZfoAvaxyt0fMWeE704AH1HnNEqGh3Uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=CzEd7ykybksjiqzU7azjyRJYdDiKxftW20GTLxwLokOnxkuwTSmihHyke3qPBCTlS
	 Mbl78vpi23NAdEXSP0iYY+7r1Gxaqi/T1U9MYOymujJ4dCILkhqSuStvSLTbx1HajV
	 r5lv16mmIiyJ16i6GHvO8FpA6bA7Y3hukOGbOapQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgBKPuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:50:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgBKPtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C74D31B;
        Tue, 11 Feb 2020 07:49:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63A03F68E;
        Tue, 11 Feb 2020 07:49:21 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Olaru <paul.olaru@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "ASoC: SOF: Rename i.MX8 platform to i.MX8X" to the asoc tree
In-Reply-To: <20200210095817.13226-2-daniel.baluta@oss.nxp.com>
Message-Id: <applied-20200210095817.13226-2-daniel.baluta@oss.nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Rename i.MX8 platform to i.MX8X

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 9da9ace29ba556d5a2ae6d044070daba5b7d3638 Mon Sep 17 00:00:00 2001
From: Paul Olaru <paul.olaru@nxp.com>
Date: Mon, 10 Feb 2020 11:58:14 +0200
Subject: [PATCH] ASoC: SOF: Rename i.MX8 platform to i.MX8X

i.MX8 and i.MX8X platforms are very similar and were treated the same.
Anyhow, we need to account for the differences somehow.

Current supported platform is i.MX8QXP which is from i.MX8X family.
Rename i.MX8 platform to i.MX8X to prepare for future i.MX8 platforms.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200210095817.13226-2-daniel.baluta@oss.nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c   | 10 +++++-----
 sound/soc/sof/sof-of-dev.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index b2556f5e2871..9ffc2a955e4f 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -138,7 +138,7 @@ static int imx8_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 /*
  * DSP control.
  */
-static int imx8_run(struct snd_sof_dev *sdev)
+static int imx8x_run(struct snd_sof_dev *sdev)
 {
 	struct imx8_priv *dsp_priv = (struct imx8_priv *)sdev->private;
 	int ret;
@@ -360,13 +360,13 @@ static struct snd_soc_dai_driver imx8_dai[] = {
 },
 };
 
-/* i.MX8  ops */
-struct snd_sof_dsp_ops sof_imx8_ops = {
+/* i.MX8X ops */
+struct snd_sof_dsp_ops sof_imx8x_ops = {
 	/* probe and remove */
 	.probe		= imx8_probe,
 	.remove		= imx8_remove,
 	/* DSP core boot */
-	.run		= imx8_run,
+	.run		= imx8x_run,
 
 	/* Block IO */
 	.block_read	= sof_block_read,
@@ -398,6 +398,6 @@ struct snd_sof_dsp_ops sof_imx8_ops = {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
 };
-EXPORT_SYMBOL(sof_imx8_ops);
+EXPORT_SYMBOL(sof_imx8x_ops);
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 39ea8af6213f..2da1bd859d98 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -19,9 +19,9 @@ extern struct snd_sof_dsp_ops sof_imx8_ops;
 static struct sof_dev_desc sof_of_imx8qxp_desc = {
 	.default_fw_path = "imx/sof",
 	.default_tplg_path = "imx/sof-tplg",
-	.default_fw_filename = "sof-imx8.ri",
+	.default_fw_filename = "sof-imx8x.ri",
 	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
-	.ops = &sof_imx8_ops,
+	.ops = &sof_imx8x_ops,
 };
 #endif
 
-- 
2.20.1

