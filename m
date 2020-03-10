Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D9C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AB24671
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583810954;
	bh=hChG5TuO06hRpHNaYJuYKM2pUOhe6ZKZiMex2rIGmIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eg/t6akhuy9hepgVEHaGrzNzI+m1WmA7JHrEGiGRUKfZGBwTYRZXa+Ww247Tmd5pa
	 CiBNFSNFdliR6C7z0pEPYv5xx3AsQvZunZ95H+NTUWhlst5DcnsfTdxWSPmbsL2p14
	 OL4FlCkrKUIlkajCypjDPDGFWm9NQQc5PvlttlHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJD3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgCJD3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:29:13 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9F82465A;
        Tue, 10 Mar 2020 03:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583810952;
        bh=hChG5TuO06hRpHNaYJuYKM2pUOhe6ZKZiMex2rIGmIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRP6s3qWT0eqCspl7lvDEybo2miBsjyHUiTQ4vink9+satmLzK2Xj7+2czwhdju1/
         t7maGSy5Ejb+kRFlscTcWMXwQzdXBNMX0KqRglPGg6NTOL8CCjIiMG6sjShF0spEp8
         gG0K6X8/s/T3HFW1mfT+pRN3K+XCnOyfWuzMF5xA=
Date:   Tue, 10 Mar 2020 11:29:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
Message-ID: <20200310032902.GA16036@dragon>
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
 <20200217041936.GH5395@dragon>
 <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
 <20200218091409.GA6075@dragon>
 <CAH9NwWcNZzKt9gwYRRbgppeL9xqcK38z0ZP-5eGF9vXmg7T_=g@mail.gmail.com>
 <20200219091138.GA12803@dragon>
 <CAH9NwWfgJvPDE4_gjMhKaRSxJm-yJkzxOSDbU-HaQkcHuTL76w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWfgJvPDE4_gjMhKaRSxJm-yJkzxOSDbU-HaQkcHuTL76w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:58:30PM +0100, Christian Gmeiner wrote:
> Hi
> 
> Sorry for the delay.. totally forgot about the mail.
> 
> Am Mi., 19. Feb. 2020 um 10:11 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> >
> > On Wed, Feb 19, 2020 at 09:48:23AM +0100, Christian Gmeiner wrote:
> > > Am Di., 18. Feb. 2020 um 10:14 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> > > >
> > > > On Mon, Feb 17, 2020 at 01:09:32PM +0100, Christian Gmeiner wrote:
> > > > > Am Mo., 17. Feb. 2020 um 05:19 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> > > > > >
> > > > > > On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> > > > > > > Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> > > > > > > <krzk@kernel.org>:
> > > > > > > >
> > > > > > > > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > > > > > > > <christian.gmeiner@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > > > > > > > <christian.gmeiner@gmail.com>:
> > > > > > > > > >
> > > > > > > > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> > > > > >
> > > > > > What do you mean by stm32 based devices here?
> > > > > >
> > > > >
> > > > > CONFIG_ARCH_STM32 - I have a STM32MP157C-DK2 in my board farm and
> > > > > would love to use
> > > > > multi_v7 for imx6 and stm32.
> > > >
> > > > The patch is all about enabling drm-imx driver support.  The commit log
> > > > gives the impression that drm-imx driver also works on stm32 devices.
> > > > Is that the case?
> > > >
> > >
> > > No - the common thing both share is etnaviv.
> >
> > I did not know that before, and thanks for the information.  But looking
> > at the code change, there is nothing about etnaviv driver, and it's all
> > about drm-imx driver.  So I'm still questioning why stm32 needs to be
> > mentioned in the commit log at all.
> >
> > > The patch subject "ARM:
> > > multi_v7_defconfig: enable drm imx support" is fine
> >
> > Agreed.  It's perfect.
> >
> > > I think but in the commit message I missed the verb so this should be
> > > a better one:
> > >
> > > --->8---
> > > ARM: multi_v7_defconfig: enable drm imx support
> > >
> > > Makes it possible to use multi v7 defconfig for stm32 and imx based devices with
> > > full drm support.
> > > --->8---
> >
> > I don't think 'stm32' should be there, as the code change in this commit
> > has nothing to do with stm32, if I understand it correctly.
> >
> 
> Okay.. what about:
> --->8---
> ARM: multi_v7_defconfig: enable drm imx support
> 
> It will be useful to have it enabled for KernelCI boot and runtime testing.
> --->8---

Applied with above commit log.

Shawn
