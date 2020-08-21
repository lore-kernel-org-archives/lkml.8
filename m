Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A1BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A482078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jDClVLEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHUQAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHUQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:00:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF704C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:00:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so2175703iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWjzEcPwT/6hwotRNTIY9NaBUTyN7quweFTkYLEKd40=;
        b=jDClVLEKJWhVolsUnITnsSQo1HZzq0iWZfsy/liv4zabUX+ksQm7q238ZH77pv1pww
         IE2xpVnuJb0uUGalHSvWp5hGTYvxUx0+HkDPoxchFCTb86f4kJvl+QgU/xdEwcfd12or
         N0oR8zb3+O+MdVq+R3wLWUjrLcP38QTN/0dRYdDDE3yysc+3hHqQz4J+GexYsxP1PLHE
         AowSSCByJw/nNarcPN/7VDb3U/wCv5B3QN6KbccLZuljorjIguGphz9/a/CGgn3oG543
         6yAp00g7o29yBR/8IX02hwpwdvpe2OV+yxIF42nETH+66Ebc2yEb3h5XPuCtnhZoBK6c
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWjzEcPwT/6hwotRNTIY9NaBUTyN7quweFTkYLEKd40=;
        b=Gwvr+fl/H02CtBP/QbuJQdO1SYOMQH8ieg4UQpP6EPbhv3X/YY7sYLjb2fQ5yLpbfJ
         mur4YYGYNDPQVt7AEpI/ry7xeiq6/Dl++qfCBnLiYaHdXKQHwlkmmYSg2d+segXREqQd
         N0eGqkwBO9CV7iq3StfRbqClnHr3/PCyurImrW59a41LTAY4s8x/4Cls+KjZ4FiP8fX5
         sTD2rI+3wTMI3oSDtBF4+4hlLwatHErQ0iZcWj2RxyqpW8LGD8i0k5iuk08+Zze1hn93
         sy/CSAiWZNUbMyDnXdz4U89K+hDl6GdWEPfElVdTFIiiI1UqAvgPYqLuVRVPaN4l1k2B
         Wu1g==
X-Gm-Message-State: AOAM533WJr4od0yjm9s0o53GzoAxsePmY4qQ+M+4J8XoJS2sHIn5IlUr
        Z27cgI7HeyEPmToZ2m0t5jblpYZpASH1UWngR9m+LA==
X-Google-Smtp-Source: ABdhPJwBm13KEUhNRpo7vk4oIVXm7ASv7AuOGK/3nYoePGcCxW34adTWVSkCHauITkFQuVHyKmTrX4EY/gRMqEK65h4=
X-Received: by 2002:a5d:8cce:: with SMTP id k14mr2831399iot.13.1598025613850;
 Fri, 21 Aug 2020 09:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200820185110.17828-1-brgl@bgdev.pl> <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com> <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
 <20200821105119.GL1891694@smile.fi.intel.com> <20200821110403.GP1891694@smile.fi.intel.com>
In-Reply-To: <20200821110403.GP1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 21 Aug 2020 18:00:02 +0200
Message-ID: <CAMRc=MfLkBRKu9ofSUGH=k3hxiJk-g=MMvab2awcsmeyF4RAKg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 21, 2020 at 01:51:19PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 21, 2020 at 10:59:19AM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Aug 21, 2020 at 10:35 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > > +static struct devres *to_devres(void *data)
> > > > > +{
> > > > > +     return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > > +}
> > > > > +
> > > > > +static size_t devres_data_size(size_t total_size)
> > > > > +{
> > > > > +     return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > > +}
>
> > > The data pointer in struct devres is defined as:
> > >
> > >     u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> > >
> > > And this value (assigned the value of ARCH_DMA_MINALIGN) varies from
> > > one arch to another. I wasn't really sure if offsetof() would work for
> > > every case so I went with something very explicit.
> >
> > I have checked with a small program simulating to_devres() with your variant,
> > offsetof() and container_of().
> >
> > The result is this: if MINALIGN < sizeof(long) and since struct is unpacked the
> > offsetof(), and thus container_of(), gives correct result, while ALIGN()
> > approach mistakenly moves pointer too back.
>
> ...
>
> > I think you need to change this to use container_of() and offsetof().
>
> To be clear, there is probably no real problem, except unlikely possible
> MINALIGN=4 on 64-bit arch, but for sake of the correctness.
>

Thanks for taking the time to check it. I'll switch to container_of()
for (hopefully) the last iteration.

Bart
