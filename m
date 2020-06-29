Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1472F204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgF2Sq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:46:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgF2SqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:06 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N63i4-1ijUcQ1moa-016RQt for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 14:31:02 +0200
Received: by mail-qt1-f173.google.com with SMTP id x62so12639867qtd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:31:02 -0700 (PDT)
X-Gm-Message-State: AOAM531p7869LT5njh8wnj6KVn4FQ+Xh3qJNQJcKg59cP05CCuxmgU9O
        tVvku5tfDJ695M6Z1OLQ+sQp2J7zRce2QdWcvKA=
X-Google-Smtp-Source: ABdhPJyi8d5XSsqDz2xGWs39SMtTovk0NumfjVlNgvEVQqVelWtmCwHZ6CtxBJqI3LVrMPW8vqPvDjskRDxpKTJl7uo=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr15464702qtq.304.1593433861257;
 Mon, 29 Jun 2020 05:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com> <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
 <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com> <DB3PR0402MB3916192607A09C7061740087F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916192607A09C7061740087F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 14:30:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1NoyMGNK90WzbgJ7opPbiVL8vwnMEuBeeNPNyvB+5sqQ@mail.gmail.com>
Message-ID: <CAK8P3a1NoyMGNK90WzbgJ7opPbiVL8vwnMEuBeeNPNyvB+5sqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2bbfnnu6caMfroSf3X6brnBsM4ueKxnAkzlLwmtvc7NLrcVsHrG
 HG76r3AKyTfjXtQvSsvspWv6vx8BJvIpJ+SYUFm1kKL+CKntyhkyzI0zuvAGUEWog7SlI2D
 BJRJthS7uCO0R2+HXeUsxIL4380OI2P7I31pzOUAp5pt1FiI8u1eeoaYd7YSAK2+3LZrkIt
 aDA+yQeFVhaTWSiwmn8nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EeNE1Bczr/E=:vh9X1h67EmkOmWVO+u3MlR
 6daWYLlzK8gV5wW6CEZWyje4BRW7MElm84xD2hG0JMjTt6dt2OcZUrd3nNSVWZFPebb6xnr5O
 ZSnOaJXT939t8FT5IncDhIacZwF7daeXNchIGOb2FTzJYvTnUHPNCVqzWQVmZpjzFdTIu8a/2
 O0XzT1j6gQYfZyl6Hmi0OOQSWNmLUejAPbAWE+S5+DuUQFjrxJvtSU/BgHnra35emZVzoDhzI
 YY5gaSUl1HXyrTB0asdpv+KRE2MB94I+0rJc7OXvrMWdRK6rDiZy8tRJ6SPouy+Ix5nSn6WOP
 HhrBesKYfAkbAtJHLTpIHXHCoEsYdduz0k+Ew9mZkTNedxkiCwB6w6YoLSW9w+2DUbmRdkrgg
 Uo081LIZP6S6CuOhd1KnLk9jK9wEVk+n4eD+q2bH5TW+pI/DDZHTfclfrigwdt+fOsW6BriNY
 bG1PdhTZx4EaYtCiAvEBEKCuAsDbggojHKPRo9pvaj/ls3eKl0l3X5LuSmKXGQxrQnqgKhhGh
 M8o53h+f3GkmTJ8tu2A5s/G+NkypngXw5YpA+4LgRp5QBQSz/igkt16gwKGTUj+a5UULj/5L4
 nD4h32mFdpkfe9UgmkbuFkiAwAffoVhz8xv9Q6mtMU3IxeqLUuR3pT9bthmbQVxJZhsfDnUUo
 9CAQ2YOh7f47fH/W6l3P/CUuInMvzPGPvfNZSFGSQLx6Yyvt7pGESJFB0BPsNW/9WhtuU/WfY
 I2dS0KFCCRbemrvlvVeUFiigvMawJcaqNUsSZArBTqWvf3X1hNbXRGyeapPsNAheNE+YGSvRM
 4YfgTYvlW/SHSag8fBJr1cLxroUiskIxgldnF0XgboudRaKZJE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:09 PM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > It sounds like your patch 1/3 is not ready to be merged then.
> >
> > Please make sure that loading it later does not break other drivers that depend
> > on it. Other drivers don't have to be able to deal with missing dependencies if
> > this one is never loaded or disabled at compile-time. However before you
> > make it possible to turn this into a loadable module, anything that depends on
> > it must be able to deal with the modules getting loaded in a random order
> > first.
> >
> I searched all driver which uses this reset driver, looks like ONLY i.MX6 PCIe is using it and
> it ONLY supports built-in.

Ok, thanks for researching this.

> and inside this driver, it does NOT support defer probe etc.,
> since I am NOT sure when this PCIe driver will add module support, so do you think if I
> can make PCI_IMX6 select RESET_IMX7, then it won't break the PCIe function even
> RESET_IMX7 is set to =m in defconfig, as when PCI_IMX6 is enabled as =y, RESET_IMX7 will
> be also =y.

Yes, I think this can work as a short-term workaround, though ideally the
PCIe driver would also become a loadable module and also support deferred
probing.

Having loadable PCIe drivers has traditionally been problematic in Linux,
but Rob Herring has recently improved this in the series containing patch
0c59c06a7c90 ("PCI: host-generic: Support building as modules"), which
was also intended to help with Android GKI.

As i.MX uses the designware PCI core support, this may require some
more changes in PCIE_DW before the i.MX specific part can be
a loadable module, but it should no longer require changes to the
PCI core code. Turning the driver into a loadable module is probably
not even that hard, but making it possible to unload definitely requires
adding a proper .remove callback to properly unregister the PCIe
host bridge.

I also see a DECLARE_PCI_FIXUP() and a fault handler hook in
the pci-imx6.c driver, which probably need to get moved into
a separate built-in file with a few changes.

And then I noticed a bug in the driver: it hooks the abort handler
from an initcall whenever the driver is built into the kernel, regardless
of which machine it is actually running on!

Regarding deferrer probing, the PCIe host currently relies on
the clk controller,  the regulator and (on imx7d) the reset driver
to be probed first. I think making it support deferred probing for
all three should be straightforward, most importantly this means
not printing an error and returning -EPROBE_DEFER when not
all dependencies are there yet.

       Arnd
