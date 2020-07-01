Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED648C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97872073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGAKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:14:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGAKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:14:02 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MWz4j-1jJm2z2fWb-00XK1R; Wed, 01 Jul 2020 12:14:00 +0200
Received: by mail-lj1-f170.google.com with SMTP id d17so11543112ljl.3;
        Wed, 01 Jul 2020 03:14:00 -0700 (PDT)
X-Gm-Message-State: AOAM532kA/9uvjHIUKkMqNuGA5XKB4OSc01DncNj6XqWIngARR62GPiU
        yOkjpAp0oNyrYwHMyPcZyfNPgBT9ZgPaXgTnJ2k=
X-Google-Smtp-Source: ABdhPJxvxG0YKdQRIZLf3EEmE6+prGIuqXSwFxFbLTEkpoK2wHJFxihZY6FoRRGdIX48u3tOAqejPZ41dhROmiVpNQU=
X-Received: by 2002:a2e:7f06:: with SMTP id a6mr2089791ljd.446.1593598440088;
 Wed, 01 Jul 2020 03:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
 <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
 <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com> <DB3PR0402MB39161C372E869A670D115FBBF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39161C372E869A670D115FBBF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 12:13:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YKsiKx66ESwvVmsubv=x=UB8JafisCY0Ct8VBMi-JhQ@mail.gmail.com>
Message-ID: <CAK8P3a0YKsiKx66ESwvVmsubv=x=UB8JafisCY0Ct8VBMi-JhQ@mail.gmail.com>
Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for module build
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zAbsWGYUYSjUhDcXivmTqZ3C0+A8yahpkjUtZi8A1inf4RtBPZ9
 Ny86rfoQjBRRZ4GqI5RqnDLxmWFce8ZfiBQ0KzC57vBlXk6Xz/x8amZAo5r+QKFyXbQeu9K
 t0zpF3Iq/33XnrT7yCFMLNATdMEaVUQJ52c2ctDgB0Q8dwhEet4D9Al5JGAyayX/s6uYd/+
 D2diBSzGf3FZ9DWXIgC0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wP/f4dl8JjM=:hptme65rAWGJzgsV9COIjS
 Ki8v5CPeBc+Dog1BdJnPh6/CYK9LmJ7obbjpxReq8/e69JtKOuyaIKBpRrxqKSXbmR3hsOaIc
 K2oOcuNWS7nK/jo1Vm1kzM7aMBD9uIL75Dia3pmoPPAx29CMboendorHguBcIGFvcfxbEp+8P
 z0te78arOZf3wjfqMNVEKdpKqUh7ZA10gxRHrS0Xu+xuWUlmrqAYTi2H8T6SBwl0QohzAn9kJ
 Q6wpmITUduLFAnmZY9+MbG+pmP7vtR8qMHhZjzRykptrooNqEu6za5Z1wE9vKDPHp+kcM9q12
 cBRWBgWiOkMspBAAt/OEMEyDEcKXGvY9zZpJ8ZooTddGOd3S5HIGsH60qeFqtuu6dpUFzJ5HU
 HoniL0S2W+L7FCVg79wuaplUD1iSByS9zjbhPuarH6w+BDi70IfYAPUNWNYYw2cx56D95jCA+
 Acje9/utIC05xXdTIYyh6mkipZjVEQYi1paUI/yuQj4UFF5g28LW1Pc50sKuvEC+/K7+HwUji
 bmjXBJWE3n+F9XB9P08jLZlDp5EYU4Vwpgo2bul2ZXGT7jKjJhgMwQvWWsTpPUXN1752RDvFS
 1r3fL/zqfml/99+gJFC0nNk65b/EW6TbuEFFdDj/AOXVx711IN5+CGHaAegYZVnptMtu8sufq
 MLpNnAsngDiTGPofn7vDW6uwrvzjMb6SQeqDXMtD7JfaTdyxuTAszm665N4d6ZAyXoEp9npQn
 RCTmlkn7Ippgxvw60N4scClRWBFKdW8l9StjgXB/E2JuJbiYFnS4V1LguKJnnXgc75sUELt9J
 0sGkMtraqvci9Y5+gWVxChWerO3LrLl3PGEZwzKTF+WqiohWQA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:02 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for
> > module build
> > On Wed, Jul 1, 2020 at 11:27 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > > Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro
> > > > for module build
> > Why not move this all to a separate file then and only build it when
> > CONFIG_CLK_IMX=y?
> > It seems that you don't need the imx_keep_uart_clocks_param() if the clk
> > driver is loaded as a module, but then you also don't need the
> > imx_clk_disable_uart() and imx_register_uart_clocks() functions or the
> > associated variables.
>
> If so, how about just adding "#ifndef MODULE" check for this part of code? I think
> it should be easier/better than adding a file and build it conditionally?

The #ifdef is clearly a simpler change,  but I think a separate file is
a cleaner way to do it. Up to you (unless one of the imx or clk maintainers
has a preference -- I'm only helping out here, not making decisions).

      Arnd
