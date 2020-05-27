Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8C7207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAxSISwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE0Fbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0Fbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:31:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABEDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:31:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so27324233ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4OE+Mzwhfdx0FQgVxh0WT9tQP++uOwkn495VNZ2ONM=;
        b=IAxSISwD9wL4huimHfBqzSMqnZJ5ZHP3M0ZR/gh9/KVhz5cj0bJVobmY7aBQixJutD
         A+oBYMzTgShxXvTAx0XErdaqsMesWUQM9bcRGNZmVt2GfFo0QIIL9m1q3tYDo9pJCk0s
         brzHOYWjQRMsYpt1x2qdy8VdcOjWS22OWuCeqJWJyMRUmpn7GSD05sfZDAMxGkF3yvxc
         CXYbWyRY2PdCrnkeyLKNZbL70qTITSADMjhyB2+LxwAJgnjyQ7FnyzjB9zA6/1aixyMY
         /K8pFSq3qPL/2bzWxYOPSBvYCjE4aOj8XbchporZb/3mBtpqZtGIIVhyDWUi28i11vLS
         KM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4OE+Mzwhfdx0FQgVxh0WT9tQP++uOwkn495VNZ2ONM=;
        b=NFBml07j7P/m3ujfdTytJVk2tVxYjI7P0f+y96OlMtuTFZ0LRqUGR8Q79zshNEBu2l
         wXRBAHTsOSPyq8OSRGgfDTS+zEjuCIEBKQEngR/TKmMYEeESuuDOc0UEvjPjvUzKXWP2
         EMDcEJcOS+b9AKLHUZLLe0LreoKx51DCH7MXWQsW8mI7kuNqsfIRF5G4p0ygUk074FZb
         T80lT4bdp6f5Der4zZkhA9AwnV5++YuhlN6seqSuC2boyMIAbn+ZNHXwo+gNL3Y1Nz9N
         0jBy9S5zYzRUolA/n8f55Hf+9/gpAZJAY4O4XWDR+A9+a8QEWG+LFkJF+pVUAAgbCuDy
         xmYw==
X-Gm-Message-State: AOAM533hsKi4N0u/WSCkFXTMYG0eSPJ600AjW8fMdka8N81ukOOSMC3Z
        cDjziiY1DG/SlX2SGgEGDn/WWz4BbqRDV5SnZCN/SA==
X-Google-Smtp-Source: ABdhPJyzRPvU61IZTb+rTiMaJ9jcLwmCScYBDCPh7EOJ1aEO1PF/M5kjHB7xHsWbc4AP2jL6MjrToCfOYFh0FdBvh5I=
X-Received: by 2002:a2e:9716:: with SMTP id r22mr2237717lji.293.1590557490905;
 Tue, 26 May 2020 22:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200419001858.105281-1-hector.bujanda@digi.com>
 <CAMRc=MeHun_WEApEXP59ZszGa2n+wbU9qq3wU1VO9o590rO-Pw@mail.gmail.com>
 <CACRpkdaeXFW5K=Npy2ubWsffc7aepEQ5kSJ2HrkrESjaTy_psQ@mail.gmail.com>
 <20200525022252.GA22956@sol> <CACRpkdagkhbULGVGJqcS55m=X2EaH_iK0Khr8+6M7ATWrC3hOQ@mail.gmail.com>
 <20200525151736.GA32461@sol>
In-Reply-To: <20200525151736.GA32461@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 07:31:20 +0200
Message-ID: <CACRpkdZnLv=mv6JEHx0aF8YsUbpJH_ZrtCD+T23XfqvJLxw4Xg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add GPIO_SET_DEBOUNCE_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Hector Bujanda <hector.bujanda@digi.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 5:17 PM Kent Gibson <warthog618@gmail.com> wrote:

> > I suppose gpiolib would have to steal or intercept the interrupt
> > by using e.g. IRQF_SHARED and then just return IRQ_HANDLED
> > on the first IRQ so the underlying irq handler does not get called.
>
> And how would gpiolib ensure that it was first in the chain?

I don't know.

> Totally agree with the concept - just trying to work out how to
> implement it seemlessly given the existing API and usage, and given my
> limited knowledge of the kernel internals.

The irqchip maintainers certainly know the answer for the question
of shared interrupts at least.

> > Failure is an option! Sorry if I push too complex ideas.
>
> I'm not as concerned about complexity as I am about fragility.
>
> I don't see any problem adding debounce for gpiolib-cdev.
> Adding a more complete solution to gpiolib itself is certainly
> non-trivial, if it is possible at all.

I agree. It's just that I perceive it as more elegant if we can do that.

> The path I'll probably be taking is adding a debouncer to gpiolib-cdev,
> so at least we have a solution for userspace, then take a longer look at
> the more general solution.

That's fine! Thanks for looking into this.

Linus Walleij
