Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CE4206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgF2TPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:15:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgF2TPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:15:14 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MqJuP-1j3RDk2HQp-00nNSp; Mon, 29 Jun 2020 17:08:27 +0200
Received: by mail-qt1-f176.google.com with SMTP id e12so13043116qtr.9;
        Mon, 29 Jun 2020 08:08:27 -0700 (PDT)
X-Gm-Message-State: AOAM532sAB5W/VPKTkLUR4AyavMWVsGao0RwMo+gteq4fYHPXPyfoutQ
        665YQr8uXaKdWTyCPAVtHS4hP8llk1XsRXqz39Q=
X-Google-Smtp-Source: ABdhPJyQuqwhfm5xEtb+Xwa0xEiKtz926rq5DKPRj0B3De279sqAWoVcj6OMbI8F3yDTfe5Hmp0EzLxdKp04XA+X8n0=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr16233441qtq.304.1593443306252;
 Mon, 29 Jun 2020 08:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com> <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com> <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jun 2020 17:08:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
Message-ID: <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
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
X-Provags-ID: V03:K1:wKgMKK0eUebDi30MowMdmQn02QMB0d3ji+fQ99MNTtuMvfZKqJj
 IGFEYRMy+xVLrwh3WOwQeEr1LKzXFgPeg7rFA2RO8pqbmryQpxnJ1JwGN98DYMQitIbtFDA
 H+w435NjfnbrJwry2unOkb6mjk2P2rkVAmcRlgqA6l7pvXAx06xwWhQkdz/AyWdzP3+6Koq
 S8My9fm5+y7e7qqsvFDUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iiPSoLVcnOk=:qoxOSacGPmBIHf5353Yapl
 gndagjhThquKoK9CuFn0RXLqH1ytqqCBv2O7rzoaIV4nHK+9dVhqcMuYUBd5M+6sbNeEXwxi2
 u3MyWGgvXqMqBHHxaSgH6SD2rvap8DjqlJTxXhIbq1YT+Ry8bKv07ZBKZ2kp/9anClzRqvk1d
 N9qZVN0dmdKg2WBIAxWYpBfthLV3wjGrXC4lCw1nbQn5yiyzDx4IvPuhVPxmo7Lvd6Cf+LdJa
 rvTs1te+x8zWObIW7WKrISxPxZgGZGtiphjt4nEDZYxoke9kbYjf2o3VotfQjIEs38yslOZ1D
 z4E9HM61JkWcRcH8LXgM2buDQk53yMrsqgyo909zMIAH9Djr0jYRBTqklewJwEXuQCIe91rgN
 i1ZRa/bEs3gf/w/htk2eh3OUyGo6xZfBR536vqcK5E1qAeJXBBKrAN6b2VH5J1ns+YMe026IY
 ycrfc5x60mZEUIgPOW+7vjasWQY3M32RN2YwwGmUw+XDUqy6SaIxYHKWK91WcpjG6BRbiunwa
 GfixAd7RegewVNZNqQlNFhT285rp0vZbbrySolHEQr2UGYXUGICBdGOUIO1Pm9eYkGtZ+biio
 BJhNlg7dfFIy92SnPGC0GUXXtMjs4efj8pv/TTQ0LQJerHgveYkfI0WBp+zgkQ25kZVHiFVYB
 GMrzRDpVBDw1Naz8wlX/A51F7Ge3JdIvU2wBpXKxcluj5YDBWaI6RKt8mgS/8i6Noet18uytu
 ltKKZHsUjU3S4YdTRGOnP4s+0Fb+36/Hlpt8Vt4NvnqXZBHJ/xkJpeC7Xhe5immPAvD+texNM
 V/oWkPIdsjYEpRo1TLlpA2biPGaMar6SACaHB8Ut45zlKgje3g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 4:52 PM Anson Huang <anson.huang@nxp.com> wrote:
> > Subject: Re: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as module
> > On Mon, Jun 29, 2020 at 2:53 PM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > Sorry, I misread the patch in multiple ways. First of all, you already put
> > clk-scu.o and clk-lpcg-scu.o files into a combined loadable module, and I had
> > only looked at clk-scu.c.
> >
> > What I actually meant here was to link clk-scu.o together with clk-imx8qxp.o
> > (and possibly future chip-specific files) into a loadable module and drop the
> > export.
>
> Sorry, could you please advise more details about how to do it in Makefile?
> I tried below but it looks like NOT working. multiple definition of module_init() error reported.
>
> obj-$(CONFIG_MXC_CLK_SCU) := clk-imx.o
> clk-imx-y += clk-scu.o clk-lpcg-scu.o
> clk-imx-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o

Right, you can't have multiple module_init() in a module, so what I suggested
earlier won't work any more as soon as you add a second chip that uses the
clk-scu driver, and then you have to use separate modules, or some hack
that calls the init functions one at a time, which is probably worse.

If it's only imx8qxp, you can do it like this:

obj-$(CONFIG_MXC_CLK_SCU) := clk-imx-scu.o clk-imx-lpcg.o
clk-imx-scu-y         += clk-scu.o clk-imx8qxp.o
clk-imx-lpcq-scu-y += clk-lpcg-scu.o clk-imx8qxp-lpcg.o

If you already know that the scu driver is going to be used in future
chips, then just stay with what you have now, using a separate module
per file, exporting the symbols as needed.

        Arnd
