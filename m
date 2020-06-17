Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E4C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odqwFLWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQGr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQGr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:47:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1846C061573;
        Tue, 16 Jun 2020 23:47:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 205so1085589qkg.3;
        Tue, 16 Jun 2020 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEOcBwuJujk3Z3FbvmUIja3o6yp5Y5I7OHP6v1ayOdc=;
        b=odqwFLWOfz6VFUZ/AEzD/ygRf/c/++SDJbNN/nwQZkGYj3C6pFFoLlEjFCrjxZnWnZ
         /AXyjECC4SETvu2arNrXc95u4TnzXHHqyDF/78eOtDBo6dibwL8+9lRcggEsnlwVQylQ
         Q6I9RWdTF9CTRakRQnCWZ15SP/vM1mxe7/0K8Ox0WcMFOZtvH87w9Kq6KK9S8dN6tZgz
         scyATY9N9Cqf2C8Yjyt4ZoRiMfOrA3xAq6nE7/EB69NaaPNXIztJjRQI5LyEp/Vgc1tS
         it112IuMOvThGIVcZT1bvRazXFl1FSC3dkTQaQZZAoFopsPy+ebRoNsXOxsCSPGsWH32
         17rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEOcBwuJujk3Z3FbvmUIja3o6yp5Y5I7OHP6v1ayOdc=;
        b=rAk4tN47y81vFs1Hp4BV7OIokEiV9FUjQ2RUWnNtxcvT0YVoelI60wpreEl5MHY35Q
         3pg05mblJfg0bfRoHbRawXR4t3XN8+mFC5DYipQFJAfHaxrkBKU+Wpz4FtDgK2AJ0MBQ
         WKiXlZ77qQXtMgXKJFP4z9d2IsRib0oT3cmxWQ4jIimyeo0r/Bu0Ucm25rq2T4pmxYGa
         g7kh77SsZrDLsMFef4mRyvT7hLKa69xxYvsjTJ9Ggldr7vNQxMeouJW++yTVN0qcAMzD
         nprVCnddSM8wlT589Z0aIvih6BDP4OubFOulikBWeUWhO3TvSmC+qCT2zy/v9mNkQ4M5
         EbPQ==
X-Gm-Message-State: AOAM533sP/PdbmkJUF41agggBm+K4bbHeGtjz3LsZ6UezfferN4Hrfs7
        9LEP+7iwXK3USa2CtFsd87eKam4KvhhEMh52J7o=
X-Google-Smtp-Source: ABdhPJyNV3aHDegvpKj24F79ISjdEF6CE/prSki/wKRdyu+fjUIjtIU5SobzxF++F/MAqTGJ6CjQl08XmDfeZGFvGf8=
X-Received: by 2002:a37:8a43:: with SMTP id m64mr23295848qkd.37.1592376473937;
 Tue, 16 Jun 2020 23:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
 <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
 <20200617062457.GA6411@Asurada-Nvidia>
In-Reply-To: <20200617062457.GA6411@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 17 Jun 2020 14:47:43 +0800
Message-ID: <CAA+D8AOBA2pM0CXpdEO7NS1fdK8Nv=4gRDQ384v6mV9ip6Ke2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
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

On Wed, Jun 17, 2020 at 2:27 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 12:30:17PM +0800, Shengjiu Wang wrote:
> > The one difference on imx6sx platform is that the root clock
> > is shared with ASRC module, so we add a new flags
> > "shared_root_clock" which means the root clock is independent,
>
> "shared" means "not independent", against "independent" ;)
>
> > then we will not do the clk_set_rate and clk_round_rate to avoid
> > impact ASRC module usage.
> >
> > As add a new flags, we include the soc specific data struct.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Can add this once fixing the remaining comments:
>
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> > +static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif,
> > +                                           int clk)
>
> Can actually merge into single line as kernel has 100-character
> limit now, though 80-char is still preferable for a good coding
> style. But I think this one wouldn't be too bad at all.
>
> > @@ -421,7 +456,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
> >       sysclk_df = spdif_priv->sysclk_df[rate];
> >
> >       /* Don't mess up the clocks from other modules */
>
> We can drop this comments now as it's out-of-date and the name of
> the new helper function is straightforward enough.
>

ok, will send v3.

best regards
wang shengjiu
