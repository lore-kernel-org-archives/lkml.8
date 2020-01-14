Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEEC2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018209;
	bh=ZfkqRtiykutxjrVgb4ThbBjRfcqZajNfLHDC/+Sr3h0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2tIpPcKm0h6mFg/X7ajc7cVjh1UM9CL8aiusLWUR183mU4FFCdS/kBgE1WI+94YRk
	 rqRj5a0OnEuZkCyqaAJF+Gt5vPL+P2fJNKyyka+z6fHYsNaWyzhF+0RtLFvWfrJQ7s
	 xzfYf/P+bW9ssEFtXhiKZzHHqAbgeHNNTBTZZNUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgANQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:10:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgANQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lh+DEYlWEE8IeDo6mbUYEZA5GlV0CUS8nFY9iiqzleU=; b=vbhqamHJyj6s
        g7bTD5W9Mqkmww/8HP9nMEqje7ClX+fLpvxOFs/gWotdma/Eh/QQaklsbEx4+ea0s7JhoYZSwlSD6
        97OXkh00fYl7FUfg5D66q8S0NUJbQVlDi9t7YVzF0UK6gm50hzdCNT1do5bZfxpcMsHAcj5n84pbO
        eESV4=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkh-0001X4-IH; Tue, 14 Jan 2020 16:09:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 049C9D02C7F; Tue, 14 Jan 2020 16:09:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt700: remove unused including <linux/version.h>" to the asoc tree
In-Reply-To: <20200114011319.173401-1-yuehaibing@huawei.com>
Message-Id: <applied-20200114011319.173401-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt700: remove unused including <linux/version.h>

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

From 5615b7a2784331d115e5774e80c1fb0c1ce80644 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 14 Jan 2020 01:13:19 +0000
Subject: [PATCH] ASoC: rt700: remove unused including <linux/version.h>

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200114011319.173401-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt700.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index b1830c1ebf8a..ff68f0e4f629 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.20.1

