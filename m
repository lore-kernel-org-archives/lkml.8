Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C619DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69CD207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSeD4DNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407215AbgE1U3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407026AbgE1U3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:29:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7014C08C5C6;
        Thu, 28 May 2020 13:29:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so32026pll.6;
        Thu, 28 May 2020 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtV5dW6W0wTHT1QljBO+2MIOLfwjQMefjp2+Ja+1XDw=;
        b=rSeD4DNMsQ5cx/NMr/IjUmElVIIUsZGTYyg+i8h79mHu6F+pXjiselcoSQOlY0n56M
         GjFDKMf8MMeuBGB0Kxf0Qk+Vf7CRTzFIEJjOgiXyxL1EHFDVWoE0opghUUC5bWUGLVDC
         oynwU7aZfd2tw3eUinbMSgvOh4+r+fXV2PRkSqcRIFye48mk69IjEnM5Izt/UW4YCyhc
         MM2cMPn1TO9QnSvIUboqDdRXgU7zUUQas7R4606Y0fzcKqya4JAqEAAG743spn5kyPj9
         TLS6SOVAZts+wUUsuCk0TlURB8Ut63XFMCUNTWqEeV8tEB9KTODv1J/1w5M//2JdP51y
         stEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtV5dW6W0wTHT1QljBO+2MIOLfwjQMefjp2+Ja+1XDw=;
        b=ckxt9F+aFS5fkSvMa9aN587hm8DYXBjHGoGvsK4l1U6o5XWUEOiNUgaBafPC49LRrO
         OHJnfJd65i2oHXMJZAx+44ENBYKyvzlNaJidpJP0mh0fvqDZ+2mpW3frN3zTQvx9L0IS
         lDiqkxHl84+wWxB+1DqdzukegJXa6EwwNvimSUGWe/ARZDJvu+TMmBHOiGYvGSqpBLXn
         pgP11BKzipAXnkt5WkAucUHUS7raWsRQH+IhS2Xr0o+VwC1aS3OniYhA0n3zHbkBh7+Y
         1HNKKokDInQU2a5Eq+8TfdFhozOasTUffX2Az3ftfdNoctW1E2oxsS51g0GzNs4ni32F
         fkFQ==
X-Gm-Message-State: AOAM530hEw9hYCabtprfGVswL1D7w1FDG0HtNRtdvFuTqeoCO88JQ5pR
        8nEjbNGwUWv0QesxqsI/gO05gO84mIVUFueFatM=
X-Google-Smtp-Source: ABdhPJzzCIEyt/HEosdWqkQyoWkR9Y1Eya0FrV5VMnEDeOInwcqhIYJGYpZrpvvY2eEIJpyLwnByYtZB0NzqCqc8Xho=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr5490278plt.18.1590697773198;
 Thu, 28 May 2020 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-9-Sergey.Semin@baikalelectronics.ru>
 <20200528145303.GU1634618@smile.fi.intel.com> <20200528152740.ggld7wkmaqiq4g6o@mobilestation>
In-Reply-To: <20200528152740.ggld7wkmaqiq4g6o@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 May 2020 23:29:16 +0300
Message-ID: <CAHp75VdrOJF6R9YDpeV7x+9=DZJULM0hsfdr0o_Jmgf69CRKvQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] dmaengine: dw: Add dummy device_caps callback
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

On Thu, May 28, 2020 at 6:30 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Thu, May 28, 2020 at 05:53:03PM +0300, Andy Shevchenko wrote:
> > On Wed, May 27, 2020 at 01:50:19AM +0300, Serge Semin wrote:
> > > Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> > > have non-uniform DMA capabilities per device channels, let's add
> > > the DW DMA specific device_caps callback to expose that specifics up to
> > > the DMA consumer. It's a dummy function for now. We'll fill it in with
> > > capabilities overrides in the next commits.
> >
> > I think per se it is not worth to have it separated. Squash into the next one.
>
> bikeshadding?

Actually no.

> There is no any difference whether I add a dummy callback, then
> fill it in in a following up patch, or have the callback added together
> with some content. Let's see what Vinod thinks of it. Until then I'll stick with
> the current solution.

The rule of thumb that we don't add dead code or code which is useless
per se. Go ahead and provide it with some usefulness.

-- 
With Best Regards,
Andy Shevchenko
