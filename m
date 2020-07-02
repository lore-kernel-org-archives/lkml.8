Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173CA20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGBHnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:43:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGBHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:43:23 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mspu2-1ixqPh1Oh6-00tBVz; Thu, 02 Jul 2020 09:43:21 +0200
Received: by mail-qv1-f42.google.com with SMTP id t11so10176939qvk.1;
        Thu, 02 Jul 2020 00:43:21 -0700 (PDT)
X-Gm-Message-State: AOAM5306ZvxhX/bLnZa4wS6/FC/NNK1Yd9+5joj7qfv4+Vft2E9qV55E
        X0VgqroeitniO4d3Ys8g5JLVD8MRBvTUqOUYJew=
X-Google-Smtp-Source: ABdhPJzfAJ/R63x8Rg0rhW0PZ5ThIP/+DMPT/KoAJrgIhL9PH+sobeznpMjfUeFlim4778ipJqibqIjiAy8EuBr6v7M=
X-Received: by 2002:a05:6214:846:: with SMTP id dg6mr27261409qvb.210.1593675800127;
 Thu, 02 Jul 2020 00:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com> <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
 <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
 <CAK8P3a31bZ1XDjjv1LRvpgifxqYUuBRFbPEc+eFD8Dby+mRE8Q@mail.gmail.com> <DB3PR0402MB391638434ED48B67EEAF8C02F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391638434ED48B67EEAF8C02F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jul 2020 09:43:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hrDs-PXHaCfBx1As0BP8GwSZ+7zPLCMgxXOAhk=4CMQ@mail.gmail.com>
Message-ID: <CAK8P3a0hrDs-PXHaCfBx1As0BP8GwSZ+7zPLCMgxXOAhk=4CMQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>,
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
X-Provags-ID: V03:K1:4l9HVnORHmFg+rFYMLql0o/rt0r+WCLGPsIMFgn65+rCL9EHkfh
 n3BhUbHqrTn6F5aJU0BHU+gkBUOzwlMtjEg3e3lkgXWaDcixik5vNhlOesQtf2a3u8ezaSJ
 qE835qSgzKuP9CP1Y1k/RrIEHG69eauMG2sAr30nvNDectnI/ShmBbfMRbOHhA/ZES66f0/
 3dd2pZbathaY/jK77VeAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:blasO2qJ3YU=:hJC7xmyx6WEz6hK+5VHXPw
 h2BkP2DApVDukpmEY304y9UiO66RFOpgaqSKzN2xjlyVeTPOJcJXk+ZGKAr9ao7/LSs5yExuh
 75RAyX7yUWQ5IYBo/TKirdf9Gz6YeTRJk4tAhZaF8fzofRkQZmLuhsD/ciKSVFk1L9INCCLIa
 gmOlcIETGTJ2JCaTkvCGdNx/mHjbxV0A1ycm6x3rDGXzp9XtJPCP6vxKVfs/lwfynpBIeQSSp
 q1tYsUWyswJjnOzPKHP6Ugww/GNLQQFfAwTN98p0EvKeqFve4mqBgVBmkLxzHENsxPN4Ptldc
 vwB8nwg9WMOno6vAiyHVXjnUgWSR+jseU5sh/Y0owYiARWGYhV4glJT+nur2RIkmr+BuDGG0o
 35N44WQv7SLhjtuu7dlpdYlVNKj6z7u20DjeMKQPPEkTTIjm4ObCja/1eIASmq4YFz3YbTB56
 PUN3Xw8AZBN4pS5ZxWJdWI1yZL/2xIuTT0V9frlPKtYgYKaamBc7N8Pr/1udG0FPFbBmHUJo+
 cug6WuaYuBgjHxnjdcJZSpEAv+f0kL7zEFjz1yTfES8lEZFcOEd0nMzWD+68k20EYPtEIJuo6
 FVg2LIO1HuqDf45GwiBLAP3yDCXVM92HJbF8f+HUzNAfSpWdF1kOCkGmsGCksEp6I+KhDz9P4
 jVNZvl/xi95bPOOzzhLYp3+5oWc1fnHDuqBCMbD1t8YgpyonIt+WOHawWk1RXshL8BRYgNA1/
 MDaQ+2hj3dxIHWojOe7MHoBfwg2y9QB59wC5BKEWRvHLvoAQoLlKMzoKqv428T2M2eHWthUDE
 rMU5ZBuD3YbuUbrQ+kNaW/tSFDb6xR5j8y6zsPhJusGASxYqSc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:12 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > The question is whether the #ifdef check in the header to test for MODULE
> > (only calling it if this particular soc has a built-in clk driver, which is sufficient)
> > or for IS_MODULE(CONFIG_MXC_CLK) (call it if _any_ clk driver is built-in and
> > the function exists, which leaves extra code in the driver but is a more
> > conventional check).
> >
>
> So you prefer to add an empty inline function for imx_register_uart_clocks() with check
> of MODULE build?

Yes, I want the empty inline stub, but either symbol check would work

> Even with this, we still need to add MODULE build check to whole block
> of this earlycon uart clock handler in imx/clk.c.

Correct.

      Arnd
