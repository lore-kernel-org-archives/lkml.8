Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A6420885
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 06:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVwzdDzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgHBGoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHBGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 02:44:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B30C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 23:44:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so19240194pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2aoqAI7ZyUC5Rm/QGa/RZ2mj9QoixqrEf8FBg4wiIE=;
        b=NVwzdDzrwGuTsH/vRGeNQFdLRqkgojk4/9Jlwet5zvG3h2zgFl7ZbxGfHRg8wffHUV
         1a/LFn1ZW7JNnr8JoVOER9hf2rBtohqBMf8T6rO54OBH+FuZOrRXdtqfQvvN0WPJ1W5k
         Q3ouXMqZXP7rj9EkRoqITzgshE5MVGBVCcl21FdPO4zv5GMcYT+AqefwIS03y+4sabBG
         u8MBuDWOZ6IoFpbrYGAQN9NyDt0kipob/5m0LYS2Nn5n+AMRR6tqwuWoauLGMtweZa5a
         30eeof/z+kPgHfve/tQG/b1IwEPqGVu6hzjIGyw67PY5Dex6SiMMHxTwzthlayu1G/A5
         MZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2aoqAI7ZyUC5Rm/QGa/RZ2mj9QoixqrEf8FBg4wiIE=;
        b=bMOvW1/BL1PUlGyqUyxnbt2Vl49Le6znD62/azw0+WU7YwfKUE9/kEOmPEzCLgf5ZT
         yco7H53NaUSXjP0V8fuSWOEabHwDOYqCHuir0+Y+vcZWEUu/3cWmETBdZxX9E3ew96tf
         tgWMLPU35V0WB15yIZxzPyAUAWJUbxf/iVXGhTs2nkTdlGhDPtMvfQ+AF/K5EiYLf83D
         5JgLQgBPozR5jGAYecnUip102qtIrsceXwQ6EK3Urkx9WpssVu+us9UPoyXP4VX4CAXf
         t2m/si2MB14okFIoazaDfKUPaYCABvqMl1N6DWgf4oDyjm//+hoWTial8TB02bXqHF97
         llmw==
X-Gm-Message-State: AOAM532LmSKeAlqs7wQmEnQKFqJpPvgbXRUw8S4ZHoLsv7TDauvugrBP
        ZCRfnsK63N1vnPIVG5jbTyBLyW+X7hI=
X-Google-Smtp-Source: ABdhPJzT67tILFTVcT+5Nq4nLiq/ChOlKvzNLIZhqH09UIVzSNlqRhHDagQVesDQEPfSG0+9p5y7aQ==
X-Received: by 2002:a17:90a:6285:: with SMTP id d5mr11743122pjj.85.1596350642900;
        Sat, 01 Aug 2020 23:44:02 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f18sm15347558pgv.84.2020.08.01.23.44.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Aug 2020 23:44:02 -0700 (PDT)
Date:   Sat, 1 Aug 2020 23:43:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Remove
 fsl_asoc_card_set_bias_level function
Message-ID: <20200802064351.GA24213@Asurada-Nvidia>
References: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com>
 <20200801075954.GA19629@Asurada-Nvidia>
 <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AMM90bt_WbPCny6C=R=dv6gXXh49p59yng2vH7DDuD2PQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 10:22:35AM +0800, Shengjiu Wang wrote:

> > > +     /* Specific configuration for PLL */
> > > +     if (codec_priv->pll_id && codec_priv->fll_id) {
> > > +             if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
> > > +                     pll_out = priv->sample_rate * 384;
> > > +             else
> > > +                     pll_out = priv->sample_rate * 256;
> > > +
> > > +             ret = snd_soc_dai_set_pll(asoc_rtd_to_codec(rtd, 0),
> > > +                                       codec_priv->pll_id,
> > > +                                       codec_priv->mclk_id,
> > > +                                       codec_priv->mclk_freq, pll_out);
> > > +             if (ret) {
> > > +                     dev_err(dev, "failed to start FLL: %d\n", ret);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
> > > +                                          codec_priv->fll_id,
> > > +                                          pll_out, SND_SOC_CLOCK_IN);
> >
> > Just came into my mind: do we need some protection here to prevent
> > PLL/SYSCLK reconfiguration if TX/RX end up with different values?
> >
> Sorry,  not really catching your point. could you please elaborate?
> Why do TX/RX end up with different values?

If TX and RX run concurrently but in different sample rates or
sample formats, pll_out would be overwritten to PLL/SYSCLK?

I remember imx-wm8962 uses SSI, having symmetric flags for rates/
channels/samplebits, but fsl-asoc-card might have (or will have)
other use case.

If all existing combinations don't have any problem, we can add
a protection later when we need.
