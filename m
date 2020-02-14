Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F401C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40A2465D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGa0u271"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBNAy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:54:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55777 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:54:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so8269097wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 16:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ik5Lp9/74mcaPuHZovIpPmbd4aGXGDxcFYnSBT9/TXw=;
        b=cGa0u271dSwrep1s8CVSVu7e7UoM/mxummeltvrPtdivYNmoHkF0Z9L8BYVmUxFGRT
         /tz/vfItOrtE5xaaiwuxfLWS2NhZjxqiMPXyNrfp+vG60XTmqxdHOHc/UypbQMJXcp2k
         c++Xvq3H9it7X7FlHW6ar1ByDuu2JJN4MHJx6GqCl82VW+S/h0RejvG/eN+KQU5OOQlU
         UWoZoNB5ahJZlQ+SjlG9tNF6xPcMKPRpTF1kMk9KYJsC5hNbgkokteoYlqwz8YpJ7SP3
         d+gSNyULDIJVhIhQF2DHtubyemgZXqFuPwxcZV0Z7HgX6/Khxwwp8PuyGMOCuyxFP2BW
         2x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ik5Lp9/74mcaPuHZovIpPmbd4aGXGDxcFYnSBT9/TXw=;
        b=ODy93Dj7QtWoa7a7iyeGq8U81AaV/Yp+3DMELVhVOMk3su1pHohIRabrKNf0Ra2RSR
         YkdivhMBtAN6Ffv97OkNZlzcFAR/e+9NC7RHe6NtVfr+8KaUlypkv65KCC/++r9ltZb0
         TcSCXcjNNCIlR6V7OeUzdNHO+zyAoKYTYC/GjZKDtTW47B2a8levxaeyFROcPwMq21M5
         F2b825PeYJrIaA1hYWH8JtuF2u23xRHP6g3VqFlXCq20fwTuB92l0xn/CkH8Bp4LuIXK
         krtECLP1n8EHQvMSaZN6cUb8acsciNMFilC8EWZ3QthHSOZWvu0jbdauC6ZeA9SGFU2I
         gQIg==
X-Gm-Message-State: APjAAAWaMPlVBKAHuFmUAmTeAUISBo0TPt+Kfj4gwzAVgdXBX+vbyfBd
        Lxev542vGw6S+OS4BUqZJT9COB5/zYsQ0trn8B7XIg==
X-Google-Smtp-Source: APXvYqzKeNuGIqzQG9e2TKL1ySUELnvG6LNlGD+yRnSvhT27cffkqhcwWnX0sAsDc3po4Xs4AjKUAnWBurtzmv1nNfY=
X-Received: by 2002:a1c:16:: with SMTP id 22mr878442wma.8.1581641693059; Thu,
 13 Feb 2020 16:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
 <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
 <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com> <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
In-Reply-To: <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Thu, 13 Feb 2020 16:54:41 -0800
Message-ID: <CAKFsvULfrFC_t4CJN5evwu3EnbzbVF1UGs30uHc1Jad-Sd=s9Q@mail.gmail.com>
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

> Well I had two patches:
>  (1) the module constructors one - I guess we need to test it, but you
>      can include it here if you like. I'm kinda swamped with other
>      things right now, no promises I can actually test it soon, though I
>      really do want to because that's the case I need :)
>  (2) the [DEMO] patch - you should just take the few lines you need from
>      that (in the linker script) and stick it into this patch. Don't
>      even credit me for that, I only wrote it as a patch instead of a
>      normal text email reply because I couldn't figure out how to word
>      things in an understandable way...
>
> Then we end up with 2 patches again, the (1) and your KASAN one. There's
> no point in keeping the [DEMO] separate, and
>
Okay, so I'll rebase onto (1) and just add the lines I need from the
[DEMO]. Are you sure you don't want to be named as a co-developed-by
at least?

>
> > > > +     if (mmap(start,
> > > > +              len,
> > > > +              PROT_READ|PROT_WRITE,
> > > > +              MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> > > > +              -1,
> > > > +              0) == MAP_FAILED)
> > > > +             os_info("Couldn't allocate shadow memory %s", strerror(errno));
> > >
> > > If that fails, can we even continue?
> > >
> > Probably not, but with this executing before main(), what is the best
> > way to have an error occur? Or maybe there's a way we can just
> > continue without KASAN enabled and print to the console that KASAN
> > failed to initialize?
>
> You can always "exit(17)" or something.
>
> I'm not sure you can continue without KASAN?
>
> Arguably it's better to fail loudly anyway if something as simple as the
> mmap() here fails - after all, that probably means the KASAN offset in
> Kconfig needs to be adjusted?
>
> johannes
>
Yeah, failing loudly does seem to be the best option here.

-- 
Patricia Alfonso
