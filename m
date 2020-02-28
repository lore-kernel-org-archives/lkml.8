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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE76DC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FB224672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUNucea0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgB1GkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:40:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40820 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1GkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:40:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id b185so1205934pfb.7;
        Thu, 27 Feb 2020 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jLyDf7HA1xjI2cZ4/f5NFCTmMji2H18M6eJIfWLIio=;
        b=cUNucea0ep9rRh4qhvCRUETrPpzkdl6LG35PtOFQM5BNV+zzYrhbJIb+v/2enqZjlb
         wcq94TO7o1VPlARsPE9s2/bj5AyOkFq1DXyYl7IR/IkmkflhSFKnPeTYsncfw0Fv7VwJ
         C6MG8BNhaqckcKv7WktCQiR6NWeyo6abFbX9o6YCefEdTHq+SSOEK8wAcrO61oTRzrko
         nXMFkTTxJLRSPLMJ5MNQT2FTQAtLvZ+b0W5/EFeLsyDiC+xHHZ7hly4FOCftRgp3Tcsn
         npJDw3lRZco6at1H4Hn8nKv+YCvg8ACIHJM4TlVgo43hbvaWB4/HrkQHxOp2PCL7AC0r
         ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jLyDf7HA1xjI2cZ4/f5NFCTmMji2H18M6eJIfWLIio=;
        b=W+AwkT2wFwfBeGlH/qklR+npdafl/K2pta8tMqpli7Oiqvq0idSwHilk+sJaU/r6IC
         fJ0WhOgfUuXV/3vg5MTBApk9cEf+ZmZ1jQ2vSbq7jnwMsEXwChmjoexXGM41NOwcZFJU
         iF2UGGIX0zgse415OSOW9esl0CtOK1js7FicMZ3HTX2/6w2JXiEXWW6IeNwOWPWfxHgv
         5FJBURq0FsPouf6LC9I2DKtIgWm9w72fOEcjog5WFlTXGYbnx4xa3GVe5ACNNexzOcVA
         3I/sKOo9ZtchkmJOkM1brWlVFfl6QyRDtcEHU6Wd4klMI5gpf8nbWjfp2ls1ZD4BtshZ
         58Eg==
X-Gm-Message-State: APjAAAVautFsfs5xWH+o6y3DsQSxudjtbMoabji9YaaWNllfmHUg/a2u
        ZXbVjB4QCsO9O0WB6ZuzuJQ=
X-Google-Smtp-Source: APXvYqw2E+Kw7R0gNcvM5/xBp+Mo7r/IZp42jhZvRCSqeJUpfX2x+jEWuRWEd+uGspE5Km1km0p/6Q==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr3010846pgd.357.1582872015725;
        Thu, 27 Feb 2020 22:40:15 -0800 (PST)
Received: from NICOLINC-LT.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 13sm8609829pgo.13.2020.02.27.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:40:15 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:40:09 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
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
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
Message-ID: <20200228063958.GA473@NICOLINC-LT.nvidia.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
 <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
 <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
 <20200227174540.GA17040@Asurada-Nvidia.nvidia.com>
 <CAA+D8AM6t79cPoNmt-8HbGwTSM9bfXSW8g76HtkCF7eauL_Xmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AM6t79cPoNmt-8HbGwTSM9bfXSW8g76HtkCF7eauL_Xmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:54:02AM +0800, Shengjiu Wang wrote:
> Hi
> 
> On Fri, Feb 28, 2020 at 1:45 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 01:10:19PM +0800, Shengjiu Wang wrote:
> > > On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > > > > asrc_format is more inteligent variable, which is align
> > > > > with the alsa definition snd_pcm_format_t.
> > > > >
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > ---
> > > > >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> > > > >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> > > > >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> > > > >  3 files changed, 14 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > > > index 0dcebc24c312..2b6a1643573c 100644
> > > > > --- a/sound/soc/fsl/fsl_asrc.c
> > > > > +++ b/sound/soc/fsl/fsl_asrc.c
> > > >
> > > > > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> > > > >
> > > > >       pair->config = &config;
> > > > >
> > > > > -     if (asrc_priv->asrc_width == 16)
> > > > > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > > > > -     else
> > > > > -             format = SNDRV_PCM_FORMAT_S24_LE;
> > > >
> > > > It feels better to me that we have format settings in hw_params().
> > > >
> > > > Why not let fsl_easrc align with this? Any reason that I'm missing?
> > >
> > > because the asrc_width is not formal,  in the future we can direct
> >
> > Hmm..that's our DT binding. And I don't feel it is a problem
> > to be ASoC irrelative.
> >
> > > input the format from the dts. format involve the info about width.
> >
> > Is there such any formal ASoC binding? I don't see those PCM
> > formats under include/dt-bindings/ folder. How are we going
> > to involve those formats in DT?
> 
> There is no formal binding of this case.
> 
> I think it is not good to convert width to format, because, for example

The thing is that fsl_easrc does the conversion too... It just
does in the probe instead of hw_params(), and then copies them
in the hw_params(). So I don't see obvious benefit by doing so.

> width = 24,  there is two option, we can select format S24_LE,  or
> format S24_3LE,  width is ambiguous for selecting.
> 
> In EASRC, it support other two 24bit format U24_LE, U24_3LE .

I understood the reason here, but am not seeing the necessity,
at this point.

> if we use the format in DT, then it is clear for usage in driver.

I think this is the thing that we should address first. If we
have such a binding being added with the new fsl_easrc driver,
I'd love to see the old driver aligning with the new one.

Otherwise, we can keep the old way, and change it when the new
binding is ready.
