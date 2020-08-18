Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022EC20674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597772110;
	bh=B2lLSK8pwzbCGEnPx54UftMkENd7vVL+nhbDCWbGFoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pz99QLVLgCqbBHOp34OGOm83vBhW9evFAR9auWsj46uD+WU2Lyjw0hEtE7p9UmhcW
	 P+pHSL6y5y7MQQathtV44unuPw8qvdudO58CzWC/KA/cOYumU7g/1DS+BLN+8LOFB0
	 NSCamyH6ah2lEgTkmKlBk4F8gf55Sk99qYbD5Gwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgHRRe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:34:59 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:20695 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgHRRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:34:29 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 07IHYF4N027894
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:34:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 07IHYF4N027894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597772056;
        bh=ibuX60bW1flfxvenHkO0aZoK/IkeXv+RuWSadAaZDEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gwb6TKi1iKgTRQsLhwBd7S5KRqAEc4P3O1bXC+0BbEqUEzUbYffTqJoKuMzQfCanu
         saq2Ea7LX455pD0nHeFrePP4sEWVRhfGtLg7h0sEQmdKRwZFcf7sqTT/JfUdvBM4jc
         fr1dopLalIglyFxSlEpJmePO013+/EQdeg0sUmjf9aWVbZKvLhtTSyebopUZfBN3Hq
         h/fH+ozIw3lUu+t1xovk8bnjqBbtvYAyWjHPDC6E48AIvCekdkq0yAR632xJacOArM
         zSMPCXkpSrCP57WOSZ0NibsO5eCAKbg1bpcNrafUZPLYRYHpZnPKXP51RXiUynwmHs
         bFGx4B6VJCpuA==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id n12so273851vkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:34:15 -0700 (PDT)
X-Gm-Message-State: AOAM532GWDd5heJEVoFbaq+up6S/sZNVFB31iNKii/md+f3bxgQOB4XR
        X/MntO3lpuFVobhfbLpQTgAOR0YMnRk4SPfpAi4=
X-Google-Smtp-Source: ABdhPJxPfLdpSx4d2/EJeZYS59VftNEmMih8yrwIf7lXzQbK53lpjtz3LU4gFPoinnGDUFSUn+NAxvNPm7rzSYodeOc=
X-Received: by 2002:a1f:2b14:: with SMTP id r20mr7802154vkr.73.1597772054350;
 Tue, 18 Aug 2020 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
In-Reply-To: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Aug 2020 02:33:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com>
Message-ID: <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com>
Subject: Re: Kernel build system broken in 5.8?
To:     Martin Burnicki <martin.burnicki@meinberg.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 1:14 AM Martin Burnicki
<martin.burnicki@meinberg.de> wrote:
>
> Hi,
>
> I'm the maintainer of a driver package for some PCI cards (GPS receiver
> cards, etc.). A read-only git repo of the driver package can be found her=
e:
> https://git.meinbergglobal.com/mbgtools-lx.git
>
> The kernel driver from that package is compiled as out-of-tree module,
> and runs fine on kernels 2.6, 3.x, 4.x, and 5.x up to 5.7, actually
> 5.7.15 on Ubuntu.
>
> However, if I try this on kernel 5.8.1, I get strange errors related to
> autoconf.h, which make it impossible to compile or install the kernel
> module.
>
> I usually build the kernel module as standard user, and only install the
> new module as root, e.g.:
>
>   git checkout devel   # The 'devel' branch is appropriate for testing
>   cd mbgclock          # the subdirectory of the kernel module
>   git clean -fd; make  # or make V=3D1 for verbose output
>   sudo make install


This is a bad way for reporting a bug
because your project is too big.

mbgclock/Makefile include the top Makefile,
which is more than 1000 lines.


Please provide steps to reproduce it
with a tiny test module.

You state 5.7.15 was fine.
So, could you also run git-bisect, please?


