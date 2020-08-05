Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8C62064B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgHETHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:07:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHETHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:07:06 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuUvU-1ktqiK3KZG-00ralV for <linux-kernel@vger.kernel.org>; Wed, 05 Aug
 2020 21:07:03 +0200
Received: by mail-qk1-f180.google.com with SMTP id p25so2232493qkp.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:07:02 -0700 (PDT)
X-Gm-Message-State: AOAM5327EMIC2+pHCnhzADtBtRjUtmqNExpKbaf1+pBPUraBz2CTZ61k
        QQiIO0FW0Y5rYo6dIViGuBoZBX+LGwDd5MGrQGc=
X-Google-Smtp-Source: ABdhPJxjj0wDC7OhYiMfIDd49ORNWNupSh5DH92LofMPrEqb1HOApEvRkUJlmHW3pwJQra2jfF+7R0Ek62KzxwXcbfs=
X-Received: by 2002:a37:b942:: with SMTP id j63mr4772181qkf.138.1596654421650;
 Wed, 05 Aug 2020 12:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <20200805172746.GC1118@bug>
In-Reply-To: <20200805172746.GC1118@bug>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 5 Aug 2020 21:06:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
Message-ID: <CAK8P3a2KnmDXYCyst15=kZWneDTMFAbz47F_TYnY_26+W4PM6A@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] ARM: SoC: changes for v5.9
To:     Pavel Machek <pavel@ucw.cz>
List-Id: <soc.lore.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Konrad Dybcio <konradybcio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bGbsl3BEepsSAYqvdVmSXF/5nBRHuGya08h7FkJDE8Ps8OjD/Zt
 dNGz17iV9XQ8VfQTgaKs8GoY3UN5jtHOfTDa5spYsVCY4lhtK/tgBKg/E3Yj7Uv+1m1D3wU
 Q3+XLNogeZmIvMVKBvMieEIvzckEGy7R3QbGWGGcUQFsf0yqrg7qsLxnzjWohXgukRguvs0
 i06gabXC3kDtoEKkP0h3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9GPoFj7rbPA=:U5u0PWKZkePxzrGz8hAokU
 JAMQa+rq3a6gw8M70zPBv9/SaM/DbpaVOacioq+rq04sry2/ndJkOakOytJn5dLzDI36bBBZu
 tbgDP+QgSvNrWyAkUIoFDn0GYNFmuxiyx4tJTTKAmitvk2f35JdqMz8EX2TxoDGV2lAi47L9t
 daRXtbFLyYx8HyqyTeayZqTHDuJP2K/RKLheucSgsXqDdsFOoQF6ix4fQ6D568ygWHwhAlVRO
 5YnKELMPJDC7BJ9cx3DuLh6tob7R6JtI3R5hfh6Zp9v+Mq3hYKSKpVLcFZcIQVwZPcrpSpeDX
 ZwCHHrd0cs1IPg4oqCSUPFZegG1jtcNHZdCNqT1f/GQr8vg7e2l26JtUk4RG3Tp72Ef6prk5G
 MGbf1F9CqFIckfHhQKjLSFxDE1die9zppRbvyz+nuWkchisu9UAvewOcIAehZ6NYuMB7Y9Y2x
 qp3LYu2idLLZW8Cv3f+xMWl+PbWv8C01cr793FtzqzomyAXWA0pWx6T+SUBHllbj7AoFkQNTi
 Kk6jNjpQSlXdD5XLO91WYHuOy1+MWK+yh52FluRDCByAY4peYGkEJCBdvKs20kr3wEyVfgdOS
 hMzsFXGN6hPDTszt9a8mD5IOuXyhrXLwYC3sjrk04hbRG/OtL9yGAzuDUFfk6JvYnR9VsHYo9
 peohmagdSqi4+MNwYDV/TnZS7UlMDcxRQHeZymmNA/a5tayoR2kjVWV5AMZkWnVwb8v6Lluzk
 Wh2zjNtW0MD6WV2M+UZBvwQvax+4POArF2Qs6dtMFuZjIXxYWiIuqrtyVgtBUknZnnxWlYmDo
 uURaYYjLLGQVO9PfSBQ3OYYX5yX3cZCgcCKu2cJI5jM3aM4ErZ+jbGqmAJxmqnEIXL7Dg0F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:27 PM Pavel Machek <pavel@ucw.cz> wrote:
> > 2. In the past few merge windows we have seen an increase in (usually
> >    older) Android phones and tablets gaining mainline kernel support.
> >    This time we get a total of eight Snapdragon phones and two Tegra
> >    tablets. To me this indicates that we finally have sufficient driver
> >    support, in particular on the GPU side, to make this workable.
> >    It also shows the impact that a single hobbyist developer can have,
> >    as most of the new support was submitted by Konrad Dybcio who only
> >    started contributing kernel patches to mainline Linux for postmarketos
> >    earlier this year.
>
> I'm happy to see that. So far, Nokia N900 is reaonably supported (basically everything
> but Bluetooth works, voicecalls miss userland daemon for audio), and Motorola
> Droid 4 (modem needs some more in kernel, camera will be hard).
>
> Is there anything with similar support coming in, or is it usual "it boots,
> serial console works"?

My impression is that the newly added phones are still fairly rudimentary,
but some others that were added in the past releases have gotten
further. I don't know any details, but I've added Konrad to Cc, he can
comment on his work.

One of the missing pieces with the OMAP based phones has always
been the GPU, and on that front I think by now almost every other GPU
is ahead.

> Should we have some kind of linux-phones mailing list? There is quite a lot of
> stuff common in phones.

PostmarketOS is probably the right place to look for this.

       Arnd
