Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A09C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E282085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580897168;
	bh=fLFdNmg3WRU7g5cL2jmZraXIorQoO+w+etY5QrR44NY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=faPsuRGIUMdZLqzC79mAzfA2dqjj2XpirsgM9mM8/kPPpTlkIrzftG4nGjwLXWRRf
	 NjIwcaQn0SMRZ0RDsd84P0zkYFq+focXbc3bd+R+UVhTTiI26mxL6nMRjYRTOM6Kv3
	 2f5fsYFdXCF7YA/2eJpQpkNbPrkFoFuE9HZ/VEdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBEKGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:06:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=A5wlAvzYuuyw/lJ8xTeNin0AyoeXmNQPK3Uj4VxKxHA=; b=FwZ3FTZBAxil
        Hqp2wHP41VqRWUSIbId1g0prfYEx0I3vVuAGnkLhkk1BLb2INYvV5DX5P3KDKVeoUcvAbF/quWTSs
        yUEwUzXsLrf+RJecjDGZX+kxJvNrKIa4PtVLLOxQ8f1GIFsnzs3NOo0UEN2l5a9QID9ZbybcJyhTD
        s3jtE=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izHZC-0003qV-Pg; Wed, 05 Feb 2020 10:05:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7B621D01D7F; Wed,  5 Feb 2020 10:05:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: wcd934x: Add missing COMMON_CLK dependency to SND_SOC_ALL_CODECS" to the asoc tree
In-Reply-To: <20200204131857.7634-1-geert@linux-m68k.org>
Message-Id: <applied-20200204131857.7634-1-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Date:   Wed,  5 Feb 2020 10:05:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd934x: Add missing COMMON_CLK dependency to SND_SOC_ALL_CODECS

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

From 13426feaf46c48fcddb591e89d35120fcc90527f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Feb 2020 14:18:57 +0100
Subject: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency to
 SND_SOC_ALL_CODECS

Just adding a dependency on COMMON_CLK to SND_SOC_WCD934X is not
sufficient, as enabling SND_SOC_ALL_CODECS will still select it,
breaking the build later:

    WARNING: unmet direct dependencies detected for SND_SOC_WCD934X
      Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMMON_CLK [=n] && MFD_WCD934X [=m]
      Selected by [m]:
      - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y] && MFD_WCD934X [=m]
    ...
    ERROR: "of_clk_add_provider" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "of_clk_src_simple_get" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "clk_hw_register" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
    ERROR: "__clk_get_name" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

Fix this by adding the missing dependency to SND_SOC_ALL_CODECS

Fixes: 42b716359beca106 ("ASoC: wcd934x: Add missing COMMON_CLK dependency")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20200204131857.7634-1-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 286514865960..7e90f5d83097 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -214,7 +214,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WCD9335 if SLIMBUS
-	select SND_SOC_WCD934X if MFD_WCD934X
+	select SND_SOC_WCD934X if MFD_WCD934X && COMMON_CLK
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
 	select SND_SOC_WM0010 if SPI_MASTER
 	select SND_SOC_WM1250_EV1 if I2C
-- 
2.20.1

