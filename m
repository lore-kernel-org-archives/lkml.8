Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365EC33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0E424684
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 04:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJRPpWc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgARECQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:02:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34547 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgARECQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 23:02:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so24357376otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 20:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vb5cyWLJV5ZR0F5iDmlf/8PvEYOZeZfUNSdNGtLvZJI=;
        b=oJRPpWc86aW8ElClMpbeSmGps0a3/zd+opvvpOkEBC8hVNCtjdLp5PzynS4G4c56BU
         3VSWjMLxP2DgfZAY4Ynqq28PxgwynoAx/Ega1iY5vHADe1nx28Ss+oVjWt9i17loT/Tn
         /hJnGFOj25AP5GZ9CftweA9mgLEHxvhOGHMWu4SjXw7OsNretKxT+LYInNxlwjS8R8tX
         Kvx6LsE4imBsm/FB7RCiHcxLA7Gd4WNxHPzi9y/zW+G3PDYWzBmvAJI8YG+Bi4dU8j07
         3cRGWMsJ6Qcd04JnH4bRW0YK5AQHQQcVmjuz3NgVrXoa9eJdOhYIIChJqAExfXq0gD00
         gpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vb5cyWLJV5ZR0F5iDmlf/8PvEYOZeZfUNSdNGtLvZJI=;
        b=Uuo825C52W2Nc1QMIP9eXTxG6QVfSqBRz5e1r9ZKxiAgJrqRYIYEeEFz3WjHDnU9hQ
         HCkj9yV268cocQniLoFAihkFjGWC0RuBn4cqXYuvt5DQwzTeYPoailzhDSVURfCnoFxF
         RKB8VSarNWo8qyZGQLjwJVYaCcggy66ufg09HY8gTd9kTTgqf19PmNx1w812ZRTNg+t0
         vgke/ceekzjUSopuDDQ/YWZMCT4Wi9HKG28IJkzaiL3L7hGBXzS2x1Qu6cQEaJ7yfCHd
         7l15+uYswBrvV9RCkIEd0HS+Si9aJHz9ZY9keQ9yosV7oOfpaMNWdhyVlcTWfZmdBMKA
         piuQ==
X-Gm-Message-State: APjAAAXgYeeYx0ufDuiJWY/v7uHwz72zdv6wnXKzx0f7ouoZ9gqSQXQj
        l2xvI3qCOajA/VAm3VE+iPYTd5j0E/Tawhobzqb6Aw==
X-Google-Smtp-Source: APXvYqxzZjCff57xw2STewj8hvzXGMNapCy6Befwm57vvCLoE09f+Ii81TVHsJjBeSvPmeIU9AkG5ERsKsyGqT2FA8Q=
X-Received: by 2002:a9d:66ca:: with SMTP id t10mr8495244otm.352.1579320135542;
 Fri, 17 Jan 2020 20:02:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1569493933.git.shengjiu.wang@nxp.com> <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
 <CANcMJZBy=yH+4YgZWwphiE-PO6d4hzhFK3XFtpN677ZAv_N4WQ@mail.gmail.com>
 <CANcMJZCuU_-Xii=YT5Rp5DAyxboptJCrpp51jForuYUpeMuhmQ@mail.gmail.com> <CAA+D8AP39bo6EsHvWhVXvAYAho_xMnWmePPAK6dBsOh5wsz48Q@mail.gmail.com>
