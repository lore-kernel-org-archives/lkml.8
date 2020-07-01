Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771682073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgGAJzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:55:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:55:13 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N95Rn-1imNnT0w0F-016Ad5; Wed, 01 Jul 2020 11:55:12 +0200
Received: by mail-lj1-f174.google.com with SMTP id f5so10294965ljj.10;
        Wed, 01 Jul 2020 02:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM531Rcb3CJcgDBNwjFZYdohzI5r+zMlKyJ30HpTbXq1EaSh3u+m21
        lyzuNbHLhGwnzmOoWbtoFG2JAce4p0ij+SB6YR4=
X-Google-Smtp-Source: ABdhPJyS8gOiUO9in/jq2pHqnW+bGf1AIEllB7ZFKe+y9xZNEbqhCylIU8X1Yk27txEvSFcy3j2uZ4aJTujKQhLR8wA=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr11032483ljk.410.1593597311714;
 Wed, 01 Jul 2020 02:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
 <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
 <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
 <DB3PR0402MB3916B16516474F8D17EF9DA3F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916461E26540B6ACFB54AFFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916461E26540B6ACFB54AFFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 11:54:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3H87w-eJhOGuRQr03W-=ONdsj_=Z6ic4nB==GpxnYsZA@mail.gmail.com>
Message-ID: <CAK8P3a3H87w-eJhOGuRQr03W-=ONdsj_=Z6ic4nB==GpxnYsZA@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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
X-Provags-ID: V03:K1:VLxLCkpT4Nb0DT5tw0KAjeBRj/PNiAvQuxxoResPU7lyxR+cWLg
 To2667boqkD8R5vASEWelu2uiiMyLJtjtp3kbTjhvGAg663Jbp3DgHGj9ljGxzfD+o9gG7m
 gMKCHh25WBEH+Mjay2DJkT/DK7V9nDUODzvgh/+NXWF5PKg4/jQv915jATW+26X6dRsveoT
 JHX0RDfWN4AgG64iG1Sqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UZatkdsoxVI=:2DaiVK7LxZn8n2TX61lhtk
 +kylqdHE2vbIVGAh53Fwku9vCrGSzTxbNuoomUvNPU0xrwtLInNnud8Jh3nEkH7WAJZnqedV/
 Nhir+GicK7+qBemztW/IAEiD+gUVfk2OwJ3GBJPG6EvUk6fkwZfnsxFmhTmpmbHOXCEyqO/zB
 A8OvQkAVaHmQwWafAAxqtIs3ehl4egsrIs2kKpkNkxvl6h6/YsRV2Ouvt4KcY4sfl8L4Ehtf4
 XED+D5qlTa+XAJ7g0CfGE+x5TDmUJdaOfy/TJBoC5LpBa0Pj+slyeJBu4prb77U9685FgKIrJ
 1SYiPbgIH5LAc3x0FZUA7vuy25CblCSI58IhPG/tMSmnzArLYc9HOo8n4PN7juePWPt7oynS6
 Qi7/mN7FFnDJV5SYwDl+L1gk7TZmwkvoH8lgnNdKAJy5kOSXZH3Ta3v+tUnDYq6Nx+K555ken
 +JsZP3ziit3FEnwuJfBYziPmliRCMn55Z0EVj6LvbUvHsPffFKs3ZnNYgv9E0/q/mo2hEBMl4
 IFzeorEgZP6r1O9gad89MjGHJQ8zXbWpIftM0bmdOvIrJXgeFYufz2vRigz8FiUZrzp409vBc
 nqAF2tyNsWPlg43vsDbQxpwnweT1hxw2STitW+OpDeS97tN5GjAFjTtrYlYuaHYv0i8xuOYhc
 uOkiuW38VdHTO1ub7bFv3vOK9BHA0iyt3KiUq8V+1uebK+7rUU90jCQP4hXXYtLnTiV7wGMCm
 zWsrXZ22iY+ACZAEzhxGy2UVUN1JU2YB4jlKaddAVzS6LXAY4l1mzP/pkNaaNotfezVM5bhV0
 H+PVdB4zzKSBQLmZsHUILLJEcGmmSEj+cZrPnNuICpJi0Zj+C4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:40 AM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: RE: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
> > module
> >
> >
> > Thanks, I will give another try, I will make the common clk part all linked into
> > each platform's clock driver, then many exports can be saved.
>
> Just tried, it works for i.MX8QXP, andcorrect one thing, other platforms
> need more complicated change if want to support them in the same way, so I
> plan to ONLY do this change for i.MX8QXP if it is acceptable.

Yes, that is what I expected anyway.

      Arnd
