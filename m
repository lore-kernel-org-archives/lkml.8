Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09962080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgFSIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:07:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37232 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgFSIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:07:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id a3so7741090oid.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9QLwr/gThP6fd0GJQ39gaT5PlOnHllX1baIFXtwLyU=;
        b=ARwyL1u8b2INHIDkSNiyNO7IL7f668sXq1o1B8yL/9hVYPTljgkE9/Mc3btaOqD2VY
         zLSCrfXcxNWuUEnaUMWFkRmqmAplsGr1Twq1pMlvTeGh5o9NyzrbKYU048Jx/IiBeBv4
         hi76s81dJkTT/2GsyP7zK5Pu3vvZ/NWm+eypdwUu344C66eyEtcY8/KVZo/2m/MmkhZ6
         ruwBm2/fF7QY8taUHSuxmWwfxdOgaAoEUjGQLbFAXuYRSrYlfaI9kDA74QIS5Y36dT7P
         iHGz9zAtEvGQkKzAbOZLaQ1IUa+W7+gGJaJcoVRzw/5cvvP93DNH2K582ElR3EBo3fT1
         oHJQ==
X-Gm-Message-State: AOAM532EUbUnYhY8inZCNFwE5pWWOF8ig4wdSqcP0iuSIvLu88SDm5r1
        T4G6HiAZAbIeUfbZJfqSgJsQAHqHuB5xe6oWDE0=
X-Google-Smtp-Source: ABdhPJzaFc9C3fifQNKploQvy0a6vVQ8Cye3kfwreRTY9aJnXhpvwaZOcSzS1B5qS9ZnLZSGGASKTTFMUnJieriQexQ=
X-Received: by 2002:a54:4006:: with SMTP id x6mr2087593oie.148.1592554065970;
 Fri, 19 Jun 2020 01:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
 <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com> <20200618050249.lqwznznltm3lcykr@ltop.local>
In-Reply-To: <20200618050249.lqwznznltm3lcykr@ltop.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Jun 2020 10:07:34 +0200
Message-ID: <CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Thu, Jun 18, 2020 at 7:05 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Jun 18, 2020 at 03:22:15AM +0200, Miguel Ojeda wrote:
> > On Thu, Jun 18, 2020 at 12:02 AM Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> > >
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > index 21aed0981edf..e368384445b6 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -5,20 +5,20 @@
> > >  #ifndef __ASSEMBLY__
> > >
> > >  #ifdef __CHECKER__
> > > -# define __user                __attribute__((noderef, address_space(1)))
> > >  # define __kernel      __attribute__((address_space(0)))
> > > +# define __user                __attribute__((noderef, address_space(__user)))
> >
> > I guess `__kernel` moves to the first place since it uses the first
> > address space?
>
> No, there is no really an order between address spaces. Even before
> this patch, the number were only used as an ID to distinguish them
> from each other.
>
> I just moved __kernel above because it is quite different from
> the others because it's the default one, and so:
> * it's never displayed
> * it's normally not needed, nor in type annotations, nor in cast
>   between address spaces. The only time it's needed is when it's
>   combined with a typeof to express "the same type as this one but
>   without the address space"
> * it can't be defined with a name, '0' must be used.
>
> So, it seemed strange to me to have it in the middle of the other ones.

Indeed. It looks like this whole list is completely unsorted, and was created
by appending new definitions at the bottom.
So perhaps all the address_space ones should be grouped together?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
