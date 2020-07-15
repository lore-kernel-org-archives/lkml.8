Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86138C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7ED206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alvhxN7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGOGlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgGOGlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:41:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD95C061755;
        Tue, 14 Jul 2020 23:41:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so1969844pls.9;
        Tue, 14 Jul 2020 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H3GOXsEias8O11m7veg8//yn3qcFVNyaC+qfLEtL+Ng=;
        b=alvhxN7ZMAQKl7g8xDR8IV6PagrJ9Hahmx//vd3jdPyUs04mYsJSaxa0f8L68+OQ+l
         E3+DxH4KmqLcBJpeV9Jtr26IcaITP+oQr6l47Zv8aHE9du2IrS27lUGCdfK6hvhSFm0E
         AnJa4gH3mgO0SYfVUP/lsMRqaZy/c5gUkHzpKYExnEj2d08k0QFoyDyd+gqaYlNKZegr
         d4bihMgLhmzBMDkqnkc2gq+sxeD2jmO6GA5EQrht3RujORiO3efOGCf9/0izJVYJAjLt
         WXryT0azR8FlK9noO8I9iG9LqC1nhEQ8wjDsmCf5ak4sEtEY9j0xzqPHAf3pv+idT7uJ
         yiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3GOXsEias8O11m7veg8//yn3qcFVNyaC+qfLEtL+Ng=;
        b=Vfu7FDC8kzrNmcfYeM5NJ4vBPXxU09zkKERhtscEUlxHvczl9knaTwpoQ54r7JGdn7
         b6XBEAG9JN/SKPlVE5se1RcGBy/LAoUePIHCqTiWqvSH0slI61cuKL7oQn9RbiVU1IJI
         6itHVDhqAmfABHFRn10vTVLkggJChgyDBWCPfj7cXc3jWkA29mUu10U3vxHKARMU7ObC
         9YQX9+NaOuJps+ngkdmGTYDnr+addHxyB4wCwjSwv2eyDujCYaCxBimPac3Q7SDxR0VI
         zeLz1llPb2WGCtl5k6bJy5/xpBxhjChVsIArrxko5o6qiI9qUdUSbbinpYC5f5U6MvAE
         MZ5A==
X-Gm-Message-State: AOAM530xvE/eY5F3aSx6PBgD804BA2Tkz1NLera3PoDDBBDmyjzVdskx
        QFiKw23qFuaax5fc+3ON3H8=
X-Google-Smtp-Source: ABdhPJx7Fa/qDN3qyOdO0QPaUPtwX+pk9Uzy1ivVjam/CKWrJ+m4kN3YIdTdkOkLBa39I3kofrPxrQ==
X-Received: by 2002:a17:90a:1d06:: with SMTP id c6mr9005046pjd.194.1594795282729;
        Tue, 14 Jul 2020 23:41:22 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id bx18sm958690pjb.49.2020.07.14.23.41.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 23:41:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 23:40:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
        kuninori.morimoto.gx@renesas.com, samuel@sholland.org,
        katsuhiro@katsuster.net,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl-asoc-card: Support Headphone and
 Microphone Jack detection
Message-ID: <20200715064057.GA14081@Asurada-Nvidia>
References: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
 <1594717536-5188-4-git-send-email-shengjiu.wang@nxp.com>
 <20200714211432.GA10818@Asurada-Nvidia>
 <CAA+D8ANQ_B9jJUhLYQnKxKJcVrmvakxPo58h433QqFhdu2nRPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANQ_B9jJUhLYQnKxKJcVrmvakxPo58h433QqFhdu2nRPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:14:01PM +0800, Shengjiu Wang wrote:
> On Wed, Jul 15, 2020 at 5:16 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > Hi Shengjiu,
> >
> > The whole series looks good to me. Just a couple of small
> > questions inline:
> >
> > On Tue, Jul 14, 2020 at 05:05:36PM +0800, Shengjiu Wang wrote:
> > > Use asoc_simple_init_jack function from simple card to implement
> > > the Headphone and Microphone detection.
> > > Register notifier to disable Speaker when Headphone is plugged in
> > > and enable Speaker when Headphone is unplugged.
> > > Register notifier to disable Digital Microphone when Analog Microphone
> > > is plugged in and enable DMIC when Analog Microphone is unplugged.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/Kconfig         |  1 +
> > >  sound/soc/fsl/fsl-asoc-card.c | 69 ++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 68 insertions(+), 2 deletions(-)
> >
> > >  static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
> > >  {
> > >       struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
> > > @@ -745,8 +789,29 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> > >       snd_soc_card_set_drvdata(&priv->card, priv);
> > >
> > >       ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
> > > -     if (ret && ret != -EPROBE_DEFER)
> > > -             dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> > > +     if (ret) {
> > > +             if (ret != -EPROBE_DEFER)
> > > +                     dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> >
> > I think we may move this EPROBE_DEFER to the asrc_fail label.
> 
> If we move this to asrc_fail label, then it will be hard to define the
> error message.
> There are many places that goto asrc_fail.

Oh...good point...

> > > +             goto asrc_fail;
> > > +     }
> > > +
> > > +     if (of_property_read_bool(np, "hp-det-gpio")) {
> >
> > Could we move this check inside asoc_simple_init_jack? There's no
> > problem with doing it here though, yet I got a bit confused by it
> > as I thought it's a boolean type property, which would be against
> > the DT bindings until I saw asoc_simple_init_jack() uses the same
> > string to get the GPIO. Just it probably would be a bit tricky as
> > we need it to be optional here.
> >
> > Otherwise, I think we may add a line of comments to indicate that
> > the API would use the same string to get the GPIO.
> 
> In asoc_simple_init_jack, gpio_is_valid() will be invalid when there is
> no "hp-det-gpio" property, and asoc_simple_init_jack will return 0.
> 
> The reason why I add a check here is mostly for
> snd_soc_jack_notifier_register().
> when there is no jack created, there will be a kernel dump.
> 
> or I can use this code:
> 
> -       if (of_property_read_bool(np, "hp-det-gpio")) {
> -               ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
> -                                           1, NULL, "Headphone Jack");
> -               if (ret)
> -                       goto asrc_fail;
> +       ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
> +                                   1, NULL, "Headphone Jack");
> +       if (ret)
> +               goto asrc_fail;
> 
> +       if (priv->hp_jack.jack.jack)
>                 snd_soc_jack_notifier_register(&priv->hp_jack.jack,

It's pretty clean but not very obvious for the "optional" part.
So I think that it'd be slightly better to go for your previous
solution, but with a line of comments to show: these properties
are optional and asoc_simple_init_jack() uses the same strings.

Please add to all three changes once the comments being added:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
