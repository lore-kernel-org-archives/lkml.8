Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DB220767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405593AbgFYPPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:15:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405309AbgFYPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:15:51 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MQy0N-1jSFOM2WWd-00NvZl for <linux-kernel@vger.kernel.org>; Thu, 25 Jun
 2020 17:15:49 +0200
Received: by mail-qk1-f170.google.com with SMTP id b4so5586471qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:15:49 -0700 (PDT)
X-Gm-Message-State: AOAM532P8vLbYzuwYyP+qmgHHZz4jDCUNFPBx4sDPzzPqyD9ZuX2hG5W
        9Df+Bwfj2mkWNoEZaNBcBK+VlPTSSixt3st6W4o=
X-Google-Smtp-Source: ABdhPJxHxjsEFmMePNDgTA1OfWqFm+2QL2fPNumeTMC0xADs4SGObt+dLYOFgRxYDZNHo3K7rfPjZtPLu+4XVCrZTgE=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr21975447qke.352.1593098148465;
 Thu, 25 Jun 2020 08:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <1593044164-32362-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2uh2eBHE+XPt1gUDEj0vnXwES-GmL=rsBRDHpK5HXc0A@mail.gmail.com> <DB3PR0402MB39165C1192139A67B5252941F5920@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39165C1192139A67B5252941F5920@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Jun 2020 17:15:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3YQrEGoRDv+NkHfwK_f1+WAOvQp4qKD1epSM54pdgsgw@mail.gmail.com>
Message-ID: <CAK8P3a3YQrEGoRDv+NkHfwK_f1+WAOvQp4qKD1epSM54pdgsgw@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:26dX5LvC7mCbRHDkcqLoH7zAKXFFBV/RsU6oqax4CibFXcAN6Hl
 IlhGOw73g56fxy4WY1tHlzfGEvrrthzg16fy6nNrklWI7VvI/PvHW6x4LDVUqLARGuSs5Sa
 PdVjgkgpw+QrsvnqgGl+h2gl3iWcjUNod+a5r5R8bbF63j050Piqd5ZpRnadgIkJo8+p216
 LDoBo6vgX5BVS2pBhrLkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4aunBoX7j+E=:zLtHpXlEvtWx4Nf+r26MGc
 TBqZmYh790BE/QAl90aSOIJBP4Qh4VXvvFGsL9lLWjx71BPcut8Oy3sJBL5DRn88pe2pdgsz8
 35KuL3/+GvPbT84BBgd+s0vtCWsJAj/sHNPWNikGae+ihoQn8zRKATgoZSpC/qN6KPzgtwoz7
 dEnWbvweJjUA4LfmiAJKulvQ1oft3vNZySqdXxOXIWLhc9nU+/29uvpScOyGx/z9Mf1XO8jzL
 B4e2DbxRWyjHMNjHGxvWxLgcIuAqxpan1AtSs5SFfjuEZknBoCXA9woC5BgcVyfF5fqg/A4zh
 StaIIDYLFlp49cCU6AVtWNtebJaVyOY3K9qBpZF9PohMD0I3AxAxWmNiEeC/vFtGl02g8pcF8
 xeITH8Xg5BFEUzOZdkqCDVgOifB8tZr/Wvpo7VhZthWys/OaKYn+QL0UBN/8GwxNH2kXYE8Nq
 kieRVzV+69vC++a/p6zVSDl/y6C+YavrQWG83NGbirAQXoUsxVCJ8eqvVZh07xojr+g180dPg
 od9KMob7CZaTqoJLvtdNJtwJIx/72ADpaHZ+jxfrhlKFVb8M6z1VfSCd8nNL6hBH4RcFKQVrt
 i1IfeeGUPW+Skju+aUrYsbh8Mus9pv2BddrjXJb8qcpR07yjxpCTBpp6JKwKfcTNxmHUDUV8P
 BzHhPR/0KmpT3gF+eLPdo8dZ/JZQ4JICKgF6ZFPzEGtrnflh/HaaSpiCDSxB8pL/Gn+A4spTc
 6lP56uGazSV0u6TeCup7KtQhKPZfx7BhDP6DO22N6L6yMkGtLUbjvUgVw8Ft8KR3sxzNf5SP2
 bViUYHmyzNpvstB7OhGrd8CjLYwMekNDrmgsPQuBzDiNYB6EBQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 2:54 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx firmware folder
> > On Thu, Jun 25, 2020 at 2:27 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:

> > This makes separate loadable modules out of the driver when
> > CONFIG_IMX_SCU=m, including the badly named misc.ko and rm.ko modules
> > that might conflict with other modules of the same name (module names are a
> > global namespace for modprobe).
> >
> > The way to make this a single module from four files is
> >
> > obj-$(CONFIG_IMX_SCU)          += imx-scu-mod.o
> > imx-scu-mod-y := imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>
> I haven't considered the support for loadable module of i.MX SCU firmware yet,
> plan to have another patch to do it, so do you think it is good to add the loadable
> module support together in this patch?

No, I wouldn't do that yet. It was just that adding the EXPORT_SYMBOL()
made it look like you were trying loadable module support already, and that
would not have been a good idea without changing the way it gets linked.

If you just remove the EXPORT_SYMBOL from this patch, it should be
fine, you can do the rest when you actually need the driver itself to be
loadable, and that in turn requires all drivers depending on it to
be loadable modules first.

      Arnd
