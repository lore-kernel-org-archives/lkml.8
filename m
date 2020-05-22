Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08796C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD007206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEVIIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 04:08:34 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:08:34 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMoKq-1jJPul2jRM-00IkLg; Fri, 22 May 2020 10:08:31 +0200
Received: by mail-qk1-f170.google.com with SMTP id 190so9991908qki.1;
        Fri, 22 May 2020 01:08:31 -0700 (PDT)
X-Gm-Message-State: AOAM531TopgningbtZJAEr0sfJj/fg7FtsqwtwZp3vnpmtV7vBLt3SEi
        46vpnZTRc5m2PLc2vMlCHehnlwBsu6lgJgujkd0=
X-Google-Smtp-Source: ABdhPJxvCN5ckqOsRHgJtAQbB9IOx9DfaplnfBWTHN4WldKZGpHGw1jQyX3CgSCcu6TNJ4bB5ueanJiINGKzx+D9eUA=
X-Received: by 2002:a37:434b:: with SMTP id q72mr14547426qka.352.1590134910369;
 Fri, 22 May 2020 01:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160313.09cb2b7e@canb.auug.org.au>
In-Reply-To: <20200522160313.09cb2b7e@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 10:08:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1H43KuLbQ0mPNjSCoWbqT2P_kx93zsdYtQXv2nw2WdvQ@mail.gmail.com>
Message-ID: <CAK8P3a1H43KuLbQ0mPNjSCoWbqT2P_kx93zsdYtQXv2nw2WdvQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the devicetree tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dShZ1qXd4jHuP4xFgkiv2xNaEHWhAnlm0xjGh5Z7VY7bZ3ip9BK
 megMSIPIHKIp/OhHs3XXHxcDX8UZhPxIW5NvZnIMHKUBylHwp2fIPgRMM3dc0JxLNdyKN9y
 DF725uGY89GcQpmoC1URNqwUhhWT3ktgD1fs7FaGu5Q92N4RZTnZcEJebVFeLuDyMcMN/RE
 8r18XDC2Nlm6kZiJJCLRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHiGbz+iv2U=:DchdaCXz9WiGoUcniA4zfa
 Gdgq4NjVmRZ0ZN1SV8iusKvRHnF4PCFMrhcagkmDvZ6Z+r0ftqS/ShoDx2eJ2qphL30SxXxPY
 V4o+lkMKxDBDHg+NhjTW9HebPwZIbaRImODup5ZsF5AVShf+SblD8ykYjA0IxEBkqncYEmlFM
 1zmC1QtXMTpNaNzdvap+cbYE9EWml+vNV217s+zuTHPcp8bblPo4OcDVTMbC8eCFpTFO4RqMm
 djko3POKzhYJ0b0RIuEz6TyrmksCkbODvrAIxLukKyavXLx+hlaLFhN3oLTe9lSGDgfbkooII
 iM2/F0mCY1+dAL4DFeHq5pnJ/mifsgq6ML9yZVSU+eb5GSnl98CrDsPCE8uGe0cVZ9PrO6tg9
 OEGiuIb2sImx7igOrikW4VE4G7cEBNy0+ieLqIm4AkE8JgZt5Kpb/5FNDpa6+3njiS0nLa0VU
 Ziq5uQHsuR0IPVOO6qwlnThu8nN1bbjiUzTS2hsnQ3nWqurebpuMrNmg14fW2AhKz4P5vgiT6
 Zbgqdd2PVKa/rCYUvwO3ixXR4QYmCjCRpzYZeiIwxqLhLOqBgAy0kKNZVNmo7UF5oxzSgt9L4
 828njk0Kqxdzqjb0oborIZkghlL4YZWOLWsqAJDEIskYq7ljinuRVczBe/+zz+7W8+phkqtd+
 lIXqnIW1c0uLmyVnXgd6HDbym4QdJwPGMq06+Gz5unuZk7SM13fvdYi3l701V5zmBAuiZ+eGl
 g9Ozk7AohtgD7MeaAh/wY8FCWUYhdweiBtrkMSoLM6qQa/tGJoTRyDroXKvN+JQtWAj962bpB
 BiCwzFLjr8O5PXam3nKrnypgfvMmphwDZCQ52kke30WLnvjRHE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 8:03 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> index 10a7f0752281,113f93b9ae55..000000000000
> --- a/Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> +++ b/Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> @@@ -51,9 -51,8 +51,9 @@@ properties
>         - description: LD20 SoC boards
>           items:
>             - enum:
> -             - socionext,uniphier-ld20-akebi96
> -             - socionext,uniphier-ld20-global
> -             - socionext,uniphier-ld20-ref
> ++              - socionext,uniphier-ld20-akebi96
> +               - socionext,uniphier-ld20-global
> +               - socionext,uniphier-ld20-ref
>             - const: socionext,uniphier-ld20
>         - description: PXs3 SoC boards
>           items:

Ok, thanks! I think can let Linus handle this in the merge window.

      Arnd
