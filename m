Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ED42073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGAJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:53:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgGAJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:53:44 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7yz7-1inUHd0d9f-0151pi; Wed, 01 Jul 2020 11:53:42 +0200
Received: by mail-lj1-f177.google.com with SMTP id f5so10290608ljj.10;
        Wed, 01 Jul 2020 02:53:42 -0700 (PDT)
X-Gm-Message-State: AOAM531QBmlciIkvRWE3CvxcvubCt2z7sACFt/+V8NTZgo8jeNomrBLI
        QtccpMioVo+cah9J0Wi1WPQIEWpAiU3GYW2VrUw=
X-Google-Smtp-Source: ABdhPJwcKJeNUzMpJ3AFWLgDww+593rA0lIZ+o9T1ESGJwcmvt8h8OKlKgOJmjFZ6E7g6CKPVURXF3FchoAkKNegvZI=
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr5814766ljj.168.1593597221597;
 Wed, 01 Jul 2020 02:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com>
 <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com> <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F746C792CB2BC876715BF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 11:53:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com>
Message-ID: <CAK8P3a1E_UecNq=7rvceQoXdFkmnBFOyUtxrpJ1bF6cLWOtNqQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:s/nBx8LPIaFnpCo7zScRj0f1v40/+zvoPK+6/sgBGubInyRd66P
 U5nSMmiYJgml+S009e9bIg92fIthh9VBVVOj8Hx26GpPggyQdbUc26R3slQDHW9fT5soIEc
 zUUgNN29R2mxWTr+9X8e/4jyyikuUqOv28z/q+cRe7ZOwf/6wk5yYSzXutPSGwBD6uz2N/H
 /8OklkUTKhX1gM28Bqm8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:58vuynDe5R0=:qkPbF9lEoyv6WIfnRemzqQ
 UJiAeSqilD6uqeMZi3TUb26jEPTL0UI+gyKx6raxPYM4Xvlml8bBJqNNBeNYqD5ZloJzOXmvB
 r6YRWFh0ABHo4K8AGQR/o6ZrJHZQ4Yqe4HJSXVomNUtap4V0BYiAQCP+MOUI/BLGjSXIRZTNX
 7P7pp/qJIg9dw0aRyn/0vqnP7D26t4QGF9RnGBvLjVY/uN2jmXt2q6mXbMZ5rriUKEmzYoFyS
 5q51sXr9uRGgjvZzw2UYsW18O1PENbYL4fu8CaF0u+e+CmAqQqm9FR1Msihu6/NkzbeYiS1qi
 WOJeIq41EJgzWP6ST5GqXxWwEVLO6npYMChdKdz70b6R4YA1c5QsWqCoiYLwpgmyanGlAIWFk
 IopBMq/KDM3PDoC5axBojSOv4sBMbJlhG/eiqQ49lGOH6xnV8NGaqW2F6GqgRRb+JYr78klcW
 uc2vH04UUpcUfWgjfFLadx2qboaTa+4qIqr+51YVm/Gw83IpKntPmFqu9APi5MdXNUXOSDa3L
 SwkO4tS2Wbr9OjEg9y2pd91Z4vT6hdbYvufoHQE7bN2+Pu0/hMHTctU3xlwtDfMKzrWtitw5T
 ie4VWxp4YVap7I5/iZl57IEdv56ppT3hO6MuRKMzcbXAhnPQ8Q3ZioJzQFyuQyDzdUtPKqwYf
 mTQENg04jAaJ2OogN3nvqtI0s40pcA0ZA0w3QVnvzmcuRTLXbsxGhwDg5eZzOWQRHz/gkmEyS
 PFqyRdEXJsaC3Im9TntmfXCwMVDbj8TeZetJAmbc6BM551chTBVff+jNYmdYLWIoGCfmNzmNm
 rJAV70SnfjmHWyqbAa2m9UQVOcAgl3zI4Uh7jzshmGvlfo9DzZr5KjxWSPpoUTGoEPBfmMiuK
 iNMkZ6xcBqNfSmV5v/Ak+VotJZDzZ1hIpbsf1+4yWrbrBctw/5a2GNRDysoY+w4SS8eWAmNLZ
 tt4AuD0ZYQkzqLE1NwpTMjl/JNN0q2uwdK49XDjG3Tfsx31Uu/Z0s
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:27 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for
> > module build
> >
> > On Wed, Jul 1, 2020 at 7:14 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> >
> > I don't understand what your plan is here. Do you mean you will leave that
> > part of the clk driver as built-in?
>
> I meant I will leave the #else block of __setup_param() defined as nothing as below to
> make module build passed.
>
> #define __setup_param(str, unique_id, fn, early)        /* nothing */

No, I think that is  mistake. It will mean that other drivers with the same
bug as the imx-clk driver will appear to build fine, but not work correctly.

A build error is better than silently dropping the command line parsing in
my opinion.

> > This error just means you can't have a __setup_param() call in a loadable
> > module, which we already knew. If you need to do something with the clocks
> > early on, that has to be in built-in code and cannot be in a module. If you don't
> > need that code, then you should just remove it from both the modular version
> > and the built-in version.
> >
> > What is the purpose of that __setup_param() argument parsing in the clock
> > driver?
>
> We need the code for proper uart clock management of earlycon, from the code, it
> is trying to keep console uart clock enabled during kernel boot up.

Why not move this all to a separate file then and only build it when
CONFIG_CLK_IMX=y?
It seems that you don't need the imx_keep_uart_clocks_param() if the
clk driver is
loaded as a module, but then you also don't need the imx_clk_disable_uart()
and imx_register_uart_clocks() functions or the associated variables.

     Arnd
