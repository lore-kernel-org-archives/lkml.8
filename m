Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3591C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C841E207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgFJJoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:44:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgFJJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:44:10 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9MlI-1iomFg13Wm-015KAf; Wed, 10 Jun 2020 11:44:08 +0200
Received: by mail-qk1-f179.google.com with SMTP id 205so1397453qkg.3;
        Wed, 10 Jun 2020 02:44:07 -0700 (PDT)
X-Gm-Message-State: AOAM533JwTxCxmVxd+bGyZZ8LWwnIEX2fjF6cxPyHnlMYfZ7DJmTQ3DR
        xnEMPtcuSkGXp8LYWrvmMMD07CvIN6KnPLv+2p4=
X-Google-Smtp-Source: ABdhPJzRNYG5EcQw70snnJLT7htZUC81kIXI94+5koJrICYsQfuJmxhcIA3XJt2ckthClHUdy2fovJvPPBTOp1iz1uk=
X-Received: by 2002:a37:9401:: with SMTP id w1mr2110620qkd.286.1591782246851;
 Wed, 10 Jun 2020 02:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-2-daniel@0x0f.com> <20200610090421.3428945-3-daniel@0x0f.com>
In-Reply-To: <20200610090421.3428945-3-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Jun 2020 11:43:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2JeH+-Naivo8B-JWxebB2ArkCLJw8_CN2Goy5bkSTBwg@mail.gmail.com>
Message-ID: <CAK8P3a2JeH+-Naivo8B-JWxebB2ArkCLJw8_CN2Goy5bkSTBwg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: mstar: Add machine for MStar/Sigmastar
 infinity/mercury family ARMv7 SoCs
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, "Bird, Timothy" <tim.bird@sony.com>,
        DTML <devicetree@vger.kernel.org>,
        Daniel Palmer <daniel@thingy.jp>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lU2b0x8yqs9dY8JdqQi624zU2A3u64WZZdXSPs5TO9KumojjZXv
 Hwug4fi66Y2UDqmvotkCzdDba5/EgMr0wnhdT4++Tnch5W1yI+7AwapjHEPBnFYcjtn0+1c
 OaD10KUhUWJl3mqItC2yGx5j9Lnh5y6RG1p113v4632WPa3PNcQpVJrr/3Av9VCBvhEV8Z4
 AnGsrnwLNADH2arIwVGzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/XwwlzMmJQ=:EU5wKH9C1dYiHYsWryDZQN
 weK1a0hsWNDmko5Rc//g1iCuwhgmPCZHLkiQZ7WzU19tEB6l6SMYPYcs1Emr6CCCriMqj0EuR
 waXcV6JsMRn8cTatuiN2/QWjGCzAHEZOjx8rnU1F54R4ZkdL78EUHymkVUdbL+7SyQtWCPe4G
 xwrlPIGE6MlJVDSuaDw97pfJ4IT9g8+OkULxhsq6VIRNl10bWo+zeogx+ELs4Nmv0c/GRYnRR
 geU3XvLuY7HPsx/TYccRg8nkim5p9IfH/MUToB3eNCBHkxPaG7ECEumh9LWLCIJEmLPASkXZH
 bwywkUlO+NfduFmMDoMuR7lgrHu9qijJICisvQGUQxvad/z0J6xTukh3oFcIVQvXLxnQ0WQYy
 KTWk3uTAZ6QzXffQS5gKidM4u8RGQkX8XrE5ej5cjkj1FvV17ZgSIWhiZAMePZmtW2XsqyzV9
 Pupd0+TEHZqFUasRhzWYZ8+JQamaTjGqfvfzTTuQRmFQr5Et2gLFkI3e4iPmAXeUziPJOPllo
 JyRh0VumjCY9rlvGWsfpTNhBn7PW2SAei1iB+rv46ncxHiH+YC6S4Z/YwWxpQo7AJLXzhMewS
 ClVcH5g/OSKxZZL2OPisBkPLTuVasifNNDkLS2z/hYVJp/xw1G+RF9HcNi2BGZ31zT4IUy4T0
 W95oqFsDBMYKsiBS8Ngctzz8BwG2Uh8jOob/VkQitSOnHzDeBgJnqILsSGgoF/IMEgPVKwA1h
 SBN11hStpdDhZr0qaFqBaO8u8OYvrWLvdJuMTItSLFzk/JJHKB/b5+38Kjc6cA3rFJhVakBRU
 /MjpiG3Bto4LCNA10NSLDFzyTYjfjsUir8qALva+1HM2CZVVaw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:08 AM Daniel Palmer <daniel@0x0f.com> wrote:

> +/*
> + * This may need locking to deal with situations where an interrupt
> + * happens while we are in here and mb() gets called by the interrupt handler.
> + */

I would suspect that you don't need locking here, and locking would likely
make it worse.

From what I can tell, an interrupt happening anywhere inside of mstarv7_mb()
would still result in the function completing (as miu_status still has the
MSTARV7_L3BRIDGE_STATUS_DONE bit set) and nothing that could
happen inside the irq would make the barrier weaker, only stronger.

> +static void mstarv7_mb(void)
> +{
> +       /* toggle the flush miu pipe fire bit */
> +       writel_relaxed(0, miu_flush);
> +       writel_relaxed(MSTARV7_L3BRIDGE_FLUSH_TRIGGER, miu_flush);
> +       while (!(readl_relaxed(miu_status) & MSTARV7_L3BRIDGE_STATUS_DONE)) {
> +               /* wait for flush to complete */
> +       }
> +}

This is a heavy memory barrier indeed.

The use of _relaxed() accessors is normally a bad idea and should be
avoided, but
this is one of the places where it is necessary because the normal
writel()/readl()
would recurse into arm_heavy_barrier(). Can you add a comment explaining this
for the next reviewer?

> +static void __init mstarv7_barriers_init(void)
> +{
> +       miu_flush = ioremap(MSTARV7_L3BRIDGE_FLUSH, sizeof(*miu_flush));
> +       miu_status = ioremap(MSTARV7_L3BRIDGE_STATUS, sizeof(*miu_status));
> +       soc_mb = mstarv7_mb;
> +}

Hardcoding physical addresses is generally considered bad style,
even if you know the address in advance. Can you change this to get
the address of the L3BRIDGE from DT instead and just hardcode the
offsets? Note that they are in the same physical page, so you only
need a single of_iomap().

> +static void __init mstarv7_init(void)
> +{
> +       mstarv7_barriers_init();
> +}

I think you can fold this into a single function.

       Arnd
