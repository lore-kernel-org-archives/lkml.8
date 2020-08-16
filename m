Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FA7206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHPBYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 21:24:15 -0400
Received: from comms.puri.sm ([159.203.221.185]:59668 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgHPBYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:24:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 18552E11EE;
        Sat, 15 Aug 2020 18:23:43 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RK4kC8KZ4Uyc; Sat, 15 Aug 2020 18:23:42 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, "kernel@puri.sm" <kernel@puri.sm>
Subject: [PATCH] ASoC: wm8962: Export DAC/ADC monomix switches
Date:   Sun, 16 Aug 2020 03:23:34 +0200
Message-ID: <3662154.EqNIRYjrc8@pliszka>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows solutions like ALSA UCM to utilize hardware mono downmix
for cases where mono output to a single speaker is desired only in
specific situations (like on a mobile phone).

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 sound/soc/codecs/wm8962.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 317916cb4e27..d36aa24da7e0 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1702,6 +1702,8 @@ SOC_DOUBLE_R_TLV("Digital Playback Volume", WM8962_LEFT_DAC_VOLUME,
 SOC_SINGLE("DAC High Performance Switch", WM8962_ADC_DAC_CONTROL_2, 0, 1, 0),
 SOC_SINGLE("DAC L/R Swap Switch", WM8962_AUDIO_INTERFACE_0, 5, 1, 0),
 SOC_SINGLE("ADC L/R Swap Switch", WM8962_AUDIO_INTERFACE_0, 8, 1, 0),
+SOC_SINGLE("DAC Monomix Switch", WM8962_DAC_DSP_MIXING_1, WM8962_DAC_MONOMIX_SHIFT, 1, 0),
+SOC_SINGLE("ADC Monomix Switch", WM8962_THREED1, WM8962_ADC_MONOMIX_SHIFT, 1, 0),
 
 SOC_SINGLE("ADC High Performance Switch", WM8962_ADDITIONAL_CONTROL_1,
 	   5, 1, 0),
-- 
2.28.0




