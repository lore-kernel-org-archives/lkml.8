Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D4AC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8917821741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgBEJDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:03:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44763 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgBEJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:03:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so1217376otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 01:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ly8+3gmEudftYUIeu3tPerclxKuHSskVOT90fOPXZhE=;
        b=OKVItxpeqmP98QfrRFgIARI97k/FesAMPoFEs+csAYh2WoKBfsZmp0kyKjgZd+QNBT
         nr0+feMKU7Xvrd3Hw8YrbTcGMstPKDI2yXsznDc3cODw5DTaAW2U7PhSSie0dtfibbr7
         pe9b/wd4W0ObtLDGFT5ANPUR/4BJRJn8S//9jCWX6TSjqO9PXE+svk4trBKsreVlqpY8
         zuY+2J38cQNjc+BHjv9LaENX5LEwurJ5WWveILB05vj/T/xeuCJaC5hAEDC4ku7YC++f
         uTwFmMMkav5BUjZhjJ1wU7yilDcEXnCjbRh7IoPxZI6U+snKN7n/MLnM61I0s+N4t7Ch
         Fpnw==
X-Gm-Message-State: APjAAAWeEv+b7rDLoCzAfl/+iUUTfl3aEmztR6LUcz7dd1XxLpIcBw/U
        e2dTKJRNdSzbAhx+bC4klnOrKgNsbENUpyxBf8s=
X-Google-Smtp-Source: APXvYqyVwSn2VmNn5oApgPX5q+zTOnNZeAT401O+YxcAG7VYa5bBHlGp+7lxWYvZwut7WPxF1fu6UU5Z6kXVuJUJXdM=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr23691249otf.107.1580893410632;
 Wed, 05 Feb 2020 01:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net> <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com> <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org> <20200205033416.GT1778@kadam> <a3032823-03a9-f018-73e4-eb0d71e0bb53@roeck-us.net>
In-Reply-To: <a3032823-03a9-f018-73e4-eb0d71e0bb53@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Feb 2020 10:03:18 +0100
Message-ID: <CAMuHMdXKtJEvwRViRpy4nHbxv68P_rCFWbpikw=BMM5XnBvD2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 4:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/4/20 7:34 PM, Dan Carpenter wrote:
> > On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
> >> On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> >>> On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> >>>> On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> >>> On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> >>>> My advice is to delete all the COMPILE_TEST code.  That stuff was a
> >>>> constant source of confusion and headaches.
> >>>
> >>> I was also going to suggest this. Since the COMPILE_TEST has been a
> >>> source of trouble I was going to propose dropping the || COMPILE_TEST
> >>> from the Kconfig for the octeon drivers.
> >>
> >> Not having it also causes problems.  I didn't originally add it for
> >> shits and giggles.
> >
> > I wonder if the kbuild bot does enough cross compile build testing these
> > days to detect compile problems.  It might have improved to the point
> > where COMPILE_TEST isn't required.

It depends...

> Not really. Looking at the build failures in the mainline kernel right now:
>
> Failed builds:
>         alpha:allmodconfig
>         arm:allmodconfig
>         i386:allyesconfig
>         i386:allmodconfig
>         m68k:allmodconfig
>         microblaze:mmu_defconfig
>         mips:allmodconfig
>         parisc:allmodconfig
>         powerpc:allmodconfig
>         s390:allmodconfig
>         sparc64:allmodconfig

I did receive a report from noreply@ellerman.id.au for the m68k build
failure. But that was sent to me only, not to the offender, and I do my
own builds anyway.

More interesting, that report happened after the offending commit landed
upstream, while it had been in next for 4 weeks.

> Many of those don't even _have_ specific configurations causing the build failures.

Exactly. These are the "easy" ones, as the all*config builds enable as
much infrastructure as possible.  It's much harder if some common
dependency is not fulfilled in some specific config.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
