Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28328C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071112070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgGFNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:19:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgGFNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:19:59 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N1x2P-1ku8Wq2089-012JoS for <linux-kernel@vger.kernel.org>; Mon, 06 Jul
 2020 15:19:57 +0200
Received: by mail-qk1-f179.google.com with SMTP id e11so34706523qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:19:57 -0700 (PDT)
X-Gm-Message-State: AOAM531qOk1cLZ0gUOgdDwusUSTRQ3opv0jbeYwSTaiQ5TbVP6kvpjLr
        q23fOKos047bZjmkuYuYr8UpRnEwQQ26CqjLlq0=
X-Google-Smtp-Source: ABdhPJww6niUigVuQJHkqYYmYfiOxZdER76y7qfgzTAcKKYifjABS1zq7DTZUu6v4QCjtiQWoqcEGT3GV0UUjF5yVFA=
X-Received: by 2002:a37:a496:: with SMTP id n144mr46772841qke.286.1594041596392;
 Mon, 06 Jul 2020 06:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <202007061834.Xh4DF8QN%lkp@intel.com> <CAK8P3a2dLDf-gOezrzmp0J1ZtnnZgq5KstUO4RZ0Wnfs9J2H_A@mail.gmail.com>
In-Reply-To: <CAK8P3a2dLDf-gOezrzmp0J1ZtnnZgq5KstUO4RZ0Wnfs9J2H_A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 15:19:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2BnecaxYpMzuEHrBqCbA_z0D4Fr=UU_MaFiddZ7OLm=g@mail.gmail.com>
Message-ID: <CAK8P3a2BnecaxYpMzuEHrBqCbA_z0D4Fr=UU_MaFiddZ7OLm=g@mail.gmail.com>
Subject: Re: file.c:undefined reference to `.dump_emit'
To:     kernel test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RyufBug6mJ3WvsoUtVFcOTPPiNDCmSOp2oQPPq2Mc/fU3pGE25e
 8F0EtU5EDaKtWNQQtCGNawlgHfp4M80btzrngiSTkH5C+vgvSbsKtZAM7okDaKrTJnPC3Ep
 BT/5CBXV1HQqmgNN9Kfskch9BBEZTXfbyaBVQ6Ffker4g+VsO+XaBdN7w15gbweBpaN0AaI
 wmB5UXHzhbiaz7hf1pvvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWcE2NkkIQU=:CZB6POWrFo/z4k2iPs5srM
 g4opwP6fsPevHW4givcMlfE17SeIMmlwzjIefPVizQHiEvep1euNOJ09uFKH7BAjpA8NNrTU5
 H0yJvvS02C8KdygR6bU3FNtK+VdLVS9C2j2f1XwfLBagzQH4LQROEJbLqzhtdAi1D+MqJIMTe
 y/hRKGmmbGlP1VitIgcIjlKmpW/6ZdFrDK31iJsBGoTGj477XRBoJJN601u2yscYqQkWJ7jEV
 1tLuZS1aGaIYuyWnI1JLMs6BO69rK9wenADF9RnlEYLROYbehQ/J3W0CttnUMufr65ZfZkg3W
 H1rXKvc5ilipPDcBACeUM5me533DTpgmfSlLJyt9V1QKG5Y8OwTP7QctCRL7IBvOxMrI21Cb4
 UBjQ3+tB0SQa6OfRV5FExP4ZLevcUZdJquoFmMnfdoBCjK6FccExjGhfmBYhWkzu5BUjvDehs
 UnwGH6OOLCN7RuxhDg5IE5ZTa5nZV68HGq8IPoNwSjQlSBE7ufKHzit7aCoOIzM/mEoW4bV9r
 G0gPFULFe4xrVZqPHSVeW6IqWR6fvDzSKvVGm6i9SN/sEnuGQQfvFHKkgntJqGI1D3JH+WiXx
 Yuq+vSg0ccPmso9h0b6OnZWBqV6N9LgWvzuLEKblh1UXZ7M83Anc1i1hbusptMegrxnLlfOFw
 4u0EG8rZYpd9maJIHPZIyfJYdpsa8RI7mJLqQMBN8KBefDraTyGI72McDoLeidqxf8zabb9CG
 iwl4lqESG2IOshwnReQtyrC75I7sRmechVjxanRY6kRIhvSm/LF5uSqowKmeAbWGblcYdiLw4
 jM/XfCIAKRnWDxddUxtcihhxwt48nw2CFoC/yCFe18Vi/qXYsOJ5CfOmYE2UXBTRwPkLIwAk9
 lECup4g6daIc6+PkS6D0Q0n6UBopJMbR54eOhWykRUKNAJCJ28AcHcgIsnVyxQhKSy6SeElIT
 6vgyKa88nll/sF6wpe76oK6UzMaYtJQTqHk0MQ70/0gELkyyFh/Cs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 6, 2020 at 12:17 PM kernel test robot <lkp@intel.com> wrote:
> >
> In the interest of keeping things simple, I'd suggest doing this one instead:
>
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -44,6 +44,7 @@ config SPU_FS
>         tristate "SPU file system"
>         default m
>         depends on PPC_CELL
> +       depends on COREDUMP
>         select SPU_BASE
>         help
>           The SPU file system is used to access Synergistic Processing
>
> I'll send a proper patch if there are no objections.
>

I see now that it's not even a regression, the report was just about
part of the output now coming from a different file.

I'll send the fix anyway, there is no need for this to be broken.

        Arnd
