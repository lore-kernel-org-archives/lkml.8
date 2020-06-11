Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C55C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44567207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="J/es4ZuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFKPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:09:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:09:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j198so7172544wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bnRdnq8JLK2uL0FC3ENBorVkJKs02mTezFsQPAeEpw=;
        b=J/es4ZuPXP+1e5VAnum1Q+8LyG8YgT+34mxouqoQK396yvZPiwXy9whPazs99utmeh
         DyTYcwtRjrpBg6pu4vVfy1dkV/vbVL6mwcEEopeFCEDHWIbmdYLiiAgLTIBqn2KZyui+
         JsvClLkiKpUBdEGo/omhYWtZu1DAE+g4RA2pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bnRdnq8JLK2uL0FC3ENBorVkJKs02mTezFsQPAeEpw=;
        b=PaCjJdfS6960W+nbgK89A5cO2nriHNmMu/k9vioTrkJZ2f52imaMPUHEx7Fnssva6e
         aONilICbnqSXkMyw8Aa0M39YrReRy+IubLMoef0fCvCJP39E/PCV9cfbSl2NGR22E1v5
         MC3mqsqtIgQkHdqZUazpWPWjwtKhqkfh+J9E8GcaP+TaapWaPooszeIFm1/v8JBD7q/P
         CSRBEIlgB+gJTcnL1igXTLReE8rl/ISu1RdcT796q4/Uls4jMkzx+5I8saYjxXJyxFcr
         rirOsKkoekLSvKt9Ug+qJtKs4PQfKwYEyq4zwnvXfQzE0XWCoxKZA8ut4uQ9CSEk+sRZ
         QgRg==
X-Gm-Message-State: AOAM533A0AfgfExieNS40cemJw7zOC5zwmMO7Y8/a6EnIGsacFLoindV
        jrB7cJ9aHXGDqcJyyHi5d9Fl3b4k44hi2Y//K06c0w==
X-Google-Smtp-Source: ABdhPJzFEzbTe4nZOrgkcxbo8Z7lm4vXqAHZCE4wREr2gS5klf4OPdEt5oMniUG7xfDDSBaEaZTBP4wrxJeFb49IkAE=
X-Received: by 2002:a1c:491:: with SMTP id 139mr8147455wme.99.1591888159280;
 Thu, 11 Jun 2020 08:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-4-daniel@0x0f.com>
 <bf26822d-acb0-ae40-df7f-80978bd26cfb@suse.de> <CAFr9PXmp=mZhyRDpx_E0_1Zc5SFrSYUm9jP-k7VCDf9P37sT6g@mail.gmail.com>
 <3d933b03-9757-f659-d19a-ce6d0fccebea@suse.de>
In-Reply-To: <3d933b03-9757-f659-d19a-ce6d0fccebea@suse.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 12 Jun 2020 00:07:59 +0900
Message-ID: <CAFr9PXmkqFfA=1XFcxOwGM-477eCvy-_y=hY8aW8ePE=nrOO7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: mstar: Add infinity/mercury series dtsi
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Krzysztof Adamski <k@japko.eu>, tim.bird@sony.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, 11 Jun 2020 at 23:39, Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> The downside would be if someone wanted to add newer sstar chips under
> the new name later, then they wouldn't be grouped with predecessor
> families. Right now it seems like mercury and infinity are not that
> different, so I figured it might be useful for people contributing
> patches to see that changes in one might require review of the other.

I've thought about this too. One thing I considered was not using
mstar or sstar at all
and doing the same thing as sunxi and using either the "chenxing"
(MorningStar, MStar) or "xingchen" (SigmaStar)
moniker instead.
However, there are lots of kernel dumps from MStar based TVs etc in
the wild already that are using the mstar
prefix so just continuing to use that seems like the right thing to do.

Thanks,

Daniel
