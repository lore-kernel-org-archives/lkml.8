Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17205C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF12206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBQDs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:48:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38068 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgBQDs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:48:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so19009099edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P9UDUTmYMSZh58iCz9VgX9ylC6V1SoZoKFa2vjdalQ=;
        b=B0nj7+RV4BIUWZYcEtqUWq8iP1r0IFH617L1/GC8Cyag527FEL4/JWRhImHHsThdyc
         QsWcPh6bscHWsnkHR/VwWViUL+r1QasbFyktFF5+k9mMsTX5LfXWSEF/Aglh4rHoRMrT
         GYWZrH+UJGVAfTTOugyxPVmRsTffAR72wU1b2D9c3bLRJk1oR5CounHQe5BUGCf4wnQH
         cy+idBvKgYfVRViAfr1YpFeSrFt7TxDaK97jPo43NtQaSToT+lD8CvOVJsNff1YvTIR7
         kmBvehFK/vxQTHkOBOcS8iNWCyHXMBGXmr7cmdEb80bdxTdrbt8yO0Hs54UZW9w9AUuK
         goWw==
X-Gm-Message-State: APjAAAWV6yMtfj7YAJerJ5/X3tA+tENm5N84D19wJMgY2CKCIufAWXG5
        6EcQYSdPwWypZBF6jt08yaaBULJRKH8=
X-Google-Smtp-Source: APXvYqxUZyKnlMphjWA4ZyyUa5jRWlhuTThzGy06Hp8Pea7KawXjwgYimAMniIo+X8xWpR/R4Avl5A==
X-Received: by 2002:aa7:c915:: with SMTP id b21mr12962900edt.174.1581911303661;
        Sun, 16 Feb 2020 19:48:23 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id l22sm789896ejq.25.2020.02.16.19.48.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 19:48:23 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id w15so17889140wru.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 19:48:22 -0800 (PST)
X-Received: by 2002:a5d:6805:: with SMTP id w5mr19709664wru.64.1581911302119;
 Sun, 16 Feb 2020 19:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-5-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-5-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 11:48:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
Message-ID: <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] ASoC: sun50i-codec-analog: Make headphone routes stereo
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> This matches the hardware more accurately, and is necessary for
> including the (stereo) headphone mute switch in the DAPM graph.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> index 17165f1ddb63..f98851067f97 100644
> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> @@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>          */
>
>         SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
> -       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> +       SND_SOC_DAPM_MUX("Left Headphone Source",
>                          SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
> -       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
> +       SND_SOC_DAPM_MUX("Right Headphone Source",

Please don't remove the widget suffix. The suffix was chosen to work with
alsa-lib's control parsing code. The term "Playback Route" is appropriate
because it is playback only, and it is a routing switch, not a source or
sink.

Also, what's wrong with just having a single "stereo" widget instead of
two "mono" widgets? I added stereo (2-channel) support to DAPM quite
some time ago. You just have to have two routes in and out.

ChenYu

> +                        SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
> +       SND_SOC_DAPM_OUT_DRV("Left Headphone Amp",
> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_OUT_DRV("Right Headphone Amp",
> +                            SND_SOC_NOPM, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_SUPPLY("Headphone Amp", SUN50I_ADDA_HP_CTRL,
>                              SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
>         SND_SOC_DAPM_OUTPUT("HP"),
>
> @@ -405,13 +411,19 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>         { "Right ADC", NULL, "Right ADC Mixer" },
>
>         /* Headphone Routes */
> -       { "Headphone Source Playback Route", "DAC", "Left DAC" },
> -       { "Headphone Source Playback Route", "DAC", "Right DAC" },
> -       { "Headphone Source Playback Route", "Mixer", "Left Mixer" },
> -       { "Headphone Source Playback Route", "Mixer", "Right Mixer" },
> -       { "Headphone Amp", NULL, "Headphone Source Playback Route" },
> +       { "Left Headphone Source", "DAC", "Left DAC" },
> +       { "Left Headphone Source", "Mixer", "Left Mixer" },
> +       { "Left Headphone Amp", NULL, "Left Headphone Source" },
> +       { "Left Headphone Amp", NULL, "Headphone Amp" },
> +       { "HP", NULL, "Left Headphone Amp" },
> +
> +       { "Right Headphone Source", "DAC", "Right DAC" },
> +       { "Right Headphone Source", "Mixer", "Right Mixer" },
> +       { "Right Headphone Amp", NULL, "Right Headphone Source" },
> +       { "Right Headphone Amp", NULL, "Headphone Amp" },
> +       { "HP", NULL, "Right Headphone Amp" },
> +
>         { "Headphone Amp", NULL, "cpvdd" },
> -       { "HP", NULL, "Headphone Amp" },
>
>         /* Microphone Routes */
>         { "Mic1 Amplifier", NULL, "MIC1"},
> --
> 2.24.1
>
