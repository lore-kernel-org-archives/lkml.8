Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82756C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5701920737
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzGh9jM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgH1QTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1QTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:19:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A253CC061264;
        Fri, 28 Aug 2020 09:19:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so1952155ljc.3;
        Fri, 28 Aug 2020 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AV3wK53DNjTebV9OJa/AEYQrrdddDiANY5m2Ft03cso=;
        b=jzGh9jM37421bOvwZ7NXOEdI9pj5lRvi9hvRilLbf7Vwy4VHfMedDd9x1I/g4r6lJk
         At83McpcFBCSvwGKZcg2lQDXfXpz2mKdvednT9QC50VHA7tLjOEe9E3MFAAJXE17NPxS
         8YG+tRxooGc4KKl/4+8bLTL+YQKnR/5C8G49Lng5Q9fhatqpbyLdVDd/SsVtqMaaRWXz
         +xinPavIk0AIDbyyMkmevSqTQeA/8O4kJJR18XPJvQLcZTNCZXyTH12vMPG7QKHYfSZU
         LujPJrfP6rSr2S4oolME6xz+Vm15hmLn67RNRVqW8hfaJsjDTpvYZSFqAxyPO5SeHRXI
         reEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AV3wK53DNjTebV9OJa/AEYQrrdddDiANY5m2Ft03cso=;
        b=QoWsWVsoRkr2Uujvlb1xGUyEtaeIQnU5vq78gTNYOkselzU6QZ2vFF6uELmQABZCtz
         iTosbGgIlHJAbeHANss1YnahjlAhdCXmERL2LMpxoSmpARb+B/TJtLtmlHqrOHITkH5U
         bCxzKvxnvlP854UWkqCJbtjxrDWIylFi92OFRya7/PQ/Gmn5aSSPHUIe353OnzZH/Mjo
         wY1brGQoidqgjmVAEmopbZYqYNZZOfTh8de6AJoi1ZCElsziCRwr3iVVPi3oKHacFfM8
         fIGpacqCh2Cm7lDLtBvs7TZwkx1ddM9LtAUWzknTpni6URulsAsXL8LgD29tB7ZYCGJG
         fl9Q==
X-Gm-Message-State: AOAM531MtLFiTDcoABMDMo2EWJvm7llxRYrOQb0b7p9IW8t9owi/3gmb
        Z630o7ghs6TCASHeHPQ9fpBJoY5ozaAZRLICjQ==
X-Google-Smtp-Source: ABdhPJy8w+pu/nTGlSuIpffTOE7/vAyX0bNdAhfzhyaYvSl0sakIF3ja5uuhUQZkMhWHo0hnbNOIFmywvTO0Ool+LBU=
X-Received: by 2002:a2e:584:: with SMTP id 126mr1153036ljf.413.1598631578090;
 Fri, 28 Aug 2020 09:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826144459.8245-1-madhuparnabhowmik10@gmail.com> <20200828074035.GB942935@kroah.com>
In-Reply-To: <20200828074035.GB942935@kroah.com>
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date:   Fri, 28 Aug 2020 21:49:27 +0530
Message-ID: <CAD=jOEYCXGrsaGsZebGR56f+JDN3fH2iy=htrpprCFHKxLk8Lg@mail.gmail.com>
Subject: Re: [PATCH] usb/c67x00/c67x00-drv: Fix Data Race bug
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jacmet@sunsite.dk, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org, andrianov <andrianov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 26, 2020 at 08:14:59PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > Currently in c67x00_drv_probe() IRQ is requested before calling
> > c67x00_probe_sie() and hence if interrupt happens the reading of certain
> > variables in the handler can race with initialization of the variables,
> > for e.g. sie->sie_num is written in c67x00_probe_sie() and read in
> >  c67x00_hcd_irq().
> > Hence, this patch calls c67x00_probe_sie() before requesting IRQ in
> > probe.
> >
> > Found by Linux Driver Verification project (linuxtesting.org).
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  drivers/usb/c67x00/c67x00-drv.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
> > index 53838e7d4eef..2e816d5ca0eb 100644
> > --- a/drivers/usb/c67x00/c67x00-drv.c
> > +++ b/drivers/usb/c67x00/c67x00-drv.c
> > @@ -146,6 +146,9 @@ static int c67x00_drv_probe(struct platform_device *pdev)
> >       c67x00_ll_init(c67x00);
> >       c67x00_ll_hpi_reg_init(c67x00);
> >
> > +     for (i = 0; i < C67X00_SIES; i++)
> > +             c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
> > +
> >       ret = request_irq(res2->start, c67x00_irq, 0, pdev->name, c67x00);
> >       if (ret) {
> >               dev_err(&pdev->dev, "Cannot claim IRQ\n");
> > @@ -158,9 +161,6 @@ static int c67x00_drv_probe(struct platform_device *pdev)
> >               goto reset_failed;
> >       }
> >
> > -     for (i = 0; i < C67X00_SIES; i++)
> > -             c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
> > -
> >       platform_set_drvdata(pdev, c67x00);
> >
> >       return 0;
>
> Have you tested this on hardware to verify it works properly?

No, I haven't, don't think I have the relevant hardware.
It would be great if someone could test this and add a Tested-by tag.

Thanks,
Madhuparna

>
> thanks,
>
> greg k-h
