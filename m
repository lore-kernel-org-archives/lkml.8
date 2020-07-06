Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D179C20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgGFNEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:04:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgGFNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:04:23 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N4i7l-1ksToJ2lTr-011my3 for <linux-kernel@vger.kernel.org>; Mon, 06 Jul
 2020 15:04:20 +0200
Received: by mail-qk1-f172.google.com with SMTP id e11so34652571qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:04:20 -0700 (PDT)
X-Gm-Message-State: AOAM530ocd6LPdY0CHJulsbFWAF7G+7xiSDyvXcXqircJIwp1pIaBnxH
        OjZpGcnIo0ImoEHh2ikopN9VgjHiXHva7SKBPsw=
X-Google-Smtp-Source: ABdhPJwubD2mijyAfUzCDzHL2/dgA6kW43DYxuGhRpvvvgDSjGytYvy9hqqMQ+FmwXaOLzZU6yw4RYKo/ZwuBXK5Kdg=
X-Received: by 2002:a37:a496:: with SMTP id n144mr46695262qke.286.1594040659501;
 Mon, 06 Jul 2020 06:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <202007061834.Xh4DF8QN%lkp@intel.com>
In-Reply-To: <202007061834.Xh4DF8QN%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 15:04:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2dLDf-gOezrzmp0J1ZtnnZgq5KstUO4RZ0Wnfs9J2H_A@mail.gmail.com>
Message-ID: <CAK8P3a2dLDf-gOezrzmp0J1ZtnnZgq5KstUO4RZ0Wnfs9J2H_A@mail.gmail.com>
Subject: Re: file.c:undefined reference to `.dump_emit'
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XzJuH2A7pNUF6aQXkgJawp3fTRkym58/elUuH3QC9kQEv8oydhY
 JeR0oiuYCdtWEybkGqYLJ1UI1MuterlGaYeAn2KasnSQQtigF/QoP9vQNf1vmMiHhcbTNSl
 hQTz5hx6InvJnryFcqt+mA9XlnWtzIcTFFioJwqfKbArDp9BzqeM5YM1OBL2sbVlPIi12Bk
 X8J4nvgVhuQ4WFrFiZQqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4OBHJOG4YM=:FDSeXJn7a7Juv5DU+y/SwO
 EKGR8c8lI9k7/lFzNPfJxGrs5eV0fiHYoCuOd0NYopOeB8a2gfgq5i+C3SkJxMs5GfTLS1/t2
 Moc4VgZmQMBckeFYD2ogjc8tYaw97dgbFqpSHhohCcZveNUY+erAeVLdgcOUN/zVDJf0OSTks
 7iGfrVBWqAcGu39zBZ8PmmNW2YuKWL24FkMwPkN+qslNdgb/o1t+ZaWqtmaJvSwHDZSz0ey4H
 YIka9EnaA3N7oyPaMTkFZOSlrzsuY4VhGxCS8uQQtM0bRny33XFYRYsjcYdYDsSkCRLCAlQVi
 AcvOruZPWHj6frH+EGENHQKXPEJzyWPnVuh12EF7t/hxmB+JY8BGFm9aiqfJbl/6ss8prkmXA
 AxhVpEloAb2Cc7KI/gPAALRaqOb6nHVhGnt0VTcjgwyCpT62Gt5fxwmePMyIyB82laxeHO8nD
 ofLS4f7X5tbJteKHmPn4nHcdRoIo+uL4aUHzFjY/4EiyfX1PiG4lLw0DXSvlkWzH6+ZIo4h98
 WkPjXfetCQf5LtOBk40xjoM0zKD/ZmIm8GHmxLFh7OTcGSvJlvCAsOmVP0RsKSNb4qLmlnZ19
 GGcDeEhZuBM34X2oJJ9fQv20fS9kplFNdhnbqlK6kQUfh8cRjdVQ6o2ZJonUhj3E3Fdd1iV3K
 RNPk+vpbtLg3Sdbzf/npXkjsZT/bs54m0KBsEF2MZx8/IAK2yZxbBA2cKcaGu1N64aJVYAXX8
 mW82lc9R0Mzkw5hodvastu3UREF9PC1Wix/EUzCMye2nl5+oFZu8y9c6TH8GCQza0cBKiNz2v
 +BaSqiT0tYH/nVJzEG0epCWC40K+PmElT+zGrDwtVhXCtMcAlzl3Dp2u0Rrkui/t9ttwJvuPi
 OOqytHPS/5+vKNMG064xaUfTudz/vys2TCLhlwedAMBWKHfTFU1s2ARwR1tb3u0D6jpEhmbkS
 U+qO7zBMA63ykrS7CXIgfczPEnDoNRPep8LqHaYvXjF2/sTTUvUfz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 12:17 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
> commit: 5456ffdee666c66e27ccc1006f9afe83ad55559f powerpc/spufs: simplify spufs core dumping
> date:   9 weeks ago
> config: powerpc64-randconfig-c003-20200706 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    powerpc64-linux-ld: arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference to `mmu_pid_bits'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_proxydma_info_dump':
> >> file.c:(.text+0x4c68): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_dma_info_dump':
>    file.c:(.text+0x4d70): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_wbox_info_dump':
>    file.c:(.text+0x4df4): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_ibox_info_dump':
>    file.c:(.text+0x4e50): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_mbox_info_dump':
>    file.c:(.text+0x4eb0): undefined reference to `.dump_emit'
>    powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o:file.c:(.text+0x4f10): more undefined references to `.dump_emit' follow

I'm sure there is a way to fix this properly with added complexity, either
making dump_emit() an empty inline function when CONFIG_COREDUMP
is disabled, or adding a lot of #ifdef checks in spufs itself.

In the interest of keeping things simple, I'd suggest doing this one instead:

--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -44,6 +44,7 @@ config SPU_FS
        tristate "SPU file system"
        default m
        depends on PPC_CELL
+       depends on COREDUMP
        select SPU_BASE
        help
          The SPU file system is used to access Synergistic Processing

I'll send a proper patch if there are no objections.

      Arnd
