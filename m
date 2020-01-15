Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F117FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C555124679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgAOKjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:39:18 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgAOKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:39:17 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MfYHQ-1jK98e08lM-00fy1R for <linux-kernel@vger.kernel.org>; Wed, 15 Jan
 2020 11:39:16 +0100
Received: by mail-qk1-f181.google.com with SMTP id z76so15167024qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:39:15 -0800 (PST)
X-Gm-Message-State: APjAAAUJyMhBrQCb0ijJ8fpQNRTuEJo+3tAKmD1eXCmZhyRomtJGdmp/
        LdIuISTlBIw3TxcxH/f5Hs+nBNFEaA/VXtuqkYQ=
X-Google-Smtp-Source: APXvYqwwMK8lTh8Q4bOX1GS6jqFFejfcqk8Cm3i2mSsSO69MRnbg256iON7w//dldQ1y9+KiSSdX5+iPUyYpK3QLxNs=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr26649069qka.286.1579084754892;
 Wed, 15 Jan 2020 02:39:14 -0800 (PST)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com> <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 11:38:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
Message-ID: <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
To:     Peng Fan <peng.fan@nxp.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:M3WXBTgV7oMTr+ED3aDHzGcAQ7MNA0LQ1Ok0eXXCAQeJYZNjUcH
 u6YYu43a5itPzEAYlsVDYi16F9M7J3DH6oroFFGlZEubH8Vt2ER2T9iYZ732VBhpAi2pEyh
 Cn6eUyBFh9bkjnhom3Ptkvxnc70hgpY6OzswkrudMK9AEMumoHtpicOl8l9ONgioLDniBMH
 GcUavoBL2+/o9cuGNq1Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7rIzxU9364=:aiDvK4QEbUHTuBstitYR80
 rJ4AFfMet/s6XKoSTLd5mT4qq8I/yjPADNQniWWN1dhogNAiQZG9Q5DY1NQ9RLhxVbrpE9goU
 7Vs5e7lEXzu2JyD3X9JAaHTGPE5MHeLsYbgtEHenZFcJiWlLW6QuGbpGf4MF9UY570+ElDOp+
 J8DssLcBf8xdgpYJyliP7lGE0+vKKaCanyRXvf4JwVn842vdiTWNKLxsTPz8SmqUgVpdzaJRn
 u1C7hH/+PYppfbuzANbCh3qa3KMbd0N7yPEKmFTBR757GwPlASluJlRKeQZoPiLBdNQgOmUuy
 rW2H/v6/lzwDlZQPQxc+AOtiBRFpc0YF9EFOilR7m4BTBBzTvyAI1XzJ53SZJVh8V964VhaWN
 Lv5rfJg3yhTzl0+kLiANPFeNQVTwakrEGKMAfaUpNDiW9mj2ShxUWybPv3l9RTmh7kNm4Qwdu
 16O3whp4c6eWKD9VT11WLz8UN0bHqkRVdi7HAx7645KbiFJtjxS3yK6zkqLg+eSvcwJYHRBoe
 UdLVTjAMjmw2L1pcQbh9EixR0O0wrfV/4K1vcul1MLTX+Z/zYfXO2akCqlM3jKZiaSKbtIALd
 6TZVvF9IsUxkFoz8CUI1hoJyipR7Suo5DEYr9piH0ASMANdu1CwyS97WGmwtlEuUvQVksQ8bz
 MyaNMcwhoeHKLYImPuaS3spBt/qx7YkxzPX64ygpNvVqR+VpeOYE14QIbiFqB6iE6pmUJ5asg
 UXh06Yiv+MjmlaB0g7TyPIre5xMs4oJAYyBMt9R8WxBXGlu3veWM92dN1mL/hmOYPUSwTtSp6
 h4+tAvIvUbiX1ziWP51ma6A1sVQ2AXAfC93JRTWS7tMo00M+CjuqcMLLNHT8cf6kd1dsGKavn
 613JtaWo7GNXZRYgR11g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 3:38 AM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
> > On Tue, Jan 14, 2020 at 9:32 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > >
> > > There is no SOC_IMX8 currently. Need to introduce one in
> > > arch/arm64/Kconfig.platforms. But I not see other vendors introduce
> > > options like SOC_XX. Is this the right direction to add one in
> > > Kconfig.platforms?
> >
> > I think it would be more consistent with the other platforms to have a symbol
> > in drivers/soc/imx/Kconfig to control whether we build that driver.
>
> Ok, I'll add Kconfig entry in drivers/soc/imx/Kconfig for various i.MX SoCs.

I was thinking of one entry for this driver.

> > For some SoCs, we also allow running 32-bit kernels, so it would not be wrong
> > to allow enabling the symbol on 32-bit ARM as well, but this is probably
> > something where you want to consider the bigger picture to see if you want
> > to support that configuration or not.
>
> Does the current upstream kernel support 32bit kernels on ARM64 platforms
> without vendor specific stuff. I recalled that several years ago, NXP people
> tried to upstream 32bit kernel support, but rejected by you.

We have at least some Broadcom SoCs that are supported this way. As
long as you can use the same dtb file on a regular multi_v7_defconfig
I see no problem with doing this.

What I would like to avoid though are ports that require extra code in
arch/arm/mach-* that is not needed for the 64-bit target, or ports to
64-bit hardware that only run in 32-bit mode.

> So Is there any plan to support 32bit kernel on AARCH64 in upstream
> kernel?
> Or any suggestions?

I don't think there should be 32-bit kernel running in aarch64-ilp32
mode. This was discussed way back when the aarch64-ilp32 user
space patches first appeared.

Generally speaking you are usually better off running an aarch64
kernel using aarch32 user space, but there may be reasons for
running an ARMv8 aarch32 kernel on the same hardware and there
is no technical reason why this shouldn't work for a clean port.

We never really supported ARMv8-aarch32 in arch/arm/ as a
separate target, but usually building an ARMv7 kernel is close
enough to ARMv8-aarch32 that things just work. If you would
like to help out making ARMv7VE and ARMv8-aarch64 proper
targets for arch/arm/, let me know and we can discuss what parts
are missing.

     Arnd
