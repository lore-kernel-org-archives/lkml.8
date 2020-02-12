Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BDC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A9020714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfOuOrPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgBLGYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:24:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38420 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgBLGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:24:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so1029707qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OOHsjtYMgDYJvlYtd6T0hN9gxm/R2JJYyhVvz7S9ig=;
        b=BfOuOrPLAsr5nPiUros+fQvJWZffy4fx7Z59zbk0cx5+OKQg34UlM5/h+CXZ0TCna8
         CUqsRCkfBG+pwj9ggsXSQw079MZMTwEpslqiwpi3RJCkBuS4tif8aYynZUSshq7WRZT8
         RqK5tzt0rL0id8YymwDCABXgp26VDa/AzZyw925xpnejf46khcqs7Xd4uz3lF3QwBEXQ
         C9YpQsPQobHPOENdtA48XM9/LOdcMWTPb7p1NdPqKBgMAYgbe/p2QHlacj4SL9WLvfL/
         R/eou232RNaB7/LkUwJ0p6kwSv9Xk8Kgcvb+V5/g5ogkb+VvXVW9lp3IYntUzhxKIWP0
         CRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OOHsjtYMgDYJvlYtd6T0hN9gxm/R2JJYyhVvz7S9ig=;
        b=gCbN2wBWf+mQJnw7VlJ2ZDY97+QCtIpeR8oGSQMZCVizwK4QCoKqSBkFY0NzHJhNmc
         eXawhpLhl9wdaQJ+2xdKsbA2OpkfLc51mff/fj7ljHAqId4ULRJDYHTXakQBfmv+zFHL
         nsRAxdq4kSXrJHxsIyKZG2gPNuKbSWQuzMSYQO2SiK71bx7Dq21CKkdZVC2K15Ra2d9P
         JaIAoOm+gI3PUbX2ePDUbj0LKR/t5A+KraJMy+U5meEku3n5H2UvXa5fe8gVOc05Q/aa
         WltTVjt0QsVusHu45P0LI99l0uP6uPcMdM0uLEU4G4OxKdWQblRMx0hd9u2d0BuRyOft
         bEzw==
X-Gm-Message-State: APjAAAUJoDNFGMuFAmPl3SLlegONhYMLQoQmpFpNO8caByUp1nFHJTX7
        hdUNZDkVevbAdAwZVS0DsFUPlpbovK6qqs12mHf+Qg==
X-Google-Smtp-Source: APXvYqzmZqyZFI5to+6MZOrXvgiAsZ8aWUJpmFanwe3RRu3ka0Ip5gWZ4OxE9/UWpAPihuEXUlXvxvvAIinLbZP3flo=
X-Received: by 2002:a37:9d95:: with SMTP id g143mr9264374qke.256.1581488690981;
 Tue, 11 Feb 2020 22:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com> <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
In-Reply-To: <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Feb 2020 07:24:39 +0100
Message-ID: <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 1:19 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > > +void kasan_init(void)
> > > +{
> > > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > > +
> > > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > > +
> > > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > > +
> > > +       init_task.kasan_depth = 0;
> > > +       pr_info("KernelAddressSanitizer initialized\n");
> > > +}
> >
> > Was this tested with stack instrumentation? Stack instrumentation
> > changes what shadow is being read/written and when. We don't need to
> > get it working right now, but if it does not work it would be nice to
> > restrict the setting and leave some comment traces for future
> > generations.
> If you are referring to KASAN_STACK_ENABLE, I just tested it and it
> seems to work fine.


I mean stack instrumentation which is enabled with CONFIG_KASAN_STACK.
