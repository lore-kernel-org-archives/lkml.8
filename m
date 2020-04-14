Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E534F2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586875596;
	bh=NF+ReJtRcTYkXwWbn0gQZMoewENSGMQLJ68bqwW6Mmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=AVsAz2bp36Ssx6ZgcMvENwoy8yDZTog6y4ax7tIjolXkl9n2soQKf1mqakc0tTYTP
	 74OX/kUur6WJUg2t/M9wM59+p8e/ih+OAVMkUlWAFknGBCR7VqMlvaYpQNor8Z9+Ph
	 xyeiofW78PSrTUpxeUnPmaaGhGuydZdWlQJNetZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404803AbgDNOqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404752AbgDNOqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:46:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E397120787;
        Tue, 14 Apr 2020 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586875574;
        bh=NF+ReJtRcTYkXwWbn0gQZMoewENSGMQLJ68bqwW6Mmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C/BTHfQDUOzrAqshiXGCZxUd05u6HaBj3kdNTyGK93zm96V/C6YRj9GuyfLwpYHcv
         dDP9o79bwt+lLfi4bXk2Efv0bJ/OFYlMVVYA2XN5bZhQt7C0DK+iNSpnUcBnfCIxAT
         OuSaau+3AnAquDPsh12gpkVSza7hSxUQm9smVQ3Q=
Date:   Tue, 14 Apr 2020 15:46:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Fricke <sebastian.fricke.linux@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        olivier.moysan@st.com, sebastian.fricke.linux@gmail.com,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "soc/stm/stm32_sub_sai: Add missing '\n' in log messages" to the asoc tree
In-Reply-To:  <20200413042952.7675-1-sebastian.fricke.linux@gmail.com>
Message-Id:  <applied-20200413042952.7675-1-sebastian.fricke.linux@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   soc/stm/stm32_sub_sai: Add missing '\n' in log messages

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

From 9de300abb71f24b190362ff53907ab90505517bc Mon Sep 17 00:00:00 2001
From: Sebastian Fricke <sebastian.fricke.linux@gmail.com>
Date: Mon, 13 Apr 2020 06:29:52 +0200
Subject: [PATCH] soc/stm/stm32_sub_sai: Add missing '\n' in log messages

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 3e086ed("ASoC: stm32: add SAI drivers")

Signed-off-by: Sebastian Fricke <sebastian.fricke.linux@gmail.com>
Link: https://lore.kernel.org/r/20200413042952.7675-1-sebastian.fricke.linux@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 0d0c9afd8791..34a7c3d6fb91 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -837,7 +837,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "Data format not supported");
+		dev_err(cpu_dai->dev, "Data format not supported\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1

