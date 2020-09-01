Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CBFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E84F206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIAMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:47:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53455 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIAMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:47:16 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuUWi-1kUCnk0TgY-00rWwS for <linux-kernel@vger.kernel.org>; Tue, 01 Sep
 2020 14:47:10 +0200
Received: by mail-qt1-f177.google.com with SMTP id b3so698121qtg.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 05:47:09 -0700 (PDT)
X-Gm-Message-State: AOAM532fabhHKWDoPLYi/0WWkPE4Bp9d5MhZBPOqv6ucRM77EuaHGzJY
        wrj2s6jOZyTCjC50HaHDTdYI6QM9qg+2qh1jNJw=
X-Google-Smtp-Source: ABdhPJyEX1Bj17gYYbPbQRBgq2qQMyZPZIpAPBTqH2kyUvklm+l3HhpmVOla7Px2A9na4NmbDSFrdP0TE41yus16msQ=
X-Received: by 2002:ac8:46d7:: with SMTP id h23mr1554599qto.18.1598964429025;
 Tue, 01 Sep 2020 05:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
In-Reply-To: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Sep 2020 14:46:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com>
Message-ID: <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com>
Subject: Re: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:850DmXH/rTlWd/nxehZmZuhDMjNFqASnRAD925F+4UZe/2itSh9
 L4hvoK0J4b0jE57zHhb1NT43zf4l1ybhRrsBfPf3wqKu/2ZQeGOXG7QMCxivMTFvGveMM+o
 GfgYwKmRMZawSxUfq1GK+q5x8M+bCSj5s8RSoLIzVvpUZFgx095plv+uzr8qcJjAvs4lz3f
 UPIWsRXYv5MjByhVCG+qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LzUa6R8TRk0=:fiPQ4iNPwKzJuwRaAhGSJy
 zX78459wEMI/FyNi+fAAMWGbPS2WzE7MUIhhAr27HZsR8J5pRDZ2WJSdsH+IoLjBWTpkQ+iui
 O5QjqwXx+2BiOfq5JiQYBmBhIT50SS01mKBDo1AuDiJVdYpHjMmFDb6T9+2LzIZQ9suAA6tjt
 SUtSka+4nuqMBUltDGGK+Zr7rwQudYIuwOa64qeD+Q9yvylueaXJgBA3bCMWBmSUeQz4sYYJ7
 NUPxKM0G2BQHWSTyVAWFO96dBUfo1G38rdKlNg3GNU8CsbMn/MSh5DzujShJkMoYQraPoli3M
 6xUrfAZy/qTUl32ARjzdNm1ubDaYNb2G0UnzyKoCHymOGEn9bCpCqJqljYupCfUJTmfwB5zBR
 PJ32mNkEDWYmsLEYhLEHsW9HCofKXkvB/OM2i8hygcjld1jyODlIB6fRKLPZJY7pnqpBZAFFT
 G/aGrNwDTGSV/5sv6vUHNrLtRJDCz4GFNWtmqW0OTVYAUhPw7YrhGHaF4KCv1CnLWOjUX2tEo
 SbYRX5vzMfsOkBbrInI4vInXzZQg9tFmkfcUIRo2rFECL/RHk5eYCA1i3xcLtMuCAXDw4de4t
 r26egOW5ZxHrTH7dvm/LwlpiB1K8mzM1rBzUCHF6nUZdzKSnYk0g7kGg+487Aiy1BiKfqZ1uH
 YIH33reTsj+oNkdtcIaTnihjN0RMcTv0x0LfwNVMw+0/IDMI41LgDoIkEfQtOyBQpnBxapptK
 BIjkwD0H/Cyt0v/BWogzFVBRFpENIn+iCXnsteCZvD6rdaJAmgEzIJ9HR5gVkDzaA64UK9yDC
 XlljCcWy6ht0ARaSrOla0HuqvFenQbXYyLHmqGrsBfQKgoCyYhBdisp9h5hy5Crfodc5+Ve
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 11:32 AM Zeng Tao <prime.zeng@hisilicon.com> wrote:
>
> Since commit bd40a175769d ("y2038: itimer: change implementation to timespec64")
> we have break the time clamping which handles the potential overflow.

Indeed, good catch!

And I broke it despite the comment telling me about the problem.

> In this patch, we fix it in the timespec64_to_ns because there is
> possiblity to cause the same undefined behaviour on overflow whenever
> the function is called.

I checked the most important callers of this function, and I agree
that truncating at the maximum would be sensible in most cases
here.

In timekeeping_init(), there is already a check for
timespec64_valid_settod() that limits it even further, but that
wouldn't make sense for most callers.

> Fixes: bd40a175769d ("y2038: itimer: change implementation to timespec64")

This one caused the regression, but if we add the check here, it
may be best to also add it in prior kernels that may have the same
bug in other callers of the same function. Maybe backport all the
way to stable kernels that first added timespec64?

Cc <stable@vger.kernel.org> # v3.17+

> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
