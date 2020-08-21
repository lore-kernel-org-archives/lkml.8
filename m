Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ACF207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+XDozwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgHUMh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHUMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:37:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8546C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:37:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r7so733513vsq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUgN6ieJhIl8uII5WpVu/u5z15uJplqpBcG4NHNK9Tk=;
        b=B+XDozwpX0mgDxmJ6B/TSWbBDUbxlXICDWzTZ0j1JZrwcVr7nlDnFEkAXLfjy9/mv8
         htZLil76tPTHeIHrsH8uDlSs0MDekxxkQFL5tatwS+M8PXeS8Las4CgSNBfkRPfZZY5n
         Db2XXy4qs3y2Ha+4PSmAEzBhK26XXt/hZh7Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUgN6ieJhIl8uII5WpVu/u5z15uJplqpBcG4NHNK9Tk=;
        b=ZDRz70Qem2dsGJTomxl9drfqxtuLXU0NlLqRyQCkVj6m+9Im17o7AuItGpViIpfHOc
         L8E+qiCg7LEWY1auIt/3qBbpQlcNARCsdGj3GJi9tgM7NoKXI3Wfi+Wv/VXroqeFs6oF
         hF2C6YM7KoMz4GEyR6H82HgtzDoz1Ga8vq9OkTIm6SoKUpYl70wjUlFvIG3frGwmssDO
         7OO4LSFNRiYGndrpJqbg4EHeFJKup4+hqSHS/f3CaSQ3k/x7R4VxAi2ToD+JzwS63+n6
         cv4IQOUvTFIWKq59qzZFt/u2mqGzQaeSLnjxdrosN3k4zgWLI0l5KrCpxgKR6zUIWfUi
         aFbg==
X-Gm-Message-State: AOAM530Zb08zwJ5tbk4TxTo5wp3rqQ0Pl3+qYtpNHnQmuh3fzjFv5+AE
        JIF9B5uGxa53IMlOXAJB4R1Zl2ZOgpQQqV7NgnJYlA==
X-Google-Smtp-Source: ABdhPJygLjeX9qF2zIlcXZqIhRvgUeRfApyD41pRd420Ijd4idtK0rAzzpbRlTzYydU7YTYMB4F1QwLFqPlRNMYVFDE=
X-Received: by 2002:a67:f787:: with SMTP id j7mr1403877vso.79.1598013446831;
 Fri, 21 Aug 2020 05:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200820170951.v4.1.Ia54fe801f246a0b0aee36fb1f3bfb0922a8842b0@changeid>
 <20200820170951.v4.3.I066d89f39023956c47fb0a42edf196b3950ffbf7@changeid>
 <20200820102347.15d2f610@oasis.local.home> <CANMq1KCoEZVj=sjxCqBhqLZKBab57+82=Rk_LN7fc3aCuNHMUw@mail.gmail.com>
 <20200820203601.4f70bf98@oasis.local.home> <21fae92da07c4566ba4eed3b5e1bce2d@AcuMS.aculab.com>
 <CANMq1KBvNqcdCsuDGGygYqS5+ZBw+qSVXTC+WWNycypG2=BRMQ@mail.gmail.com>
 <898c56e4b7ef4c3da1d634fdef5a8898@AcuMS.aculab.com> <CANMq1KDT+uecuqxXRsxv9-sMv0sGXk6ZQ3hWv0aK34dfzaJXyg@mail.gmail.com>
 <6c5249afad274ce49e643d9b05706e3a@AcuMS.aculab.com>
In-Reply-To: <6c5249afad274ce49e643d9b05706e3a@AcuMS.aculab.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 21 Aug 2020 20:37:15 +0800
Message-ID: <CANMq1KCc-KObgJTe0vWXGHcsffMD=41VMe=GjtsKG0iobJES0Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: atomisp: Only use trace_printk if allowed
To:     David Laight <David.Laight@aculab.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:18 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nicolas Boichat
> > Sent: 21 August 2020 13:07
> ...
> > > You might also want a #define that can set temporarily
> > > to enable traces in a specific file/module even though
> > > CONFIG_TRACE=n.
> >
> > I don't understand how traces are supposed to work with CONFIG_TRACE=n?
>
> Probably because I meant something different :-)
>
> You want the kernel built so that there are no (expanded)
> calls to trace_printf() but with support for modules that
> contain them.
>
> Then I can load a module into a distro kernel that
> contains trace_printf() calls for debug testing.

Gotcha. I think it already works this way ,-)

So if you have CONFIG_TRACE=y, but no trace_printk in your
vmlinux/kernel, no memory is used, and no warning splat
(https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3160)
is displayed. But then when you load a module with trace_printk, the
buffers are allocated and the warning splat is printed.

The magic is here:
https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace_printk.c#L53

My option wouldn't really change that. I mean, if you have
CONFIG_TRACING_ALLOW_PRINTK=n when you compile your module, it'd fail
at build time, but if you set it to =y, your module could happily
build and load (with the big warning splat), no matter how you built
your kernel (I mean, you still need CONFIG_TRACE=y, but
CONFIG_TRACING_ALLOW_PRINTK doesn't matter).

> Which is why I was suggesting a config option that
> only rand-config builds would ever set that would
> cause the calls to generate compile-time errors.

I think I already answered that one above. We'd want that config
option enabled on Chrome OS and we're not a rand-config build (I mean,
we're a very carefully selected random config ,-P).

Thanks,

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
