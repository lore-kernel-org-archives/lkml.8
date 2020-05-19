Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F66120758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgESTyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:54:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESTyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:54:22 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M27Bp-1jdb9h1SZd-002Zsx for <linux-kernel@vger.kernel.org>; Tue, 19 May
 2020 21:54:20 +0200
Received: by mail-qk1-f181.google.com with SMTP id z80so1054206qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:54:20 -0700 (PDT)
X-Gm-Message-State: AOAM530XkrYEMdSEjjbI+V4yXCqDb75n7c3T8JDmzmt0AH9JkFLnJzC7
        rczr36ela9Whs1mb7QC5YcG9baSpmei8pinzpZY=
X-Google-Smtp-Source: ABdhPJxmZ665bnKOzvdR2P18X8izcsTLDXWEaUV5X4KMbj1e+DoEU64Tu5I7jwlFmb0Sax5yLCI3R4V6Wl4XCtmZdLc=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr1165079qkg.394.1589918059229;
 Tue, 19 May 2020 12:54:19 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 May 2020 21:54:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
Message-ID: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
Subject: clock_gettime64 vdso bug on 32-bit arm, rpi-4
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, Rich Felker <dalias@libc.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eJozbr21bM9Lq8IgkoRNAniWBUDHZTSvimsiRW2DZAMi16bo3pM
 n+ci7aUKApbYDCEJC0UbW+P03V0a7PJ3GC4HQl3gQBLX1bdQOBeyRBmUjgB69rE7KUW5U/F
 EZWWCV3EZEHgGsP2NOYE3d5nBYJ27yhEFbVqf0KTQyyTbydDWE5vdtGQBOS08cSRoXOhQcH
 SJxLbqRF/3rnJ5DAXtv6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EuyWfmasTzA=:7w6J20igkootAEltQsPdF2
 ZiY/tO9yx6Ybd4wBWuiBc78n5s/Ut7C9U7WELsZMDyuVYkDgq5UX1bCE4CCU4a4TzTdS3wH5l
 4YgStzr4Jk20jdLQQWiEiwbm7zBnMSwxuBsV5MPfgIbXr9zzEn0/f5KodR8oGa1poefxIaaDq
 I8IboK1a75mZoGjg4oGWArj9fFmB0xjaoRWGT4x0u+N/DmPDVBVTkoIenAlPlLfAldGUynrus
 WQ9HqYqv9F4xvicWAeBe2of4DLuVfx3EmNv0vM4PcdBCRo3/1IZ5QdzK50g9drRWNmksJj9sF
 yWj/0J/w0OeTOZCauP0oGnXhBPwE5inXFfcZh0wa0K5RJ+CX8wgJ1f7FXi8aZeLSxgrSZGWND
 PilV8WxEpL9aORl/zdBUNnsnVe9yVNHSicwfGKJpJ23GsmaxXSxkI3eK48zw6NJzP6FeRBZvy
 WKnEf6Ax1y0MVsSHJCanWmnX0ueiB5yzzNSi1Rspu55caXmgXpHuh7F1/vKYguj3W8ppopTVc
 GmC00DXNizrZaYhNcoUj+XQTGuh3g2Gb6HjP/X7ZL24jhF9dq68zaBS5m9c3XG0mB/OaKNUDo
 i7hCN7oefqZaWFWfs85tsHRIhFxZf3IJ3KsI1bYIykUJ+Dw5c2x7zFPda7LNQGD2TCsGKQmZm
 LmuTYzMIRZpxPxg2ExoWWQnhTOTxvTxnuYoz4068dUAEgicinYQ2YO9gM+JWkj6YUUI6My5Hy
 et2vjFlpcCyVBD48KmXg0XbKvVszeeUELacwlrvnTTmhndPQdlbJVfP8NbqEJrhKj185G4iBI
 nefDYU9ek1zZzsi4M2AGIuw4m1Tth9pYzoF4KDXtktr71CgFXo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
month: https://github.com/richfelker/musl-cross-make/issues/96 and
https://github.com/raspberrypi/linux/issues/3579

As Will Deacon pointed out, this was never reported on the mailing list,
so I'll try to summarize what we know, so this can hopefully be resolved soon.

- This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
   kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
   clock_gettime64(CLOCK_REALTIME)

- The kernel tree is at https://github.com/raspberrypi/linux/, but I could
  see no relevant changes compared to a mainline kernel.

- From the report, I see that the returned time value is larger than the
  expected time, by 3.4 to 14.5 million seconds in four samples, my
  guess is that a random number gets added in at some point.

- From other sources, I found that the Raspberry Pi clocksource runs
  at 54 MHz, with a mask value of 0xffffffffffffff. From these numbers
  I would expect that reading a completely random hardware register
  value would result in an offset up to 1.33 billion seconds, which is
  around factor 100 more than the error we see, though similar.

- The test case calls the musl clock_gettime() function, which falls back to
  the clock_gettime64() syscall on kernels prior to 5.5, or to the 32-bit
  clock_gettime() prior to Linux-5.1. As reported in the bug, Linux-4.19 does
  not show the bug.

- The behavior was not reproduced on the same user space in qemu,
  though I cannot tell whether the exact same kernel binary was used.

- glibc-2.31 calls the same clock_gettime64() vdso function on arm to
  implement clock_gettime(), but earlier versions did not. I have not
  seen any reports of this bug, which could be explained by users
  generally being on older versions.

- As far as I can tell, there are no reports of this bug from other users,
  and so far nobody could reproduce it.

- The current musl git tree has been patched to not call clock_gettime64
   on ARM because of this problem, so it cannot be used for reproducing it.

If anyone has other information that may help figure out what is going
on, please share.

        Arnd
