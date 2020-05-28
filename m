Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358E2207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOmAJe2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407280AbgE1Ubb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407142AbgE1Ub0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:31:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1AC08C5C6;
        Thu, 28 May 2020 13:31:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so13179560pfn.3;
        Thu, 28 May 2020 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO93gGZQjKHF+4cli9OA2QkdcgnKXo9HEkck4xDjwz8=;
        b=SOmAJe2uE3yg7U6wU9cVu9NJC41iLUgt+XMEEdXPWP+1lW5LfjYskGh+GU5/sDgLzb
         rZYttf3PmMUnNXk9fNQENzbrD+sXe9iKFc7fXHvYWt+FUPmASSnQAHSfXAhX3HArjQrg
         Un6QKchNE7gg85YHSG8pk9CBdWKxS5J059yc9FmKX5eJtIBApyW9Q+s3b+AH5vTkK659
         weo5YbyabyBByjsQqP/AwFXaWJSv85WQV7N4SPbuyDyGknjEmhwKE5qnuw7JDik6JOJC
         FcW89nTckg/BQXVcgl4icra3V0asZ/sElYvMdEGDeSgGuHW4iwe6n7oVMglC5dluV0WZ
         ipww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO93gGZQjKHF+4cli9OA2QkdcgnKXo9HEkck4xDjwz8=;
        b=kR1/X9A6WMt0gJcfLSjmUwH1hF7OWjc9ddMzT9M0u51gL6te+mYj9nv2oV5By3rk33
         CFrFupS/4hyCIho9nk7oXgThleuWCXUfnnlirz6kpOAzaSZyBIQwTNuVjrHvmKqfYEbw
         F2zoEl8fnzr5RiqXKqVaK+PKz6FycUfWEw42FHcXgeOJvWO6mI3VR2Utt+NLOcTiARfv
         jzxmbylmAdiH4fXbALiVbNyPNHtaGleJuuIkySiNd0yXIUWswjNDfC2S2ZcnvwZBjXo2
         payDrvHnL65yevaiuV7bnv/jny+tdMP4PTrZu3oS0VoABHbClaSsfZ7Kh/YDWP60GbS+
         ej8w==
X-Gm-Message-State: AOAM531Zr+Z9LB/R93zMRpHe72v7Q5sU3rhe9iJMi4PNuE6Gh5s00HUw
        qs/Zes47iQUVVX5h/bX6HwTKAzD6/qJrtERKdKc=
X-Google-Smtp-Source: ABdhPJx94LzXA1WkPW6Dg6EZMEEZCfIfkIu6MSWJ+jsb66vmlBxe8RTSL8onlyxY8WKj4AUWZwiBqOB937YZW4btBJE=
X-Received: by 2002:a63:545a:: with SMTP id e26mr4679459pgm.4.1590697885623;
 Thu, 28 May 2020 13:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-11-Sergey.Semin@baikalelectronics.ru>
 <20200528145630.GV1634618@smile.fi.intel.com> <20200528155017.ayetroojyvxl74kb@mobilestation>
In-Reply-To: <20200528155017.ayetroojyvxl74kb@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 May 2020 23:31:09 +0300
Message-ID: <CAHp75Vd0ujdxzXtE3-XGxrbJHBJqj6suBvN4VUQbApPSNCstmg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] dmaengine: dw: Initialize max_sg_nents with
 nollp flag
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 6:52 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 28, 2020 at 05:56:30PM +0300, Andy Shevchenko wrote:
> > On Wed, May 27, 2020 at 01:50:21AM +0300, Serge Semin wrote:

...

> > In principal I agree, one nit below.
> > If you are okay with it, feel free to add my Rb tag.

> > > +   /*
> > > +    * It might be crucial for some devices to have the hardware
> > > +    * accelerated multi-block transfers supported, aka LLPs in DW DMAC
> > > +    * notation. So if LLPs are supported then max_sg_nents is set to
> > > +    * zero which means unlimited number of SG entries can be handled in a
> > > +    * single DMA transaction, otherwise it's just one SG entry.
> > > +    */
> >
> > > +   caps->max_sg_nents = dwc->nollp;
> >
>
> > To be on the safer side I would explicitly do it like
> >
> >       if (dwc->nollp)
> >        /* your nice comment */
> >        = 1;
> >       else
> >        /* Unlimited */
> >        = 0;
> >
> > type or content of nollp theoretically can be changed and this will affect maximum segments.
>
> Agree. Though I don't like formatting you suggested. If I add my nice comment
> between if-statement and assignment the the former will be look detached from
> the if-statement, which seems a bit ugly. So I'd leave the comment above the
> whole if-else statement, especially seeing I've already mentioned there about
> the unlimited number of SG entries there.
>
>         /*
>          * It might be crucial for some devices to have the hardware
>          * accelerated multi-block transfers supported, aka LLPs in DW DMAC
>          * notation. So if LLPs are supported then max_sg_nents is set to
>          * zero which means unlimited number of SG entries can be handled in a
>          * single DMA transaction, otherwise it's just one SG entry.
>          */
>         if (dwc->nollp)
>                 caps->max_sg_nents = 1;
>         else
>                 caps->max_sg_nents = 0;

Fine with me, thanks!

-- 
With Best Regards,
Andy Shevchenko
