Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA072C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886124684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWNa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:30:59 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36741 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:30:58 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so1007358uae.3;
        Thu, 23 Jan 2020 05:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+L/2IhzPeQzIOBWlkZ5pb6nsfpL9PHovfEkpJKJ33U=;
        b=tfZ8xdMXne2j6zAYSePkCxIvjgsESJ2alS2OrK1gvvUe9qj08TPmb2CWYRjOH4kDYk
         5F9VtLFQ7thkAFH3CCL3vWBHT6A7gLnxA0Nbbja98kpXZr+kTkjdY76QpSo1MI4vCJZc
         uKzyYnbxDVbakiYl4bT9+fVvK1wh+o6vPDu7U0p/sFEbejl+OMXF8bHr4bcYPEj9PU4B
         AuHHjGqDLJf5mKDhzH3dY/2VE/BkQGWEojVeCXJkLXJ8Mvz3nksoipmWzSb3v1sjLZXD
         T7C93+Y4F41CKy8YfFiVBs8JXOPccmP6ApM+ZTPLR7kWtdbkoy3vL5TzWkU/KS5ql1RN
         4iLw==
X-Gm-Message-State: APjAAAUdT1rWfzN9PaDYU97tRW+uJFtX1HEJVnpdpPRqgvSEHxaZQGdA
        e3UAZX4vGa2w59BI7jnXipfFWX+AI3Gc2SgGzBe+j0UU
X-Google-Smtp-Source: APXvYqyRlraHNmDMZdZCjBusJQDVjLX1k8LZn1KXe8p0/vt6EjbszONOt8LLgQR0Jfc3uHWQsHfSAGvWLUwy+B2lRik=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr11516407otm.297.1579785825019;
 Thu, 23 Jan 2020 05:23:45 -0800 (PST)
MIME-Version: 1.0
References: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr> <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
 <8f1f01a1-b0c7-77d5-7d01-dd53811fa217@free.fr> <CAMuHMdW=0Qf=bdE8Vy75wySRV5wzWhgM=-vhXjc0RhLGwomF_g@mail.gmail.com>
 <91058d8f-7075-6baa-6131-cce1ccd160a6@free.fr>
In-Reply-To: <91058d8f-7075-6baa-6131-cce1ccd160a6@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Jan 2020 14:23:33 +0100
Message-ID: <CAMuHMdWVisqq-rXi4aB2woKb9rHbXoQjWcbhN4zcf3F2+jhewg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jan 23, 2020 at 1:18 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> On 23/01/2020 11:32, Geert Uytterhoeven wrote:
> > On Thu, Jan 23, 2020 at 11:13 AM Marc Gonzalez wrote:
> >> A limitation of devm_add_action is that it stores the void *data argument "as is".
> >> Users cannot pass the address of a struct on the stack. devm_add() addresses that
> >> specific use-case, while being a minimal wrapper around devres_alloc + devres_add.
> >> (devm_add_action adds an extra level of indirection.)
> >
> > I didn't mean the advantage of devm_add() over devm_add_action(),
> > but the advantage of dr_release_t, which has a device pointer.
>
> I'm confused...
>
>         void *devres_alloc(dr_release_t release, size_t size, gfp_t gfp);
>         int devm_add_action(struct device *dev, void (*action)(void *), void *data);
>
> devres_alloc() expects a dr_release_t argument; devm_add() is a thin wrapper
> around devres_alloc(); ergo devm_add() expects that dr_release_t argument.

OK.

> devm_add_action() is a "heavier" wrapper around devres_alloc() which defines
> a "private" release function which calls a user-defined "action".
> (i.e. the extra level of indirection I mentioned above.)
>
> I don't understand the question about the advantage of dr_release_t.

OK. So devm_add_action() is the odd man out there.

> >>>> +       void *data = devres_alloc(func, size, GFP_KERNEL);
> >>>> +
> >>>> +       if (data) {
> >>>> +               memcpy(data, arg, size);
> >>>> +               devres_add(dev, data);
> >>>> +       } else
> >>>> +               func(dev, arg);
> >>>> +
> >>>> +       return data;
> >>>
> >>> Why return data or NULL, instead of 0 or -Efoo, like devm_add_action()?
> >>
> >> My intent is to make devm_add a minimal wrapper (it even started out as
> >> a macro). As such, I just transparently pass the result of devres_alloc.
> >>
> >> Do you see an advantage in processing the result?
> >
> > There are actually two questions to consider here:
> >   1. Is there a use case for returning the data pointer?
> >      I.e. will the caller ever use it?
> >   2. Can there be another failure mode than out-of-memory?
> >      Changing from NULL to ERR_PTR() later means that all callers
> >      need to be updated.
>
> I think I see your point. You're saying it's not good to kick the can down
> the road, because callers won't know what to do with the pointer.

Exactly.

> Actually, I'm in the same boat as these users. I looked at
> devres_alloc -> devres_alloc_node -> alloc_dr -> kmalloc_node_track_caller -> __do_kmalloc
>
> Basically, the result is NULL when something went wrong, but the actual
> error condition is not propagated. It could be:
> 1) check_add_overflow() finds an overflow
> 2) size > KMALLOC_MAX_CACHE_SIZE
> 3) kmalloc_slab() or kasan_kmalloc() fail
> 4) different errors on the CONFIG_NUMA path
>
> Basically, if lower-level functions don't propagate errors, it's not
> easy for a wrapper to do something sensible... ENOMEM looks reasonable
> for kmalloc-related failures.

Indeed.  If devm_add() would return an error code, callers could just check
for error, and propagate the error code, without a need for hardcoding -ENOMEM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
