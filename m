Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF9BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF6D2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgCCLFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:05:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgCCLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:05:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 091D52919DF
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: amd: AMD RV RT5682 should depends on CROS_EC
Date:   Tue,  3 Mar 2020 12:05:14 +0100
Message-Id: <20200303110514.3267126-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.25.1

