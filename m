Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94869C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D5B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCINuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:50:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCINuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:50:37 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MUXlA-1ikrz03lNg-00QTSJ for <linux-kernel@vger.kernel.org>; Mon, 09 Mar
 2020 14:50:35 +0100
Received: by mail-qk1-f172.google.com with SMTP id b5so9218122qkh.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:50:34 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2V7GyZaD7jEDi/oQwYO6B8pbmJGalIdPjdkEiZ463vlPRmegrj
        nT+sD4Rfxv93NhfZO1FZZY/C2Tb9/g9Ny4dzH/g=
X-Google-Smtp-Source: ADFU+vuqpwW8ZhxLQBpNPchoZcyzxLU401q7S/l6dUozKVJq9KHwtsxSODvooMUjZKLBpgQVX9CQBQG+FwLDoTO1dSg=
X-Received: by 2002:a37:a4d6:: with SMTP id n205mr4917403qke.352.1583761833703;
 Mon, 09 Mar 2020 06:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
 <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
 <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com> <AM0PR04MB44813F8292A36D84B3F80AEA88FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44813F8292A36D84B3F80AEA88FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 14:50:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Lc--pDmBG3mBiKyjpOEZVdKVBnLNYBdCjzdgN1byU3w@mail.gmail.com>
Message-ID: <CAK8P3a0Lc--pDmBG3mBiKyjpOEZVdKVBnLNYBdCjzdgN1byU3w@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u7tZKW5GDcfSZ9sax7R5+vm+jAt0yrVmNNZQ6u1xKx9YoHjIeOp
 RfkJqLn/IgMZGERhAOGIcLG4G+poMj/CTaqQQslcRrBqdKVmxetSuIKXaxKZCkLZ7yctDi6
 elOAsKo5Ax/GT4/1hzha5YBpJjHyqReWaJlBiZVegR4XT/Vt27+d0Nypk7XXlx79IatrObZ
 SBcxRIRyV8xXV1Q2VnfyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xvD5qQK+WuY=:bwpgLGFEWED+oX8g9vGM++
 elcMEMKqIiXppt73NiHVzDgi2ZnJ98ADPg9pHphvqHBE1E6B8SVZmzBHOGULwbCe1Fpey2aXb
 yOStb+7igZpEEwwUAiZf7s+kM02kHvlKrRFa9wObvvK/lxKjBgHQbtvyDjSvdvknTkAqk7997
 zLzsE9xXKzjwzGkV5enWOk+7d8PrICbiJOnnR/kHlui5sslVaeRJJPOAfKH/ONNfUgW7KFW0u
 qAz+7hGoK/IeMQ4XvapYzZ4Dr0gLDhM9mRwlgUFJ9OfXOBiP6OKXU4IOoO1yDmf8czGdiO27N
 TWNLAwRe+4Yyq9b7SxI9J5wgBIl0AaZ4gQ7XXSE8a76UDF8LwWaLcRuFpC4o36TIg44ceYZZu
 OYZZVM0zzzFOJ/09NELd1L5a0SclEHlGxLDCzwFq2XSWR8Bk4wtbAibnZ8VoM1K5tPekoe6L2
 wltIcdYSIuO/Sx2YCzVU3w5ya3cMI8Jk6Z3PmzZUsY0IFGMqQWyC97ngbe5GqoIkuahqpb25K
 rmXMb3cp6LKAxcEMFyI+9PsEyWx+dkO79+P9gTTmC5BVM3tUTbwrPowmYWOwEaWwupmpRLzic
 2VXdMuZdIlYo9Y2i70tENlo/xd0SRZQZuRxIwSY880RQViqu7rvtNExfx7c3HBgaCjwRXNPXd
 42u1D9zy23eXYOmODYYG3+gH6ujvij+zJ8E3w1QzNJMqGwxqyBNeywoIVKGC3VrjrgvpDUspg
 POG0zuxqpMA5ZYZ0xmTjI5LPGS+V63PiW9dABxBnQtaW7Ao8bOmjlwfzqcWwth8rHDMkEX3Tn
 tNjNKHfp6vydK9hPRmCzfhKWl71ooP3R1xFrqfuz+EovwSl/0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 2:28 PM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > CONFIG_ARM64
> >
> > On Mon, Jan 27, 2020 at 6:05 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > > > Does anyone have any suggestions on where I might find some generic
> > > > stuff for either iMX8M or generic ARMv8 docs for doing something like
> > this?
> > >
> > > We did a porting for one customer, but code is not public available.
> > >
> > > First let uboot switch to AARCH32 mode when booting Linux, this is
> > > already supported by uboot mailine.
> > >
> > > Second, create a mach-imx8m.c under arch/arm/mach-imx to handle
> > i.MX8M
> > > just like other i.mx arm32 socs. This is not preferred by Linux community.
> > >
> > > 3rd, build i.MX8M drivers when using imx_v7_defconfig( or
> > > imx_v6_v7_defconfig in upstream)
> >
> > I think the third part is something we can clearly do once it actually boots.
> >
> > Can you post the patch for the second part for reference? In theory nothing
> > should be necessary there, so I wonder what I'm missing (as we need no code
> > for arch/arm64) and what we can do differently to make it work out of the
> > box.
> >
> > Is the problem that the SMP bringup using PSCI for arm64 doesn't work with
> > the 32-bit kernel for some reason?
>
> Sorry for long time delay. I forgot your mail. I did some try again, seems only need
> the following piece code to make it boot, also select GIC_V3 and drop some ARM64
> dependencies in Kconfig for some i.MX drivers.
> Need some addition work in ATF/U-Boot
> to make smp work, that is not Linux related.

Ah, nice!

> +static const char *const imx8mm_dt_compat[] __initconst = {
> +       "fsl,imx8mm",
> +       NULL,
> +};
> +
> +#include <asm/mach/arch.h>
> +DT_MACHINE_START(IMX7D, "Freescale i.MX8MM (Device Tree)")
> +       .dt_compat      = imx8mm_dt_compat,
> +MACHINE_END
>
>
> Are you ok we add such piece code in drivers/soc/imx/soc-imx8.c to support
> aarch32 linux?

I don't think that code does anything other than set the machine name. Are you
sure it doesn't work without that?

If it's indeed required, I'd prefer to add a file for in arch/arm/mach-imx than
in drivers/soc/.

      Arnd
