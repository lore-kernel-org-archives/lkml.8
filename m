Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B752C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5188E22CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/CYaZUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHGHSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:18:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:18:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so642726qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjBgjmOHw57678g0o5hgG5E9h3ORFUrabBo5u11RIkM=;
        b=a/CYaZUTnaXHYxqHoecfCwYEelSne77o/fgIVbDNgujdYRVXwWmuaYBlO1L60+Q7wi
         VAV9GzcIaEiwrsQqXgQ3CbqbZwpM7Rm67s3wC/vPd0V1vU10vpdIVlwFdQSGnXWT9iFL
         FrBz/EmG2SzhpE4MAtfAGijqdjnGgI7x9BkGB8b9wkvXFAs3sWZfS3cuNBWuUjeF144e
         WqmS/sjKnHERyHXHj1D4ub7NJFhZrZzLmQcpm9CfbG1MfC82t2ZP2lvZExDnEwQGDZ6T
         C7y9vnBi+pglIAzfJqty3goo1Mshzlovbmb77WUsXZEshGSm43rphjfMNd8HoqJuCBZC
         OelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjBgjmOHw57678g0o5hgG5E9h3ORFUrabBo5u11RIkM=;
        b=QzfOZHCnArVb9o+W7WNga75jPyx1lAArTunPxa13Kg4ogpOkhKcY2edw8wW5+LunGp
         ptSGXyx5MDVSAh94s3joE5Sb7CKXXlJZVyRBVIHwUbVuTlSg+N0aJH2eWkSrDfWsmKH1
         X/PcUK0Y7w+ekWgj76jA88JP7dbJtUp0d2GyjkQTuSjIL7ZU2t+B1uR+OIOhzxOY0Oy+
         KCifQIIg3lEQeDYgQB4sETyRoDlBFqYiTkk6x3aJGas7dg5VRT8816v1DgSQca7VEgnd
         GTftUkMZnXDXAr0W5GAHMPqjIhEF4rp1PlV3W5XbxoUlOJMl9Xegt0dXgsiPQQHGxLpW
         iTBg==
X-Gm-Message-State: AOAM531ftCtUG63NbxbTSVnS4XvNPcH1HY8IfP99GsdLOlywQUJeRNqm
        oOQxS1c2++dsNssMYUWbTegdRnTbj58YOXV3ng4=
X-Google-Smtp-Source: ABdhPJwH6rQ4Xtx8TIDeCErClcwMqaVFrhF6ev68LM4jAENVmB3yaTIBDChUTbXFpgYfNjU12TzCBsz0qDFzNQ4T+OM=
X-Received: by 2002:ac8:450c:: with SMTP id q12mr12563634qtn.292.1596784688131;
 Fri, 07 Aug 2020 00:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com> <20200806123721.GC6442@sirena.org.uk>
In-Reply-To: <20200806123721.GC6442@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 7 Aug 2020 15:17:57 +0800
Message-ID: <CAA+D8AOqaEEGuVp_vaSf6XAyjjCd=azj2qgKkqagvrtBNr9Mqw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Get "extal" clock rate by clk_get_rate
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:39 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 06, 2020 at 03:39:45PM +0800, Shengjiu Wang wrote:
>
> >       } else if (of_node_name_eq(cpu_np, "esai")) {
> > +             struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> > +
> > +             if (!IS_ERR(esai_clk)) {
> > +                     priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> > +                     priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
> > +                     clk_put(esai_clk);
> > +             }
>
> This should handle probe deferral.  Also if this clock is in use
> shouldn't we be enabling it?  It looks like it's intended to be a
> crystal so it's probably forced on all the time but sometimes there's
> power control for crystals, or perhaps someone might do something
> unusual with the hardware.

Ok, will add handler for probe deferral.

This clock is not a crystal, "extal" clock is for cpu dai, it is from
soc internal PLL. which is enabled by cpu dai, here is just to
get the clock rate.

best regards
wang shengjiu
