Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1EFC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B92469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrLlidHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgB0Rpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:45:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgB0Rpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:45:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so70479pgu.3;
        Thu, 27 Feb 2020 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aavjJ+Z/Os0zHnsfY4LhrQa/kjKKVPycfJnfRrQ9Zao=;
        b=WrLlidHpJQHENIo9YAPAEQekykxM5HD2YXi3IVdH2pDlg6yOsqQeAnBHuInus8IGYC
         T+Llicheka6t83Av1G7fnGQK8N8t/+ARqHcr7lEyinMjtYM47yBrjkl2uEcRsEZ4vjUz
         pAjZPbsFEKwx29NM8eVxoOKBbOhAa5Ss0rhJpdsluzAbqfyGiQnGG/Zp0NAiBrgbAbt0
         jfF0riqJcV8+RHgdQPpeLHStGSeazOIOy4Dlp0oY3js8i23wr6q2uHDBiIWHOaJsg9t8
         1ZOC6VPeEyYaQraK7qW+s5OLWdodWJnu6yrWH8xyJEc1DQGF4Yy9unxmzfeJW8N2YDjq
         /lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aavjJ+Z/Os0zHnsfY4LhrQa/kjKKVPycfJnfRrQ9Zao=;
        b=d5KvKt7BrH7gcLYsDCg9of86TNN4g2JAf/HnyiTMXCB8uswLlUqBLq1E4wSDptQKQ1
         sspnlkxy3KdzSpsm4dVwhLDlLo16atWdXP74R9SCzzkXW4591SVk890vcaAUC5bQjOJo
         I2fHE/3ogFDDZ2jiSqu4K95yV8wDfZ32QYkH2y3oo3ig4fVxEBbTZ1TyF3HspInmEDCJ
         ew+heDh1tSNyCBMjljV9X57gTIlNLIr8NzgiXO67TmTSzsa0HA96FTNVok/j/HoQl3nD
         mnEeBBLNBEN6y8ELhXBBHozaf6ze/6GwZSaNRWjiyP1o4C///YHBtv6M8fWqFSstPiC+
         aNLg==
X-Gm-Message-State: APjAAAUH55cWVuSj9QbIGieqDRLpl/y9T7BDiyM+1XsyEigmKv7ewC7M
        ERw76zBLAwH5IfwZ+luslN0=
X-Google-Smtp-Source: APXvYqxLesXxb5FW6sTnMiGiGe5CN/UVKj1bBr36Rl2QBzPtHaPhoQYlUWdpilUa7ohjuvvcuvc2jw==
X-Received: by 2002:a62:7c96:: with SMTP id x144mr114879pfc.7.1582825543344;
        Thu, 27 Feb 2020 09:45:43 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id m16sm7712623pfh.60.2020.02.27.09.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 09:45:43 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:45:41 -0800
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
Message-ID: <20200227174540.GA17040@Asurada-Nvidia.nvidia.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
 <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
 <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
 <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AMzqpC35_CR2dCG6a_h4FzvZ6orXkPSYh_1o1d8hv+BMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:10:19PM +0800, Shengjiu Wang wrote:
> On Thu, Feb 27, 2020 at 11:43 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> > > asrc_format is more inteligent variable, which is align
> > > with the alsa definition snd_pcm_format_t.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
> > >  sound/soc/fsl/fsl_asrc.h     |  4 ++--
> > >  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
> > >  3 files changed, 14 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > index 0dcebc24c312..2b6a1643573c 100644
> > > --- a/sound/soc/fsl/fsl_asrc.c
> > > +++ b/sound/soc/fsl/fsl_asrc.c
> >
> > > @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
> > >
> > >       pair->config = &config;
> > >
> > > -     if (asrc_priv->asrc_width == 16)
> > > -             format = SNDRV_PCM_FORMAT_S16_LE;
> > > -     else
> > > -             format = SNDRV_PCM_FORMAT_S24_LE;
> >
> > It feels better to me that we have format settings in hw_params().
> >
> > Why not let fsl_easrc align with this? Any reason that I'm missing?
> 
> because the asrc_width is not formal,  in the future we can direct

Hmm..that's our DT binding. And I don't feel it is a problem
to be ASoC irrelative.

> input the format from the dts. format involve the info about width.

Is there such any formal ASoC binding? I don't see those PCM
formats under include/dt-bindings/ folder. How are we going
to involve those formats in DT?
