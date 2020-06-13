Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C34C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E09A206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFMSz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:55:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:55:28 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MPXMa-1jXcXH3T3y-00Mdf4 for <linux-kernel@vger.kernel.org>; Sat, 13 Jun
 2020 20:55:26 +0200
Received: by mail-qt1-f179.google.com with SMTP id g62so9680038qtd.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 11:55:25 -0700 (PDT)
X-Gm-Message-State: AOAM532ZuUxdmmmIl6K43COS4OBHGgN+JR6dFNEPx8aNMB8jyWBtbYwN
        ZSrcaao6+Qapa6W02VahPw7iZu7VuGGT0dAtdI0=
X-Google-Smtp-Source: ABdhPJyuxw4tUYCzfqYU9Qk2nyGDIv212AgyB/v6klMsDa80OnzI1YzehoJDFzRkxl5xXtHUS44S4533nKMvd4MIeK8=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr8988128qtp.304.1592074524733;
 Sat, 13 Jun 2020 11:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc> <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc> <20200613125126.GE23230@ZenIV.linux.org.uk>
 <20200613125615.GF23230@ZenIV.linux.org.uk> <20200613134236.GA4086@afzalpc>
 <20200613153102.GG23230@ZenIV.linux.org.uk> <20200613154118.GH23230@ZenIV.linux.org.uk>
 <20200613160040.GI23230@ZenIV.linux.org.uk>
In-Reply-To: <20200613160040.GI23230@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 13 Jun 2020 20:55:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3MEu=00h1HKzpPw5d5Owu7NiYjoDWDUM5DdgLaCtaR8w@mail.gmail.com>
Message-ID: <CAK8P3a3MEu=00h1HKzpPw5d5Owu7NiYjoDWDUM5DdgLaCtaR8w@mail.gmail.com>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mo5KIWaH/QtFp8L0CgGFDvW2cCq8zPs5Wxrt1NFMjP3RPeJPhBc
 I3VQNsJrX5dY+wJ+rynN2XuewamXDaUuewppUFJ1tb1JVF1rKNvIcDtD4i/tpwCGW+LMxsf
 wuV86hqegFVXPuz3IUmUqPkci8X1MLO7Mb/Zrgz9UKulD7dO54STcWGwP4NYKSPpGjhu5Ei
 Vw86zGgAaqzhUuK3y/hiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pw4cFvkZ/7Y=:BIrBzpneh+lWAHOo8Qgr3m
 yKoY92S6d4DoJLdfQFLgUkQ4DNr9zYkzfxSNf09jVMShnSriH0dFR2OHXf6FHe5XkEIgi/9hP
 6klc0C0rBx7UDg0DnvQ5BpqxnReLZoW3wkGwgmO4BdaZ0bs/ij/zR6NN0fRu9RRCDGED5ryBk
 KnD0mzvzSmvXFzGHZeyepEgL98IkElXXbpakoV11KE0XrK+4fSTfMdjh/TuUBHUmLWF7/NZQs
 srkCF/M/X6y07vCoSzXybIKXmli5QpChXu9kUlvRYH/kfPBEl19q2+6HUtJndYJFHpO6O8mik
 8v6J8JZ7o5QMeE3s6e2ChqvYZX1BOoUXNb4rZg7V+JVjNbAx1ln4iWR+YmFU+p0tvwl4GcmG2
 Ag8Ui33MO9mhysxxd4CqN+3fjctY05Zjm9emS4yT/kbu8eiz0vVAVxMrDq6ntSl/xXsg9K4Ul
 ouRMZiqd95vzgjqzRB86rVYzWNqeiPL/9yODxEzbwZuNT6kimIwGbXlIRt4sGyX3sgcRRJ0+N
 QUeR/QgMU9lT2clUOD93XH9AVfuaajY8QeDEsfA6KkT6PcsBU8aYQpXGv/DP4xx29Y5bc+PU9
 HurrkUUEVP9khIJ+ZeyqTZegtE4KbPD1cwzpLAIP7VDeJdmXxD4S4gvtZAB9HXx+QuncvrHPN
 vnSOhKTAllGVTxQfZ2RW1ii2Qzqet8VIifViTS3R9bQOl+nCe7aqBpppqhu4JSWqEq639iB59
 lx3lkCkuOJUxguQZGf/AruyYdEcY/I1URWu3yBiHt807cFIXB0ciPAHXC9P9LUmB3m4uAMsaD
 S5Zl7ujv6c7kNjLsEQLSYgDfhXiYdTz5ncnjMzI68GIAxtFxII=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 6:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jun 13, 2020 at 04:41:18PM +0100, Al Viro wrote:
> > On Sat, Jun 13, 2020 at 04:31:02PM +0100, Al Viro wrote:
> > > On Sat, Jun 13, 2020 at 07:12:36PM +0530, afzal mohammed wrote:
> > > > Hi,
> > > >
> > > > On Sat, Jun 13, 2020 at 01:56:15PM +0100, Al Viro wrote:
> > > >
> > > > > Incidentally, what about get_user()/put_user()?  _That_ is where it's
> > > > > going to really hurt...
> > > >
> > > > All other uaccess routines are also planned to be added, posting only
> > > > copy_{from,to}_user() was to get early feedback (mentioned in the
> > > > cover letter)
> > >
> > > Sure, but what I mean is that I'd expect the performance loss to be
> > > dominated by that, not by copy_from_user/copy_to_user on large amounts
> > > of data.  Especially on the loads like kernel builds - a lot of stat()
> > > and getdents() calls there.
> >
> > To clarify: stat() means small copy_to_user(), getdents() - a mix of
> > put_user() and small copy_to_user().  I would be very surprised if it
> > does not hurt a lot.
>
> PS: there's another fun issue here:
>
> fill a file with zeroes
> mmap that file in two areas, MAP_SHARED
> thread 1:
> munmap() the first area
> fill the second one with 'X'
> thread 2:
> write() from the first area into pipe
>
> One could expect that nothing by zeroes gets written into
> pipe - it might be a short write() (or -EFAULT), but finding
> any 'X' there would be a bug.
>
> Your patches allow for a possibility of write() doing
> get_user_pages_fast(), getting the first page just as
> munmap() is about to remove it from page tables and bugger
> off.  Then thread 1 proceeds with the store (via the
> second area).  And then thread 2 does memcpy() from that
> thing via a kmap_atomic()-created alias, observing the
> effect of the store.
>
> That might or might not be a POSIX violation, but it does
> look like a QoI issue...

I assume this problem exists in arch/um/kernel/skas/uaccess.c
and in Ingo's old x86 VMSPLIT_4G_4G patch as well, right?

I guess holding mmap_read_lock() would prevent it but make
it even more expensive.

      Arnd
