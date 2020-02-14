Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0269C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F77222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581713803;
	bh=PqeEAT/c2p6Puc8LeGUGcWhLci2cU49jk17n63UV5GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=FtIDvECv+KKnjMjxFBVoMlexnej5WRZM+HZQvtUq+XIVfRVi7uqhSmAOI1UkDFAzI
	 W8OGqQB5LRQZGZAhiplUAOJertEEFnVtE43+8gbzjnnT+bSfRsXXWMs4sOmIvh4oQo
	 nPFuVGTZl4QgFosnTLA0BTQSwsAY3wwN29SkWXhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbgBNU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:56:43 -0500
Received: from foss.arm.com ([217.140.110.172]:45032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbgBNU4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE26D30E;
        Fri, 14 Feb 2020 12:56:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624433F68F;
        Fri, 14 Feb 2020 12:56:40 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: ensure component names are unique" to the asoc tree
In-Reply-To:  <20200214134704.342501-1-jbrunet@baylibre.com>
Message-Id:  <applied-20200214134704.342501-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: ensure component names are unique

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

From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:47:04 +0100
Subject: [PATCH] ASoC: core: ensure component names are unique

Make sure each ASoC component is registered with a unique name.
The component is derived from the device name. If a device registers more
than one component, the component names will be the same.

This usually brings up a warning about the debugfs directory creation of
the component since directory already exists.

In such case, start numbering the component of the device so the names
don't collide anymore.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 03b87427faa7..6a58a8f6e3c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	return ret;
 }
 
+static char *snd_soc_component_unique_name(struct device *dev,
+					   struct snd_soc_component *component)
+{
+	struct snd_soc_component *pos;
+	int count = 0;
+	char *name, *unique;
+
+	name = fmt_single_name(dev, &component->id);
+	if (!name)
+		return name;
+
+	/* Count the number of components registred by the device */
+	for_each_component(pos) {
+		if (dev == pos->dev)
+			count++;
+	}
+
+	/* Keep naming as it is for the 1st component */
+	if (!count)
+		return name;
+
+	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
+	devm_kfree(dev, name);
+
+	return unique;
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
@@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->card_list);
 	mutex_init(&component->io_mutex);
 
-	component->name = fmt_single_name(dev, &component->id);
+	component->name = snd_soc_component_unique_name(dev, component);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.20.1

