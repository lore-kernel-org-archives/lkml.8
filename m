Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEDC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39942086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436161;
	bh=l4fldM31ofLcGdjk8qjnVDm4LED4hJPi2Vn87fAKGHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Y98sB2IKUQSX8liOBrGL6apsoXKb5n7cC9OqKCS6Ns5xblV6kfHsiqYThF+mwMzNw
	 iukLFJ8gOus0R70wr0X900mSff5XPvgovHCayY4apdO6udnK12wIdFKrCoY19POmyh
	 pAisaDdbhTe0KZxMIXbzTcCA+thi4qDnlGaw2JoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgBKPtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:49:20 -0500
Received: from foss.arm.com ([217.140.110.172]:48446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgBKPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0E012FC;
        Tue, 11 Feb 2020 07:49:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC773F68E;
        Tue, 11 Feb 2020 07:49:17 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Olaru <paul.olaru@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "ASoC: SOF: Add i.MX8QM device descriptor" to the asoc tree
In-Reply-To: <20200210095817.13226-4-daniel.baluta@oss.nxp.com>
Message-Id: <applied-20200210095817.13226-4-daniel.baluta@oss.nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Add i.MX8QM device descriptor

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

From f831ebf2faa598793a7ec327847c61dbeabba601 Mon Sep 17 00:00:00 2001
From: Paul Olaru <paul.olaru@nxp.com>
Date: Mon, 10 Feb 2020 11:58:16 +0200
Subject: [PATCH] ASoC: SOF: Add i.MX8QM device descriptor

Add SOF device and DT descriptors for i.MX8QM platform.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200210095817.13226-4-daniel.baluta@oss.nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/sof-of-dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 2da1bd859d98..16e49f2ee629 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -13,6 +13,7 @@
 #include "ops.h"
 
 extern struct snd_sof_dsp_ops sof_imx8_ops;
+extern struct snd_sof_dsp_ops sof_imx8x_ops;
 
 /* platform specific devices */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
@@ -23,6 +24,14 @@ static struct sof_dev_desc sof_of_imx8qxp_desc = {
 	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
 	.ops = &sof_imx8x_ops,
 };
+
+static struct sof_dev_desc sof_of_imx8qm_desc = {
+	.default_fw_path = "imx/sof",
+	.default_tplg_path = "imx/sof-tplg",
+	.default_fw_filename = "sof-imx8.ri",
+	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
+	.ops = &sof_imx8_ops,
+};
 #endif
 
 static const struct dev_pm_ops sof_of_pm = {
@@ -103,6 +112,7 @@ static int sof_of_remove(struct platform_device *pdev)
 static const struct of_device_id sof_of_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_IMX8)
 	{ .compatible = "fsl,imx8qxp-dsp", .data = &sof_of_imx8qxp_desc},
+	{ .compatible = "fsl,imx8qm-dsp", .data = &sof_of_imx8qm_desc},
 #endif
 	{ }
 };
-- 
2.20.1

