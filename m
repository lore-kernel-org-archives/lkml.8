Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D04C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62E720702
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgBQHdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:33:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42822 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgBQHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:33:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so19498836edv.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSSCawygB3nvTAtWswavRnt6s9D1sDcPs8tiWUcv5Cc=;
        b=MrnUyVq5FDtHLq4lH/vyWUZEIQUIGG6pQwhy13p/mroif3efiCqYBxWLpP3GW/gnkw
         P2Hje8Ga7Z2fbBHBLT+oyfqgNsIP9fYrth67pTsHGaDpOY9ZmQx2XuqOQKVOlDCPReTg
         DmF2BYIa2TjS0QgBTlQ79C1o+wBga4kIz34XAmhKrb4xfTxw+/pnU5jbnnbjPUf1d/k6
         c+yjNIUCGcjUuy8Kk/35VKpnxAeDfpfZnUa58y2lp0Y+5q2mp2irgPXUaxeB8zyajhSG
         99sNGIefuAV5DUY6OXeXhGGs1aOih/D24adYoMWHjV3cZpbZR6lWVfaU96+eAQYSKQqV
         BbSw==
X-Gm-Message-State: APjAAAXLBt3InpWEGVlwcvgz0T5ItppFEDAatoAf/05UfCNHXfTpCjIZ
        1UjM/jtGAJ4RF8agqPfQb41gcGxqaww=
X-Google-Smtp-Source: APXvYqwuY7NYdP7tBJ7Ax5TtT8itVVWaznKvimLRsGrUvl1OSonrVp5V8P8YJIecY6XZ5eL/gimfuQ==
X-Received: by 2002:a05:6402:1749:: with SMTP id v9mr12600163edx.55.1581924814285;
        Sun, 16 Feb 2020 23:33:34 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id z10sm811611ejn.16.2020.02.16.23.33.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 23:33:34 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id a9so17205172wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 23:33:33 -0800 (PST)
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr22012620wmg.16.1581924813434;
 Sun, 16 Feb 2020 23:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-9-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-9-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 15:33:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wvWEYM4ttKVmgM6Pou+00tuvwb8nMvjR+Y+F-p2cA=g@mail.gmail.com>
Message-ID: <CAGb2v67wvWEYM4ttKVmgM6Pou+00tuvwb8nMvjR+Y+F-p2cA=g@mail.gmail.com>
Subject: Re: [PATCH 8/8] ASoC: sun50i-codec-analog: Enable DAPM for earpiece switch
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
> By including the earpiece mute switch in the DAPM graph, both the
> earpiece amplifier and the Mixer/DAC inputs can be powered off when
> the earpiece is muted.
>
> The mute switch is between the source selection and the amplifier,
> as per the diagram in the SoC manual.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  sound/soc/sunxi/sun50i-codec-analog.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> index 84bb76cad74f..6c89b0716bbd 100644
> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> @@ -232,11 +232,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
>                        SUN50I_ADDA_EARPIECE_CTRL1,
>                        SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
>                        sun50i_codec_earpiece_vol_scale),
> -
> -       SOC_SINGLE("Earpiece Playback Switch",
> -                  SUN50I_ADDA_EARPIECE_CTRL1,
> -                  SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
> -
>  };
>
>  static const char * const sun50i_codec_hp_src_enum_text[] = {
> @@ -295,6 +290,11 @@ static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
>                       sun50i_codec_earpiece_src_enum),
>  };
>
> +static const struct snd_kcontrol_new sun50i_codec_earpiece_switch =
> +       SOC_DAPM_SINGLE("Playback Switch",
> +                       SUN50I_ADDA_EARPIECE_CTRL1,
> +                       SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0);
> +
>  static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>         /* DAC */
>         SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
> @@ -341,6 +341,8 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>
>         SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
>                          SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
> +       SND_SOC_DAPM_SWITCH("Earpiece",
> +                           SND_SOC_NOPM, 0, 0, &sun50i_codec_earpiece_switch),

I would suggest naming this something a bit more specific, in case someone
uses "Earpiece" as a widget name at the board level. Also, having the
"Earpiece" come before the "Earpiece Amp" in the route doesn't make much
sense. However, this creates an issue with the name of the created kcontrol...
Any other ideas?

ChenYu


>         SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
>                              SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
>         SND_SOC_DAPM_OUTPUT("EARPIECE"),
> @@ -462,7 +464,8 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>         { "Earpiece Source Playback Route", "DACR", "Right DAC" },
>         { "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
>         { "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
> -       { "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
> +       { "Earpiece", "Playback Switch", "Earpiece Source Playback Route" },
> +       { "Earpiece Amp", NULL, "Earpiece" },
>         { "EARPIECE", NULL, "Earpiece Amp" },
>  };
>
> --
> 2.24.1
>
