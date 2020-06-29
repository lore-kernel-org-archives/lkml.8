Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A549C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624A02073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgF2VaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:30:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgF2VaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:30:21 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKbPg-1jX6cV011A-00KzBD for <linux-kernel@vger.kernel.org>; Mon, 29 Jun
 2020 14:02:39 +0200
Received: by mail-qv1-f49.google.com with SMTP id m9so7486313qvx.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:02:38 -0700 (PDT)
X-Gm-Message-State: AOAM531OhSZ4Zoi9/bYdMoK6biOyoO+eqbwsGGTmbZ0keiM5SDlWoVK6
        jvLxNsogocXhhjDiosJIyLVA7aNEJN3Iu2Ozak4=
X-Google-Smtp-Source: ABdhPJznG3KXhGobnsMvegA1SAcvtwATKB5v7VQ9LDYftJtnSRjGxsomTyailCW05ySyhsOgMimFanF2ob2IwX+YusM=
X-Received: by 2002:a0c:f385:: with SMTP id i5mr15202056qvk.4.1593432157860;
 Mon, 29 Jun 2020 05:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
 <DB3PR0402MB3916E7A184549BF302C7401FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1qSdiKfcgXLAQ8JTWeg4_i+8+qh-7hH5rYiEjp-dJMkA@mail.gmail.com> <DB3PR0402MB3916A6B7F90D3A11AF093499F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916A6B7F90D3A11AF093499F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 14:02:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26Z74V__7sCv6Q=ByFJs1f_8wJ9OtgxHgxndeoUCiFRw@mail.gmail.com>
Message-ID: <CAK8P3a26Z74V__7sCv6Q=ByFJs1f_8wJ9OtgxHgxndeoUCiFRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
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
X-Provags-ID: V03:K1:l3q3mI9pQkh4SjS+dXvkIKT5eYVF8JrWprPUbEW3p4wwCMyfXFe
 ZfHtRl84B7bpttx5J2tcvJtlOKAywx4+Ydkh6Za6y0lbVZM9vHJixqjStLPjM4MjPZzGK1L
 KnOahbsge/xvleZjhRWJtv4s9SWBg0fX02UB7fNom6/O2JrCXRQfccDmkO/763/3AWapiBn
 0e2Qi+ElsCUefFaJIbQ/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wmc4CPQsBmY=:RBuD1LHCvp2XO9aoQRAm0M
 jMdSK7uHIgbNX8kRlMUX6ieO7YzI8HZhUc25Xvkffr3Tpmq9NRsfElXDsEdWdMc2GQDEHokj6
 PLfg+vCYjJJSgjaCIf5fXhauq125u7vqS6Wh7f5S+vIkyTLWYt+Q4CYp/NUTvRn+HNbgIvmlJ
 4zslJiYwVh8wFnywq0G8AyEuj4C4IO2HFncqxM8hLnvJuqqXGzxjL6Oj/4Wy7LLBQN1h18j9Q
 tZLY2mbcuFgGuauy6Zuyk/WDANOjgkBbmtaJAAZuZ05I5g0UeLg5yQbTtx2oc4tPENUGfpcDs
 P7E1ZI6E76Ld4Oz/d/kIEqFdAG6J1qv4en0knpaAOAPrv4T50j+Dl4hb9EYtKURXdIZfGdPyI
 a2OEaxup0NiPJUG12g4hG1eNUxdWieinbQp7WNTWzsnyQXvjHLbpENQnF1Atf+cTn4d/IZ/Kt
 ttbMyAuVLlAZaVGC4XkXQ5s/Q84MP1WQpgW1u7KItZB1Gvsggiuu1PCJQzo46zTGKzbLgbRS8
 K4oecPTPhSi5ekI0PojUo9uI5pYX2z56sCCxXq3xxbDJSmk2bJHKCOEHatoUB8IzBLnxppgwS
 x4AXC/wWoVKWxaSYEsDQSVVjWdpPW8F8Qir0wgCSMBP102hjWfsrvHfPd6TVeMjXgykQxj1Ii
 pnsf4+mhFBm0/dc1hkCIJ7lfPL0dU/07EPf1XDtQ3Rnk8vQvNOgdKaiER/pINKM1OWiidKoXs
 q8YdF7WiQn3j7j9x5QxQMP2mpp9PHb/rd3zpvI/qDDn/4jgwxioOT8k+Z4avEtof+BeDhUkBo
 4TpkGA83tIlrS3RIhR4AJiqs5gyVfmWBSDVUy1KF9LEI76lyMc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:54 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
> >
> > On Mon, Jun 29, 2020 at 1:36 PM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > > Subject: Re: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
> > > > On Mon, Jun 29, 2020 at 12:25 PM Anson Huang
> > <Anson.Huang@nxp.com> wrote:

> > I don't understand. Why can't this driver be a loadable module on i.MX7?
> > Please clarify in the changelog what the bug is on i.MX7.
> >
> > > ARMv7 SoCs is NOT in the plan, that is why I add this patch to make it
> > > same as previously when this reset driver is =y by default. Without
> > > this patch, this reset driver will NOT be enabled by default for i.MX ARMv7
> > SoCs, function will be broken.
> >
> > But it's the same driver, make it work the same way on all chips!
> >
> > I think artificially limiting a new driver feature to one chip just because nobody
> > asked for it on another chip is not helpful.
> >
>
> Understood, what if I don't select it in SOC config which is NOT flexible, but put it in
> imx_v6_v7_defconfig, then user can select either =y or =m according their requirement?

I would recommend using a 'default m if SOC_IMX7' or 'default y if SOC_IMX7', so
any distros and users that have their own defconfigs still get a reasonable
default, but can choose between =m and =y based on their needs.

> And in imx_v6_v7_defconfig make it =y by default.

Having =y in imx_v6_v7_defconfig sounds reasonable if you go with 'default m'.

     Arnd
