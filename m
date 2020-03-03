Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F99C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3399420848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583255277;
	bh=0E7Cz8fxoAfea7PhJy8DMBwwk5masbcHP5eJQ1S8aTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=GKWM+2YLXmFyUSst9xu6OJvbYtrGzZahj2tmyQFzWFIf/kiN5qi/lE9Q2TYGodn23
	 /UXwIpps0nBMuUa859zgoNplDehfzWrJGHxUPkjGvzHEWgFtjTU1RI4oRdCerP3dOQ
	 MfQKW/N7CsHdtA/xZ3WB+sQo9tw3SwmFlpp9mxxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgCCRHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:07:55 -0500
Received: from foss.arm.com ([217.140.110.172]:49936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbgCCRHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:07:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E802F;
        Tue,  3 Mar 2020 09:07:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C2A93F534;
        Tue,  3 Mar 2020 09:07:53 -0800 (PST)
Date:   Tue, 03 Mar 2020 17:07:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>, alsa-devel@alsa-project.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: amd: AMD RV RT5682 should depends on CROS_EC" to the asoc tree
In-Reply-To:  <20200303110514.3267126-1-enric.balletbo@collabora.com>
Message-Id:  <applied-20200303110514.3267126-1-enric.balletbo@collabora.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: AMD RV RT5682 should depends on CROS_EC

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

From e7e2afeacaa6e6b3d428ca8dd0507f1098bafe5d Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Tue, 3 Mar 2020 12:05:14 +0100
Subject: [PATCH] ASoC: amd: AMD RV RT5682 should depends on CROS_EC

If SND_SOC_AMD_RV_RT5682_MACH=y, below kconfig and build errors can be seen:

 WARNING: unmet direct dependencies detected for SND_SOC_CROS_EC_CODEC
 WARNING: unmet direct dependencies detected for I2C_CROS_EC_TUNNEL

 ld: drivers/i2c/busses/i2c-cros-ec-tunnel.o: in function `ec_i2c_xfer':
 i2c-cros-ec-tunnel.c:(.text+0x2fc): undefined reference to `cros_ec_cmd_xfer_status'
 ld: sound/soc/codecs/cros_ec_codec.o: in function `wov_host_event':
 cros_ec_codec.c:(.text+0x4fb): undefined reference to `cros_ec_get_host_event'
 ld: sound/soc/codecs/cros_ec_codec.o: in function `send_ec_host_command':
 cros_ec_codec.c:(.text+0x831): undefined reference to `cros_ec_cmd_xfer_status'

This is because it will select SND_SOC_CROS_EC_CODEC and I2c_CROS_EC_TUNNEL but
both depends on CROS_EC.

Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20200303110514.3267126-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index b29ef1373946..bce4cee5cb54 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -33,6 +33,6 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
-	depends on SND_SOC_AMD_ACP3x && I2C
+	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
 	help
 	 This option enables machine driver for RT5682 and MAX9835.
-- 
2.20.1

