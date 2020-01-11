Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E947C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC872072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgAKQVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:21:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgAKQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 11:21:34 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MA7Om-1ixR3u1dyE-00BcEp; Sat, 11 Jan 2020 17:21:32 +0100
Received: by mail-qk1-f178.google.com with SMTP id z76so4845525qka.2;
        Sat, 11 Jan 2020 08:21:32 -0800 (PST)
X-Gm-Message-State: APjAAAV+xPOTNIum1DTMGzBc32GfFKrD36xosqYU5whPE6L0ypkGfhN0
        e/CWuzZwKUbcQ5CNQtd/J+PdGWaImwViev6zB/Y=
X-Google-Smtp-Source: APXvYqyUQ+1umLAhS3Bm3WiAPaIa5zQhdGd1bt3YDgKZSygcwFwuyAG5XgGigoAyhcs9Z3KHaAN/PlWtbZai2e30oEo=
X-Received: by 2002:a37:84a:: with SMTP id 71mr8365643qki.138.1578759691126;
 Sat, 11 Jan 2020 08:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20200110204903.3495832-1-arnd@arndb.de> <20200110210512.GB30412@brightrain.aerifal.cx>
 <CAK8P3a2VONV2Z6rs=xpntJyzfX4W7YijqCFr-f-PNMm3g4zRyA@mail.gmail.com> <0BF859F5-AA95-4941-A80D-7D33F7AC3636@alum.mit.edu>
In-Reply-To: <0BF859F5-AA95-4941-A80D-7D33F7AC3636@alum.mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Jan 2020 17:21:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a109n5JWNJG557i+NtqJuVDU3K0tYcY3DGhjopOHQWp4w@mail.gmail.com>
Message-ID: <CAK8P3a109n5JWNJG557i+NtqJuVDU3K0tYcY3DGhjopOHQWp4w@mail.gmail.com>
Subject: Re: [PATCH] hcidump: add support for time64 based libc
To:     Guy Harris <guy@alum.mit.edu>
Cc:     Rich Felker <dalias@libc.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZHrUmBaNX1d8ZysSWkioreCOyec215J+zph9SYHp039wOh7ZKTy
 nPo0hXRNl5bned2hNeZDNMgZ4yGTUF6x9U9vX2zHk4mxmaqAh8RuK7WOY1JqNjot/LgcNO3
 6A9pAAcKddt2iEi2kFMksnzQa/k1pBQTC8mJRWb0GAC+Kc7VZ5zMC1xNT7nFX0SS2130Hj6
 cbd3tIpksoLMBDiD9naZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8qeHBL42Pyw=:YBchiJbJMNRjohDgudsLeC
 eQe6ASoSR5d3ftFDgzuG7CB6HtZZI89pfS1kA5MZj7cDFfauBAC3NvdwhNU2+/TDVZqgXkbpv
 ucNTrqGZaefkX5e3o3wpNYYyjBRaeyTNsCcmTQ9xBXyRxgTO83GXdusT32mZjE3haU44f+6Xq
 m+qHguAQYQH1ng3Ko2XG+dWU5L+Cqxrb4ZT+FTOgSbBHWc9AxpYBDv1W7wp5aW06bOuPO+hy+
 AD1eEhx7uBGxOPuY9H1BUGdDfk3xM4mwNxCsKNVEd+hnxwkJJhy5vK5utADYh0D+nG5QzeR6L
 YGIZs+4a0265r4liIvowdQ8T0uz8maKcn4ZSen148gZl4nI18jfVFV00h8OvRAbs1zBVrkiGC
 9HHidcd1DMQ1376vdji1iLprF1YRizlNGrlMbvI6Jm07aqlkJyAjpKqcvBKojW2/hFz7DMA91
 S/gIAOKnnfsrgnE3cJbGogo/uVkTScjMyQwSqR9f4pMbgcTwTUFVB/4AGJj+mZzYrorZwZ34k
 CT4OWeshSkio0UaA0+pbaOi1ygq2n6U0GgNmOpEntaLo2TRqgRrggDWIY2TtTPANaOpvlfoM+
 6fAlyL1upnEE79eaJTvpbZe/NUNwBc2fUILffcnmBZRXHi7OfChK1TbDfFrJTtUDbb/Sddzpr
 nouCajXeYYS3INICEmtTxlHy12vrXoU8FRuw8nbtjLf/oI7jLROXorEnbWPnrj3DFJ6NOwPN6
 A8ZijVwFBT/o/tOeB8deN8DPtaCMTKhc3csKS2pLE6kChUB40wGruugtJJv9QWM6tVJEjjQuB
 JXUuoQAuJOTi9IVsjDveUVHaDg7s/yum7S5rDAsX12BlurpSICCBRp6ahc27pmU4kXFf2duOP
 tIdjp+QlmLCJymaF55UA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 was On Sat, Jan 11, 2020 at 12:32 AM Guy Harris <guy@alum.mit.edu> wrote:
>
> On Jan 10, 2020, at 1:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On Fri, Jan 10, 2020 at 10:05 PM Rich Felker <dalias@libc.org> wrote:
> >>
> >> On Fri, Jan 10, 2020 at 09:49:03PM +0100, Arnd Bergmann wrote:
> >>> musl is moving to a default of 64-bit time_t on all architectures,
> >>> glibc will follow later. This breaks reading timestamps through cmsg
> >>> data with the HCI_TIME_STAMP socket option.
> >>>
> >>> Change both copies of hcidump to work on all architectures.  This also
> >>> fixes x32, which has never worked, and carefully avoids breaking sparc64,
> >>> which is another special case.
> >>
> >> Won't it be broken on rv32 though? Based on my (albeit perhaps
> >> incomplete) reading of the thread, I think use of HCI_TIME_STAMP
> >> should just be dropped entirely in favor of using SO_TIMESTAMPNS -- my
> >> understanding was that it works with bluetooth sockets too.
> >
> > All 32-bit architectures use old_timeval32 timestamps in the kernel
> > here, even rv32 and x32. As a rule, we keep the types bug-for-bug
> > compatible between architectures and fix them all at the same time.
> >
> > Changing hcidump to SO_TIMESTAMPNS would work as well, but
> > that is a much bigger change and I don't know how to test that.
>
> If so, maybe I'll just do that for libpcap.  Libpcap *does* have an API to request
>capturing with nanoseconds in tv_usec (and I plan to give it pcapng-flavored APIs
> to deliver higher-resolution time stamps, as well as metadata such as "incoming"
> vs. "outgoing", as well).

Sounds good to me, just make sure that you no longer reference
HCI_TIME_STAMP and it should be fine with both old and new libc
versions.

SO_TIMESTAMPNS was first added to the kernel in linux-2.6.22, which
is probably older than anything you care about,  but I'm not sure what you
need to do to use it on bluetooth. It appears to have first been added along
with the monitor channel support in linux-3.4.

On a semi-related note, I see that there is a y2038 compatibility in the
libpcap definition of struct pcap_timeval, which uses a *signed* tv_sec
field. I assume the sizes of the fields cannot be changed, but it would
be good to investigate if you can just make it unsigned instead, changing
the supported time range from 1902...2038 to 1970...2106.
It probably makes sense to do this together with supporting nanosecond
timestamps. You could also consider changing the format to use a
64-bit nanosecond value starting at either 1970 or 1902 to give an
even larger range.

       Arnd
