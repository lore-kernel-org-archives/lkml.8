Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9561CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DC2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUaaPrZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBCOfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:35:12 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:41394 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgBCOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:35:12 -0500
Received: by mail-il1-f196.google.com with SMTP id f10so12766212ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PeAE2050RUwA2PhxvSVJSMNprANdC/69hQV8eL+NY48=;
        b=TUaaPrZnYM1tgevoqkuJWFXrJMpt7+22SMpJkevzbwT+vt6EMOU3Sxf5Ll8wF7cWhx
         7wgPwHJBuaVxTxd2/kVnoxRg3aW8jdNZabM+0Z/6I40M8Hfubj7S1Z5RTdQgDwPFOlFX
         OVICfMVZyyoNxzFIvNvbpQZVApef+W2nMB6qVASrRYzBY8X67KyEq3DacxVLhs9NYN9H
         vqjOWSLE5mRse511pO6UqBzDcy18YqEX0PX3v8nMk5Y+GMUrUyHqK5xTkzftOzmp7jp5
         zRsbdXlVnXf4+DzZwS5E3lmroWXUCCzizzdOG527hxV8gTth11yutKox7zlpOIfLMnZV
         5aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PeAE2050RUwA2PhxvSVJSMNprANdC/69hQV8eL+NY48=;
        b=pZNVNy8C5a/zph3jWlknS9N0q9mF1Y4aJotodsG/kpEbwu471Hd48bF/k1OYLR1XDl
         tGKkD4AQpYwpjnzZfW510CEqMCNa+SCuFLcKPhsIot7Vy4EzPgMZWDyXJ8gbLfWtg9aa
         5Bt9dmg2nW5+u8xza0D7Dn5a/fxfTeXimCama8gRMpmreXGwn9l4nHq4/Nm5BKg2kTAn
         R/uo6hAwQhYEmak3MI0WrxpB89zoe5Hh/dEBYwP9A0IOqHdMsbS7tDALfBN9utZYflJC
         uOJye4HVd6Y78HWOj9f5co2C1Iz9++4tKzGTjPWKSqQBQOawZLpunzdxJV9sJCbDw6yG
         s74A==
X-Gm-Message-State: APjAAAXQ66OTGScAEjjzT1ENSSRiMrdkGN8rAoSL9702kc/gIGMxAvZr
        85ZIjYn972MlmrczQRUIpr+Y3goW4+FTG5749DU=
X-Google-Smtp-Source: APXvYqyHSJVh71XbyNxUrseBdDaOrgsCKYEgH80cZsvYCQFfhjuOIwCdgh9E8GWzYcLhFnLBPzjp7kW4MaZ05lXAWdg=
X-Received: by 2002:a92:981b:: with SMTP id l27mr22497981ili.118.1580740511331;
 Mon, 03 Feb 2020 06:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20200203140425.26579-1-erwan.leray@st.com>
In-Reply-To: <20200203140425.26579-1-erwan.leray@st.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 3 Feb 2020 15:35:00 +0100
Message-ID: <CAJiuCcfRuHXajo7+cDMpQ73vhGuerW3_ObrfG0YOEzogKaH-sA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] STM32 early console
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan,

On Mon, 3 Feb 2020 at 15:04, Erwan Le Ray <erwan.leray@st.com> wrote:
>
> Add UART instance configuration to STM32 F4 and F7 early console.
> Add STM32 H7 and MP1 early console support.
>
> Changes in v3:
> - fix a missing condition for STM32MP1
>
> Changes in v2:
> - split "[PATCH] ARM: debug: stm32: add UART early console configuration"
>   into separate patches as suggested by Clement into [1]

Thanks for splitting the patch, the whole series looks fine to me.

Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Cl=C3=A9ment



>
> [1] https://lkml.org/lkml/2019/4/10/199
>
> Erwan Le Ray (4):
>   ARM: debug: stm32: add UART early console configuration for STM32F4
>   ARM: debug: stm32: add UART early console configuration for STM32F7
>   ARM: debug: stm32: add UART early console support for STM32H7
>   ARM: debug: stm32: add UART early console support for STM32MP1
>
>  arch/arm/Kconfig.debug         | 42 +++++++++++++++++++++++++++++-----
>  arch/arm/include/debug/stm32.S |  9 ++++----
>  2 files changed, 40 insertions(+), 11 deletions(-)
>
> --
> 2.17.1
>
