Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72AC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020672081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAPgEX95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAPFzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:55:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35675 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPFzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:55:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so17842900wro.2;
        Wed, 15 Jan 2020 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGGRCbRsjloWfYF2cHg3taqwmJTEu8ejz3Fhy/MiNIg=;
        b=FAPgEX95Okm1PYWx+lYdAYkeQZFYdkQpx4INTn3yuTeEPggTIkb+SSmpiN1DrTzTMR
         F8YAzV3LpIE8v/+DzLESZGFiolINqohluQXIo5pP4qfGoAv4WuvIl09MTLyH/FgA1uED
         xrvzH0NNnXsLoP7bi/MMapp889FaW2xsFrvqd9tgZSywMra+//L2O3Mv0Qxb5MadOSHP
         jz223DZjqzt/Nu4ZBN1vXyCUZyN/lHZMeD3lyK1qC5WaiY3J1zUCz+M5X+Kbrc/ZBLL7
         l6i3rSH3TITt2pQsDv9MJNDyHG9uJQQzOv14/uixxkDS9KoFz7btgVg7iRx2X6f/H1vU
         VCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGGRCbRsjloWfYF2cHg3taqwmJTEu8ejz3Fhy/MiNIg=;
        b=mORmB0PJPByy1cqEUlQrchJyP7gFMouicSTjwQ7+t72fWieNmPCMNTNO/5FOBY48/1
         cYb/l8SlP8TccrcscJNysMyI8LOmsNBP3un3NJlbhDf/Uc/9ivr5FwPTRe5FNQOEDlN0
         gl4qCFQ7lBxIFRS3G2hGzJr+P6gcC5xmaG8Q/zC+jVcpfdDiIkPK8neFNS7WN0IpRKPU
         mjb/A3Iu5je8d+0Gc461IgIpNfkLlk1Kj6uJPoghkqIHSLN32cbolktNBVZh6m0bSOlT
         Z5c3wKAimdus/4mAwAyIlKOjzeCASEtZTj1vIqV48buT8eKv1jm4ly0R1vCezTgc3V6R
         8Ubg==
X-Gm-Message-State: APjAAAUdw5UAMXCS4mDDA6WaKx4LubL2MYWVyFP9tuf4gAANyNWgzPL9
        E0QaedYSHIOi+zAlaMrQ0RJ365RgOe0XMz5n1tQ=
X-Google-Smtp-Source: APXvYqygaiL9IxcZBDeOlGW0IjTYd9QUt9aNCyzyH/CPff3tMmmEB2RiYIW6FqMd9/9j6NWJe0bNxet3KikGqZP6xRw=
X-Received: by 2002:adf:d850:: with SMTP id k16mr1193679wrl.96.1579154104574;
 Wed, 15 Jan 2020 21:55:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1569493933.git.shengjiu.wang@nxp.com> <d728f65194e9978cbec4132b522d4fed420d704a.1569493933.git.shengjiu.wang@nxp.com>
 <CANcMJZBy=yH+4YgZWwphiE-PO6d4hzhFK3XFtpN677ZAv_N4WQ@mail.gmail.com>
In-Reply-To: <CANcMJZBy=yH+4YgZWwphiE-PO6d4hzhFK3XFtpN677ZAv_N4WQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Jan 2020 21:54:54 -0800
Message-ID: <CANcMJZCuU_-Xii=YT5Rp5DAyxboptJCrpp51jForuYUpeMuhmQ@mail.gmail.com>
Subject: Re: [PATCH V6 3/4] ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, lars@metafoo.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 8:58 PM John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Sep 26, 2019 at 6:50 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > When set the runtime hardware parameters, we may need to query
> > the capability of DMA to complete the parameters.
> >
> > This patch is to Extract this operation from
> > dmaengine_pcm_set_runtime_hwparams function to a separate function
> > snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> > which need this feature can call this function.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> As a heads up, this patch seems to be causing a regression on the HiKey board.
>
> On boot up I'm seeing:
> [   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component
> f7118000.i2s: -6
>
> And HDMI audio isn't working. With this patch reverted, audio works again.
>
>
> > diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> > index 89a05926ac73..5749a8a49784 100644
> > --- a/sound/core/pcm_dmaengine.c
> > +++ b/sound/core/pcm_dmaengine.c
> > @@ -369,4 +369,87 @@ int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream)
> ...
> > +       ret = dma_get_slave_caps(chan, &dma_caps);
> > +       if (ret == 0) {
> > +               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > +                       hw->info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > +               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > +                       hw->info |= SNDRV_PCM_INFO_BATCH;
> > +
> > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +                       addr_widths = dma_caps.dst_addr_widths;
> > +               else
> > +                       addr_widths = dma_caps.src_addr_widths;
> > +       }
>
> It seems a failing ret from dma_get_slave_caps() here is being returned...
>
> > +
> > +       /*
> > +        * If SND_DMAENGINE_PCM_DAI_FLAG_PACK is set keep
> > +        * hw.formats set to 0, meaning no restrictions are in place.
> > +        * In this case it's the responsibility of the DAI driver to
> > +        * provide the supported format information.
> > +        */
> > +       if (!(dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK))
> > +               /*
> > +                * Prepare formats mask for valid/allowed sample types. If the
> > +                * dma does not have support for the given physical word size,
> > +                * it needs to be masked out so user space can not use the
> > +                * format which produces corrupted audio.
> > +                * In case the dma driver does not implement the slave_caps the
> > +                * default assumption is that it supports 1, 2 and 4 bytes
> > +                * widths.
> > +                */
> > +               for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> > +                       int bits = snd_pcm_format_physical_width(i);
> > +
> > +                       /*
> > +                        * Enable only samples with DMA supported physical
> > +                        * widths
> > +                        */
> > +                       switch (bits) {
> > +                       case 8:
> > +                       case 16:
> > +                       case 24:
> > +                       case 32:
> > +                       case 64:
> > +                               if (addr_widths & (1 << (bits / 8)))
> > +                                       hw->formats |= pcm_format_to_bits(i);
> > +                               break;
> > +                       default:
> > +                               /* Unsupported types */
> > +                               break;
> > +                       }
> > +               }
> > +
> > +       return ret;
>
> ... down here.
>
> Where as in the old code...
>
> > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> > index 748f5f641002..b9f147eaf7c4 100644
> > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
>
> > @@ -145,56 +140,12 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
> >         if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
> >                 hw.info |= SNDRV_PCM_INFO_BATCH;
> >
> > -       ret = dma_get_slave_caps(chan, &dma_caps);
> > -       if (ret == 0) {
> > -               if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> > -                       hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
> > -               if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
> > -                       hw.info |= SNDRV_PCM_INFO_BATCH;
> > -
> > -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > -                       addr_widths = dma_caps.dst_addr_widths;
> > -               else
> > -                       addr_widths = dma_caps.src_addr_widths;
> > -       }
>
> ...the ret from dma_get_slave_caps()  checked above, but is not
> actually returned.
>
> Suggestions on how to sort this out?

Just wanted to check in on this, as I'm still seeing this regression with -rc6.

thanks
-john
