Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89858C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EF220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw1t7clZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgGTKe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:34:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC98C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:34:22 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p7so7108660qvl.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKpYBbrlnZWFZ3b9/7gPTVvr7uUXN2uw4/yc1h13XyM=;
        b=Xw1t7clZzNAezWxkwn6uMU0INMdckgeJj/r5KWBOP378438MNB0l3z/9VRnhE1E2qq
         tzaKFj3rmwyD2Dwft0ESb1tjUlGoovmduHcJ7jGDN9fkY3X16C+hN7+RLDZfc+U0J3rM
         NRcFsn8ALuGmUfT8cYHONuBWuepXrWm08QgmHEouegAHcD6fBjt9YVpUxT4Xo1QoU0Up
         0m58/28f30BkP/vYkU8yKlITL5F0hl5xLUmGofmKs8boxHsL79OMmW7VPvOEzddgO+DV
         FyIcM86Z/mI1/iMd7f8YtgiF1TMy0AWxj5Mbb/YW0hDh1F6cOjktTPPke8SzVaG3tL3x
         43nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKpYBbrlnZWFZ3b9/7gPTVvr7uUXN2uw4/yc1h13XyM=;
        b=LBJ9XRH7ik6/kH7pVwOdsDxHEipEu+GBPLl9B+q7UXZCTdfeEnlKJ+vNzMtslu8N79
         QIApLPGYxUpW1v+ZdjtNWvDq7CAPbZE6kEdqH5KmblS3S+iwZ3yFQFr53EZbITwFwGFU
         21JBthcirv886EThJLxehWyZPsVNGE7iWaazpgOo3xV6QXDKUmUHIxOaxPzvLED9/WC8
         5jLEp7p4knEl390xqFP3wnSU4ZXduEqOmrVpazxqMLpnfDTg1J1n/0XEss3TivK6rN8I
         hQqqgFM9maH9zoxU56G8rp3SQ9iWxwVcCUHXk72V5iyq8oNXhC6AmKzQ1NGFxhIZuKUz
         q9dA==
X-Gm-Message-State: AOAM533CZ+d4tn62Nq7S10PmsmG1Cgky+hcwGaV2M5ViIL28EiQZ+I4O
        v3D54YgoPCPgDylWfpuoYHpXUVOgHGcjn91R7To=
X-Google-Smtp-Source: ABdhPJycw37x1nzlr7P53atdMWdi6e2oUYQ8kUhWmklSym5hek24o6IxjZ9bBdyZEH+X8XPvUZykq3x46DwKcA8caag=
X-Received: by 2002:a0c:eac1:: with SMTP id y1mr20806707qvp.32.1595241261541;
 Mon, 20 Jul 2020 03:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200716232000.GA27246@Asurada-Nvidia> <20200717103857.31877-1-arnaud.ferraris@collabora.com>
 <20200717103857.31877-2-arnaud.ferraris@collabora.com>
In-Reply-To: <20200717103857.31877-2-arnaud.ferraris@collabora.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 20 Jul 2020 18:34:10 +0800
Message-ID: <CAA+D8AM9S6UThwyM2vWcXBzysY+3EgnzxToyk4kQ4e9rs3ch1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ASoC: fsl_asrc: make sure the input and output
 clocks are different
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 6:40 PM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:
>
> The current clock selection algorithm might select the same clock for
> both input and output when, for instance, the output sample rate is a
> multiple of the input rate.
>
> In that case, both selectable clocks will be multiples of both the input
> and output sample rates, and therefore the first of these clocks will be
> selected for both input and output, leading to miscalculation of the
> dividers for either the input or output side.
>
> Example:
>   Input uses clock A (512kHz) and has a sample rate of 8kHz
>   Output uses clock B (1024kHz) and has a sample rate of 16kHz
>
>   In this case, the algorithm will select clock A for both input and
>   output: the input divider will therefore be calculated properly
>   (512 / 8 => 64), but the output divider's value will be only half
>   the expected value (512 / 16 => 32 instead of 1024 / 16 => 64).
>
(input divider, output divider) = (64, 32) for the same clock source
(512kHz) looks no problem.  could you explain more detail why
(64, 32) can't work?


> This patch makes sure it always selects distinct input and output
> clocks.

There should be no such constraint for this IP, do you have any
evidence for we should use distinct input and output clocks?

>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 02c81d2e34ad..de10c208d3c8 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -608,8 +608,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  {
>         struct fsl_asrc_pair_priv *pair_priv = pair->private;
>         struct asrc_config *config = pair_priv->config;
> -       int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> -       int clk_rate, clk_index;
> +       int rate[2], select_clk[2], clk_index[2]; /* Array size 2 means IN and OUT */
> +       int clk_rate;
>         int i = 0, j = 0;
>
>         rate[IN] = in_rate;
> @@ -618,11 +618,15 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>         /* Select proper clock source for internal ratio mode */
>         for (j = 0; j < 2; j++) {
>                 for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> -                       clk_index = asrc_priv->clk_map[j][i];
> -                       clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
> -                       /* Only match a perfect clock source with no remainder */
> +                       clk_index[j] = asrc_priv->clk_map[j][i];
> +                       clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index[j]]);
> +                       /*
> +                        * Only match a perfect clock source with no remainder
> +                        * and make sure the input & output clocks are different
> +                        */
>                         if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> -                           (clk_rate % rate[j]) == 0)
> +                           (clk_rate % rate[j]) == 0 &&
> +                           (j == 0 || clk_index[j] != clk_index[j - 1]))
>                                 break;
>                 }
>
> --
> 2.27.0
>
