Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93981C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5512223D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 21:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBweGkuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDRVa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgDRVa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:30:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD2C061A0C;
        Sat, 18 Apr 2020 14:30:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z12so5830766ilb.10;
        Sat, 18 Apr 2020 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nKuUM6IHW8RYHdTcFjqmk2a4BW3C6dzC42TENSM2aLE=;
        b=PBweGkuNrIIhqTHUkOqGVSkGqJB1PNvsadvz8LjfFnZ6P4CKIZCf1OAKrTNC4fy/ci
         4Rp54B1F6f+fHirPVBzu+pGSLCRXannDPndxPXIipkYN04OXsDitRYo8dMu6UkvQ7wka
         mHlk2SqG72sY3ogGch4dFZJ5dabTsi5z1+3kdAhCfWGUt7A+bnu61TA2CtygquAFmihW
         ia+COjjURroAkwcgnA79DX9SyvVhL0/SIcGzfzTafYQuR5zcQ3p1u0mLakhEy0SG5eMN
         ukpZ34SJsxEsGD8VCPxfd/24Qf4ZqKsbkfRiDsxCLI5BV5p0WpoconaIixFeUU6D9fyd
         Snhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nKuUM6IHW8RYHdTcFjqmk2a4BW3C6dzC42TENSM2aLE=;
        b=Dox9hcZjExfJT8C2RM27AkiQCcf8nhC9wtMEUNmElMM3sRiKn0A2blAqnEwyRjimI3
         p1zFv9N5uYKUFoj3TeuKZQgX5LAdq4BLwGmTIKoQm/HAc3o4mxFhLU9YayipyXmrr/bU
         K7tNP3488gvG0o8XBccUTFT8l2qwSW3/KyTaDcKre5fzcM43g09ljglTVST9JXezI/fd
         D9n1VRQfb2hNW5taUeK+Oi+TMQRA94JFG3t/0HsyxCsi0/YXClEYL/MxGJifUnE2UeJa
         G+kN/JC/MySTgsWH39kQzkgGPcFQocnnKgLD4p4H3A2Iiohhys5j0Koo+BT8DGjjXbwm
         NqfQ==
X-Gm-Message-State: AGi0PuY8kddGeIyJutDS3ORywMf3XQ1/duSn2OQmpDVJgSe1QkJhExfg
        M5a2yGGLA0bverHq5lXhlqKEFvbXKch21SFoFS4=
X-Google-Smtp-Source: APiQypJzTdzColiYA6jI5kUE3R3feOOH5KcSAgB1jGYlnjTxo7vews7lVZM8Ee7P9ayUu0/SV24dV3u7niNPl+4w1Io=
X-Received: by 2002:a92:540f:: with SMTP id i15mr8784006ilb.59.1587245427254;
 Sat, 18 Apr 2020 14:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200418143923.19608-1-peron.clem@gmail.com> <20200418143923.19608-5-peron.clem@gmail.com>
In-Reply-To: <20200418143923.19608-5-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 18 Apr 2020 23:30:16 +0200
Message-ID: <CAJiuCcdH0=wdKfmAquNfv=0AT_S8qx0Nasbb4m6itWXjUyw8_g@mail.gmail.com>
Subject: Re: [PATCH 4/7] ASoC: sun4i-i2s: Set sign extend sample
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 18 Apr 2020 at 16:39, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>
> This isn't a problem whilst we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a23c9f2a3f8c..e5f00be8cdcf 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -663,6 +663,12 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_=
i2s *i2s,
>         }
>         regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>                            SUN4I_I2S_CTRL_MODE_MASK, val);
> +
> +       /* Set sign extension to pad out LSB with 0 */
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> +                          SUN4I_I2S_FMT1_REG_SEXT_MASK,
> +                          SUN4I_I2S_FMT1_REG_SEXT(0));

My apologies, I made a mistake during the rebase between old Marcus
Cooper patches and new one.
And sadly I lost the defines required here without noticing it.

Will send a v2.

Sorry for that,
Clement

> +
>         return 0;
>  }
>
> @@ -765,6 +771,11 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_=
i2s *i2s,
>                            SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_=
OUT,
>                            val);
>
> +       /* Set sign extension to pad out LSB with 0 */
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> +                          SUN8I_I2S_FMT1_REG_SEXT_MASK,
> +                          SUN8I_I2S_FMT1_REG_SEXT(0));
> +
>         return 0;
>  }
>
> @@ -867,6 +878,11 @@ static int sun50i_i2s_set_soc_fmt(const struct sun4i=
_i2s *i2s,
>                            SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_=
OUT,
>                            val);
>
> +       /* Set sign extension to pad out LSB with 0 */
> +       regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> +                          SUN8I_I2S_FMT1_REG_SEXT_MASK,
> +                          SUN8I_I2S_FMT1_REG_SEXT(0));
> +
>         return 0;
>  }
>
> --
> 2.20.1
>
