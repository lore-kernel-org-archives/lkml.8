Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2DCC352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EC421739
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1VSERI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgBMAiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:38:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44387 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBMAiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:38:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so4559502wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu9p1NHkE2MkYSqLVKem4JSGakNOnN3LkVvsdFKxSS0=;
        b=C1VSERI1Zhn2+zwNq4GK6omW9Pu8n04thGggoaimCH1HofOfRHUCOQ5eRuXLOKllFc
         RX9W6HYCh+X9U4q+03sYtLor09rSeoyf+ckAi45iIrgRkMtyJ3kibvnFsEqp1eDBlTfS
         mVMLsY3zEFVRNDD+XeN5jD4tizPm7byE3GOwlkb74Wkh7GebPOjUPkIZ44B8cGktU+J5
         apRTM6MlGFpSrFIFlPyktFh92vU1H4Y/SVS01GeIKVbPKR5M9wObqBORQb9PgTcZCBXe
         Dxbzv2zhc8mDcI2DbOKhVb7TLu4fn4zJMQ06LjAnab5mTAb2GUkRaqil7WQ3dRCt7VQd
         6lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu9p1NHkE2MkYSqLVKem4JSGakNOnN3LkVvsdFKxSS0=;
        b=qmbHXsnD9jv/W4bndgA9/HjHBw+TbY+CdBRTY2e4hZdKoyIG8UxqeWztlafP3b1TqN
         RI1ZtzrUaFmBC+hWdBWh6IcnfJS+qTTMV/wo7/C7smumgT3qUH+o96bf6jH12ivwjhCg
         OUb/adU6l3ve91W7AmrkQqRNq8knEExn4iD7v0Gkjp823pIyo6ZBdkZ0vwzTktig3aaM
         oc5sSKPjcteBGh/sVh/6yRSrXfe19/CGO/wePgwpOplFnDDZT9Kj5+Q4t37VAvM/hY61
         wuc/0k9+c7pn4whe3Q0nbPUAlBXxasE1WW7I8CyZO9QIh8j0n+BKjjcPLH+CG89HnV62
         ORrQ==
X-Gm-Message-State: APjAAAWIIThoYtOJonqnSNukq6LiFFDNjXVnly4ik1PudnOOHgYY53Kd
        +XRnfzABDzOS0s4ysHQE+lqE3VEos0Fep1GwlVVGYw==
X-Google-Smtp-Source: APXvYqz7SKVv+770ZaFi2dowLu+8kazlXKxtMl134e8KL6iEs1D3IFyj0n8c6LkAkAZ7K4ZgRmQZxxhDp/pwxZbULu0=
X-Received: by 2002:adf:81e3:: with SMTP id 90mr17109059wra.23.1581554291169;
 Wed, 12 Feb 2020 16:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com> <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
