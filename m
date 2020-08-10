Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E21020729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de+5jf2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHJIuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:50:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7143C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:50:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o22so6135599qtt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd+KGdIV03ZDNVLVq/+Q/ATX3ww0wvxrVThg94dncCE=;
        b=de+5jf2K1ZqwDSsbSIkMiHfDdBuBPN1wwq2KpeqVKD3Dn8C++08xSBeuzhqHRqsh3k
         A//1yK1EsW31DJmZQg8bOZfon/fjhmRXanUEY81Nd+9akPoto21VQQFBH+5ySmgasI8v
         6O1mIDiPj1QpwalGOW1HlLJCva8THeH7PcceRnSnH3OHEKgvJWV8AXR8D3nz6bhvo9V6
         1S+n+IMWxrUWwbrDnPdsOlYiw7pX6UikVtIqgzqHJdyrGDuQmdIiXyr6KS3ICvA3SF2Q
         0Um8jB4/ps3KjbdgcNMbxXrkeW64BxD+atuwdFxHO7d2KQ9R75OJ+HIfLu4QpXR61Vfs
         U+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd+KGdIV03ZDNVLVq/+Q/ATX3ww0wvxrVThg94dncCE=;
        b=QbWH+P52s0IqLOrNhHJQGQumNSootfVs9oZ6mzV93Md9Zbe9qWEfGVuLl34Ttf4SUm
         fTATlkv5jWI1CYyc+ZK7V7CN74QeC0IGUHov8Vig3TTIFY3+NmTLvJ15tyggb2VPGirl
         8Yc42QIdVCwhvjM48uBwFT6YSSwQZsqQ60znyXtqWOTVYkz+F+/bZlm3mZcLcb5GrQwj
         wos9U6acpeMngweqpszhSvaA9WIdmod3pZAO6tD/i9mldF33a3NvMiXgcSe2pMx1SxWA
         lXQ4jmjNaPT1NrbNIirmKFEK5qpMPqzdItOJFHpEmSJjeOJPqOW0BJR/ZtUX78QBNooF
         CxUQ==
X-Gm-Message-State: AOAM533L8V2pU8dyKK8LHr+ytJoy/8PHGkiDsZrhQtEAoR3+Pq1mvRnM
        5vt639s6s/S1nPk2W1/nQsS7kaTt1f2Ax/uGWfnp3w==
X-Google-Smtp-Source: ABdhPJwQZN3wjUk9e2RerROvjSA6KbTeAzJFLgIrN6bfeIV50G58IGJM27E6joMW6fVh+7DW7jJ1yMB19OH8aYMwSRo=
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr25763620qtt.121.1597049421042;
 Mon, 10 Aug 2020 01:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com> <20200810083728.GA7560@Asurada-Nvidia>
In-Reply-To: <20200810083728.GA7560@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 10 Aug 2020 16:50:10 +0800
Message-ID: <CAA+D8ANmEMnRR1N4QRh7y4=+XUpKYnXRQ4LRKw6VG=totd8rwA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by clk_get_rate
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

On Mon, Aug 10, 2020 at 4:39 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> > On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> > with the mclk of codec, then the clock rate is also different.
> > So it is better to get clock rate of "extal" rate by clk_get_rate,
> > don't reuse the clock rate of mclk.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2
> > - add defer probe handler
> >
> >  sound/soc/fsl/fsl-asoc-card.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> > index 52adedc03245..32f8f756e6bb 100644
> > --- a/sound/soc/fsl/fsl-asoc-card.c
> > +++ b/sound/soc/fsl/fsl-asoc-card.c
> > @@ -696,6 +696,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >                       goto asrc_fail;
> >               }
> >       } else if (of_node_name_eq(cpu_np, "esai")) {
> > +             struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> > +
> > +             if (!IS_ERR(esai_clk)) {
> > +                     priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> > +                     priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
>
> Will it break existing imx-audio-cs42888 on older i.MX platforms?
> 'cause it overwrites cpu_priv.sysclk_freq[] that are set in "card
> configurations" section.

Tested,  no break for imx6.

best regards
wang shengjiu
