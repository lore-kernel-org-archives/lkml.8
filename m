Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F6B2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph86JCwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgGUS3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:29:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:29:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w9so8491397ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jBpCAfHmvrXMsleahVys7l2Kbtf/JTxu6AXTIkM0eQ=;
        b=ph86JCwgAqK1FafyGhguYtYD9m1MR+zqcBbTXsg8IP83H4jR+1Msy9ofw8JwBHPkBH
         ryf1PDwI/2ck3LAn4CYZ0jSaBhoePx1DxNUmO5leaJ6oichh5CjPdWJbFpZn8nSQ1mP6
         6FQ3HutBUXBCSfAseimn6jrVVkEt4TsA2fysQRViTliWKVuA0tVxqN6yxHra5zMM6Z/2
         u0DKVHBff+qBD72/RB5fnv06htnRbIlmW4Ebk5kQNqyZ+peu2f4/dUJrwDFX0OSPu02P
         EnhYv13WCFw4l82yHLWeV1x5LOWZII9u0MXBFgkyo1uIjj01lDL4T6fcx3O1kZwYXd3Q
         CHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jBpCAfHmvrXMsleahVys7l2Kbtf/JTxu6AXTIkM0eQ=;
        b=VmUH6G2sD6C0iyqn+d5jfKOFMW7lfrHMSioFDdbEXOYCtH5t3iraR+OjJuTbP7NKe5
         1bhk7VCajBcRaG8tDfq9lObxyPs1y3scmhcdKsdXj4jfhWznLoP7JKy7brJ6eRc/hrcR
         Z1NwcxKXhX+DBwCEe2jBK9zFcUR+0HMlzAf53MQVSoTXUHMfM5QOTjjQrFBUYYqi3M1T
         jXeACQVabfr6mz98Nz4nai5N3gng6GUbZrwfvJeCMzIvAEUmuZU2ObFAMrR79U/lO74D
         DD8Rn3V4VR9NDKrF5fDHVkdunAFykega/Kmc5Sc3f4rVYb1srbmPeAiNgNCpboXtFPyW
         f4vw==
X-Gm-Message-State: AOAM532R8BSrxGkhPdweah/yUErJKFmBVAface8deRZ3/A7J452lF6Id
        Io4J7GhmOwZS0yujz+E5AxA=
X-Google-Smtp-Source: ABdhPJyEgjQbISmhm3byo3MXCSUHt+hp1xt7nWYRb4nRip5I+01vDGLbcwHA7g6DLRR1xMIebM/Eig==
X-Received: by 2002:a17:906:a84d:: with SMTP id dx13mr25279915ejb.246.1595356141506;
        Tue, 21 Jul 2020 11:29:01 -0700 (PDT)
Received: from localhost.localdomain ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id q6sm16959454ejn.30.2020.07.21.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:29:00 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] ASoC: rk3399_gru_sound: Add DAPM pins, kcontrols for jack detection
Date:   Tue, 21 Jul 2020 21:27:10 +0300
Message-Id: <20200721182709.6895-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PulseAudio (and perhaps other userspace utilities) can not detect any
jack for rk3399_gru_sound as the driver doesn't expose related Jack
kcontrols.

This patch adds two DAPM pins to the headset jack, where the
snd_soc_card_jack_new() call automatically creates "Headphones Jack" and
"Headset Mic Jack" kcontrols from them.

With an appropriate ALSA UCM config specifying JackControl fields for
the "Headphones" and "Headset" (mic) devices, PulseAudio can detect
plug/unplug events for both of them after this patch.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index f45e5aaa4b30..c17d146717a8 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -32,6 +32,19 @@ static unsigned int dmic_wakeup_delay;
 
 static struct snd_soc_jack rockchip_sound_jack;
 
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin rockchip_sound_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+
+};
+
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphones", NULL),
 	SND_SOC_DAPM_SPK("Speakers", NULL),
@@ -176,7 +189,9 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &rockchip_sound_jack, NULL, 0);
+				    &rockchip_sound_jack,
+				    rockchip_sound_jack_pins,
+				    ARRAY_SIZE(rockchip_sound_jack_pins));
 
 	if (ret) {
 		dev_err(rtd->card->dev, "New Headset Jack failed! (%d)\n", ret);
-- 
2.28.0.rc1

