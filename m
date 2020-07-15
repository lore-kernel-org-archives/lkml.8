Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5769AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3558A206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1HTY9Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGOEOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGOEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:14:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4CAC061755;
        Tue, 14 Jul 2020 21:14:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x62so708835qtd.3;
        Tue, 14 Jul 2020 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foDNNdgIp5gEZxCFX16NjXsSXtzimT2AqP9s4DUPnRU=;
        b=K1HTY9DwxKkwlxnhxfdiEyaM+jc4pxAHsm3ZoHLNf46o0NPweVzUmsjJtWpbSuLE+5
         lvihYceaJxRcEpAn5Y7EIeZe/uvSunAtgqS9kNlEQiAGK00zW7tqpXxTeSY/4j+aQStZ
         dmrHIkiZe+s8yH734YCb8MWgS9ATNCn5XMcrXihLhLhW4cwiabHZHBVUHd1gjGLW4Q1k
         a0OvsQS95Pvuit+60T/5UuMN5I0UHd0X5zOBO38F201gGpVLceSzNqKd3aGWubrmj2EM
         Mn2jFZoMXI7qVziDUAk642VoUW2CExUIyYCmfbb46N7N3LTCKRJRuW2yeEO85s+bRLIn
         UHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foDNNdgIp5gEZxCFX16NjXsSXtzimT2AqP9s4DUPnRU=;
        b=hmLLa0iAOZfoB/jGrNMB3Gg/3clEtRSG3DAq+Bq7T5Xg5Mi//0VQ8Jiheozfl+554W
         zMufiXJBReL0LbMFP3hY1uQ+I32iv9s0KvU1mGyfAjWeXQvDZ8WFQMHb24rdKzEIH4jY
         GPzawy7WmqFJcjfb/y7yXuvimo3Rhj1qiMjXp72n6FO8COnt5hsGVmmLamJzLnLKgXPu
         ApXa4jP4YnVln0nf2vSkUZLdJVNvH+jURhEJqCszEDNOxDPrN9hDnTx6i85PWpT00Ptn
         L1VmMxaYFXkjYGZ3TIBG0L6gKD5nSCUYsW2GLdUL06xlv1ED7/Me/Lq45eAH5/4Blxwt
         aKPA==
X-Gm-Message-State: AOAM533s72WljpwaLq2TYunbmP4u3aHjBj24BQC1pQdJ67/pinMM0HjM
        7FJ80K/BVR9r5BCWNpES30G/5ocT+n6+/Ln6P34=
X-Google-Smtp-Source: ABdhPJz9uu3YAldIkZ25DwFl7GQTjr4Q/2qWdCJALV+nDYpRz3j+ggBoJDewGFe15ct9g6o4fvRHNE0l6dRRFxn2zpM=
X-Received: by 2002:ac8:41c6:: with SMTP id o6mr8114697qtm.292.1594786452616;
 Tue, 14 Jul 2020 21:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
 <1594717536-5188-4-git-send-email-shengjiu.wang@nxp.com> <20200714211432.GA10818@Asurada-Nvidia>
In-Reply-To: <20200714211432.GA10818@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 15 Jul 2020 12:14:01 +0800
Message-ID: <CAA+D8ANQ_B9jJUhLYQnKxKJcVrmvakxPo58h433QqFhdu2nRPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl-asoc-card: Support Headphone and Microphone
 Jack detection
To:     Nicolin Chen <nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 5:16 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Shengjiu,
>
> The whole series looks good to me. Just a couple of small
> questions inline:
>
> On Tue, Jul 14, 2020 at 05:05:36PM +0800, Shengjiu Wang wrote:
> > Use asoc_simple_init_jack function from simple card to implement
> > the Headphone and Microphone detection.
> > Register notifier to disable Speaker when Headphone is plugged in
> > and enable Speaker when Headphone is unplugged.
> > Register notifier to disable Digital Microphone when Analog Microphone
> > is plugged in and enable DMIC when Analog Microphone is unplugged.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/Kconfig         |  1 +
> >  sound/soc/fsl/fsl-asoc-card.c | 69 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 68 insertions(+), 2 deletions(-)
>
> >  static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
> >  {
> >       struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
> > @@ -745,8 +789,29 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >       snd_soc_card_set_drvdata(&priv->card, priv);
> >
> >       ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
> > -     if (ret && ret != -EPROBE_DEFER)
> > -             dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> > +     if (ret) {
> > +             if (ret != -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
>
> I think we may move this EPROBE_DEFER to the asrc_fail label.

If we move this to asrc_fail label, then it will be hard to define the
error message.
There are many places that goto asrc_fail.

>
> > +             goto asrc_fail;
> > +     }
> > +
> > +     if (of_property_read_bool(np, "hp-det-gpio")) {
>
> Could we move this check inside asoc_simple_init_jack? There's no
> problem with doing it here though, yet I got a bit confused by it
> as I thought it's a boolean type property, which would be against
> the DT bindings until I saw asoc_simple_init_jack() uses the same
> string to get the GPIO. Just it probably would be a bit tricky as
> we need it to be optional here.
>
> Otherwise, I think we may add a line of comments to indicate that
> the API would use the same string to get the GPIO.

In asoc_simple_init_jack, gpio_is_valid() will be invalid when there is
no "hp-det-gpio" property, and asoc_simple_init_jack will return 0.

The reason why I add a check here is mostly for
snd_soc_jack_notifier_register().
when there is no jack created, there will be a kernel dump.

or I can use this code:

-       if (of_property_read_bool(np, "hp-det-gpio")) {
-               ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
-                                           1, NULL, "Headphone Jack");
-               if (ret)
-                       goto asrc_fail;
+       ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
+                                   1, NULL, "Headphone Jack");
+       if (ret)
+               goto asrc_fail;

+       if (priv->hp_jack.jack.jack)
                snd_soc_jack_notifier_register(&priv->hp_jack.jack,
&hp_jack_nb);
-       }

what do you think?

best regards
wang shengjiu
