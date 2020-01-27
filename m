Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ED7C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07EF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA0Gxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:53:33 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0Gxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:53:32 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M734j-1iwoQH2tgd-008b7I for <linux-kernel@vger.kernel.org>; Mon, 27 Jan
 2020 07:53:30 +0100
Received: by mail-qk1-f175.google.com with SMTP id x1so8594906qkl.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:53:30 -0800 (PST)
X-Gm-Message-State: APjAAAXy96mSdVpWCdIm8WvfqIZ5w7D9MVeOWWRRLy5cwLrbt+Txmn+Y
        77KP0WAksP+QaqxyhA7titj+XSFYI8PGzRzrMwA=
X-Google-Smtp-Source: APXvYqyBg0aK/XM7DOCpc+zyNjEeT72WLcZ4upAGMAoAxkkLtsbwNOUentHIPudsyZSd0HoIMQEnbY9lJ1UtKJSacRI=
X-Received: by 2002:a05:620a:218d:: with SMTP id g13mr14318824qka.286.1580108009529;
 Sun, 26 Jan 2020 22:53:29 -0800 (PST)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
 <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com> <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jan 2020 07:53:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com>
Message-ID: <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com>
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
X-Provags-ID: V03:K1:XOaoleA782ZySXFisxo7uZHoE0FFNAaE4iSPl0FjUDq109Kek5H
 FbeQEwcp1g9xETqjPPCakDOKM4MwQmsAIlGJzbPhal9nsu4VMG4TP/4zwZghEpSO+DQGDE0
 4suxstFm3lbBkjcOP06k7jrMyq6rStpACBoKXLuVxC6Nqs366aX+w/4zgLLzPiSZyGaMQYh
 vNN2ig0OmEUABtBJFOB9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vtiAGHAX2bM=:zznmMc9wNO0YeQeLipyuGP
 ABbTXZlYqGkFBiA4RsefcyvV5GwIlhNnhwf2G6jFU04QzzGKbkqndfoB1fP88xlZrdzjI8Dpt
 LfF42Tc49xFJZTFKv/mwHdLsqPplm2IUe/9poXH2K8ZG1NN3dZ3mde2x1l4WtyWgrHnp2w+Dw
 AOG7PMk4AoNFlR+NMDy4hCXlnCAc5lUnWttLil770+TOJDsQ9IM+2OxLBUrMIvpB8pYgprweT
 CgWLI3CIzCJQjmJihuAg92MLAssqsMd9hRHl9FfqagDmu/3mlSign5hLbjA58mQuhkDxA0gM/
 VkyYOkxiXvvZFEzUE0KYad8RYh1rAj0KWkkL0d6x3Wdj1O49EcCIYBvVcDXXI0EqW1JMaPAJE
 2Nh8xNZ2smiO33UhOuHOxgyPFgmmBCvM8h68bFq2Cj+sEwtlDPSVfAinMlc7ZQmBm0pOMwoDs
 fbI01t1dsOXXCZK8upt5tMibJfCDym4rHynWyQvQ7hCYB/60p5OlB6MnmszhfSOuApHxAEytj
 f8bQxBZyx3B4ap1aV5UiU7/Kls/9hmlZ9AABTkXsO6/VVqZFA+uiLEwbJsS+PXr0mNs/1xZ/V
 z7ZgBteVP1btJ4T9tEkFBlomfvrnfKwNqzTr16GRGrc8P783yW3cy89xwhItCMU+a2jK/jbAE
 lCdGTo8IslePBMm2cHlrKa6jsxgOZLNltXpXk8ofqDlTV8UXRp/eh0RtteMbJRrihT1daE6or
 5vlfnFV/8BJcGuXnAfkCX0ERobkBzDjXEsYXOtv5ZqNP/tthwjb5QxRMFTc3SDbcRBes/QJsh
 oNgXrSCZp8rb6qs7PSp8vZWaTCglOYfrPbqRqfV64oWI5U/ZUc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:05 AM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > Does anyone have any suggestions on where I might find some generic stuff
> > for either iMX8M or generic ARMv8 docs for doing something like this?
>
> We did a porting for one customer, but code is not public available.
>
> First let uboot switch to AARCH32 mode when booting Linux, this is already
> supported by uboot mailine.
>
> Second, create a mach-imx8m.c under arch/arm/mach-imx to handle i.MX8M
> just like other i.mx arm32 socs. This is not preferred by Linux community.
>
> 3rd, build i.MX8M drivers when using imx_v7_defconfig( or imx_v6_v7_defconfig
> in upstream)

I think the third part is something we can clearly do once it actually boots.

Can you post the patch for the second part for reference? In theory nothing
should be necessary there, so I wonder what I'm missing (as we need no
code for arch/arm64) and what we can do differently to make it work out of
the box.

Is the problem that the SMP bringup using PSCI for arm64 doesn't work
with the 32-bit kernel for some reason?

      Arnd
