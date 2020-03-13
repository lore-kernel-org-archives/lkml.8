Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6EC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB9B2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCMKXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:23:53 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:23:53 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNL2Y-1iwefF1he6-00OkjQ; Fri, 13 Mar 2020 11:23:51 +0100
Received: by mail-qk1-f174.google.com with SMTP id e16so11524503qkl.6;
        Fri, 13 Mar 2020 03:23:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ24k8eOENtIYiud4zkwexFqM3w9+zACEQYpvETucADmdnEptKpO
        bLj9W9LQhDv926st46fMDku8V643+dj9tlrdbJQ=
X-Google-Smtp-Source: ADFU+vsfaaXYmPUQjslMErhWJ/7BvzHgLpx+ZaRka5jikHGLM6PMuhOsS2wljIY0klh7xwIHigG91vLUduJxNabWMiQ=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr12564191qke.352.1584095030201;
 Fri, 13 Mar 2020 03:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <1584070314-26495-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584070314-26495-1-git-send-email-peng.fan@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Mar 2020 11:23:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
Message-ID: <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Makefile: build arm64 device tree
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GYi++AP6j9j2XxjU9mbIA92RCdmrg0YEULM7da0/JU26Z7pmxot
 8K1u1ntVwNw3cHkOLDds2HphH5/A/D671faepELJ/5+GPIpbZtePTnx4pNCRHM0Cha/NCu3
 rS+stg5SNKxXFwty6gi7sF0wgfX2MhpC8NL/byr5DHipzDZ/ycOmO9PBbB2F04zOT49hzns
 A5A6A4mPKah31B8/dQ6KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qihaRHoDAgw=:LH8RWLl8m+4ye4gEfDDKXv
 2NfTtFYI3hx7oFzT0I0b13mac6Ii//p5pjCkt06yVogAw34obkIXbgWd9kuOa+dg1F4iByEOs
 fkPy9fFj0wbXZ2vt/Fl3EgyEe4LJSi4xfHJ68LvMwJdz9GeHE0LYl5kPP7w1xUBpR2Tn8FJRn
 jV0pkNxxzcn6AFjxp/+SXF8EiDqu87ADYxQuVSkjC4vuNw7Tfkza7DZspIZmOmhWhfuHzTXkr
 BXLCchmqhgYg10M0zSswujj7WcbwknuE9XW/Yi18Hr/KJdtlPmrZlaXzfPXIQFgwir9Xf+ShN
 gAhq3KOHppdVHG+nRy7rc0aivE1bTqgwXCRuDBmumTNpTkzj1JFvh2Frp6Xu/cNSS/5C1p0y+
 hYr5nxnkg8XDJ3GhqYdfUqCHrGaKQbr1DZ14iI8jYxr/Ii4nDbZHh6Pye6vonVXxm2XCFjfeD
 AoTWW7gbH8Ba1G7zD43a7TiZQG/Qv/Jv42CymDiQl+siKikp64/HSg2wMmpR0Zs3MvtAu+oge
 WBaJAeSEuEGrdHLoTwaDo4r92TyuWvSxGnN2nZ7d6MXPeddWqx/e5JFEXVywoTabaLuxGX5GE
 1zPoTF8+sZ+IQo4DLsdlU7GKKUje1iVzn5nIi9e7GkYTPeMgULLB1nguo8yYkf0TKARmePfgE
 ickx651s2Un8Sxl7F+0sfjFaOYdGikCizZxVHiwB6saf1GK+TweIUaysbIuSH6+BEG+QxaEnb
 bW/xJ7uC3o3VKQw1EOmyPj2FLhOnNXN5r0xMtJasnObpsqCGs/SG7r8ZlUMqq35i1FKaxct98
 gl4Zn3atdGppCX0W2iwrAHNQBdG3zgJsGEDPifSke7eZ3B1s0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:38 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> To support aarch32 mode linux on aarch64 hardware, we need
> build the device tree, so include the arm64 device tree path.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

There are a few other platforms with similar requirements, in
particular bcm2837,
so maybe try doing it the same way they do, see
arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts

> V1:
>  This is just the device tree part. Besides this,
>  I am not sure whether need to create a standalone defconfig under arm32
>  for aarch32 mode linux on aarch64 hardware, or use multi_v7_defconfig.
>  multi_v7_defconfig should be ok, need to include LPAE config.

I'd rather not have a standalone defconfig for it, given that we have a
single defconfig for all armv6/armv7/armv7hf i.mx machines.

There was a suggestion to use a fragment for enabling an LPAE
multi_v7_defconfig recently, which I think is still under discussion but
should also help here, both with imx_v6_v7_defconfig and multi_v7_defconfig.

Can you remind us why this platform needs LPAE? Is it only needed to
support more than 4GB of RAM, or something else on top of that?
Note that users that actually have 4GB or more on i.mx8 should
really run a 64-bit kernel anyway, even if they prefer using 32-bit user
space.

Turning on LPAE not only disables imx3 and imx5 but also the Cortex-A9
based imx6 variants.

      Arnd
