Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9581C217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580815423;
	bh=QmUJLjNtctwjPOg/fo2/bUliXImpve1GP4rGIVKoIV0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=w5Bb2PRvr4rOru/2ferNt6f4XbLT6X0FyrFV8oMwoN0LRuKYYJWvR+ffDnF+za1FP
	 H1Ba6E2Ia3mAtyV2+tWxw/ujV2X/eRpQHCWopSq58nx1Eosz1/j1bUNLC3i8/e8TzT
	 Za/BYosGtZMrvCXETxIT6vibxAD7CC2U3xEtJxtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBDLXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:23:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33744 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgBDLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=p3ecvIGvTCPUYxkPwEIi3DyBl4sbJaimA2IDcfZHVA0=; b=rkMTOmyxLH9K
        T3arp4n3AjZwzYNX5SW0yWsqPHOzCgChYCtf4oAMvbKCrETXdcL7lh0qsQLf/JgBotdvuYDIep8rx
        4UYmWjWwic0BXMsX2YVCBMh9TZzZdF4FlsPtG5Ye6YSOpLst3rO70vQvK8PJlEIwdiqDx3+lkARrM
        2QPfY=;
Received: from fw-tnat-cam2.arm.com ([217.140.106.50] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iywIo-0007QR-GZ; Tue, 04 Feb 2020 11:23:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 271E2D01A54; Tue,  4 Feb 2020 11:23:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, sfr@canb.auug.org.au,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Applied "ASoC: wcd934x: Add missing COMMON_CLK dependency" to the asoc tree
In-Reply-To: <20200204111241.6927-1-srinivas.kandagatla@linaro.org>
Message-Id: <applied-20200204111241.6927-1-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Date:   Tue,  4 Feb 2020 11:23:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd934x: Add missing COMMON_CLK dependency

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

From 42b716359beca10684195fd6e93a74ecd8ca8003 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 4 Feb 2020 11:12:41 +0000
Subject: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency

Looks like some platforms are not yet using COMMON CLK.

PowerPC allyesconfig failed with below error in next

ld: sound/soc/codecs/wcd934x.o:(.toc+0x0):
	 undefined reference to `of_clk_src_simple_get'
ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
wcd934x.c:(.text.wcd934x_codec_probe+0x3d4):
	 undefined reference to `.__clk_get_name'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438):
	 undefined reference to `.clk_hw_register'
ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474):
	 undefined reference to `.of_clk_add_provider'

Add the missing COMMON_CLK dependency to fix this errors.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200204111241.6927-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c9eb683bd1b0..286514865960 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1334,6 +1334,7 @@ config SND_SOC_WCD9335
 
 config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
+	depends on COMMON_CLK
 	depends on MFD_WCD934X
 	help
 	  The WCD9340/9341 is a audio codec IC Integrated in
-- 
2.20.1

