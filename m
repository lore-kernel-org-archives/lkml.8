Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C1C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5959B2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlG2wNJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICFin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICFim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:38:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E991C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 22:38:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so1090910qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/srxmXOQUdGOTgQu2IuqE2j58tt26cmpQAGEQoUfF/k=;
        b=BlG2wNJPYLR+rFryCKSetR5cKCniB4g/4HijU9okP0ui0rIsM3wxVymFTj14GFBX6q
         pK5+3rG4FJjOIgBAIpAjbQVoXniXWSV0TdHquceFaLdMTu8y7tro9mpkEiFR+UX5OlXU
         FmrMJRd16wseT1va/r33k5gJEc7XwRoD2CVA8REXK0RmYehVgri6Wsm8Wrsw31hc/BAo
         O+Va8jlRuamwJ81xgknpaV/yP8nR2C2oRaC32NUaqJxSUwmLsvx1W0uTxBP7Tv+NOj5Q
         MyLctmJl7IfP+gDw0n0DhQtOdg4Q3DG6Tm/GmE/zgu9UqsqiPeH5aB0lP77qRuuxhuWq
         8lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/srxmXOQUdGOTgQu2IuqE2j58tt26cmpQAGEQoUfF/k=;
        b=VHK/Q/ZihjJw+r+Ie7bOh/n0MAQKFRBkIU3yd7DdqDTIjV13dq/1e2GP819xwCG+9r
         TDXt5ElEvX66687qt4kkOF9f75YlxiemkeHaI54p9hzky8w1qF//cUPNzphoebg4ZjE5
         Fi4NJ6LhsroAZvSYlTOu+o6sjAMwDRUbhVjUMuzd45rN5mrHLeiD/vtsvFTYVA3gXxwz
         UsyMNTV6o9/uRRsE8FRpGDGkiZz9p4RJz8+NkVbASPXo/4wfGDHcLgwPLEctO7VnBdyr
         0oBUK1nCoP3XL62a6cHKOs31GoavGMkzyOL8HKXqXoHEFYPdTJONGOqKHtu1hhiVN4YU
         rctw==
X-Gm-Message-State: AOAM531c9q31hOSEj6XZzkwp2tyLOekJrU8wwphsAjfR566in+TtHqeN
        Fjqfe1Mw+VFuct51EtpL2F7JG/nA/zoar/3GONM=
X-Google-Smtp-Source: ABdhPJzaK6BoZepXoJ10dK0NPS4TvabWN2zlZEZXM5iY2qiaE4SmYwSpCXEsJMm/APS6kZyYQg8zAMlaCjyRxI4OR/8=
X-Received: by 2002:ac8:67ca:: with SMTP id r10mr1883306qtp.54.1599111521573;
 Wed, 02 Sep 2020 22:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <1599102555-17178-1-git-send-email-shengjiu.wang@nxp.com> <20200903034018.GC4517@Asurada-Nvidia>
In-Reply-To: <20200903034018.GC4517@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 3 Sep 2020 13:38:30 +0800
Message-ID: <CAA+D8AOJGH77cpbC9dqaE_BES208sgEPDNPWbZ8HGpfom_FoRg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:42 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Sep 03, 2020 at 11:09:15AM +0800, Shengjiu Wang wrote:
> > Transmit data pins will output zero when slots are masked or channels
> > are disabled. In CHMOD TDM mode, transmit data pins are tri-stated when
> > slots are masked or channels are disabled. When data pins are tri-stated,
> > there is noise on some channels when FS clock value is high and data is
> > read while fsclk is transitioning from high to low.
> >
> > Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> Though one nit inline:
>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 12 ++++++++++--
> >  sound/soc/fsl/fsl_sai.h |  2 ++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 62c5fdb678fc..33b194a5c1dc 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -486,6 +486,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> >
> >       val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
> >
> > +     /* Output Mode - data pins transmit 0 when slots are masked
> > +      * or channels are disabled
> > +      */
>
> Coding style for multi-line comments. Yet, probably can simplify?
>
>         /* Set to output mode to avoid tri-stated data pins */
Ok, will update in v2.

best regards
wang shengjiu
