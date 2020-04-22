Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B24C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E2820776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jgw7Bqaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDVW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:57:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83861C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:57:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so1037466pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPEl3Y+Ybg1crmwtPQDknu/xwFvAPuHK+btv4xjSltE=;
        b=Jgw7Bqajg28NhTDdElXhQ7wa0XifQzEGQs+Td/iiyLGb2RxJZmKCXGVqkj44gkWYzY
         qWhgjmyYsGNxNHifARjGb9wW7OHGi50vEtanIdUufMuItUZ3I2jWQdv4zjVdSrw1RSrq
         WQZwlwbhAcI5zQCyfOIIaVxF6pw95ONDzCr8GvgODnuI6TA5P/uMOb02/X4lJdR3YgMv
         xWUdrmZaQ1XR+jnCGJPhD/F8Zl+xgaiP8ezlQ1UvjFPieOji3hMKMTZ2QSRXEBSRmToD
         CR30ELb7eKMor5x8w/YiK8h0yBIYuzeHY4UcOKX7d2yS4qQUUqZnrzHsjFZ+KUwwagA9
         4Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPEl3Y+Ybg1crmwtPQDknu/xwFvAPuHK+btv4xjSltE=;
        b=ii+vjbkiQu67sdDtcchRf3chUSN+Q+LsPUbYLXwZDCsVdgYPH7szC+bPwRAxyCOnX8
         O4xlSdyae/KDrk8oqczcghH5NYJeoM8c0qcL88+cULobSixnsgchRk8w2mNswGcdbI+t
         MZcVSJsR4OF72NrfOcX7L720TamhaCsip6EhEL+mtnEJrg8IBNa9LaR6LBGIY1SXfJ6R
         e2AQTiDeZgg4xxBWOxwkM+GYQI5hok03ryU/A8Zg2yRc9lJfTgbvpPk837xwzRA9DFoS
         9q4ObgFm1PH6S6YoaKlvGo4QkM85qQXHXtyIyj3E4toumfIFPCOTmcP3pGG1pMPitAnD
         ZURw==
X-Gm-Message-State: AGi0PubjVeoLyQ7uz7HrHHV8P/xVUQxbelMblcPeZ9x7IY2ChdCre6yt
        LbRgD4zy0upUZK4bgrAnW9bNosMKJmKvwWk/ey/j4A==
X-Google-Smtp-Source: APiQypJf7meqiWPxS0hJxeoVT1P8BUfJIkWWIhwbSz+a2LTnV7lN1yEAkKiTpcBEQr0vr4iGsaqkqKZyNu90vphRzJM=
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr980349pje.186.1587596267562;
 Wed, 22 Apr 2020 15:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak> <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic> <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
In-Reply-To: <20200422212605.GI26846@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Apr 2020 15:57:34 -0700
Message-ID: <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 2:26 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 22, 2020 at 02:05:13PM -0700, Nick Desaulniers wrote:
> > s/functions/statements/
> > or
> > s/functions/function calls/
> >
> > Sorry to be pedantic and bikeshed a comment! *ducks*
>
> Yeah, you better duck! :-P

*gunshots ring out, across the ghetto that is LKML, reminding you that
you've reposted in the wrong text formatting*

> Btw lore.kernel.org has this cool mbox.gz feature:
>
> https://lore.kernel.org/lkml/20200316180303.GR2156@tucnak/t.mbox.gz
>
> This way, you can grep the whole thread, open it with a proper mail
> program etc. Very useful for catching up on threads.

Ah, neat, I see the "mbox.gz" link near the top of a thread near
"Thread overview".

Would be helpful if I actually took the time to RTFM; just dealing
with a lot of constant nonsense regressions lately.  One day, I'll be
able to sip margaritas one the roof without anyone noticing I'm not
working...one day.
-- 
Thanks,
~Nick Desaulniers
