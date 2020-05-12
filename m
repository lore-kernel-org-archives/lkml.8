Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CAACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7818206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgELTuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:50:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:50:18 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MAgIQ-1jNYHp0ihE-00B6ut for <linux-kernel@vger.kernel.org>; Tue, 12 May
 2020 21:50:17 +0200
Received: by mail-qk1-f169.google.com with SMTP id i14so13838126qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:50:17 -0700 (PDT)
X-Gm-Message-State: AOAM531Twh7mf9NUGMsI4X+/5DM9aVqw7zlhsLZQxovS1fASuLeGqap4
        7N9TjLIIl3H2XVHhdPhQ51qd0ubXkAPSv1Nnyvc=
X-Google-Smtp-Source: ABdhPJwKJd3U0klcU7IDRjkuleiIc4wPNOMiOc0saxTFEWTaSUun13tPHi7rCexv4xkXDUCA3EAbyG/iGjnOgQ+uULY=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr2657025qkl.286.1589313016016;
 Tue, 12 May 2020 12:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc> <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc> <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
In-Reply-To: <20200512104758.GA12980@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 May 2020 21:49:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
Message-ID: <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:blbAoHz0+CqER1w53waskxa/mVPfQBIA/zs3Fq8lPgn02aAoN47
 NTjfMzxYskcWg4MRCwhReK/i5MnwJucBCAMw1LS4XmyVL/jTL8Gv2b+v72PG9EBbcPRbJ1c
 jf4fi8UJP+IbaETb9YkiAq1MNLtkAYcd5eclSWZTjBn7za/NjOiAVhxDpuH6IafuHNynY6m
 HN6ieMnUNrs7GtnG7QPEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d9K5INitm8A=:NzYMwt2C46/nI537H/luU9
 n5wh8nO6TfZhr22Q02qvXH23v/VHtUeQOY8aQBYiTC2uHBJJYEX61svXKadtaBhX2tNyOL3oa
 f7wWH8aotE1rk2JbJROv4V9PIJYMrv2K/MbtVNPXztgOkA4styc8xf7lEEQWLhZieKzZUcrP/
 YfU73qx2sfJHRZSs9FBceZVRPz1RyLBh2cTH3gexGbkJLS2GkagEade/uuiD7g/PYcWgAzO0l
 1InMbU1BwFXp4qR7PaTfRCy1TdGnhzwnvBgd3vScqL+ZLPmiOJ+1uIiPVPFsMzT2qu757qEQe
 byiC9LonIq/gdwxH6nYMr0RueQA36JgMBkC6ovSpZfQBfmvrnS3nlSylsJ1PEyLtqpzNjZBaK
 moRE5Oj/5o4dfDqsFaNeno1ahTglqCKwPU0AUcF0B5yG3lLj9sLa43IPxEyS0/YPtteRJeBqR
 DJ5B8+Yr0louUgq+lz+l3Fruz+Dn5ph8FeC0X8b0R4dT/wfPopOpAKsIvItBaWOVpJ0wpL2fC
 k2cFxTwjRvI1R8+kQtHVV+mMeyabhiQtqB1n5WtTZObLF+Kluc3b23m62iKgK+Gq6Z1lhP5Iz
 OMmQBa8NH2cOId76aMNZ2zl4fI00hldwtr9W8Bj3iYK086IQavLGVRF9HRUJjfLZaMS+tpia1
 MC4vngH59l69JG4GoDx0wdIFVHQUWlc79KWL9YHMJf4ElHV8+g0HgwcwomtRGPv9yDVFpykMJ
 VLXNYOon3eLHzucYVp4b1wLZ6Qp9fBfyyOjJj7fQXlYvBDqcu311ADU/PZaLuQikWFXmLNocK
 fomf85JMPce6oHb4Pr5MJXPEWc6iknqd4tX60GvSkEaxONYZ7U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 12:48 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 05:29:29PM +0200, Arnd Bergmann wrote:
>
> > What do you currently do with the module address space?
>
> In the current setup, module address space was untouched, i.e. virtual
> address difference b/n text & module space is far greater than 32MB, at
> least > (2+768+16)MB and modules can't be loaded unless ARM_MODULE_PLTS
> is enabled (this was checked now)
>
> > easiest way is to just always put modules into vmalloc space, as we already
> > do with CONFIG_ARM_MODULE_PLTS when the special area gets full,
> > but that could be optimized once the rest works.
>
> Okay

Any idea which bit you want to try next? Creating a raw_copy_{from,to}_user()
based on get_user_pages()/kmap_atomic()/memcpy() is probably a good
next thing to do. I think it can be done one page at a time with only
checking for
get_fs(), access_ok(), and page permissions, while get_user()/put_user()
need to handle a few more corner cases.

        Arnd
