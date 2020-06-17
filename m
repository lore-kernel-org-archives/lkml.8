Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D2620663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftQAHhnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFQDcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgFQDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:32:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E598C061573;
        Tue, 16 Jun 2020 20:32:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so480883qte.10;
        Tue, 16 Jun 2020 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzA+ElcDbnifqfzX8lfOg2mPfYscDQJ4/Xb5PE+7lMg=;
        b=ftQAHhnW0hzD4YpGdWc0LllO2OMD/jfP3C4MQqdKOT5C7eeHNFuf4K+O4toru/tGfa
         M0ivB23w/gyeywiGVuCZ3kCavIsEUJxW2YyS/g0DOG4+iW+DvSMZLCj5gblEB0Co3h93
         O5KmfqxvIQC+AZFf7dtDsayhkTtx4Gjtpik3xLJbdQ47I/AO2eQqNDg04oYiDPxo4zF5
         wvphcCLw4AsFpffOfDBt2aD5MeJ8v8EDC6Zz/XhkBL3rvmf7ktHDmE4tH4D8JkXS6fU2
         qvJz80e1pU8aBXdOeY3q4NtoHG9yuQorBt2J57jYGQumcjXumzorN4FSkwDG8AlEhqBC
         2MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzA+ElcDbnifqfzX8lfOg2mPfYscDQJ4/Xb5PE+7lMg=;
        b=K3rZp7D3oF961/5OqbgD8F0vDibU7jpB3uGmtQdhcAhY7ouewyKdkGBnomrgv1YN7B
         fLIJHSGeYGeae42dy7WIDJQEUHp7lCdfnDNis6BNNdbal50w8vHTS09f/aP7igPzSb56
         9GffNYALEf6JXv/Pkq0bJv8GnrexbPrNPlqupQtM5xiEJM0y2rnxbr/mbDiIKJn+kNIV
         8x2kxB8UoyZm09IH4PX48ZcDOqlox+Uz1XBVJuzWV6uZ/MO3tB7HA/RhkK8sq0aLg7iZ
         rd+23ArQk+NxqirUTYpRzbJmAIQ+2Y8nAlMQvsrcMMzNmma3IIU5ixl60EOTyqvDlbLG
         1zGA==
X-Gm-Message-State: AOAM5314bcfIY4f8CWaF/UwPxVKWc2e/c5T/ZyWAXDyaFTydLkKCC9qe
        xtzsu8gXUzKPg18X5veiZEihK9kUQMxZv2T9z1U=
X-Google-Smtp-Source: ABdhPJyDsNi9Q52RPZTC9rfPswpXtaMmRaUOjgRU4MMGl6dorrqU82mtSiCqR9s3ZZfHZZvEgOKG74qt9+Wv16UivMo=
X-Received: by 2002:ac8:f47:: with SMTP id l7mr24311236qtk.292.1592364729462;
 Tue, 16 Jun 2020 20:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <1592292637-25734-1-git-send-email-shengjiu.wang@nxp.com>
 <1592292637-25734-2-git-send-email-shengjiu.wang@nxp.com> <20200617004845.GB19896@Asurada-Nvidia>
In-Reply-To: <20200617004845.GB19896@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 17 Jun 2020 11:31:58 +0800
Message-ID: <CAA+D8AN_Djr_OTXBWJbymtUY7pjTV_VKKiqwRBqQ8cxo4USgCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl-asoc-card: Add MQS support
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

