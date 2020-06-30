Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C072A20722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/Y2LEm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgF3Fb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgF3Fb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:31:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90150C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:31:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v19so14670500qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQ4+/e636DjU53ZutFkneDCxV7N9AiA63WewmD4xQRo=;
        b=H/Y2LEm0lur0oZA8cMF+qOfMdmDEufwHt8gopg4rg6MJFdWZkdZjG5EJjRH3nfkJDF
         DKMJqCadNNnqvKBtaN3rHZkQVyKtfXSz4U90upgH1YbAExNl/mdq46fT9HMq7Wd9JQjY
         0kx7V1ODrnNe93ASuiXATDjIk8RNPyGXqBDgrrEwUKHITq9bmkpjSfcpBWjJi6o7mR8L
         MFMgZGfxkogIeoUm2AsGug0PM1LeGfBhG4P9xC3agZ0WkGRyLxJiPRPKjl4nIW5pjQSM
         M4+K92DwUmXuiwAOKUFqO0Vf1wnCac1Gynjv5OLh30l+ftlAydyu9xSZj5WJGqxFcfXS
         o46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQ4+/e636DjU53ZutFkneDCxV7N9AiA63WewmD4xQRo=;
        b=ZDdqQ+9Ufjg76IsZW35oiHSPae+U8YOHiObeE+W4/V+jt4Q3WsP0Hkc8PsGOFOkO7z
         Ptx8VA/CcPkEgMXhf/WWpdUylOo9AChTtEUHjuB1SMzcLrGNf1CFV+mqIyU/bjVFo0zm
         rH4CX9oGLs08HsNJkBvHeE5SdwToDuR1xRPrpbsfSGYSWfoIZ8GgKAw3s3/EPafN3Ae9
         huiFAyKXj5KZbfsNoVNC6kUPcafc/sivaLOtYakbJuO+E9EwEppJ7fHXZjnHXYrfmN63
         GtTS7gE/m0/HTFmMNK5Oshoune+YnNnQ3HiyU4Iyyh9w141ZkLrYZw4w+2x4Blc2y+JJ
         Jd7w==
X-Gm-Message-State: AOAM533Ur/ppYCVG7vUqSgUFckkl1uBmBI+pLTH6XPQB6ON+vhQusbJ4
        OIQyfFbtrf2lbgqjgl/PXXE2oGu5TvgJ6oBqkQU=
X-Google-Smtp-Source: ABdhPJw/wlWIPyYhzzU13zpDaxH5qYo/b+CmHKJa4nXgPZmta/pNIYYI8YVXbPlxwfzKQtXmUfA37/tLflAUu6/Nsac=
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr19287396qtb.204.1593495086854;
 Mon, 29 Jun 2020 22:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com> <20200629200813.GB27967@Asurada-Nvidia>
In-Reply-To: <20200629200813.GB27967@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 30 Jun 2020 13:31:15 +0800
Message-ID: <CAA+D8APOd2MxO08nnK9UE03bMj25fyMfMnF-neBzdyoykbjAKA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add an option to select internal ratio mode
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

On Tue, Jun 30, 2020 at 4:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jun 29, 2020 at 09:58:35PM +0800, Shengjiu Wang wrote:
> > The ASRC not only supports ideal ratio mode, but also supports
> > internal ratio mode.
> >
> > For internal rato mode, the rate of clock source should be divided
> > with no remainder by sample rate, otherwise there is sound
> > distortion.
> >
> > Add function fsl_asrc_select_clk() to find proper clock source for
> > internal ratio mode, if the clock source is available then internal
> > ratio mode will be selected.
> >
> > With change, the ideal ratio mode is not the only option for user.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
>
> > +static int fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
> > +                            struct fsl_asrc_pair *pair,
> > +                            int in_rate,
> > +                            int out_rate)
> > +{
> > +     struct fsl_asrc_pair_priv *pair_priv = pair->private;
> > +     struct asrc_config *config = pair_priv->config;
> > +     int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> > +     int clk_rate, clk_index;
> > +     int i = 0, j = 0;
> > +     bool clk_sel[2];
> > +
> > +     rate[0] = in_rate;
> > +     rate[1] = out_rate;
> > +
> > +     /* Select proper clock source for internal ratio mode */
> > +     for (j = 0; j < 2; j++) {
> > +             for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> > +                     clk_index = asrc_priv->clk_map[j][i];
> > +                     clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
>
> +                       /* Only match a perfect clock source with no remainder */
>
> > +                     if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> > +                         (clk_rate % rate[j]) == 0)
> > +                             break;
> > +             }
> > +
> > +             if (i == ASRC_CLK_MAP_LEN) {
> > +                     select_clk[j] = OUTCLK_ASRCK1_CLK;
> > +                     clk_sel[j] = false;
> > +             } else {
> > +                     select_clk[j] = i;
> > +                     clk_sel[j] = true;
> > +             }
> > +     }
> > +
> > +     /* Switch to ideal ratio mode if there is no proper clock source */
> > +     if (!clk_sel[IN] || !clk_sel[OUT])
> > +             select_clk[IN] = INCLK_NONE;
>
> Could get rid of clk_set:
>
>         for (j) {
>                 for (i) {
>                         if (match)
>                                 break;
>                 }
>
>                 clk[j] = i;
>         }
>
>         if (clk[IN] == ASRC_CLK_MAP_LEN || clk[OUT] == ASRC_CLK_MAP_LEN)
>
> And it only overrides clk[IN] setting but leaving clk[OUT] to
> to the searching result. This means that clk[OUT] may be using
> a clock source other than OUTCLK_ASRCK1_CLK if sel[IN] happens
> to be false while sel[OUT] happens to be true. Not sure if it
> is intended...but I feel it would probably be safer to use the
> previous settings: INCLK_NONE + OUTCLK_ASRCK1_CLK?

ok, will update the patch.

best regards
wang shengjiu