In-Reply-To: <CAA+D8AP39bo6EsHvWhVXvAYAho_xMnWmePPAK6dBsOh5wsz48Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 17 Jan 2020 20:02:04 -0800
Message-ID: <CALAqxLVapiMC-qPX4fza9cPCKFqvoi2KWhZkJa42DiHwOqGe8Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V6 3/4] ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:11 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi
>
> On Thu, Jan 16, 2020 at 1:56 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Wed, Jan 8, 2020 at 8:58 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Thu, Sep 26, 2019 at 6:50 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> > > >
> > > > When set the runtime hardware parameters, we may need to query
> > > > the capability of DMA to complete the parameters.
> > > >
> > > > This patch is to Extract this operation from
> > > > dmaengine_pcm_set_runtime_hwparams function to a separate function
> > > > snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> > > > which need this feature can call this function.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > >
> > > As a heads up, this patch seems to be causing a regression on the HiKey board.
> > >
> > > On boot up I'm seeing:
> > > [   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component
> > > f7118000.i2s: -6
> > >
> > > And HDMI audio isn't working. With this patch reverted, audio works again.
> > >
> > >
> > > > diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> > > > index 89a05926ac73..5749a8a49784 100644
> > > > --- a/sound/core/pcm_dmaengine.c
> > > > +++ b/sound/core/pcm_dmaengine.c
> > > > @@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
> > > ...
> > > > +       ret = dma_get_slave_caps(chan, &dma_caps);
> > > > +       if (ret == 0) {
> > > > +               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > > > +                       hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > > > +               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > > > +                       hw->info |= SNDRV_PCM_INFO_BATCH;
> > > > +
> > > > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > > +                       addr_widths = dma_caps.dst_addr_widths;
> > > > +               else
> > > > +                       addr_widths = dma_caps.src_addr_widths;
> > > > +       }
> > >
> > > It seems a failing ret from dma_get_slave_caps() here is being returned...
> > >
> > > > +
> > > > +       /*
> > > > +        * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
> > > > +        * hw.formats set to 0, meaning no restrictions are in place.
> > > > +        * In this case it's the responsibility of the DAI driver to
> > > > +        * provide the supported format information.
> > > > +        */
> > > > +       if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
> > > > +               /*
> > > > +                * Prepare formats mask for valid/allowed sample types. If the
> > > > +                * dma does not have support for the given physical word size,
> > > > +                * it needs to be masked out so user space can not use the
> > > > +                * format which produces corrupted audio.
> > > > +                * In case the dma driver does not implement the slave_caps the
> > > > +                * default assumption is that it supports 1, 2 and 4 bytes
> > > > +                * widths.
> > > > +                */
> > > > +               for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> > > > +                       int bits = snd_pcm_format_physical_width(i);
> > > > +
> > > > +                       /*
> > > > +                        * Enable only samples with DMA supported physical
> > > > +                        * widths
> > > > +                        */
> > > > +                       switch (bits) {
> > > > +                       case 8:
> > > > +                       case 16:
> > > > +                       case 24:
> > > > +                       case 32:
> > > > +                       case 64:
> > > > +                               if (addr_widths & (1 << (bits / 8)))
> > > > +                                       hw->formats |= pcm_format_to_bits(i);
> > > > +                               break;
> > > > +                       default:
> > > > +                               /* Unsupported types */
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +
> > > > +       return ret;
> > >
> > > ... down here.
> > >
> > > Where as in the old code...
> > >
> > > > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> > > > index 748f5f641002..b9f147eaf7c4 100644
> > > > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > > > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> > >
> > > > @@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
> > > >         if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
> > > >                 hw.info |= SNDRV_PCM_INFO_BATCH;
> > > >
> > > > -       ret = dma_get_slave_caps(chan, &dma_caps);
> > > > -       if (ret == 0) {
> > > > -               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > > > -                       hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > > > -               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > > > -                       hw.info |= SNDRV_PCM_INFO_BATCH;
> > > > -
> > > > -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > > -                       addr_widths = dma_caps.dst_addr_widths;
> > > > -               else
> > > > -                       addr_widths = dma_caps.src_addr_widths;
> > > > -       }
> > >
> > > ...the ret from dma_get_slave_caps()  checked above, but is not
> > > actually returned.
> > >
> > > Suggestions on how to sort this out?
> >
> > Just wanted to check in on this, as I'm still seeing this regression with -rc6.
> >
> Compare with the old code. it seems that we shouldn't check the return value.
>
> Could you help to test below changes?
>
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -138,12 +138,10 @@ dmaengine_pcm_set_runtime_hwparams(struct
> snd_soc_component *component,
>         if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
>                 hw.info |= SNDRV_PCM_INFO_BATCH;
>
> -       ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
> +       snd_dmaengine_pcm_refine_runtime_hwparams(substream,
>                                                         dma_data,
>                                                         &hw,
>                                                         chan);
> -       if (ret)
> -               return ret;
>
>         return snd_soc_set_runtime_hwparams(substream, &hw);
>  }

Yes, thanks for taking a look at this! Your patch does appear to avoid
the regression.
(Though you'll want to drop the ret declaration to avoid "warning:
unused variable 'ret'" compiler warnings.)

thanks
-john
