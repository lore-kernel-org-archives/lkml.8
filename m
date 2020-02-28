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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6791DC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B12246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBD1vGhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgB1CyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:54:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41666 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgB1CyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:54:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so1013145qtr.8;
        Thu, 27 Feb 2020 18:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22hz3EXYq0SzN1Wu2fonmhGKwST6HFX0P3UPEDmpwXo=;
        b=TBD1vGhuloKu8RtFPWQxFgHHziYiJYOdde1353qzy2LmcoeF0TiDjDX1vZWq4i+I1G
         PxOGEuwdm3jskEG8pUt/6K0JSYZJ0j+CUnc9p9tBIyyk6ljb/P7YZkENFlOKudEIAHIz
         lYZu3V4cVEiJhkcItpRev2T8F2Xv+xbwvQMzSApqjce7q0xJzmAlfnCRx7iznMqtFpMw
         D9hPjaUJnzrxXvBACyVYK5QgZxg449iJK2ULaQ3hg4IfAgfp2YuQsaC0pP09+/AMME+N
         e7XkK8nJFvXHADovHj3sQyLpUp4qgFKouUF/Xr15HR9gMjka5EcBntqIZbCRQm7aoS9P
         Mm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22hz3EXYq0SzN1Wu2fonmhGKwST6HFX0P3UPEDmpwXo=;
        b=DgQl2P/yX/tamwH2Mjm/3dxMArx2aAV/QCXI1dgjXEMfg/vp+CrM2nWYcp2t0Vhdzp
         K+6eF9VAchaF9Leub1ImGrGMNwdo6SjqF6TAxesYoYgT8IMWZr2SnlJzqKn84a/2tRE5
         4xS5RJKKkWCyB9gXSy8BXNK1HFvAp7jXdSPad76j2KxxwBIaUH0geu0YKyhEvT8H5InD
         TY7U5ZSC1itwWw5F2pOMi/j4BqWbMYBq0awODF9hJxEZ5jDLfi86CSKaz9TNuElN2LIK
         deEiPun7oKDPW75FcV6WM0i8CF407VmKBjVf2q4BprXYSoa4j3XfteeBUr1zdCJJyHR8
         iS/A==
X-Gm-Message-State: APjAAAWom6DIhIXuD3zbAP02xCHmJBVRgCW0NwSvRRiqJzfRKgD1TGs9
        fC1fLHleS4/MfPuRGgExEKWC4/8S92cAvBbKv2HXjR3B
X-Google-Smtp-Source: APXvYqx40ohLVeMfivRLcPCJq0RBwQ9BYmvFVQpKE5DzCFxMCXj1+DIF7ZrkDxeYve2lklZXhdcB7wpqqqroi1Qjtfk=
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr2482318qtu.360.1582858453803;
 Thu, 27 Feb 2020 18:54:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582770784.git.shengjiu.wang@nxp.com> <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com> <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
 <20200227174540.GA17040@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200227174540.GA17040@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 28 Feb 2020 10:54:02 +0800
Message-ID: <CAA+D8AM6t79cPoNmt-8HbGwTSM9bfXSW8g76HtkCF7eauL_Xmw@mail.gmail.com>
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

Hi

On Fri, Feb 28, 2020 at 1:45 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 01:10:19PM +0800, Shengjiu Wang wrote:
> > On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > > > asrc_format is more inteligent variable, which is align
> > > > with the alsa definition snd_pcm_format_t.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> > > >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> > > >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> > > >  3 files changed, 14 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > > index 0dcebc24c312..2b6a1643573c 100644
> > > > --- a/sound/soc/fsl/fsl_asrc.c
> > > > +++ b/sound/soc/fsl/fsl_asrc.c
> > >
> > > > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> > > >
> > > >       pair->config = &config;
> > > >
> > > > -     if (asrc_priv->asrc_width == 16)
> > > > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > > > -     else
> > > > -             format = SNDRV_PCM_FORMAT_S24_LE;
> > >
> > > It feels better to me that we have format settings in hw_params().
> > >
> > > Why not let fsl_easrc align with this? Any reason that I'm missing?
> >
> > because the asrc_width is not formal,  in the future we can direct
>
> Hmm..that's our DT binding. And I don't feel it is a problem
> to be ASoC irrelative.
>
> > input the format from the dts. format involve the info about width.
>
> Is there such any formal ASoC binding? I don't see those PCM
> formats under include/dt-bindings/ folder. How are we going
> to involve those formats in DT?

There is no formal binding of this case.

I think it is not good to convert width to format, because, for example
width = 24,  there is two option, we can select format S24_LE,  or
format S24_3LE,  width is ambiguous for selecting.

In EASRC, it support other two 24bit format U24_LE, U24_3LE .

if we use the format in DT, then it is clear for usage in driver.


best regards
wang shengjiu
