Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B4F21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582017269;
	bh=hRw209oKEaCZWoYigJBg7fczTf5My05WHql2Hw28z8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZPB/GxSZ57yRYLhLBtaLD4tftxgJQjHXJagrKQxm4E2PGXJ40XIz1eWGf6dr/zWG
	 cgUZmQ6f4pWAEJvH2mCiSwdOjbUep+820KlWuZFMB/z4lNWf2QPVZS0AsSn3KZshp8
	 9sPwvwH0MLz43JSDordYOHpwUXr221HEpvtC1Sj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRJO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgBRJO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:14:28 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1176320659;
        Tue, 18 Feb 2020 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582017268;
        bh=hRw209oKEaCZWoYigJBg7fczTf5My05WHql2Hw28z8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ajy3HkFdFWng9bLPIdBDSTUY+a9Q087LEQvwAb9hQoRaKk1S2f/KZ60vL5VdR3UtF
         YGzA0uSe4HGNYCerYkSQ/h9zT2REdDnJoQXGKzI+Ddmv+qCGzDrMkJ7fIyfIwbVNU8
         bTsxUSp/LdJtoYQu2vaUZR1bNPsh29niWarF4wik=
Date:   Tue, 18 Feb 2020 17:14:10 +0800
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
Message-ID: <20200218091409.GA6075@dragon>
References: <20200124084359.16817-1-christian.gmeiner@gmail.com>
 <CAH9NwWfMwN9cRgMHPF5zPCmdmnrfX7E6cAYW8yfUGTf+t3=HzA@mail.gmail.com>
 <CAJKOXPdM4s8DAVPh1zOt5kYyEjp4dmbseC3RdrKaVk4H41XOwg@mail.gmail.com>
 <CAH9NwWdg5r1T9TkXAe4=3Zui2vMcnOc2UJ=e02NFbiPhb5n48w@mail.gmail.com>
 <20200217041936.GH5395@dragon>
 <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWeT=h=hPzDbwRggNYNx-mSdQkjUypPWk2nmsLDOfw8Zqw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:09:32PM +0100, Christian Gmeiner wrote:
> Am Mo., 17. Feb. 2020 um 05:19 Uhr schrieb Shawn Guo <shawnguo@kernel.org>:
> >
> > On Mon, Feb 10, 2020 at 02:30:12PM +0100, Christian Gmeiner wrote:
> > > Am Mo., 10. Feb. 2020 um 11:58 Uhr schrieb Krzysztof Kozlowski
> > > <krzk@kernel.org>:
> > > >
> > > > On Mon, 10 Feb 2020 at 11:54, Christian Gmeiner
> > > > <christian.gmeiner@gmail.com> wrote:
> > > > >
> > > > > Am Fr., 24. Jan. 2020 um 09:44 Uhr schrieb Christian Gmeiner
> > > > > <christian.gmeiner@gmail.com>:
> > > > > >
> > > > > > Makes it possible to multi v7 defconfig for stm32 and imx based devices with
> >
> > What do you mean by stm32 based devices here?
> >
> 
> CONFIG_ARCH_STM32 - I have a STM32MP157C-DK2 in my board farm and
> would love to use
> multi_v7 for imx6 and stm32.

The patch is all about enabling drm-imx driver support.  The commit log
gives the impression that drm-imx driver also works on stm32 devices.
Is that the case?

Shawn
