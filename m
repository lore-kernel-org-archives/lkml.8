Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 02:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAF22072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 02:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT+DUHoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHBCWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 22:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBCWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 22:22:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBDAC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 19:22:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so25929227qtg.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 19:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whOvptctYszI0TUoSb9wHwW4EucWmLnWHPSIiYGN8Wg=;
        b=GT+DUHoLyEtK/qt+Sl6m8Mf+/U/Q8YGwJbZQspRR/1cq9u8FUPWTRWwLNmCNY3JUxP
         1qy9NrIWokY2Vnh7eWIHVvWNN5jtyeXj1JPKyU8nDJI/CCYA68tNtCURbY1tL7UPSc22
         3yQnM1wHR4Oe1023lD3cRY5PbLwT8Y8bxZbGaQSMrfZFWR5vI1is0il6HOs5wNN5daUe
         vO1Qsh5a4CntBIYA5kpBv+7RBsOsRwopAO37ClYQyoNZsx5K78yetewKgHCZehgNRd1k
         ZXThfFVMGKnTMdCRlnBGkrkWCfpcbnow50sw+sjZSScZkiOLCNWLhMd53Pxwj9zNvb52
         idag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whOvptctYszI0TUoSb9wHwW4EucWmLnWHPSIiYGN8Wg=;
        b=V+dKc8/FMEVMvanNSzrOqCSMogpkQBEwnvHTrjIKK+EWkgzxdcY+V+SpK3k6E+gvrJ
         WhpAwD4i+7KMzGZN7zaQXMtltE5rWdKoZCuVdcJAnrbKKgruzOwiTlBdYVuPrGTXG9uV
         IpF+Nr1AQsZ7Ca6wDLEr62b4KzTPbEsgTurPs/18aTHCw6xJg+tXdAl2rho/+yTLw3nh
         yLghUl+FzuyDzvThEZQXxxqdfe+yxEqp2R3pww3q4vDqxCsb6/8wcKRUQbBOXqk68jPG
         aIiEj54WjENeKffPgNiSI+stQLa7GJm5ctYkdr7dzbpQsJ23Nj8v1LYEruvqGzBgPOlw
         TUEg==
X-Gm-Message-State: AOAM532jSbkwueKt6Z3e/Ntf+mYvz2jkwYwkEBMGaEeaO1wquZ/Bgw99
        hFeNY3CiTn1ap0jbTiX87jRqXvtWwx13CiHDOLJ/6SJR
X-Google-Smtp-Source: ABdhPJx+oNY0MJ6Pd5AOYnXI12LGvR++U9v1s05zQk6gTj0oayzG0KE5Co6SYk/c4xn465qVOihcKPEWfsGkyGTJ6ws=
X-Received: by 2002:ac8:450c:: with SMTP id q12mr10542733qtn.292.1596334966873;
 Sat, 01 Aug 2020 19:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com> <20200801075954.GA19629@Asurada-Nvidia>
In-Reply-To: <20200801075954.GA19629@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 2 Aug 2020 10:22:35 +0800
Message-ID: <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level
 function
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 4:01 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi,
>
> Having two nits and one question, inline:
>
> On Thu, Jul 30, 2020 at 05:47:02PM +0800, Shengjiu Wang wrote:
> > @@ -182,6 +180,69 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
> >                                              cpu_priv->slot_width);
> >               if (ret && ret != -ENOTSUPP) {
> >                       dev_err(dev, "failed to set TDM slot for cpu dai\n");
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     /* Specific configuration for PLL */
> > +     if (codec_priv->pll_id && codec_priv->fll_id) {
> > +             if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
> > +                     pll_out = priv->sample_rate * 384;
> > +             else
> > +                     pll_out = priv->sample_rate * 256;
> > +
> > +             ret = snd_soc_dai_set_pll(asoc_rtd_to_codec(rtd, 0),
> > +                                       codec_priv->pll_id,
> > +                                       codec_priv->mclk_id,
> > +                                       codec_priv->mclk_freq, pll_out);
> > +             if (ret) {
> > +                     dev_err(dev, "failed to start FLL: %d\n", ret);
> > +                     goto out;
> > +             }
> > +
> > +             ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
> > +                                          codec_priv->fll_id,
> > +                                          pll_out, SND_SOC_CLOCK_IN);
>
> Just came into my mind: do we need some protection here to prevent
> PLL/SYSCLK reconfiguration if TX/RX end up with different values?
>
Sorry,  not really catching your point. could you please elaborate?
Why do TX/RX end up with different values?

best regards
wang shengiu
> > +     return 0;
> > +
> > +out:
> > +     priv->streams &= ~BIT(substream->stream);
> > +     return ret;
>
> Rather than "out:" which doesn't explicitly indicate an error-out,
> "fail:" would be better, following what we used in probe().
>
> > +static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +     struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> > +     struct codec_priv *codec_priv = &priv->codec_priv;
> > +     struct device *dev = rtd->card->dev;
> > +     int ret;
> > +
> > +     priv->streams &= ~BIT(substream->stream);
> > +
>
> > +     if (!priv->streams && codec_priv->pll_id &&
> > +         codec_priv->fll_id) {
>
> This now can fit into single line :)
