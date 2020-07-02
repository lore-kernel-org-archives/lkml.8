Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A550A2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGBHDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:03:52 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:03:52 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MLA2e-1jZuL90XNi-00IClm; Thu, 02 Jul 2020 09:03:49 +0200
Received: by mail-qk1-f172.google.com with SMTP id k18so24695955qke.4;
        Thu, 02 Jul 2020 00:03:48 -0700 (PDT)
X-Gm-Message-State: AOAM533/8N3rpApox64MT2iAtrjVg7SBZz82+5U9I97yZ+M4W79k3cNO
        G7oBZJXkS1gYRTc8qMRlPUL0A633PrqGkDVhBV4=
X-Google-Smtp-Source: ABdhPJy1J9OKRiOFi7eXG30KY3L0LxGjT1O8dCnD25KnYneALqn8NIrOpou0Mi3/xlE6GFnLs09LBh9Q++KQPysW2EU=
X-Received: by 2002:a37:a496:: with SMTP id n144mr28916015qke.286.1593673427914;
 Thu, 02 Jul 2020 00:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com> <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
 <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
In-Reply-To: <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jul 2020 09:03:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31bZ1XDjjv1LRvpgifxqYUuBRFbPEc+eFD8Dby+mRE8Q@mail.gmail.com>
Message-ID: <CAK8P3a31bZ1XDjjv1LRvpgifxqYUuBRFbPEc+eFD8Dby+mRE8Q@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7bOCzNp5Raruey2KRYtDaaMrPtdeP5ZFJqLXmLWlnz6ojji+ouN
 VqBf/jEvWts7m85Y0Ryj4vLlxbg031p3GPIGz2eVjkcnQQdBcdL1x1WpBZSOvrgyChg5fZ8
 F6j3lzaOO4y3w3Ccj1mtnsNQspIEF7XUBnaGsjgfaaZS5I46u/JIxakYxSAmlRvUNtD8HLQ
 1aZlMq3b/pPMQC+sbfDTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tda3zbNPZV8=:D1Ic8xSUfHkfJ6v1TABpbJ
 hMHsTXk6CcBZXCT8JM7xq5zo+2aws/zyt3Kz6YSG/t1apmv++UqWJKzrgUiI8JtOgohxRyruF
 hNCdkQIKi1JXV82ovMs9uAMxGGmc/VrPdMKFDRFRzg6NYd2N3q2yICK9o5JvzTFs8/DuPdUfh
 bEJZ3XdgDtwcheIQ9OMKvezd/ZUAlrgxGJ4hNpOxVknnBFt9gI0y5HTJYgO6TamLzaQHaK5tv
 seZ2z8dwEuJUrN1efkV5yDWUyJBwhOXONUQcR1x/LK5H0QMJp+J47BGBJs9VM1g/JJ10Z8/YQ
 G6Dp9diFeJAEa+JVq5FIePo47bBBzRLY5wEyKuo2al+JOGclM5ubIIO754fdvG6ZLRT9pneOm
 2o5tZVMVU+88tyAvAWHk9MKsJTknyqGFh6fwg9JqJClbSj6UHDXf1zpWQCfti+RkCE3tqqMjx
 btgbA7W+CvWA8UR3TFPz7vmGjOBLDvY5ycPiMf6Je9auSCpaQkCzzk70geJsi8/WW9A2Rd/V6
 4eeC8W7k7zeiZj9uxBQxIu/KkM/V0n1o0/xbKGH4/hngMw1ngIvC6DCUZfKpx2hJcKrv+g+jo
 vesL1U0WNuXuJGedGj7S33aMRy9vq20RhsrWPoEN0WCANRQaCg5R2++1DpiDrGPtnDmnfWZuy
 nCX3PDsgC0UdBwASU/ER5bQ18XKkM/VNxYUFNJ6BAa4JSTVl16gUWK8FFg8wXg2krWo4vRGWV
 MNTuawCz/V95qAYPvdB0Q+x8CSdX29Oz1w4PK4+pFj/BuH1vGizi3n/Jar+jYlmN4jDu0hv7x
 7NbekmRGhLn5wnD7eMJmw8cnOqbu9+H7M7UmzBaRIilrlvAhnU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:40 AM Dong Aisheng <dongas86@gmail.com> wrote:
> On Thu, Jul 2, 2020 at 2:11 PM Anson Huang <anson.huang@nxp.com> wrote:
> > > Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
> >
> > I am fine of adding the '#ifndef MODULE' to imx_clk_disable_uart() and imx_keep_uart_clocks_param()
> > as well in next patch series. Others like ' imx_keep_uart_clocks ' and imx_register_uart_clocks() need to
> > be kept always built, since they are used by each clock driver no matter built-in or module build.
> >
> > So that means I have to add another 'ifndef MODULE' or I need to adjust some code sequence to make
> > those code can be built-out in same block and just use single 'ifndef MODULE', I think adjust the code
> > sequence should be better, will go with this way.
>
> What if we  condionally compile it in clk.h? Will that be easiser?

Yes, that's what I expected to see in v4 after the previous discussion. If
imx_register_uart_clocks() is an empty inline function, then the arrays
passed to it are unused and also get dropped by the compiler.

The question is whether the #ifdef check in the header to test for MODULE
(only calling it if this particular soc has a built-in clk driver,
which is sufficient)
or for IS_MODULE(CONFIG_MXC_CLK) (call it if _any_ clk driver is built-in
and the function exists, which leaves extra code in the driver but is a more
conventional check).

     Arnd
