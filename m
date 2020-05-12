Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C10C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC90020757
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXTFgedf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgELCsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:48:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6CC061A0C;
        Mon, 11 May 2020 19:48:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so9904792qtu.8;
        Mon, 11 May 2020 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
        b=uXTFgedfKAJw/mdH+r2ogZwZQTp/ZTIBRyakuBwLSXaz9PWFl3s45PRztLUO7H5FBP
         TFYtbn1ZzJ8znyq1exL44gJ+IKnPayj/ne3+XdrgqoDlhm+JXc+fHRnDRZSCC1iZcULu
         yhJjq9wd8k0JUQ5xuOSqJk7LCa34c2BTbb+fpES1GQHxSzMKez4IXl6KXXc2J0kHCym9
         ikeiYA+UxdiiLcFWazU/ZZWHH2jqHQh+MyNod6nD4dNcLGcAZqgtnSBzUJkrg0cVhUou
         AEcbyFUk/TIHzd/EwmZjEKhx+oQIh3IVZ/2yfe+rvjvi/yqZqN2j8s7+DeSsAmIJ2JGc
         PA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
        b=kKwYBOt97oCcvLN1z9fJF2usKS3O15hsp/c5KyiHxD31J+EB+w9yG513U02Z9xE/A7
         UoF93Dpg8yUz39arerSvhNkoNn+3JebgYlbEAEkusIgmCP3B87qQQZCMNwG25f7jxEPk
         drQFX2lxHGwxMG+K0RoSBFkBYZRaWzjvloVfEQw8zIGEidt7Ca2JKbQBOMX0YM6pxTUu
         Bzm8HBYtXoILhnRqaC4MRlE7n8CNVj3IjcW8IcZPolmN1Wpp/EiqsqI0SlO9/7B2Q7GY
         O9v5+VvFRR0TAwcRtxEmLQ2abAXUPu3OFbg4Pm54xc5Y7lcUi2+fpDBxI/lPLihsZ6fH
         3v1g==
X-Gm-Message-State: AGi0PuYCbs9Vi8AcgCeJc1uRviZUYTbN+U5whuuzVcMHNhVzKidtV+FB
        ZglQIxboagmncCmkz/HLhkwy5w1ymp7q+z02RAE=
X-Google-Smtp-Source: APiQypId7oxhT26ItzjC8bMXwsSFBjnYZNmv7Cgv/UndRHY6NfhZPgW4iFgXhDPKhepQCP0rcyNz85IZmAz5rBwh+Hs=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr19665595qtw.204.1589251733739;
 Mon, 11 May 2020 19:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com> <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk> <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
In-Reply-To: <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 12 May 2020 10:48:41 +0800
Message-ID: <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Nicolin

On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi
>
> On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, May 01, 2020 at 04:12:05PM +0800, Shengjiu Wang wrote:
> > > The difference for esai on imx8qm is that DMA device is EDMA.
> > >
> > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > the remaining bytes are not transferred and thus noise is produced.
> >
> > If this constraint comes from the DMA controller then normally you'd
> > expect the DMA controller integration to be enforcing this - is there no
> > information in the DMA API that lets us know that this constraint is
> > there?
>
> No, I can't find one API for this.
> Do you have a recommendation?
>
could you please recommend which DMA API can I use?

best regards
wang shengjiu
