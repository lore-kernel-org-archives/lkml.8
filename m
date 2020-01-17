Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A03DC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED78F21D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579275864;
	bh=N4/o3IasfYq2aRRIzOl4amLCW5AcUW2GmU7gF2tUrL0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eQwLBf8Gcc01pNSUegCE/yk12lLjM8vXsbTdexqSIXncVTEKZN3xuck5yULkJ30Oy
	 wmOPn9yhd3SBCOCF3mgCmtZPNVBZ12Ofo0XP4Q1gFeJwTTWPu2RQYoEoAW0hfCX6Cp
	 3w8d6e20gzsnt3RM4YZxH7FaOjH/1Q/Mm4d1Cvj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAQPoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:44:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uAGC0c7m8VYsjJ2F+efHvKBc4dyIiGeg7UGw0hyyBcs=; b=ojMo5/QgSeye
        3shLOZmmkNr/ErnwmM7bQhBx4TGjoV+Ozq9rXd6SEDneekw0LJj7v6nVoEs8t9vkepXOcFNWZ+23v
        0TaOW8tqy42/LwQCsL9yJq822gF7AELtuvaBx05quPv6IfyY63euzzmRXHozrit/52a3ayYSgOvzi
        tXnwQ=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnA-0006sD-HC; Fri, 17 Jan 2020 15:44:12 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 33758D02BD9; Fri, 17 Jan 2020 15:44:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, Jack Yu <jack.yu@realtek.com>,
        Jaroslav@sirena.org.uk, kernel-janitors@vger.kernel.org,
        Liam@sirena.org.uk, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt715: remove unused including <linux/version.h>" to the asoc tree
In-Reply-To: <20200116021142.149000-1-yuehaibing@huawei.com>
Message-Id: <applied-20200116021142.149000-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt715: remove unused including <linux/version.h>

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

From a62c449f4cc1498d040d84e6210209c474b5c746 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 16 Jan 2020 02:11:42 +0000
Subject: [PATCH] ASoC: rt715: remove unused including <linux/version.h>

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200116021142.149000-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt715.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 4c746938a062..2cbc57b16b13 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
2.20.1

