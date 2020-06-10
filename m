Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B125C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7399A20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dL2TrTTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFJKKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:10:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA00C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:10:33 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so1092171lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAhzONNr7z3ygGUqG934E3Yihpizy6C4bWVguia+sKY=;
        b=dL2TrTTLy7r6e6P3kCV8VlxlA9Db3VcE3zFFe7xcEr8nMHDScBF9vsWQ8ytW1YJrYW
         etOhipCNb6uKdjPJMUNNfm4So/Spq0mvAuxViNW9ugd0BbRtIo/UeVrWOA+Av48tDdMj
         07fZcBb7KtQoRqCVtf4uBi/r8znrUa4mXMjym8Q7WcXQzJYbQ6R+zNSAIsA3+WnNPVE2
         sXVJYECC0MwXDOt3idZeZQaetYMUte4/kDSMGagZpNxEKtD50aiKyzxVf7FyVDx95dKj
         l/nU+Zz248XNJfMLXvnkbuaYrR36t4JFSvN0tOG2mQBAJtcHCgcjdBecZyVu4FxQb+Nj
         onzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAhzONNr7z3ygGUqG934E3Yihpizy6C4bWVguia+sKY=;
        b=Fh5n3qOsw4vzhwHxdXiQeWpcQf6kkKrrVq4cWvGoypiK26Qtahj1j50Mc+jfj8fnz+
         A6jhxSZImPz6FPadiDxoZsHqU5qEXVHjpxHRXMSFvh45nnaMLDMdeX8TMgfdu8gw/LB1
         H+Uo4IHoUdWiRgOs5hR+cJlh2187w1OCVVXEVYyINLKouzEGaPyAFAYwbHhfv8OJ5Y37
         VcqGqtvoeypEF8AnljKFgHDgxzChEwRuXNvBGzH8658cr8XQ/Z2dUEH4GCkU/yQcbfu7
         0Ax44XTKRXOJ3iEqPjHZY15M3XwwiChUDfABogQ5BVgEpjHrCJWixXEMU9iuXS9kNgso
         Nw6A==
X-Gm-Message-State: AOAM530IzF2MJMAa4sPWS4f8bGNBWMBpQfZWgBp8jMT+9tL3OnHNE8Xa
        VUIxyiCUuQYjy0c3p9m93dKK69p7ht/7Ys3JNsY61A==
X-Google-Smtp-Source: ABdhPJyTa1XrI/sysgesk54NFQfcSN3GAqb6rinYxiQxuvsa0bLQFSw0HofyX/7Hp343PcO7RYxIXfIdX3ufmtwkHYw=
X-Received: by 2002:ac2:562b:: with SMTP id b11mr1305542lff.47.1591783832131;
 Wed, 10 Jun 2020 03:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc> <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc> <20200607161116.GN1551@shell.armlinux.org.uk> <20200608110902.GA5736@afzalpc>
In-Reply-To: <20200608110902.GA5736@afzalpc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 12:10:21 +0200
Message-ID: <CACRpkdboPBGBdHaRtZ=OAFvikYZVh=BVu192uyiB8T=yeHHEbA@mail.gmail.com>
Subject: Re: ARM: vmsplit 4g/4g
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 1:09 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Sun, Jun 07, 2020 at 05:11:16PM +0100, Russell King - ARM Linux admin wrote:
> > On Sun, Jun 07, 2020 at 06:29:32PM +0530, afzal mohammed wrote:
>
> > > get_user_pages_fast() followed by kmap_atomic() & then memcpy() seems
> > > to work in principle for user copy.
> >
> > Have you done any performance evaluation of the changes yet? I think
> > it would be a good idea to keep that in the picture. If there's any
> > significant regression, then that will need addressing.
>
> Not yet. Yes, i will do the performance evaluation.
>
> i am also worried about the impact on performance as these
> [ get_user_pages() or friends, kmap_atomic() ] are additionally
> invoked in the copy_{from,to}_user() path now.

I am happy to help!

I am anyway working on MMU-related code (KASan) so I need to be on
top of this stuff.

What test is appropriate for this? I would intuitively think hackbench?

> Note that this was done on a topic branch for user copy. Changes for
> kernel static mapping to vmalloc has not been merged with these.
> Also having kernel lowmem w/ a separate asid & switching at kernel
> entry/exit b/n user & kernel lowmem by changing ttbr0 is yet to be
> done. Quite a few things remaining to be done to achieve vmsplit 4g/4g

I will be very excited to look at patches or a git branch once you have
something you want to show. Also to just understand how you go about
this. I have several elder systems under my
roof so my contribution could hopefully be to help and debug any issues
on these.

Yours,
Linus Walleij
