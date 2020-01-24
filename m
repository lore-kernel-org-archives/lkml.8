Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E5AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1C21835
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 02:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gQMy796V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgAXCrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 21:47:11 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:47861 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgAXCrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 21:47:11 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 00O2kqei029172
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 11:46:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 00O2kqei029172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579834014;
        bh=+EzVSJ88AM6VtQOKMl81qWyrjKidBjG7lFGZaq37WKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gQMy796VuPmOKP36jF1oyMAK0h18OnO5/G2T5ZEvXJDvysfYvoL/EIn+yTEZ6bOQL
         kXk+A0pAIaB7mkPyuJLKvfVIm94ajpjdL1f+6YLyXNdkEMeMqPvQLQCebeTyqzCn2W
         hTxOmNhv08tBGx22LISXl9HATJtf9PPxN9tj88HWJQuAECKgmhbytjJfvKCq93b9b7
         UlyvamIn1qDM2GpqGXJIGoEdaY7fowr0ybs9+Nb4Vl0lqrXF3IwwH0tObiyXSaETJ8
         vvj0qdu8Y1kFSk4hj30xCGfOidU/pZaRBW0ZjR6K4ot43Q0CPh992od65QN9v3V0gW
         tqsjtUltd1ZNQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id b79so349337vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 18:46:52 -0800 (PST)
X-Gm-Message-State: APjAAAX1gO5Ae0YR80XpnyEFdPhUs491A7kild8BvT0UZG5yffLVeZ5R
        8xEDjT6s/6PKbMjqmpoluSDEasXGrkI5r8Ld4TY=
X-Google-Smtp-Source: APXvYqyNJHWo8CL9vRIwpnUvgr5kzniDUpyOSGA0K3qHXpVn2R+Rv9XBqnrEpWYZowgKPN086DVKKSpRLiqbARoN7RM=
X-Received: by 2002:a67:f8ca:: with SMTP id c10mr938838vsp.54.1579834011513;
 Thu, 23 Jan 2020 18:46:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASSVYHunCn154ktOVDm=MOe+jhEq8Xc8g0JAtCjjJRHwQ@mail.gmail.com>
In-Reply-To: <CAK7LNASSVYHunCn154ktOVDm=MOe+jhEq8Xc8g0JAtCjjJRHwQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Jan 2020 11:46:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARy9eDNHWDYNKAJKGu8U9AChpMPPTLhmTu9bp+VpNhWfw@mail.gmail.com>
Message-ID: <CAK7LNARy9eDNHWDYNKAJKGu8U9AChpMPPTLhmTu9bp+VpNhWfw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v5.6
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Olof,

I know it is already -rc7, but
it would be nice if you could pull this for the next MW.

Thanks
Masahiro


On Sat, Jan 18, 2020 at 1:16 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Here are UniPhier DT (32bit) updates for the v5.6 merge window.
> Please pull!
>
>
>
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v5.6
>
> for you to fetch changes up to 37f3e0096f716b06338a4771633b32b8e2a36f7f:
>
>   ARM: dts: uniphier: add reset-names to NAND controller node
> (2020-01-18 00:56:09 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v5.6
>
> - Add pinmux nodes for I2C ch5, ch6
>
> - Add reset-names to NAND controller node
>
> ----------------------------------------------------------------
> Masahiro Yamada (2):
>       ARM: dts: uniphier: add pinmux nodes for I2C ch5, ch6
>       ARM: dts: uniphier: add reset-names to NAND controller node
>
>  arch/arm/boot/dts/uniphier-ld4.dtsi     |  3 ++-
>  arch/arm/boot/dts/uniphier-pinctrl.dtsi | 10 ++++++++++
>  arch/arm/boot/dts/uniphier-pro4.dtsi    |  3 ++-
>  arch/arm/boot/dts/uniphier-pro5.dtsi    |  3 ++-
>  arch/arm/boot/dts/uniphier-pxs2.dtsi    |  3 ++-
>  arch/arm/boot/dts/uniphier-sld8.dtsi    |  3 ++-
>  6 files changed, 20 insertions(+), 5 deletions(-)
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
