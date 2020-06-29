Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40151C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A80020672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgF2Tfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:35:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732113AbgF2Tfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:35:37 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MBDva-1jgVWL1PeY-00Cj1w; Mon, 29 Jun 2020 15:20:31 +0200
Received: by mail-qk1-f175.google.com with SMTP id z63so15126119qkb.8;
        Mon, 29 Jun 2020 06:20:31 -0700 (PDT)
X-Gm-Message-State: AOAM533ZJSAok7jlSRbfwQAVTrEvXLc3dVAIhoX5VLL1+Q5z2k/tWNzy
        T4GhrP7N1EOYyFVhxReaWoqgPPE1ZF8cSiw2KMk=
X-Google-Smtp-Source: ABdhPJwdmyIy2DXspwln00tSJlWBM/RffskxeSD5edRyoGLfgGk7pYtSMO2AKnWt6g6WM8uCKr4sKoJigN65H2p7/FQ=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr8459703qko.138.1593436830130;
 Mon, 29 Jun 2020 06:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 15:20:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
Message-ID: <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
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
X-Provags-ID: V03:K1:b0yzQOCCTZd+elNc6Q7/QnHIpomX4vV3bgG68HT+lCfG2Nqxz3e
 /zY+elPSL+xd/FENBfREHS5z8zguV4CZ4fu0uXzi4XgkTJrpt15zzhYwqfY1tHD3fAdqNCy
 IBQRTe1wgQC3h0RioRLhfmMdeNc9mJjD/qwF/ViXQFyGpmvBTCtdbOgnt6oxE6o2/l70F44
 3nklo4nCtdNnUcN1EjhVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wddScc3gBbY=:9FLiBjsnYjWwOT967YuGO4
 w2nnLLAiCIfa6CWXrxz84prDuuhyXcNo2xeq/0jRjcY2JdeW+2YUEtKgzCySiE+vPsrOGEy/Z
 pvQe5DCMGnquQqdIO1XbvammKJFYu5+QoRAzdxhjvMeRtYjv2B+pZC/XJQ6Of4L1/N3r04IXr
 iZ3cYn21LM8U6iC2PLMK6+Ocl34z6gcBXJRHfCgn9kW+aX1EjZPEkhpQYgCId1DgFAnx6hBhu
 akrABzMT37m1RviASSy+qgpJfmq5aAEmV4vc9C1KAjt2dUaAtsgrh0L2p0iv/CwAw3Jaq7ygE
 mLX+d74y1eubmRHlkyPfADHX3Y0TMAR2dNTE8GQIyJdMyrUvWBdyqNweEyDGfozRJjyIw70aO
 s4ONdC0irEp0910DdpXDrwdHS3YJp0xQMcipSW1xZYGEBAVPCJ4ItcoIE3NHri06LPeQJiUso
 x+seJ6Wj+41cCjs3lbJShLb0MCyAAbKUxmHUrKa4hwUp7RFZqGhpD15fJpTA4qtgQ8fGAu4lp
 1kPar2/dzsDbmamtgQAKbv5iI7/mevZw5h0rk+zjhdpDtxiaDB+DM8ewGeIngvUjSZUWeucVt
 KA8wdjmyhPRWGpug0Sx/pMwRDKBzWKFHgpMv/nOWPwWYRwmk3PDjmc9vJt6WjT4x7CC0Lmkry
 DhtKtzpWQlI4mLhXXur8uP98w/ALKS9U1KsZce4Az8pNyiFVc4OIrY5FQWtjzbTxCoaa2V7tz
 29Y2Fc6F614fp4yqFy8p9iMrkeDt++iTU+u0EeXYJHfOk3qbSLWNpv4Y4sD79ZMw4oMgdpLji
 YOCrK4C4MSZzRd+IvWOBi4O7QMd8gjIVg3U26WogEFvWJfkEqWYBn3sey+TQt9j0wTwkwoHK/
 CSm3lXcCsKPgDq+RWjAks7uhbOkb5z+RNmwXDcFPj3eXAqZk7zFlUMJMhn9iGXtR6dKSShO/g
 1/GSk+L6ezhrodyMxXsUzocEbwXvYTCOpXzLWW9sO0MHv1OjvJaDz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:53 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
> > module
> >
> > On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> >
> > > --- a/drivers/clk/imx/Makefile
> > > +++ b/drivers/clk/imx/Makefile
> > > @@ -21,9 +21,9 @@ obj-$(CONFIG_MXC_CLK) += \
> > >         clk-sscg-pll.o \
> > >         clk-pll14xx.o
> > >
> > > -obj-$(CONFIG_MXC_CLK_SCU) += \
> > > -       clk-scu.o \
> > > -       clk-lpcg-scu.o
> > > +mxc-clk-scu-objs += clk-lpcg-scu.o
> > > +mxc-clk-scu-objs += clk-scu.o
> > > +obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o
> >
> > It looks like the two modules are tightly connected, one is useless without the
> > other. How about linking them into a combined module and dropping the
> > export statement?
> >
>
> From HW perspective, the SCU clock driver and LPCG SCU clock driver are different,
> SCU clock driver is for those clocks controlled by system controller (M4 which runs a firmware),
> while LPCG SCU clock is for those clock gates inside module, which means AP core can
> control it directly via register access, no need to via SCU API.

Sorry, I misread the patch in multiple ways. First of all, you already put
clk-scu.o and clk-lpcg-scu.o files into a combined loadable module, and
I had only looked at clk-scu.c.

What I actually meant here was to link clk-scu.o together with clk-imx8qxp.o
(and possibly future chip-specific files) into a loadable module and drop
the export.

> So, I think it is NOT that tightly connected, it is because they are both for i.MX8 SoCs with SCU
> inside, so they are put together in the Makefile.
>
> If the export statement is acceptable, I think it is better to just keep it, make sense?

There is nothing wrong with the export as such, this was just an
idea to simplify the logic.

      Arnd