In-Reply-To: <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 12 Feb 2020 16:37:59 -0800
Message-ID: <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:21 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,
>
> Looks very nice! Some questions/comments below:
>
> > Depends on Constructor support in UML and is based off of
> > "[RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules"
> > (https://patchwork.ozlabs.org/patch/1234551/)
>
> I guess I should resend this as a proper patch then. Did you test
> modules? I can try (later) too.
>
I have not tested modules - you might want to test modules before
sending it at a proper patch. I just know that it works for the
purposes of this KASAN project.

> > The location of the KASAN shadow memory, starting at
> > KASAN_SHADOW_OFFSET, can be configured using the
> > KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
> > space, and KASAN requires 1/8th of this.
>
> That also means if I have say 512MB memory allocated for UML, KASAN will
> use an *additional* 64, unlike on a "real" system, where KASAN will take
> about 1/8th of the available physical memory, right?
>
Currently, the amount of shadow memory allocated is a constant based
on the amount of user space address space in x86_64 since this is the
host architecture I have focused on.

> > +     help
> > +       This is the offset at which the ~2.25TB of shadow memory is
> > +       initialized
>
> Maybe that should say "mapped" instead of "initialized", since there are
> relatively few machines on which it could actually all all be used?
>
Valid point!

> > +// used in kasan_mem_to_shadow to divide by 8
> > +#define KASAN_SHADOW_SCALE_SHIFT 3
>
> nit: use /* */ style comments
>
Will do

> > +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> > +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> > +
> > +#ifdef CONFIG_KASAN
> > +void kasan_init(void);
> > +#else
> > +static inline void kasan_init(void) { }
> > +#endif /* CONFIG_KASAN */
> > +
> > +void kasan_map_memory(void *start, unsigned long len);
> > +void kasan_unpoison_shadow(const void *address, size_t size);
> > +
> > +#endif /* __ASM_UM_KASAN_H */
> > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > index 5aa882011e04..875e1827588b 100644
> > --- a/arch/um/kernel/Makefile
> > +++ b/arch/um/kernel/Makefile
> > @@ -8,6 +8,28 @@
> >  # kernel.
> >  KCOV_INSTRUMENT                := n
> >
> > +# The way UMl deals with the stack causes seemingly false positive KASAN
> > +# reports such as:
> > +# BUG: KASAN: stack-out-of-bounds in show_stack+0x15e/0x1fb
> > +# Read of size 8 at addr 000000006184bbb0 by task swapper/1
> > +# ==================================================================
> > +# BUG: KASAN: stack-out-of-bounds in dump_trace+0x141/0x1c5
> > +# Read of size 8 at addr 0000000071057eb8 by task swapper/1
> > +# ==================================================================
> > +# BUG: KASAN: stack-out-of-bounds in get_wchan+0xd7/0x138
> > +# Read of size 8 at addr 0000000070e8fc80 by task systemd/1
> > +#
> > +# With these files removed from instrumentation, those reports are
> > +# eliminated, but KASAN still repeatedly reports a bug on syscall_stub_data:
> > +# ==================================================================
> > +# BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x299/0x2bf
> > +# Read of size 128 at addr 0000000071457c50 by task swapper/1
>
> So that's actually something to fix still? Just trying to understand,
> I'll test it later.
>
Yes, I have not found a fix for these issues yet and even with these
few files excluded from instrumentation, the syscall_stub_data error
occurs(unless CONFIG_STACK is disabled, but CONFIG_STACK is enabled by
default when using gcc to compile). It is unclear whether this is a
bug that KASAN has found in UML or it is a mismatch of KASAN error
detection on UML.

> > -extern int printf(const char *msg, ...);
> > -static void early_print(void)
> > +#ifdef CONFIG_KASAN
> > +void kasan_init(void)
> >  {
> > -     printf("I'm super early, before constructors\n");
> > +     kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>
> Heh, you *actually* based it on my patch, in git terms, not just in code
> terms. I think you should just pick up the few lines that you need from
> that patch and squash them into this one, I just posted that to
> demonstrate more clearly what I meant :-)
>
I did base this on your patch. I figured it was more likely to get
merged before this patch anyway. To clarify, do you want me to include
your constructors patch with this one as a patchset?

> > +/**
> > + * kasan_map_memory() - maps memory from @start with a size of @len.
>
> I think the () shouldn't be there?
>
Okay!

> > +void kasan_map_memory(void *start, size_t len)
> > +{
> > +     if (mmap(start,
> > +              len,
> > +              PROT_READ|PROT_WRITE,
> > +              MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> > +              -1,
> > +              0) == MAP_FAILED)
> > +             os_info("Couldn't allocate shadow memory %s", strerror(errno));
>
> If that fails, can we even continue?
>
Probably not, but with this executing before main(), what is the best
way to have an error occur? Or maybe there's a way we can just
continue without KASAN enabled and print to the console that KASAN
failed to initialize?

> johannes
>

-- 
Patricia Alfonso
