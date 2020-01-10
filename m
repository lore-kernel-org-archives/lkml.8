Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3152072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578663484;
	bh=0qIPmd99HiT1g6Jqcg/shLk0kf+hjueBNgJw8JNOWy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=xdCBvql3Tuff2SYg97mo4KVsbgpY1wU0c0ZJpVsiMfmUb1Lrq1GUaaPnpd1E6SFcy
	 arTK/qV9G/j6XURxA4j+HRdvm0tpuERM2PTbRnR6FoQHoZInk4MUGNDm9e0u76jjgt
	 PJ/1uOZZJ/nrRAHurypSxGIjT2StkolfaNKw56Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgAJNiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:38:03 -0500
Received: from foss.arm.com ([217.140.110.172]:44550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgAJNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:38:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB29C1063;
        Fri, 10 Jan 2020 05:38:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCB93F534;
        Fri, 10 Jan 2020 05:38:02 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:38:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: dfsdm: fix 16 bits record" to the asoc tree
In-Reply-To: <20200110131131.3191-1-olivier.moysan@st.com>
Message-Id: <applied-20200110131131.3191-1-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: fix 16 bits record

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 8e55ea19125b65cffe42747359af99d545e85f2f Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 10 Jan 2020 14:11:31 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: fix 16 bits record

In stm32_afsdm_pcm_cb function, the transfer size is provided in bytes.
However, samples are copied as 16 bits words from iio buffer.
Divide by two the transfer size, to copy the right number of samples.

Fixes: 1e7f6e1c69f0 ("ASoC: stm32: dfsdm: add 16 bits audio record support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200110131131.3191-1-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 81c407da15c5..08696a4adb69 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -153,13 +153,13 @@ static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
 	.name = "stm32_dfsdm_audio",
 };
 
-static void memcpy_32to16(void *dest, const void *src, size_t n)
+static void stm32_memcpy_32to16(void *dest, const void *src, size_t n)
 {
 	unsigned int i = 0;
 	u16 *d = (u16 *)dest, *s = (u16 *)src;
 
 	s++;
-	for (i = n; i > 0; i--) {
+	for (i = n >> 1; i > 0; i--) {
 		*d++ = *s++;
 		s++;
 	}
@@ -186,8 +186,8 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 
 	if ((priv->pos + src_size) > buff_size) {
 		if (format == SNDRV_PCM_FORMAT_S16_LE)
-			memcpy_32to16(&pcm_buff[priv->pos], src_buff,
-				      buff_size - priv->pos);
+			stm32_memcpy_32to16(&pcm_buff[priv->pos], src_buff,
+					    buff_size - priv->pos);
 		else
 			memcpy(&pcm_buff[priv->pos], src_buff,
 			       buff_size - priv->pos);
@@ -196,8 +196,8 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	}
 
 	if (format == SNDRV_PCM_FORMAT_S16_LE)
-		memcpy_32to16(&pcm_buff[priv->pos],
-			      &src_buff[src_size - cur_size], cur_size);
+		stm32_memcpy_32to16(&pcm_buff[priv->pos],
+				    &src_buff[src_size - cur_size], cur_size);
 	else
 		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size],
 		       cur_size);
-- 
2.20.1

