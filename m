Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03661C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE342082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgG3KSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:18:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgG3KSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:18:13 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MRC7g-1kOEfH2JXQ-00N93h for <linux-kernel@vger.kernel.org>; Thu, 30 Jul
 2020 12:18:11 +0200
Received: by mail-qk1-f171.google.com with SMTP id b79so25021492qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:18:10 -0700 (PDT)
X-Gm-Message-State: AOAM531pv/RW11PiVAF7pbM8Byx/cjwkuhQ2VC2iRO0AXIMqcNHE8zN5
        UTkNZcxPPl11jfYfALUilV/cUBsUiLZUp3gYT3w=
X-Google-Smtp-Source: ABdhPJw0zhgWI8XEuaE7dh3Gaf8Co5aAjwivB4PWqycBiz+hNcxCHa8bJhqSS7E2r1fWP9+uf5sQwRpfZwYGDsX74Ps=
X-Received: by 2002:a37:385:: with SMTP id 127mr35163874qkd.3.1596104289349;
 Thu, 30 Jul 2020 03:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514162535.GP1551@shell.armlinux.org.uk> <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
 <20200514234013.GQ1551@shell.armlinux.org.uk> <CAK8P3a1d-9B86uXxkZnDGf7u-2Vf9fCrUgWQ9HGNEcf3--Yg5w@mail.gmail.com>
 <CACRpkdZ0YT7JoBdYHSb1bbZUv_ovjkBg7yx7gHbG5VjEDV8vhQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ0YT7JoBdYHSb1bbZUv_ovjkBg7yx7gHbG5VjEDV8vhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jul 2020 12:17:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hWSROf9N8YthU_LHEgD3aKzJbemyyhoJ_jPTR4nn=EA@mail.gmail.com>
Message-ID: <CAK8P3a3hWSROf9N8YthU_LHEgD3aKzJbemyyhoJ_jPTR4nn=EA@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VBeb0vS6YbnrS4P9dnsvNYqBjD2aZQWD0TWhNzK3R9Pwure+UPj
 Oz81g4J8AWd3T6zHv4ZOEVBjydqbUy7OIFIlvQ0anxbBfhs1FkYqQVCTlTtD2QgiRwlAQwy
 GPgDf3WtYeQqnO0bbjgcnL1Y0K5qd7cO/V+PHtYS1YBCnrG/0eu40r1BFnTQffOuK4P4/ao
 YBzeYMnbivdkgs6QTB4dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yF1rdyvFDis=:r7btjw+E3DlWGDxZKPwQmo
 haDvHn9gFbfifyNHO2MHyxtSBQAEWnPEaKf6DkySoa0G9EpTwBMpSXQxPauqPdodBJoC0lk6/
 FqxFQSglM5NuM8A/6kSgErQBHLSu5vs8F/FwJiakp2sIFrvMa8P5aOja4kc03Ge4oW3S1eMlt
 vpLlAw5Mh5k4rJxrtRrmiJo9tbzdDs8IRrj3wQmkS0126jPkMoVZ5YmhSZyUQfG5PsgcZJg59
 fZ6g8vp93eIIUOQSt/pKr4L+eTRQ+dHW+zc9Vuw6Td92AKH6fYSvtLcwipCBHdKQeIDirnX7E
 abL1XpZ+6mADZbhcwyWHPd53fBC7eD95ya6pFezMqLMO83+J+WevmPyHgCr4VCehCxVN8MdU3
 0Fqr+7GLgDt53v0EvLEcWtGlsCSfALCwYRT07IfhbUwVcsBN0+40Wvr8ENkv8LWl91QhB/G0k
 ArFtRdxeG2sZcbCP75cdTHfCAXIBx3zRluT/IOVJD01S8aTjCrXrwz8gzl++pafBkEC8L+Fg2
 j/8gQ5rawpKU7Q8ywi7gLD6iTCltOwWEYH2ckZ1CI0/BfwasPqZqEXZSfodKUyPWPqyTv+o8M
 L9++M4cDzmlW1MdewytGscSQAwlzO2Hy6m0lFFRjllilNfzMK/VU1GMkYnVHPy44w2XImkP2V
 hKzrunxRfFGBM78bQL8WrOkpxHUsZZHmaZ9LhWmLY+qx6EIvwr7vQYp2Yu7iSq7LxgGiyE649
 gNXhsozxPRnccflfEaZgo/g7ys1sFWmbjeSmvB+ja+eVZ1EStYAOReYRJovLplWnh1D1+z3NF
 ISHXjzh+gpzVH237GOEDvKHEFTco21L4wIEJVYoeVMnSkC0Dp8RieSmAOF53Ab46O4qHp7k8Y
 u/LvBv17s7yCPSCLt3I16o9Cknn9UI9zlfVSMXQBI1HistDvLzy7r+jwKhlX/4GapHp1rFYA0
 QIRKT8w7f9Iv8SaszMJW/10D7a5UzmaG5NH94ZfZIMQ+w843FmBA8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:33 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, May 15, 2020 at 5:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> [Russell]
> > > There are some aliasing VIPT implementations on ARMv6, but I don't
> > > remember how common.
> >
> > I thought it was only realview-pb and omap2, but it seems there
> > are more, at least ast2500 is an important example.
> >
> > I could not find information about integrator-cp and picoxcell.
> (...)
> >   integrator CM1136JF-S core module: arm1136r?, 16kb non-aliasing VIPT
> > ? integrator CTB36 core tile: arm1136r?, ???
>
> These do exist, the Integrators have pluggable CPU core modules.
> What you do is populate the core module slot on the Integrator CP
> with a CM1136.

Here the question is really what the cache size would be. 16kb
caches are non-aliasing, while 32kb caches would be aliasing.
The particular core revision would tell you whether this is an ARMv6
(1136r0) or ARMv6k (1136r1) implementation.

> That said, I think I am the only user of the Integrator/CP actual
> hardware. And I don't have this core module. So I think it will be
> safe to drop support for that specific VIPT implementation by the
> token that if a tree falls in the forest and noone
> is there to hear it, it does not make a sound.
>
> As for physically existing VIPT 1136/1176 systems the Ambarella
> legacy SoCs that are not upstream is the big consumer of these.
>
> Ambarella's main customer is GoPro cameras and similar
> products. I have no idea if they ever upgrade kernels on these
> things though, I think not, but it would be great if someone knows
> them and can ask whether this is a concern for them. (They
> should be working with the community IMO, but is one of those
> companies that for some reason do not.)

It seems unlikely that there is still enough interest in the old
GoPro chips.

Apparently GoPro Hero3+ from 2013 already used a Cortex-A9
based Ambarella chip, and according to Wikipedia in 2017 they
started making their own SoCs rather using Ambarella's.

I found some source code for both the arm11 version [1] and
the Cortex-A9 based chips, the last update on either of those
that was in 2016. The boot log in [2] shows this is a nonaliasing
cache btw.

Anyway, as I said earlier, as long as AST2500 (or OMAP2) is used,
aliasing dcaches remain a concern for ARMv6-enabled kernels.

     Arnd

[1] https://github.com/evilwombat/gopro-linux/tree/master/arch/arm/mach-ambarella
[2] https://www.tapatalk.com/groups/goprouser/hero3-black-firmware-studies-physical-teardown-pho-t10016-s10.html#p58148
