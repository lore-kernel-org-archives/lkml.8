Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461FF2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgE2UFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:05:36 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgE2UFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:05:35 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2w0K-1ji3Z20ocG-003PJQ; Fri, 29 May 2020 22:04:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: byt: fix unused-function warnings
Date:   Fri, 29 May 2020 22:04:17 +0200
Message-Id: <20200529200433.19068-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jUReMJwwaY6kcLP8d5WAviKG5ZhIsqMuAyesMGtOt6TbqQ87Iry
 /dlkch7Ztvq4+lIzXoPe+JZcvA4RWdudO1zp4JkU3ktEl47OROaHsjby1O7osP4W4PFHPg0
 Z0wHJj852iT/cckPWhvLM0sJcrMjOw6OdjS/mCzFJ+l5Ad7dFZaFxRey7r23PGqXKd2Fvvf
 zjRuHhYDVoYTm4Sxc29ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2JjzO58DcQ=:CcBshmwd0gDiOaTjoTIVio
 cYoDJ7AS356b9uCyDbDo/LhroWRbaz1A/aztPCHPKDvUhXmg6P4GxWvZ9ELfEqknGp2+sqtDP
 BEFqX3p2qu69HU0KWGbP67ycwwFYd4vPVf6iryxNhnIThfGosFWHBRHyCoZ9Tx3kCCtMKOeLu
 G2pSWz4b/j73vk7hsWOVRMX8Ejm/2GEyuhQQrmKN7XGvVEw0Ep0UTPzs2triyvUN/JUts90Dm
 GAkaWYdg+lbouIWCrxyN9BLnpJH4RQtd8Y24MsepID1Bmc+ownmXx0oC60bj6rJ2IyzdvWss8
 BXgnd1h+elHw2259j/BusKGWwIaFBXeBHVupmQ7P0rMDQJSRLa2ZPBVWhFu9yhnV6q+MMjgeR
 cRfoSSAK0deHw6Z9XuS2AwBjhTmc0lFJ/udBcqMkgVjwfvVUHVS1HK6KUQc1CMKZqmWdBWHKi
 hfjCz5ghmk93tkMhhBUlVzV1A5T4rliw1ot81PXtk3TKxqqtYrjW0cCEJwyU5uupKLJqD2qYM
 pkndx+Ym7skK6TRA/1krKSzlACmXeNpJ7nYifGEdWzCDJQoG/geJTD6ez1UZgKO/MoegriaR6
 NGNnh5xmQ03ySybtGGbKJn6tGxYonmgD3SNQ/XhwjRuGhHRtmm4zHUFssoh9MA6/E1MO93N56
 zRznCHbcYzoOmE8gQNWZYbYlaBEUr6I+Qf4HxU2XxvPic8lq035+sKpwmYL+c9HFCd7pFLQsf
 RDBt68PnJAEr36AEbPcO+PHbefSXwX+7cRqz07OuJQR9jL8A24E+P2nIe0bftostOjzlTEd3m
 PvZahy2dEOq46iv0CxnWJ3ktYHlXllBM/yQh1RqAfIKmWTN9cg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions in this driver are only referenced for baytrail-class
configurations and building configurations with only merrifield enabled
causes a warning:

sound/soc/sof/intel/byt.c:447:12: error: unused function 'byt_suspend' [-Werror,-Wunused-function]
static int byt_suspend(struct snd_sof_dev *sdev, u32 target_state)
           ^
sound/soc/sof/intel/byt.c:454:12: error: unused function 'byt_resume' [-Werror,-Wunused-function]
static int byt_resume(struct snd_sof_dev *sdev)
           ^
sound/soc/sof/intel/byt.c:464:12: error: unused function 'byt_remove' [-Werror,-Wunused-function]
static int byt_remove(struct snd_sof_dev *sdev)

Move these into a corresponding #ifdef section.

Fixes: c691f0c6e267 ("ASoC: SOF: Intel: BYT: add .remove op")
Fixes: ddcccd543f5d ("ASoC: SOF: Intel: byt: Add PM callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/intel/byt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index e6ba8382b1de..6ae62a8a9daf 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -432,6 +432,7 @@ static void byt_set_mach_params(const struct snd_soc_acpi_mach *mach,
 	mach_params->platform = dev_name(dev);
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 static void byt_reset_dsp_disable_int(struct snd_sof_dev *sdev)
 {
 	/* Disable Interrupt from both sides */
@@ -467,6 +468,7 @@ static int byt_remove(struct snd_sof_dev *sdev)
 
 	return 0;
 }
+#endif
 
 /* Baytrail DAIs */
 static struct snd_soc_dai_driver byt_dai[] = {
-- 
2.26.2

