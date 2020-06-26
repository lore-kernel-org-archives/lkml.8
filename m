Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4873207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFZOD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:03:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFZOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:03:58 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mxlio-1iuPgb3hHi-00zFiB; Fri, 26 Jun 2020 16:03:56 +0200
Received: by mail-qk1-f178.google.com with SMTP id r22so8788314qke.13;
        Fri, 26 Jun 2020 07:03:55 -0700 (PDT)
X-Gm-Message-State: AOAM533nmrDvFxM8pNae7N4bphHyCUsh2LSrymB8xeoVZbaIHsGvfZSb
        pDR9KBXzkjLK3mf6ReikW3nzPmw+PVdrJImUo3Q=
X-Google-Smtp-Source: ABdhPJwvfCG8V0xTspjw/3/nnT9m0PoPb3zOnO5BicQKB9lFdnOYcErQQmTlzwly2D1MQXpIopKu4V5jSrdei+HC0EA=
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr2854546qkb.138.1593180234661;
 Fri, 26 Jun 2020 07:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org> <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com> <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com>
In-Reply-To: <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:03:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
Message-ID: <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        mm-commits@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3/QvdGkvXOOKAHm1vs/kLgE/g1bjT6dmnbZOIDZA6aLp80yikm9
 VpxUK6FcrK3CfXHBBPtHm/7r+LKZt9J40xSxFTercS1T0qR401XjlEoyQgMGRpacTFW+FYt
 725kxUl9udNia1NVyHm7aYvFkRDXivgrJjg6gyo4ILTLX8LTygd58QQFDj6EDB6rFP8wK1h
 Fst+uQxFqo9Yac/Hm9xsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ksrCpW0zKM=:N8NmHPwFGV9ADQDR3luMXh
 D/xSvXmTGOlglrb0wkz0F8bM5w0ZAy8pgsVAU78J4gR49/1nbFBt2L+arAEvKvzEV88eCydup
 Rp+sUAEl/04BTGJn4n3qUxQokwuc7HJelhliYdqEtAQgYyXx+ExPUWIZ/8bcncoPJ7otqir7t
 mEy00ji4mpG1S84FzTmlG06pFbVF232W0IAKX87wIpYV5qi+oENYzQX42Ntb9ajagXPU1iYxs
 risX4yP2nos5Ax65BXHN23YZozinUTgtpdhzJyzcqWAF/9ZTGyQfBR32qaBlp6q8p8lWevbKd
 BgMASZ+CcZOIJc+rw321OVFPwNvE15lD28qX+ZuIFRcTTCmzvxEDvVp0F+X26HF3FhGhrXGu5
 PPqH16N0ZHF0+rpgfEQGL8iBNb/rzxdgkvp+kDxhfDUcXvy2SNQZRhXiIqE0Yab9Ss30ixFBN
 3q2iivrKRZeduWN4rBw5yFB9REFK2gkKWdHZRK5Y/aaUGLeM7c97UDcGvwzLpoZUO/56E6lQt
 HGk0AmvFuewchdAg+EX6WVkREJDpYyYZ6bXIKX6/cuDscPw7Uo3jE8pWcE6P515Wv0L9THTpV
 vngiZdsXwf1Ujml61JQzjrHDMS3/q8BPb6k1HVuxHOxTB1akvEMYa4LK6BMLCglIZIOn83rDJ
 c3h3r/141iPUWXMjnyOdvAepLmCK8vhW6C2oyBrMcjgD48uDMdZyaexjeBmjZ1xuptSwyPqL9
 wbSqkcrLV0rFmDDJ1ZI/CHfIFPMWGzCwumq/PISjYfQPeMaPBIOK3c+rHSHtvCXHkZnleUAZb
 TINDblSfchHZOgxmU+kBSgu3RKfygVa2ljRI2JEhPjMXiDe51g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:24 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 2:37 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > Den fre 26 juni 2020 08:32Linus Torvalds <torvalds@linux-foundation.org> skrev:
>
> ...
>
> > I'll just say no and point to this email next time someone complains instead.
>
> "No" is not constructive here. People can be annoyed with warning
> messages, but the real issue here are the various CI systems which
> send a lot of spam because of that. As a maintainer I would need to
> drop CI in order to see a good patch. If Linus considers that warning
> useless, then probably you can change your patch to do what he
> proposed.

How about moving that warning from W=1 to W=2? Generally speaking
I'd expect W=1 warnings to be in a category of "it's generally better to
address this in the code, but we can't turn it on by default because the
output gets too noisy", as opposed to W=2 meaning "this sometimes
finds a real problem, but fixing the warning often makes code worse."

     Arnd
