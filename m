Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA59C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2D820781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585578768;
	bh=1kXTpX/yWwozFlgHWWi66FpvqsLhyioW/SMPlj9tlsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=mir6g8jFgYQdYnoc7SopbWcLpsoh8cU3ERP+WOGCXnZKUT5L310LR9UNj7TOsaWdo
	 uFkBfmmLbDeYQRWd1XcwVk7eckvU6zexPwx9d8/wiGPNEIO8a76bYF2ZvwKDg9T/6o
	 gATPHjnhw6xdgUP3lbtWwTFrjkMQyHpoobaaikfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgC3Ocq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:32:46 -0400
Received: from foss.arm.com ([217.140.110.172]:55056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgC3Ocq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:32:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE42F1042;
        Mon, 30 Mar 2020 07:32:45 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5803F71E;
        Mon, 30 Mar 2020 07:32:45 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:32:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Applied "ASoC: AMD: Clear format bits before setting them" to the asoc tree
In-Reply-To:  <20200328093921.32211-1-akshu.agrawal@amd.com>
Message-Id:  <applied-20200328093921.32211-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Clear format bits before setting them

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

From a91ab6509cd382dae4b7953155f47f276ff0d22f Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Sat, 28 Mar 2020 03:39:16 -0600
Subject: [PATCH] ASoC: AMD: Clear format bits before setting them

This avoids residual bit form previous format when the format is changed.
Hence, the resultant format is not an invalid one.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/20200328093921.32211-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-i2s.c | 1 +
 sound/soc/amd/raven/acp3x.h     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 3a3c47e820ab..f160d35a6832 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -139,6 +139,7 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
 		rv_writel(adata->tdm_fmt, rtd->acp3x_base + frmt_reg);
 	}
 	val = rv_readl(rtd->acp3x_base + reg_val);
+	val &= ~ACP3x_ITER_IRER_SAMP_LEN_MASK;
 	val = val | (rtd->xfer_resolution  << 3);
 	rv_writel(val, rtd->acp3x_base + reg_val);
 	return 0;
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 21e7ac017f2b..03fe93913e12 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -76,6 +76,8 @@
 #define ACP_POWERED_OFF			0x02
 #define ACP_POWER_OFF_IN_PROGRESS	0x03
 
+#define ACP3x_ITER_IRER_SAMP_LEN_MASK	0x38
+
 struct acp3x_platform_info {
 	u16 play_i2s_instance;
 	u16 cap_i2s_instance;
-- 
2.20.1

