Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC96208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgF2V0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:26:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgF2V0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:26:46 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MC2o9-1jfjxx1pxV-00CQW9; Mon, 29 Jun 2020 13:59:08 +0200
Received: by mail-qk1-f181.google.com with SMTP id j80so14938409qke.0;
        Mon, 29 Jun 2020 04:59:08 -0700 (PDT)
X-Gm-Message-State: AOAM531dNoRFCGQ5gU+WKgIQezUtMEXHMxzuOjwCEaKgGIXbfLmJtxX5
        IUlkRwyKWfCdVH0F294m9CILhcAT/AMHyZym1bw=
X-Google-Smtp-Source: ABdhPJwiHIrS/zcyAzwtI//A/mP+kmmPqCmXXzVgsA8QR3TbrjAPEDgdefcDhM7ibQGaLfv1MsgnsXjRn6wnP1Y+ubE=
X-Received: by 2002:a37:b484:: with SMTP id d126mr14639824qkf.394.1593431947272;
 Mon, 29 Jun 2020 04:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-11-git-send-email-Anson.Huang@nxp.com> <CAK8P3a1W4Wxj0o3dtcjGq0L5VQqsH0=ntego=jmH2Von97+H-w@mail.gmail.com>
 <DB3PR0402MB3916911E2321760C65AB3293F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916911E2321760C65AB3293F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 13:58:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28=41imeva5nG-fSx5dPG52Um8hkZ2_=y7soOZ8p5bnw@mail.gmail.com>
Message-ID: <CAK8P3a28=41imeva5nG-fSx5dPG52Um8hkZ2_=y7soOZ8p5bnw@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] clk: imx8qxp: Support module build
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
X-Provags-ID: V03:K1:EfD4DhoPrgKqPKihKT5z/Cx/um5RnkYhhXBAEVqqcd5KXJV3mGk
 FnkR4upRdwIFx6cIM2dkWoYHi8Mzs9c2uM17g4sHi3Atxqxd/0HjtCqRpqcLu9cgbti82X7
 gp5hNsJzQl4KMoXR+XK3XjWtOUkU6vZ6U4bOFFumXRZM5kwEKi0WL8xPLdhxglCdXFp2cyk
 ugWKHpW6biMesJyQj9BAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u4BHHFgnkr8=:wAptT75sXjOiKxyrZxJdjS
 FXEkX3heeqNYUeRtxlLPUpOc0NpOAkHhNiQatb1kzFE5jnsV1nq8sglceXECtLLcqNgVk1RHR
 7z3rnjKVRnCzG+HHN96RneHuF1vCC5m5dDSe6+bSwIy3OHCaKAd1Balf8HoYr6y37gd8zu8qV
 /W+wLpOZgq35rdH9q2dEXjMbmWUhHCSvwN+/vUwqLb0cXijBEhKE+mPaBLbSrmeGgQszplK8m
 pIPOF3IQ4/DwrdJIJ3thfE4j7+jBlKatupe/L9P6ZG6MPD+Z/1SBSL8j2FvbPEghz61U3eiKz
 el0GHwqCX5KE9qm8XXhM5cbqQlTKN7QkEf5pDhO/H0gv3d032DWuw1VDtzLZQZZfsNUa6Cbz9
 fbagBwP+JYYyyarp8un2MDtEK1UWgS9+3YScR9ivmW4Mp6CzvxFCJvDmQkNo9Bxl3SzFUZIv9
 Qe2zXFp5SmLpxDdDo/kR9Vo5tg7CBGbLrKrSKj5bA3nc4KuE0NErLgYWIZeJvS6I+yT6Uxut3
 VVONUXAkrzuzq1zZuKw9Tt0cWX7s/IshFsrbPLW4+q8Bz5zr9/7jfFsuCW/UiYLigGqH1jVzi
 GTKB3+lQJ/9NgDobeUrgldXQcZz6tFW6F6AiCoX5CMPosr7vYDX2FYTuMFTLbLMTSP22s164T
 +0mLUuNANnnVJ4xvdSjO7PgLAG7FTRSMHNdDxmRBUo2m6okyEu2G96vPbmvkeW1jamGRNW+Ws
 RfCtxp0zW/IhHrapv8JGHSE1LhquxCTIqLsNutgoIpoeLD1l899EwDK5pnrthXpUlcWb8LLq1
 vb4oTofPY43GsXCGc3G0RLG0auiDPm0xDNf/L0FpVkByOabe/M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:43 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 10/10] clk: imx8qxp: Support module build
> >
> > On Mon, Jun 29, 2020 at 8:06 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > Support building i.MX8QXP clock driver as module.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> > I would just combine the per-soc patches into one, as they all have the same
> > changelog text.
>
> OK, I will merge those patches with same changelog text into one patch.
> But for i.MX8QXP clock driver, as I need to add more changes about module author
> etc., I will keep it as a separate patch.

Ok, sounds good.

      Arnd
