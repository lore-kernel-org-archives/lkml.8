Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A14C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3323E20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582742861;
	bh=bHNKURmu+SQCGAmgcoQ3e6NzJIGYKu/B6HERhQdXwPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Krs9UuRP7Ja7hZxgYU+M6Ve6bo8xOPYRArPpBUD5+g8piyf1I5fpMgxo5lm+6oQae
	 thLq+sRk9VqYGEpZXMUQWvFqbglUBPReHOBS0+TagZ9Laj49Uz64BdvW8bwldpKjGw
	 hX4pKlR70CQHq0h8L8zs5cJVLjRHqGVnWsBOK+Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgBZSrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:47:40 -0500
Received: from foss.arm.com ([217.140.110.172]:41308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:47:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99B031B;
        Wed, 26 Feb 2020 10:47:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0524A3F881;
        Wed, 26 Feb 2020 10:47:38 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:47:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        Hui Wang <hui.wang@canonical.com>, jank@cadence.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        slawomir.blauciak@intel.com, srinivas.kandagatla@linaro.org,
        Takashi Iwai <tiwai@suse.com>, tiwai@suse.de, vkoul@kernel.org
Subject: Applied "ASoC: soc-dai: add get_sdw_stream() callback" to the asoc tree
In-Reply-To:  <20200225170041.23644-3-pierre-louis.bossart@linux.intel.com>
Message-Id:  <applied-20200225170041.23644-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-dai: add get_sdw_stream() callback

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

From 36d73c4a9ed7c8a0988cfb9d1282c62d8c422a3b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 25 Feb 2020 11:00:40 -0600
Subject: [PATCH] ASoC: soc-dai: add get_sdw_stream() callback

We only have a set() operation, provide the dual get() operation to
retrieve the stream information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200225170041.23644-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 92c382690930..7f70db149b81 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -202,6 +202,8 @@ struct snd_soc_dai_ops {
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
 			void *stream, int direction);
+	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
+
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -423,4 +425,23 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
 		return -ENOTSUPP;
 }
 
+/**
+ * snd_soc_dai_get_sdw_stream() - Retrieves SDW stream from DAI
+ * @dai: DAI
+ * @direction: Stream direction(Playback/Capture)
+ *
+ * This routine only retrieves that was previously configured
+ * with snd_soc_dai_get_sdw_stream()
+ *
+ * Returns pointer to stream or NULL;
+ */
+static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
+					       int direction)
+{
+	if (dai->driver->ops->get_sdw_stream)
+		return dai->driver->ops->get_sdw_stream(dai, direction);
+	else
+		return NULL;
+}
+
 #endif
-- 
2.20.1