> Also, I was under the impression that the kernel source tree should be
> read-only, and kept clean, but this doesn't seem to be the case anymore.
>
>
> For example:
>
> On Ubuntu 19.10 with kernel 5.8.1-050801-generic from
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.1/


I cannot try it since that is not what
I install on my machine, sorry.


Please provide steps to reproduce it
for a person using a different environment.




> 'make' completes without error, even if run as normal user without write
> permissions in the kernel source tree.
>
> 'sudo insmod ./mbgclock.ko' loads the module successfully, and the PCI
> card can be accessed as usually, e.g. using the 'mbgstatus' program, so
> the compiled kernel module  is OK.
>
> BUT: Once I run 'sudo make install', which calls the kernel build system
> to make 'modules_install', I immediately get an error:
>
> -------------------------------------------------------------------------
> Calling kernel build system to make "modules_install"
> make[1]: Entering directory '/usr/src/linux-headers-5.8.1-050801-generic'
>
>   ERROR: Kernel configuration is invalid.
>          include/generated/autoconf.h or include/config/auto.conf are
> missing.
>          Run 'make oldconfig && make prepare' on kernel src to fix it.
>
> make[1]: *** [Makefile:719: include/config/auto.conf] Error 1
> make[1]: Leaving directory '/usr/src/linux-headers-5.8.1-050801-generic'
> make: *** [/home/martin/projects/mbgtools-lx/mbgclock/../Makefile:834:
> install_module] Error 2
> -------------------------------------------------------------------------
>
> And once this has happened, this problem persists, i.e., if I run the
> same commands
>
>   git clean -fd; make
>
> once more, as normal user as mentioned above, I get the error above
> every time.
>
> Also, If I initially try to build the kernel kernel module as root, with
> 'sudo':
>
>   git clean -fd; sudo make
>
> I immediately get this error, and the module is not built. Only after I
> have re-installed the kernel headers package, I can compile the module
> again.
>
>
> A diff between the kernel header files before and after the kernel build
> system has been messed up shows that the following files have changed:
>
> include/generated/autoconf.h
> scripts/basic/.fixdep.cmd
> scripts/basic/fixdep
> scripts/kconfig/.conf.o.cmd
> scripts/kconfig/.confdata.o.cmd
> scripts/kconfig/.expr.o.cmd
> scripts/kconfig/.lexer.lex.c.cmd
> scripts/kconfig/conf.o
> scripts/kconfig/confdata.o
> scripts/kconfig/expr.o
> scripts/kconfig/lexer.lex.c
> scripts/kconfig/parser.tab.c
>
> Specifically, autoconf.h has been deleted even though some script
> obviously still requires that the file is available.
>
>
> With openSUSE Leap 15.2 and kernel 5.8.1 from
> https://download.opensuse.org/repositories/Kernel:/stable/standard/
>
> I've encountered similar problems because include/generated/autoconf.h
> is not even available after installation of the kernel headers package.
>
> Only on Arch Linux with kernel 5.8.1-arch1-1 I can build and install the
> module as root or standard user, as it was possible with earlier kernel
> versions.
>
> Can someone please shed some light on what's going on here?
>
>
> Thanks,
>
> Martin
> --
> Martin Burnicki
>
> Senior Software Engineer
>
> MEINBERG Funkuhren GmbH & Co. KG
> Email: martin.burnicki@meinberg.de
> Phone: +49 5281 9309-414
> Linkedin: https://www.linkedin.com/in/martinburnicki/
>
> Lange Wand 9, 31812 Bad Pyrmont, Germany
> Amtsgericht Hannover 17HRA 100322
> Gesch=C3=A4ftsf=C3=BChrer/Managing Directors: G=C3=BCnter Meinberg, Werne=
r Meinberg,
> Andre Hartmann, Heiko Gerstung
> Websites: https://www.meinberg.de  https://www.meinbergglobal.com
> Training: https://www.meinberg.academy
>


--=20
Best Regards
Masahiro Yamada
