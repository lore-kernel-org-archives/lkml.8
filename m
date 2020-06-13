Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFBE2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgFMUpy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:45:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgFMUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:45:53 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMX9b-1jRrCb1T3X-00Ja93 for <linux-kernel@vger.kernel.org>; Sat, 13 Jun
 2020 22:45:50 +0200
Received: by mail-qk1-f176.google.com with SMTP id l17so12289799qki.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:45:50 -0700 (PDT)
X-Gm-Message-State: AOAM531vzDtJV8JNcLwmekwNzluC4ubowzJEFWvXQ1dmNQMvs9B9nMjN
        nHob3ayIXKmAdEL3bJ/TOu8KiTaEEylX0AX8bo8=
X-Google-Smtp-Source: ABdhPJzKWxg5VOCg6vbBkuAbhbaPgmzk/da3ldxe5pweVGVyYaX22A3xzHltoZ9K8pid2aVLjXRyBB04rgSXBEjgxrg=
X-Received: by 2002:ae9:de85:: with SMTP id s127mr9295217qkf.352.1592081149191;
 Sat, 13 Jun 2020 13:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com> <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc> <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
In-Reply-To: <20200613120432.GA5319@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 13 Jun 2020 22:45:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
Message-ID: <CAK8P3a2g6a=V4BmPAOM0vNYUfJqm_aZziQhCxfF8MT_fbHMMLg@mail.gmail.com>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:4NoU2Gnj4LglAONJgINRf0RpTTl00mAY4QHv2GqQry3wNbrK2pg
 vWuZQnnEe6dpESRH0MkclignVWr289d4StiWz7f2fpn0NcDwTTkvY1Q9EVid7C2slbePWHF
 lVCqNJHHBDCjMk7pUgZDz8c2p8NMMr3TJdE6hpPvfExCg0YzEjNIdENZ5f9om2FQWdlHDF1
 IhZ1kbZ1zpwMHEFSjB2TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:33nKHNz1kMo=:OIjMCeYLVHArwUPq4wTSSz
 Ku1PQqmglvicIJaOtXLnCHvDwjdU5ffoKJDn7vST26EWlQsjSEnJ9Q1xeQv2u2c5hBH82bw6S
 yihafAUheyHbKAMzb68JqcE4Ejd4lMx34pL7XMdhX2W53INzqNJp7UeU4rSyb3YolAKGaGui8
 /swZfhmwSGMtAbTATaLJiJ0iOTGc+HJo8qtSGcfOS3sY2p73DXMVwcUyA17WIR+FxCdm3WPpl
 LyjJS4Gd+eSq/bZmuY0jA59BsEmurtcc8JCQMUoxrUxPTIQL9tLOLqioFxo9ikaBeVbXJ4x6m
 AowtpbZLxtoEYC+ZUv1hQT2agpwcFcOuOK5CouVfJerK3sEiZqah6NkMX058xgSiTKvQvjMuW
 164JgcEuXeCSojHVPZUtYZ8/6SWtKcvbF0fZ2GstuykJ9AJZ2+c4aaUbfiZylcoyAHFHtuqcP
 PL1SP31pglBXPbeaHdKaLvqJqNXRM2kr8ozhB1KlJbRRGN2BvMeeacbbJOkqxJn4LIu0sJn3s
 UWDI4AodU47yBDmCvgI7IT3FqGXHf4GoU/TfWwjacp6ASUhK9WcKHsFfm7ikFLZt5Boi8UcMK
 IRScDBMQEACFfMpuPU4Qo+gu7tI5zJXo1pnD1T8gahJdDC8757cYF1wHdLIsErt6VUrI3DvRD
 o2M8OAO0qWhLyFczYCPVFVW2TUEN0AEMWeBoroSVgW3SOteP0xZXOSAeVtWbqEBXirArpAUjh
 1JOATnsBbEWHss6izvSfZ/7gpq4TUCqPOLJel2hnw0VdvFNFpDY2oLCBa8lBuI7NkqEvOn5lH
 SzhJLHWMCg+u0Rz1aulWVEfb9EoOZxWgl4BH6BCWQ0trW8Ycgs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 2:04 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Fri, Jun 12, 2020 at 10:07:28PM +0200, Arnd Bergmann wrote:
>
> > I think a lot
> > of usercopy calls are only for a few bytes, though this is of course
> > highly workload dependent and you might only care about the large
> > ones.
>
> Observation is that max. pages reaching copy_{from,to}_user() is 2,
> observed maximum of n (number of bytes) being 1 page size. i think C
> library cuts any size read, write to page size (if it exceeds) &
> invokes the system call. Max. pages reaching 2, happens when 'n'
> crosses page boundary, this has been observed w/ small size request
> as well w/ ones of exact page size (but not page aligned).

Right, this is apparently because tmpfs uses shmem_file_read_iter() to
copy the file pages one at a time. generic_file_buffered_read() seems
similar, to copying between an aligned kernel page and address in
user space that is not page aligned would be an important case to
optimize for.

> Quickly comparing boot-time on Beagle Bone White, boot time increases
> by only 4%, perhaps this worry is irrelevant, but just thought will
> put it across.

4% boot time increase sounds like a lot, especially if that is only for
copy_from_user/copy_to_user. In the end it really depends on how well
get_user()/put_user() and small copies can be optimized in the end.

> > There is also still hope of optimizing small aligned copies like
> >
> > set_ttbr0(user_ttbr);
> > ldm();
> > set_ttbr0(kernel_ttbr);
> > stm();
>
> Hmm, more needs to be done to be in a position to test it.

This is going to be highly microarchitecture specific, so anything you test
on the Beaglebone's Cortex-A8 might not apply to A7/A15/A17 systems,
but if you want to test what the overhead is, you could try changing
/dev/zero (or a different chardev like it) to use a series of
put_user(0, u32uptr++) in place of whatever it has, and then replace the
'str' instruction with dummy writes to ttbr0 using the value it already
has, like:

      mcr     p15, 0, %0, c2, c0, 0  /* set_ttbr0() */
      isb  /* prevent speculative access to kernel table */
      str    %1, [%2],0 /* write 32 bit to user space */
      mcr     p15, 0, %0, c2, c0, 0  /* set_ttbr0() */
      isb  /* prevent speculative access to user table */

This is obviously going to be very slow compared to the simple store
there is today but maybe cheaper than the
CONFIG_ARM64_SW_TTBR0_PAN uaccess_en/disable()
on arm64 on a single get_user()/put_user().

It would be interesting to compare it to the overhead of a
get_user_page_fast() based implementation. From the numbers you
measured, it seems the beaglebone currently needs an extra ~6µs or
3µs per copy_to/from_user() call with your patch, depending on what
your benchmark was (MB/s for just reading or writing vs MB/s for
copying from one file to another through a user space buffer).

       Arnd
