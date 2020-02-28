Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55FC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03856222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKbwFGtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1G5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:57:00 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36551 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1G47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:56:59 -0500
Received: by mail-qv1-f65.google.com with SMTP id ff2so894319qvb.3;
        Thu, 27 Feb 2020 22:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y01M/2zdHCZcq/LUwDdnQfmblvhfbJOn2D+Py6njg7g=;
        b=ZKbwFGtPtc2xfkSIQh1fpVq2oIEcHMYmuGCZgeHsYFzw6OrDBybr7dn68Ya6Haf12t
         4vU4ZDPCwz/A8AuWJON2bqbmPVLFJP7BgcWM/moPEl4FAinQuPpI2DYx5geA/nHXcA/K
         GCDXCScmwy7+mQHcGNMyA+STiUkaz0BwlCl9ctxf18xxXTukTMCg1p3eTCbkojg8fo5k
         0u0DUmmXRhcOvC2VPcUHs5w//ck4/LHiObI0OVIM6hCI1rX3b0oZ2yD65ima+PxeIIro
         tAlElbsYlY52UiaPrnpoIHCLHKFUAo6+jaGrKFymTy8slT8vP8vyeNYbNA2YVZRtN6c0
         W2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y01M/2zdHCZcq/LUwDdnQfmblvhfbJOn2D+Py6njg7g=;
        b=GWqdwJKc2S62x96WBWgD0O+Oimz6n4CBRqrjGSEpM0vZB6WCDtJ53jHpa1noXKTYto
         0dKqaci7G5MyDwGQf4lPWtV+3tU7GSHSVSGDkI5qff4cBBznJFb+yrO515SUiDjhvrrG
         TLjAS/U01HikxZGo5ZGRMOu9Ju563NZASQh6ADiTifccHnJsEWz4ufGpHtjiPVaAu7B4
         U4KpWCKSpPrX8r7gYngR2l2O4BRVFLGOLgULzTCom1MmLZRIedvuF9BWto6J7sk5vYzF
         oLZhrkF8H4EjuR2FI+D7vphfEpYr6FrsEK3/yFdEHd8Cmnk7gYE/KdAHWPGjQVwX87Fk
         YPYg==
X-Gm-Message-State: APjAAAWgmuvpRcM3zV0/KDfzNOVae7WwLyAsWWUvpWDRC2O2lvSIzTON
        l1tExIChztX6cqgMmzSHfffeBTP7yKo/MMISlek=
X-Google-Smtp-Source: APXvYqzj5j0vPNWa4F9PJfSQ8lKIGPn+N9t3wsMNUwuluF4E14JSjeMvx2/NNDaPp5uF+vkPGCMI5QJ3InE97/22PGw=
X-Received: by 2002:a05:6214:a46:: with SMTP id ee6mr2639365qvb.32.1582873018570;
 Thu, 27 Feb 2020 22:56:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582770784.git.shengjiu.wang@nxp.com> <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com> <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
 <20200227174540.GA17040@Asurada-Nvidia.nvidia.com> <CAA+D8AM6t79cPoNmt-8HbGwTSM9bfXSW8g76HtkCF7eauL_Xmw@mail.gmail.com>
 <20200228063958.GA473@NICOLINC-LT.nvidia.com>
In-Reply-To: <20200228063958.GA473@NICOLINC-LT.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 28 Feb 2020 14:56:47 +0800
Message-ID: <CAA+D8AMAV=d8FDL4wmUaAx7h7ZBaTZyKJcwXqkA+oWDLLF6oYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:40 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 10:54:02AM +0800, Shengjiu Wang wrote:
> > Hi
> >
> > On Fri, Feb 28, 2020 at 1:45 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 01:10:19PM +0800, Shengjiu Wang wrote:
> > > > On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > > >
> > > > > On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > > > > > asrc_format is more inteligent variable, which is align
> > > > > > with the alsa definition snd_pcm_format_t.
> > > > > >
> > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > ---
> > > > > >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> > > > > >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> > > > > >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> > > > > >  3 files changed, 14 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > > > > index 0dcebc24c312..2b6a1643573c 100644
> > > > > > --- a/sound/soc/fsl/fsl_asrc.c
> > > > > > +++ b/sound/soc/fsl/fsl_asrc.c
> > > > >
> > > > > > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> > > > > >
> > > > > >       pair->config = &config;
> > > > > >
> > > > > > -     if (asrc_priv->asrc_width == 16)
> > > > > > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > > > > > -     else
> > > > > > -             format = SNDRV_PCM_FORMAT_S24_LE;
> > > > >
> > > > > It feels better to me that we have format settings in hw_params().
> > > > >
> > > > > Why not let fsl_easrc align with this? Any reason that I'm missing?
> > > >
> > > > because the asrc_width is not formal,  in the future we can direct
> > >
> > > Hmm..that's our DT binding. And I don't feel it is a problem
> > > to be ASoC irrelative.
> > >
> > > > input the format from the dts. format involve the info about width.
> > >
> > > Is there such any formal ASoC binding? I don't see those PCM
> > > formats under include/dt-bindings/ folder. How are we going
> > > to involve those formats in DT?
> >
> > There is no formal binding of this case.
> >
> > I think it is not good to convert width to format, because, for example
>
> The thing is that fsl_easrc does the conversion too... It just
> does in the probe instead of hw_params(), and then copies them
> in the hw_params(). So I don't see obvious benefit by doing so.
>
> > width = 24,  there is two option, we can select format S24_LE,  or
> > format S24_3LE,  width is ambiguous for selecting.
> >
> > In EASRC, it support other two 24bit format U24_LE, U24_3LE .
>
> I understood the reason here, but am not seeing the necessity,
> at this point.
>
> > if we use the format in DT, then it is clear for usage in driver.
>
> I think this is the thing that we should address first. If we
> have such a binding being added with the new fsl_easrc driver,
> I'd love to see the old driver aligning with the new one.
>
> Otherwise, we can keep the old way, and change it when the new
> binding is ready.

ok,  I will change the binding this time in next version.

best regards
wang shengjiu
