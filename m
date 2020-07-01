Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FEF206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgGAK74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:59:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgGAK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:59:54 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MX00X-1jJlrc1O4f-00XNgi; Wed, 01 Jul 2020 12:59:53 +0200
Received: by mail-qk1-f172.google.com with SMTP id b185so11099342qkg.1;
        Wed, 01 Jul 2020 03:59:53 -0700 (PDT)
X-Gm-Message-State: AOAM530Pr/UXhWxrak0xcyWKXpgviCxTN2Ym+CC6qF5QsdfyfmpMhbB7
        mhKw92z5GP6pJ81JM6DVJpcoLt6vacvS37TqvC8=
X-Google-Smtp-Source: ABdhPJztc8Rs2Aj01FvDlsDy8FiXAWwus7EMwqiq3oxxcJK+edsUbi5amD2c/ikaFMMy81wZESqitxpCJ/9YRg9OP74=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr25404833qke.352.1593601192134;
 Wed, 01 Jul 2020 03:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
 <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com> <20200701101922.GC14959@willie-the-truck>
In-Reply-To: <20200701101922.GC14959@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 12:59:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1MWBxHihcUaduqcpS2U61cKPujQG6mAfn3-pCokzLwUw@mail.gmail.com>
Message-ID: <CAK8P3a1MWBxHihcUaduqcpS2U61cKPujQG6mAfn3-pCokzLwUw@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:g7I2hYYZ2lCZFQ7sbdyRHfQy91HD0wtoFaGz8CBa/Dg3GlDiMEM
 0cDVsVCv/r0iOiUjFafyiLdI5VLmh3fb/4xtPl3rqxU4Dq9aAR/IVIxpZ8dTcS7JK3zGJBL
 MG2nTNgHBZNK1wJn0HRu5jLzBpCpkelS2+hqD9/5VgKCl8oaxz3X28Hcrvwu6vhZHbCE7Ax
 YdMUmUdrpIWPZtf4pB2+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4DwWKkZ8m/I=:B55ukcCg0k7NW87sDOEGI4
 ezfpNvn78XuzW/zJHkxhecufP7cmEd/Gl6VvKI96SgL/jjGAnD9G4VS7MAbL8DSd2MxlI29Jm
 pOgFyhsNXhAtoj7ENFbNNyXhj1XNN6d4DvI4+ZW3Yv08i8recA9aME7Vrtl0fSEnjUfCXlJ5J
 SYliPHA42Gx4R2DGnTELryvEoppMkIsH1ZSBFvM5pFGtyufvui+5w8k+5ELZ1W4qOJWz1NcRx
 /sgEwy5+TvtUTB/ZSMeTIwZ4mGVs52rW/OhwSeK+QV8Crg8yqtHFdhAGNCtoPAStpN4pctJhB
 se5V+o9cUGyLZFoxBO2F7eXJtk85pVY8LuTygSa5Kf5pNmwLZX/HhKbQuK21MOt9oQCGPHqwQ
 4NHC7/vbLc7ss525ziNJGxYJK5ePR8VdUEoqHa47zwqKEeR8OfYWMToshuvjnQcfNLecDtxeY
 p+oqSuKNyjkuyLtcyETqiyYzuUrNqgxPUq3SppAG04lsYFdAAYNMyavQ1zNhpGE8OKcOxELIo
 enuXtU++MpzFPDHXwbx66ECu7o2SacgzWZQcQmEG4CGsH+MB3HkhpnCKMnrToEbkn2uADHHIe
 DdgS7Vc1cTZcR/h75pQmF8cdr2Vi+YR0EBxsL2Ke5xp8G+fLIUGjbuIMo7CwxKCfzxPoPanvP
 iaD6bT+eDDzvrdijwabmzRXCoV5inzrcNEZoSVK7wQA/c2X/4tVbvEGg5+meuO0Sv3fO17YH0
 V0052JR0LleOOUQW0lk/D1getQWpdr7hdsBN7fvMuqlcpO/FRd4VzThCQ1G1nFwwZB8z/tvps
 rWlfjq+Cc3wfr1uZ/c2o7/0Tn7OzaGcEhD/ZpHjmJ9BiS/o+60=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:19 PM Will Deacon <will@kernel.org> wrote:
> On Tue, Jun 30, 2020 at 09:25:03PM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> > Once we make gcc-4.9 the minimum version,
> > this could be further improved to
> >
> >        __auto_type __x = &(x);
>
> Is anybody working on moving to 4.9? I've seen the mails from Linus
> championing it, but I thought there was a RHEL in support that people
> might care about?

I don't think there was a serious discussion about it so far, and
we only just moved to gcc-4.8.

I think moving to gnu11 (gcc-4.9 or clang) instead of gnu99 has other
benefits as well, so we may well want to do it anyway when something
else comes up.

For __auto_type(), we could do it like

#if (clang or gcc-4.9+)
#define auto_typeof(x) __auto_type
#else
#define auto_typeof(x) typeof(x)
#endif

which could be used in a lot of macros.

     Arnd
