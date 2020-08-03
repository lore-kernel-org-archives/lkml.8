Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D8F206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEdiU72r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgHCB2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHCB2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 21:28:13 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFDC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 18:28:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so27175780qtg.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdPTwt6GzaEE8ypkWcyEAGla3ExjJ1L9xlPLjdJjECo=;
        b=fEdiU72rgYUFv9VxZJS1kvdK2VZZ3oV8HbXncHDDjA5BQ65BZMi8GwdFhXl1Ye4PpZ
         bI1ijchagYxkSM4OfR2b6qC7gI4oNsmp9TcwMT80BR6lleR9ee9i7WFxeCVdvfuvSqLu
         UHltGgZaXzD77Vy6L32svJpXEJvmaB0fTCbw4JubQ2ny2imbJtgqROPHQyU2A7xfvrxs
         6n780V50p67eQizGGpyIKfBpqyIVN9iNtvGYaML06s2jMGegknEJIFwJkCfoSABhJba+
         +0zBty3ts1Q/agn7DV2tT6YXAfZFPp8/5OX+J35KOQdo+w55Gr6sS5hy+RTcU9Pacz82
         1f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdPTwt6GzaEE8ypkWcyEAGla3ExjJ1L9xlPLjdJjECo=;
        b=g6YftySs6T8SG8+eGPr2RMiiLXgSglNyrRxk2Jy22O+DPYNC38aqham3OzF/344a+G
         s9H0IlMLJupEP2B3WwgGydBzPULMosxtg0jh4B0lQFQX0YHGaaP8k48D9mVIx9PLwOGc
         Tr3VjgGo11T3OHqsCgKykC/GJjPhms+E8+kxu+LI46QHHAhXwlAkwWey2ywbChfw02Xf
         2F+0BGP7sZqahU4dOfmpHSqjSVMCbestKXLtQQUHNuvcRCoEUeLvLS1nv6eQh/crZ9lQ
         EFwRpKkunypnirZpiWWI+RUSfkzLNgK4WYy8c3YfOtJZs00GMSQTf9A23wQjPb/T07i3
         wXew==
X-Gm-Message-State: AOAM532Gu1cjT6XvGpTnpGIVlzm6gHEOrsJyEW0zLqs3qbv59Gh4c24h
        EphXp+zYtO/yJB3RVxDJGZ+mEi/GVtbrZfp0k24=
X-Google-Smtp-Source: ABdhPJwocfcyQPliB369D5sk19qV1NbUk9jBsxi7F2QFFlJFuMT6+0u0s+7ZI7bqi/ttnQcjQ9O5aO+qWGK5SbuojF0=
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr14208849qtt.121.1596418092106;
 Sun, 02 Aug 2020 18:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com>
 <20200801075954.GA19629@Asurada-Nvidia> <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
 <20200802064351.GA24213@Asurada-Nvidia>
In-Reply-To: <20200802064351.GA24213@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 3 Aug 2020 09:28:01 +0800
Message-ID: <CAA+D8APexk_-o91B=u1bthVxXr_+gUL9Yq4UA5zscLfP3Xsa6Q@mail.gmail.com>
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

On Sun, Aug 2, 2020 at 2:44 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Aug 02, 2020 at 10:22:35AM +0800, Shengjiu Wang wrote:
>
> > > > +     /* Specific configuration for PLL */
> > > > +     if (codec_priv->pll_id && codec_priv->fll_id) {
> > > > +             if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
> > > > +                     pll_out = priv->sample_rate * 384;
> > > > +             else
> > > > +                     pll_out = priv->sample_rate * 256;
> > > > +
> > > > +             ret = snd_soc_dai_set_pll(asoc_rtd_to_codec(rtd, 0),
> > > > +                                       codec_priv->pll_id,
> > > > +                                       codec_priv->mclk_id,
> > > > +                                       codec_priv->mclk_freq, pll_out);
> > > > +             if (ret) {
> > > > +                     dev_err(dev, "failed to start FLL: %d\n", ret);
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > > +             ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
> > > > +                                          codec_priv->fll_id,
> > > > +                                          pll_out, SND_SOC_CLOCK_IN);
> > >
> > > Just came into my mind: do we need some protection here to prevent
> > > PLL/SYSCLK reconfiguration if TX/RX end up with different values?
> > >
> > Sorry,  not really catching your point. could you please elaborate?
> > Why do TX/RX end up with different values?
>
> If TX and RX run concurrently but in different sample rates or
> sample formats, pll_out would be overwritten to PLL/SYSCLK?
>
> I remember imx-wm8962 uses SSI, having symmetric flags for rates/
> channels/samplebits, but fsl-asoc-card might have (or will have)
> other use case.
>
> If all existing combinations don't have any problem, we can add
> a protection later when we need.

Good point. Current cases should be ok, as the boards with
wm8960 and wm8962 are all designed as synchronous mode.

Agree to add protection when needed in the future.

I will fix the nits and send v3.

best regards
wang shengjiu
