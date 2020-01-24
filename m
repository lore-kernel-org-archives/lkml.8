Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD12C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F2420709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3TQZGZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbgAXPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:54:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36805 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389172AbgAXPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:54:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so2815695edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW6kTXsb+AMUpnGd0Np6dLhfVf8Q9ZDqnV2qmDoDlDE=;
        b=H3TQZGZcdRTBERaePDaluLz/yGmA6niYVpD9lpB8ecfDyAdIUuUiXSQd8yI36Vidj1
         D0WaYtkXfCnSNAgPZZo/bkaXJtGh5R66E29iCC/T9ISpn8d6LL+sSrg1G8jmiF6e0CCs
         SQ5pC3x8QZIbzz3MIMCUDCLrZpRXpaDSS8c26ozw1z/VHREqbvFTaGZXsaQoGOcHw6/4
         o8Fn3TOA51JFwxAtkyn8IeK0zAAzVkg0XDHD/q+NdEjSjtSmZvlE1Yhy5ZOyPde3InKJ
         sZG7sTZ+CHo/7pPyy99yzenIhi+4RDqIgl3PnNxoCEQgNFlHXISYDpdHk3cM1yhijutV
         tI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW6kTXsb+AMUpnGd0Np6dLhfVf8Q9ZDqnV2qmDoDlDE=;
        b=Lf45J2S0TC7yPPp0L24YBY3EImBJxFonB4gArgPtrES8nRU0Jk/w+aQvtIuuEGSRzy
         ASWnVLoybMLlGcZkLj3dcJczuI9BQdj7hUBbpCi3FWito8/a7FFnCCuuOvdosF+DtM54
         fnAJtpFraD3LHHCgL8f9NOcJdOSWV6zYxKKBfkyr+2qpOoDzHwghPjsvqR5cGDxA8GEg
         zE6RCNv/nlNqMmSKP6+pPw7V9nbRorivQ+CvzRBChqwuD6uFQ9U4P5xpyyw+aoVtjcRK
         JgUxxLb2GbSrr3Z2mxp41TQueMyqdW744Z12IIs9aKzBCes79X/mGkj2QeDj/y1WcpOU
         1I/w==
X-Gm-Message-State: APjAAAV+qNOOyGBj/1E7Dr4/2Kq2PrZpgLFVnMTMSy0aXuOdbSEmtSRl
        CseQIjA2OOJRc1eUNdLKD9yuCOE90rVYpFyTSs8=
X-Google-Smtp-Source: APXvYqyadpmW1cAK9X6qA/FtoBgIZOCZp0Nn/wpY64zn9YMqMvTULjMEpssAp18wfzHjoLPDGP1GgV1rBnKqV/b0NV0=
X-Received: by 2002:a05:6402:799:: with SMTP id d25mr3203640edy.221.1579881261869;
 Fri, 24 Jan 2020 07:54:21 -0800 (PST)
MIME-Version: 1.0
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de> <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
In-Reply-To: <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 24 Jan 2020 09:54:10 -0600
Message-ID: <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 4:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 15, 2020 at 3:38 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
> > > On Tue, Jan 14, 2020 at 9:32 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > > Subject: Re: [PATCH] soc: imx: Makefile: only build soc-imx8 when
> > > >
> > > > There is no SOC_IMX8 currently. Need to introduce one in
> > > > arch/arm64/Kconfig.platforms. But I not see other vendors introduce
> > > > options like SOC_XX. Is this the right direction to add one in
> > > > Kconfig.platforms?
> > >
> > > I think it would be more consistent with the other platforms to have a symbol
> > > in drivers/soc/imx/Kconfig to control whether we build that driver.
> >
> > Ok, I'll add Kconfig entry in drivers/soc/imx/Kconfig for various i.MX SoCs.
>
> I was thinking of one entry for this driver.
>
> > > For some SoCs, we also allow running 32-bit kernels, so it would not be wrong
> > > to allow enabling the symbol on 32-bit ARM as well, but this is probably
> > > something where you want to consider the bigger picture to see if you want
> > > to support that configuration or not.
> >
> > Does the current upstream kernel support 32bit kernels on ARM64 platforms
> > without vendor specific stuff. I recalled that several years ago, NXP people
> > tried to upstream 32bit kernel support, but rejected by you.
>
> We have at least some Broadcom SoCs that are supported this way. As
> long as you can use the same dtb file on a regular multi_v7_defconfig
> I see no problem with doing this.
>
> What I would like to avoid though are ports that require extra code in
> arch/arm/mach-* that is not needed for the 64-bit target, or ports to
> 64-bit hardware that only run in 32-bit mode.
>
> > So Is there any plan to support 32bit kernel on AARCH64 in upstream
> > kernel?
> > Or any suggestions?
>
> I don't think there should be 32-bit kernel running in aarch64-ilp32
> mode. This was discussed way back when the aarch64-ilp32 user
> space patches first appeared.
>
> Generally speaking you are usually better off running an aarch64
> kernel using aarch32 user space, but there may be reasons for
> running an ARMv8 aarch32 kernel on the same hardware and there
> is no technical reason why this shouldn't work for a clean port.
>
> We never really supported ARMv8-aarch32 in arch/arm/ as a
> separate target, but usually building an ARMv7 kernel is close
> enough to ARMv8-aarch32 that things just work. If you would
> like to help out making ARMv7VE and ARMv8-aarch64 proper
> targets for arch/arm/, let me know and we can discuss what parts
> are missing.

I would be interested in learning more about running the i.MX8M in
32-bit mode.  I'm looking at running Linux on a device with < 1GB of
RAM, so having 32-bit pointers and instructions would be preferred.
My preference would be to run as ARMv7 for migration purposes, but I'm
open to alternatives.

Does anyone have any suggestions on where I might find some generic
stuff for either iMX8M or generic ARMv8 docs for doing something like
this?

adam

>
>      Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
