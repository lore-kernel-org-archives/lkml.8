Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A09C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56012206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgEEOmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:42:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEEOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:42:39 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MekrN-1ixkQF1vi1-00apPG for <linux-kernel@vger.kernel.org>; Tue, 05 May
 2020 16:42:38 +0200
Received: by mail-qt1-f174.google.com with SMTP id q13so717406qtp.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:42:38 -0700 (PDT)
X-Gm-Message-State: AGi0PubtyDTYm45KTTYbrMR/8CPNTSuVYBNXnsdxDqT39qnOh/1KRhRp
        zDHCjFHtYwjgB0EFSlt5zRdIVfIhd1qGCv1mF2I=
X-Google-Smtp-Source: APiQypLlhYQf7fq/1v0dm90zwWA86A9C8KA52UCtn36b/qe56zBKDZqiifbmYW+Cab0gFL/AUmEbJBOD9oHp5/E1lrQ=
X-Received: by 2002:ac8:12c2:: with SMTP id b2mr3012949qtj.7.1588689757275;
 Tue, 05 May 2020 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141218.684079-1-arnd@arndb.de> <20200505141908.GH1551@shell.armlinux.org.uk>
In-Reply-To: <20200505141908.GH1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 May 2020 16:42:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1c1+7GyAzocpWqUMo7=oN48WAdDfPZtnEBHQXpmd7pOw@mail.gmail.com>
Message-ID: <CAK8P3a1c1+7GyAzocpWqUMo7=oN48WAdDfPZtnEBHQXpmd7pOw@mail.gmail.com>
Subject: Re: [PATCH] ARM: use ARM unwinder for gcov
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nathan Huckleberry <nhuck15@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M1VNuKvVZ615qw96nOi5BI+GFyzPkKBKvKTrivaSkzc8INf5IAT
 inekSEoVZRd86q6gvlHb6RZ1EtNC/6BAvBhbXdqxmvEMzdTpzxg2g22P8xusPYxzV4V0vPk
 1LmuD9dKslF3wBokf2SGU5DZWJJ/+KS4+IFyT82tG1t2UbDT9xYgJLvFmAfBdiZM5x6sVif
 KTeFR4FvamZ+F8gcb5Ceg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9ubrjF0/fM=:f0rQU5LmNG+5Em1rKhJ8HA
 f4CxNLQHh/d0L1MKrGeIx+x38t/JEfcEPtOi97b2oisnnxXd9blJ7LpRh8678uBXhGBrIAIzP
 DtT+ZcSTzke4jUQvjykNzolu5kHxpgBErlfIOWEqgT1sJb6bSATc6fbQji7nFvCCBZEvmDtc0
 ewRBnPPctC1L+tsdcwz8r1Okvd/WEhtntmaJCGdjD7cly7Dz21W8DykWi8dmbgpIVtT9s5EDd
 3pjJc310qnhx+Cj0FAJfuUa22tsMJ7UL9+YSXL95oxl7KpPpjCVCdutZ6bCTV8sWjVcAjtWle
 fCZN/qHPbnYRehjtN8cRy7xKd8cEhDVQx9dq3Q76K3yMoWXNN4nPT8xlKJ/wcirdvlPzf5xxK
 J7HB1vhEoVF6EV2UJpDsNA7/o+P4CwxNZ9KAh2JI71JmpbEGNf8Gj9eqmgPiIYbSp/JzWDgjC
 SCc65hv7eeva24farfmerYholy0a9AYVtJ82vJiJyr99doG24ba+DpfHjEqvxlTkcFzc9uD2v
 RyM3JEyUXhIvdaA5DjzP139XNfStlpx2vN0Wot+kOHDvEEJfXV/BbuiEeHr6IFS96wELjnywW
 0hp5Ix/wxb+ZPZDn6JFbEyYDLsQLMDIX69ftY7lAi+p5j83iXehK/UxTZ3mfM3hh+Nw+R76TV
 VefLjrNPPTS84wIcmQPDQWX0joSbcgYkSCQt5za9U4BUAUCGEkPaRC+aF2uFsCZkjmq5IVfzw
 5SX8wKVoV0a7DOF7qyTyy/KizcULVKZm1L9w+I8khPRZTaxFs8pw9A19BbuVbWqtapQlHGrAM
 Si2WlJfc34zgPfRjCmxZzxFmEZXqNIGnAvcwEaLbOOZ1PsTa5c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:19 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 05, 2020 at 04:11:56PM +0200, Arnd Bergmann wrote:
> > Using gcov on ARM fails when the frame pointer unwinder is used:
> >
> > arm-linux-gnueabi-ld: kernel/softirq.o:(.ARM.exidx+0x120): undefined reference to `__aeabi_unwind_cpp_pr0'
> > arm-linux-gnueabi-ld: init/main.o:(.ARM.exidx+0x98): undefined reference to `__aeabi_unwind_cpp_pr0'
> > arm-linux-gnueabi-ld: init/version.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
> > arm-linux-gnueabi-ld: init/do_mounts.o:(.ARM.exidx+0x28): undefined reference to `__aeabi_unwind_cpp_pr0'
> > arm-linux-gnueabi-ld: init/do_mounts_initrd.o:(.ARM.exidx+0x0): undefined reference to `__aeabi_unwind_cpp_pr0'
> > arm-linux-gnueabi-ld: init/initramfs.o:(.ARM.exidx+0x8): more undefined references to `__aeabi_unwind_cpp_pr0' follow
> >
> > This is likely a bug in clang that should be fixed in the compiler.
> > Forcing the use of the ARM unwinder in this configuration however
> > works around the problem.
>
> Or should the stub functions in arch/arm/kernel/unwind.c be moved out?

I had not realized this is only a stub. Moving them out should fix the
link failure, I can
send a patch after testing if we are sure that calling them is not a
bug in clang
that would lead to runtime failures.

       Arnd