On Wed, Jun 17, 2020 at 8:50 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Jun 16, 2020 at 03:30:37PM +0800, Shengjiu Wang wrote:
> > The MQS codec isn't an i2c device, so add a new platform device for it.
> >
> > MQS only support playback, so add a new audio map.
> >
> > Add there maybe "model" property or no "audio-routing" property insertions
>
> "Add" => "And"
>
> > devicetree, so add some enhancement for these two property.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl-asoc-card.c | 70 ++++++++++++++++++++++++++---------
> >  1 file changed, 52 insertions(+), 18 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> > index 00be73900888..2ac8cb9ddd10 100644
> > --- a/sound/soc/fsl/fsl-asoc-card.c
> > +++ b/sound/soc/fsl/fsl-asoc-card.c
>
> > @@ -482,6 +489,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >  {
> >       struct device_node *cpu_np, *codec_np, *asrc_np;
> >       struct device_node *np = pdev->dev.of_node;
> > +     struct platform_device *codec_pdev = NULL; /* used for non i2c device*/
>
> Having both codec_pdev and codec_dev duplicates things. Actually
> only a couple of places really need "codec_dev" -- most of them
> need codec_dev->dev pointer instead. So we could have a cleanup:
>
> -       struct i2c_client *codec_dev;
> +       struct device *codec_dev = NULL;
>
> > @@ -512,10 +520,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >       }
> >
> >       codec_np = of_parse_phandle(np, "audio-codec", 0);
> > -     if (codec_np)
> > +     if (codec_np) {
> >               codec_dev = of_find_i2c_device_by_node(codec_np);
> > -     else
> > +             if (!codec_dev)
> > +                     codec_pdev = of_find_device_by_node(codec_np);
> > +     } else {
> >               codec_dev = NULL;
> > +     }
>
> Here can have something like (feel free to simplify):
>
>         if (codec_np) {
>                 struct platform_device *codec_pdev;
>                 struct i2c_client *codec_i2c;
>
>                 codec_i2c = of_find_i2c_device_by_node(codec_np);
>                 if (codec_i2c)
>                         codec_dev = &codec_i2c->dev;
>
>                 if (!codec_dev) {
>                         codec_pdev = of_find_device_by_node(codec_np);
>                         codec_dev = &codec_pdev->dev;
>                 }
>         }
> >       asrc_np = of_parse_phandle(np, "audio-asrc", 0);
> >       if (asrc_np)
> > @@ -525,6 +536,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >       if (codec_dev) {
> >               struct clk *codec_clk = clk_get(&codec_dev->dev, NULL);
>
> Then here:
>
> -               struct clk *codec_clk = clk_get(&codec_dev->dev, NULL);
> +               struct clk *codec_clk = clk_get(codec_dev, NULL);
>
> > @@ -538,6 +556,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >       /* Assign a default DAI format, and allow each card to overwrite it */
> >       priv->dai_fmt = DAI_FMT_BASE;
> >
> > +     memcpy(priv->dai_link, fsl_asoc_card_dai,
> > +            sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
>
> > @@ -573,13 +596,25 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >               codec_dai_name = "ac97-hifi";
> >               priv->card.set_bias_level = NULL;
> >               priv->dai_fmt = SND_SOC_DAIFMT_AC97;
> > +             priv->card.dapm_routes = audio_map_ac97;
> > +             priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_ac97);
> > +     } else if (of_device_is_compatible(np, "fsl,imx-audio-mqs")) {
> > +             codec_dai_name = "fsl-mqs-dai";
> > +             priv->card.set_bias_level = NULL;
> > +             priv->dai_fmt = SND_SOC_DAIFMT_LEFT_J |
> > +                             SND_SOC_DAIFMT_CBS_CFS |
> > +                             SND_SOC_DAIFMT_NB_NF;
> > +             priv->dai_link[1].dpcm_playback = 1;
> > +             priv->dai_link[2].dpcm_playback = 1;
>
> dpcm_playback = 1? That's the default value in fsl_asoc_card_dai.

ah,  should be dpcm_capture = 0.

>
> > @@ -601,19 +636,18 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >               priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
> >       }
> >
> > -     snprintf(priv->name, sizeof(priv->name), "%s-audio",
> > -              fsl_asoc_card_is_ac97(priv) ? "ac97" :
> > -              codec_dev->name);
> > -
> >       /* Initialize sound card */
> >       priv->pdev = pdev;
> >       priv->card.dev = &pdev->dev;
> > -     priv->card.name = priv->name;
> > +     ret = snd_soc_of_parse_card_name(&priv->card, "model");
> > +     if (ret) {
> > +             snprintf(priv->name, sizeof(priv->name), "%s-audio",
> > +                      fsl_asoc_card_is_ac97(priv) ? "ac97" :
> > +                      (codec_dev ? codec_dev->name : codec_pdev->name));
>
> We can just use dev_name() if codec_dev is struct device *
> Or having a codec_dev_name to cache codec_pdev/i2c->name.
>
> > -     ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
> > -             goto asrc_fail;
> > +     if (of_property_read_bool(np, "audio-routing")) {
> > +             ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
> > +                     goto asrc_fail;
>
> Hmm...audio-routing is a required property in DT binding doc.
> So you might need to update that too.

will update them in v2.

best regards
wang shengjiu
