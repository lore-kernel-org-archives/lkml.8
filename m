Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2119C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC3320747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGAIiT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:38:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGAIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:38:18 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N6LIF-1ikk2T2fE1-016k59; Wed, 01 Jul 2020 10:38:16 +0200
Received: by mail-lf1-f43.google.com with SMTP id u25so13124276lfm.1;
        Wed, 01 Jul 2020 01:38:16 -0700 (PDT)
X-Gm-Message-State: AOAM533xy/B54DPq4ztENfNDLBCfLWy5i3zXjLonPGW7MiEEQDXr5sle
        iBdBAJ1mIhFsdXAuXBYS16mfpCFS2+54Wg8GfrA=
X-Google-Smtp-Source: ABdhPJwzwtYzIUVi7Dm9Y4uYvWYcPABWZrBmDbryX1bwywOeHD1krZwjKaIruzorKHAJp9/4fp/5Z5KUYurCFXk9WQA=
X-Received: by 2002:a19:4a94:: with SMTP id x142mr14757261lfa.207.1593592696066;
 Wed, 01 Jul 2020 01:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2ZL6_rV=2brNz=UDdji3mddF+1Nb6Ew+=n4j0-fNrCug@mail.gmail.com>
 <DB3PR0402MB3916BA91E0F44EA5DAD6BF26F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3igMrRNa1oR=d=9A-YNAmb+LXNRbwBk9zuJZq5tfvr9Q@mail.gmail.com> <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39166254A6F287DC0A8216F1F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 10:37:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
Message-ID: <CAK8P3a3FueW3JSLO4RV4WV3C-UP_5y5UA1WGs+gaQGaPaafaUA@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:41ecaovUe9VVqxw3GNZSmlJioDVuUFbZuYiPPXm3pJZCduxti+E
 2PapA+8sEsI26KAMnuMGCKD9nf43PRyPyLopR37GIVMFoNTCWHSLxyvbGV6fTyEkEN+dn83
 RQ+2vHKfVVUeOBx2Um5qcWKExQLtf+0GwODE8C+w7ttybwrAGZvW8oJOoeCOCirvNA8gMfu
 9ZCvYFU8dqHbAPJUHhOpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6QPKR3G4LQs=:UYD4p1YQ5DuPba1zFbRJ1t
 UxU5xk9KDrRr2CEed5E1K6JULqSQ0kn/DlosJBniA/W7t1xJ17eEI3x0Zu1Gan8ozjaKew3mp
 BgLTenvZZnbszZqWayE4lJBuPaYhLMa0yZgbmP+fa9ZhNOQmEiWVW2t47+Rq8HYvgkCTOcs5q
 1ZApXvPNUSJdABHzCagD5aR+auzEGOB3wuDyH7ZEJ+8BFbs4kvbLlESj1uVsaGmYAsfgapFGb
 /P5wDT9dV4NXqkoWr8TSzUNThdTfO95NPBQ1jiMN2pgeKYybkkelGswucr2YVvm3YxJP9vy8H
 B7UoV4RUdad8Fl1PMXbxzjbg/aqnA23PYL9fp165PITtRk41VjP7MajHMemiEGUD3M1eEk4yN
 iq+6QylcHOoZSs8T0SWcaxrTN1sUY4wmCeBc5V+QFVDKdNVzMrtzoQ3Z5NfkpaT9a0bzUWsqx
 mQ/bAWKVrwGk608CcraGBzPx12tx3BPf2ySG54WH3kqGX2o2ZUzwFv7g+1S5nM7F057yRHvvb
 h5YtpNgpGC+0639q+lrGkj9GnTJuXTDm+nRJhVElJ3EFlrdH5Av0mfPZRxrnDaR4bUDRbK9S0
 fv6kc5f+oPZyTlAsZtm4tOylzWQVYkDhG7DmCVggPk+4j/YW6G5xfrqBB37Xp4aE/RNq0j4Lq
 a9YHFBrBdWV4r0DpBQ979xJ/n+cqmG2F3G66kIiJTSIF0eI9Y5uqRejtcVLsHHwFJMYJDif67
 8NNwRhU5Er98IhCS4R7kj3zbBhrQCXPpyZ2ZWksA2XuC1nLosmKA+sYPHB+Fc/DLmlAwDDMZ+
 yt+xsa3+Ku/OfZxnSB9BXcjmb6UOTL7+XUJX0N18/iIeqPBYjc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:14 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 02/10] init.h: Fix the __setup_param() macro for module build
> > On Mon, Jun 29, 2020 at 1:40 PM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > It makes sense to drop the __setup() and __serup_param() in the #else
> > > block, just use one definition for all cases, if no one objects, I will remove
> > them in next patch series.
> >
> > Ok, sounds good. Note that there may be users of the plain __setup() that just
> > get turned into nops right now. Usually those are already enclosed in "#ifndef
> > MODULE", but if they are not, then removing the definition would cause a
> > build error.
> >
> > Have a look if you can find such instances, and either change the patch to add
> > the missing "#ifndef MODULE" checks, or just drop the __setup_param() and
> > leave the __setup() if it gets too complicated.
>
> Looks like the __setup_param() defined in "#ifndef MODULE" can NOT be used for
> MODULE build at all, so sharing same implementation is NOT available, so if it is NOT
> that critical, I plan to keep the #else block in this patch, let me know if you have further
> concern or any other suggestion, below is the build error reported for module build using
> __setup_param() implementation for built in.

I don't understand what your plan is here. Do you mean you will leave that
part of the clk driver as built-in?

> In file included from ./arch/arm64/include/asm/alternative.h:12,
>                  from ./arch/arm64/include/asm/lse.h:15,
>                  from ./arch/arm64/include/asm/cmpxchg.h:14,
>                  from ./arch/arm64/include/asm/atomic.h:16,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/asm-generic/bitops/atomic.h:5,
>                  from ./arch/arm64/include/asm/bitops.h:26,
>                  from ./include/linux/bitops.h:29,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/clk.h:13,
>                  from drivers/clk/imx/clk.c:2:
> ./include/linux/init.h:177:16: error: variable ‘__setup_imx_keep_uart_earlycon’ has initializer but incomplete type
>   177 |  static struct obs_kernel_param __setup_##unique_id  \
>       |                ^~~~~~~~~~~~~~~~
> drivers/clk/imx/clk.c:157:1: note: in expansion of macro ‘__setup_param’
>   157 | __setup_param("earlycon", imx_keep_uart_earlycon,
>       | ^~~~~~~~~~~~~
> ./include/linux/init.h:180:7: warning: excess elements in struct initializer
>   180 |   = { __setup_str_##unique_id, fn, early }
>       |       ^~~~~~~~~~~~
> drivers/clk/imx/clk.c:157:1: note: in expansion of macro ‘__setup_param’
>   157 | __setup_param("earlycon", imx_keep_uart_earlycon,
>       | ^~~~~~~~~~~~~
> ./include/linux/init.h:180:7: note: (near initialization for ‘__setup_imx_keep_uart_earlycon’)

This error just means you can't have a __setup_param() call in a
loadable module,
which we already knew. If you need to do something with the clocks early on,
that has to be in built-in code and cannot be in a module. If you
don't need that
code, then you should just remove it from both the modular version and the
built-in version.

What is the purpose of that __setup_param() argument parsing in the
clock driver?

       Arnd
