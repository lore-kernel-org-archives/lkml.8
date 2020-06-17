Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6322082E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLXf0FXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFQDnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:43:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE5C061573;
        Tue, 16 Jun 2020 20:43:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q8so762417qkm.12;
        Tue, 16 Jun 2020 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vu+NO376NKYI1jWLgdkbjWwFJw4rHiE2cx4A9CRwj8=;
        b=rLXf0FXmhfaJqwRhe7pzmFH+I+5Jzl+4mGdC8v2m0Lm3iaDGlAH3hqj8lfuKZH8obQ
         SRV1JMUu0z5+zc2o19KWm6yO8G1kgZ50kIc+3naYW/anOSrAwoEac5sA2keGAK/W102h
         qxCUwKnNcV5tfpStRlLLA2V49N18kqd6rPVDQ4T7Q6EY7W3p3TqRfdV6NEbeRxb9ROZd
         x7Xw3OyEQ4JiY/LGYSbJ7jRR/86tBZWNItSDIX1v2cnl0fF5hqwrE0zA6Xt9R7jQEbZX
         yaLVuBpMHhd5R9p0xoVsMyZ7+EXwMdJgxtLXQ/FjnTbvPBmyqY12rwTJNOWZaP/UWf9d
         5+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vu+NO376NKYI1jWLgdkbjWwFJw4rHiE2cx4A9CRwj8=;
        b=f+AM5Jxt5XKWECX42PzR+i9/HEwWUP38LB0pnz0l0dcDT9QH7Ue1tEzQ8JPZ/ziGxk
         WehBZRa+ywKBnxyKPZWeifEgezVrOqLYtTynhL94MAODPXxvzbCJZkFMcoSkxtEBt129
         ZRzvgw2YjZ3VK8T37XhAfdTmiP9dHswCapzM5qp8/336fVltms/kEQE3nNwHWSspZ9qA
         WjGaLcNXNHErmkMj1DrROOrsCvD84Otdcpm+WmasUeh7MaoJWhS2hU2GfXzVptyFipM2
         Cif+scA3bn5tsOoc1Joknl3/3qM5l+K1/5fqIo5hyd3wG9jeifuK2ROOOyYhq7PuQ86S
         FwQA==
X-Gm-Message-State: AOAM533OBASx3T2ZFjU//cIhX8QGvlJhJxpjWLzYr3HX6ZFfO0bWxWD/
        FjUC9pptdpnPKPGQjmsPb/UOvRp9cF7qmNazhVJsYw==
X-Google-Smtp-Source: ABdhPJzTnuBuNJC6PfYb8KsQOFkrB783WazcWiNJ7FUK4rjhj/lk+ZuGwVKuHA9gkQzAAjPETCxduLPoj1SRbaYHNHc=
X-Received: by 2002:a37:b50:: with SMTP id 77mr23894892qkl.152.1592365402625;
 Tue, 16 Jun 2020 20:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <1592289761-29118-1-git-send-email-shengjiu.wang@nxp.com>
 <1592289761-29118-2-git-send-email-shengjiu.wang@nxp.com> <20200616232810.GA19896@Asurada-Nvidia>
In-Reply-To: <20200616232810.GA19896@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 17 Jun 2020 11:43:11 +0800
Message-ID: <CAA+D8AMv0EW+zUbT8bA7H+hWB8t_DQdWR=cWuYhFZA2z3F-twg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Jun 16, 2020 at 02:42:41PM +0800, Shengjiu Wang wrote:
> > The one difference on imx6sx platform is that the root clock
> > is shared with ASRC module, so we add a new flags "ind_root_clk"
> > which means the root clock is independent, then we will not
> > do the clk_set_rate and clk_round_rate to avoid impact ASRC
> > module usage.
> >
> > As add a new flags, we include the soc specific data struct.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_spdif.c | 43 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> > index 1b2e516f9162..00e06803d32f 100644
> > --- a/sound/soc/fsl/fsl_spdif.c
> > +++ b/sound/soc/fsl/fsl_spdif.c
> > @@ -42,6 +42,17 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
> >
> >  #define DEFAULT_RXCLK_SRC    1
> >
> > +/**
> > + * struct fsl_spdif_soc_data: soc specific data
> > + *
> > + * @imx: for imx platform
> > + * @ind_root_clk: flag for round clk rate
> > + */
> > +struct fsl_spdif_soc_data {
> > +     bool imx;
> > +     bool ind_root_clk;
>
> "ind" doesn't look very straightforward; maybe "shared_root_clock"?
>
> And for its comments:
>         * @shared_root_clock: flag of sharing a clock source with others;
>         *                     so the driver shouldn't set root clock rate
>
> > +};
> > +
> >  /*
> >   * SPDIF control structure
> >   * Defines channel status, subcode and Q sub
> > @@ -93,6 +104,7 @@ struct fsl_spdif_priv {
> >       struct snd_soc_dai_driver cpu_dai_drv;
> >       struct platform_device *pdev;
> >       struct regmap *regmap;
> > +     const struct fsl_spdif_soc_data *soc;
>
> Looks better if we move it to the top of the list :)
>
> > @@ -421,7 +448,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
> >       sysclk_df = spdif_priv->sysclk_df[rate];
> >
> >       /* Don't mess up the clocks from other modules */
> > -     if (clk != STC_TXCLK_SPDIF_ROOT)
> > +     if (clk != STC_TXCLK_SPDIF_ROOT || !spdif_priv->soc->ind_root_clk)
> >               goto clk_set_bypass;
> >
> >       /* The S/PDIF block needs a clock of 64 * fs * txclk_df */
> > @@ -1186,7 +1213,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
> >                       continue;
> >
> >               ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
> > -                                          i == STC_TXCLK_SPDIF_ROOT);
> > +                                          i == STC_TXCLK_SPDIF_ROOT &&
> > +                                          spdif_priv->soc->ind_root_clk);
>
> Having more than one place that checks the condition, we can add:
>
> /* Check if clk is a root clock that does not share clock source with others */
> static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif, int clk)
> {
>         return (clk == STC_TXCLK_SPDIF_ROOT) && !spdif->soc->shared_root_clock;
> }

will update them in v2

best regards
wang shengjiu
