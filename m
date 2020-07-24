Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380BC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589702065C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:37:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:37:22 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M5Q6n-1k0MOz3oDl-001RSX; Fri, 24 Jul 2020 16:37:21 +0200
Received: by mail-qk1-f178.google.com with SMTP id d14so8733337qke.13;
        Fri, 24 Jul 2020 07:37:20 -0700 (PDT)
X-Gm-Message-State: AOAM530FIFJc95r7tlLXcXV7NgEUGV9fBFtMgOZFoSH9aCHC1QqVp0ub
        szReiIBPj6uwYpEdyq7S9sR57/HWG6uZF5xqRl8=
X-Google-Smtp-Source: ABdhPJyaQi7YzQKTJwmOO4XDEeEyZaHphOcqVuChV10LKgqkrkdxnJ75ifPgkS9cU2YkIgVzTsgKdKYNadxoztv7GTc=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr10764238qko.138.1595601439718;
 Fri, 24 Jul 2020 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200710094544.430258-1-daniel@0x0f.com>
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 16:37:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2xQmba=ikPjRZCu+PhMGMRKDWW=WbgzjRypD9U43WHDw@mail.gmail.com>
Message-ID: <CAK8P3a2xQmba=ikPjRZCu+PhMGMRKDWW=WbgzjRypD9U43WHDw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Initial MStar/Sigmastar ARMv7 SoC support
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YLqLKonfSFlV0CdryiCWyZo0KqBmLMX0UfCGDGKDrrPMRzm2Hct
 Ztf2ZBDM5+/H/XndQ/LS9H3sP0bnW5+u2srbtzlLBfGd/uWGha8cGvgL6jj1vDQ2KrkAVrk
 4mlCMm/wImI5OI9VgicQKt/jSk4t4NZscA3hKRcKwwypkNADgzpBZu8mrwkd0Shai9F6V6p
 Re1+014RGObpWXvfAXS+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qYsSy1sGqow=:ozo37+sqzsWY5KN5+V+YPI
 OlCXkG+1uGAPEs4x28hvbfb7vE1YcujfYXFT5xV1GF9bl9/VC8ouXY9p0ReOAYV0hHOxLnMhs
 Qrc5Ceetk6PUduiI3LOl584yJlaBkrJqkl3lH8Er3zibKHbn434znybWfHvp7LlfaTVvtkT+B
 Mm1Oc3cMcfhCphAScByEKkTK2gWPA3tPo5F6kGItVyCMr9q6aixvJXwKGzoJPRKkTfuLgG6Bl
 3oAP6a+3YgzwksObkpGDOpSKGCwxeHU4ddWIqOcOb+3CV6OsMqHkA0UFtwbVEpqkA/GWJ9Ov3
 ynuV01ekPkRUq3kin9/uA2yH3iSd138L+x6cjBNorXqDRx+0mJULTl3NwmZp7AQA7PP/3EG8w
 48rA6nhG4n0CXkWmLXpYJ6Wki0rIuynAwOPG/zHroaaCOo8KytudNcNQ1DBtEUJ16pL7eRHum
 OwazTZc5iFxQKwCd0iBqQTO6Zm4VsvwTnpTgidrM9NnjRu8ZzTjDH5YsI2LhTN2VvdXz7H0MQ
 /ywa+I4jndo23Il8TafVODSX2PbHwIUQxO6dsPnbKbFvPHy3s1oQmhpzV4AB7rRdo1LUSY8hv
 Nj/uQDY9LR4cBc95RfcRh7pSUMUc9X+wEsBr5vlaLArGkGUWtnokqDT3dxVVmL/4GHhi4yEIb
 f4w4nUWC0w+1UDefFvoSmu8zXzaU/BcTXlRIDnxAHbxRH8rPJCHU1XwWkxZw1x3bYx12JyN/k
 l2ahhrFD0Q8i1RTVt9BMrRnO88m3cAarJAX/o/cFq7nYkhows7EZU49w1aGwzJ//be5+pkiW4
 /AZ+urb+e4cxs1ne7rq6rAmh9+AYO7zt4n26ueBoYgBhWYyJortjXI5VrtwKhs/DwzQ9P2kHp
 rGqcaqR3F1oFPaM9D31vh7DOc4snOFK5YT1DjajpeRkI8Ia8xsMbOHGKvHCGkCtC5/grEbh4B
 iT/5/nvlhiIgq5cnFIulaqNYEIEalrC6v5taFCaft/luDscbiiPLK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:46 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> This patch set adds initial support for MStar/Sigmastar's
> Armv7 based SoCs. There is just enough here to get to a shell
> with an initramfs but support for a lot of the hardware is
> in progress and will follow.
>
> MStar also shipped chips with MIPS cores and ARM9 etc which
> are incompatible so I've tried to make the distinction in the
> code that this is strictly for the Armv7 based chips.
>
> Sorry for the spamming this. I just really want to make some
> progress on this because I'm worried the other bits that are
> needed for these SoCs (Really old AT91 support in macb and
> the fotg210 usb host) will be lost or stop working in the meantime.
> This already happened in u-boot.

Hi Daniel,

I just found the series again after looking through some backlog,
and noticing I missed your submission from July 10. This looks
all good to me now, so I've merged the series into the arm/newsoc
branch that already contains added support for the keembay and
sparx5 SoCs.

If you require any changes to this, please send incremental
patches against the soc tree, and submit it to soc@kernel.org
so it makes it gets into patchwork.

       Arnd
