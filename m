Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09597C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41BB20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584382074;
	bh=y9oLjSK2TxUZWlILM/SVB5M0J/KgHI6XPxssQ9hwb/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=WtZpJTtOEvKmpWmuSDWp/KAP3pNwxdbE9NbiwhEPn4znDHejGp4MRtPHPZrAJHWS1
	 Jy0KmKsyieLpjSpJHWg3fyVKYFraPq8KeYzZfzyYutqeCe8Kt0GPngVgEMA1n53ocj
	 F2riseqzdPU0e4tUoUt3Xm+2QAqvPcN0x+Xf9KBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgCPSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:07:53 -0400
Received: from foss.arm.com ([217.140.110.172]:53758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731731AbgCPSHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:07:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40741FB;
        Mon, 16 Mar 2020 11:07:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66D323F67D;
        Mon, 16 Mar 2020 11:07:52 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:07:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        pierre-louis.bossart@linux.intel.com, vkoul@kernel.org
Subject: Applied "ASoC: soc-dai: return proper error for get_sdw_stream()" to the asoc tree
In-Reply-To:  <20200316151110.2580-1-srinivas.kandagatla@linaro.org>
Message-Id:  <applied-20200316151110.2580-1-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-dai: return proper error for get_sdw_stream()

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

From 308811a327c38364fff7752d3009160632f5dd5e Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 16 Mar 2020 15:11:10 +0000
Subject: [PATCH] ASoC: soc-dai: return proper error for get_sdw_stream()

snd_soc_dai_get_sdw_stream() returns null if dai does not support
this callback, this is no very useful for the caller to
differentiate if this is an error or unsupported call for the dai.

return -ENOTSUPP in cases where this callback is not supported.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200316151110.2580-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 7f70db149b81..78bac995db15 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -433,7 +433,7 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
  * This routine only retrieves that was previously configured
  * with snd_soc_dai_get_sdw_stream()
  *
- * Returns pointer to stream or NULL;
+ * Returns pointer to stream or -ENOTSUPP if callback is not supported;
  */
 static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 					       int direction)
@@ -441,7 +441,7 @@ static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 	if (dai->driver->ops->get_sdw_stream)
 		return dai->driver->ops->get_sdw_stream(dai, direction);
 	else
-		return NULL;
+		return ERR_PTR(-ENOTSUPP);
 }
 
 #endif
-- 
2.20.1

