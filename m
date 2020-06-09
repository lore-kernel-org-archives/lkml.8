Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF17C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6A720812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591689535;
	bh=zRdYAziJHxWBDEYM5KKlxSHJ/2cNJ4wlPkwlFghOTT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMxkZJ5Sc3OnLaZ4GtVRyS2GwZ5upcR8Ds+AaRb6vlEDGFJEEHGePlKahvHUAAd++
	 meMO4O3w9fZ3J+/TlRiSWBphqFnh6QOnZUal4vgOs/rVKV4x2Ynax01usred58Zl4Q
	 sfahIvXSbItahQrp7+sc0OS7kRekossUiOXfzNAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFIH6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 03:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFIH6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:58:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89617207ED;
        Tue,  9 Jun 2020 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591689532;
        bh=zRdYAziJHxWBDEYM5KKlxSHJ/2cNJ4wlPkwlFghOTT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/AkDdO0kY2FimxYhm96ajehPTA3zfSW6Sntw50ctgKF1WWQka1lADXW7aKuwUdpo
         UsTfX6zhKHwBXX2AXjjCksAjEP7bvBvAggSWz5rnjcS89C+sCnkn3DH+nitzPeE+rg
         xL8mZDXC2UYdY5uJRVYmBjD6pxTvEN/tbfck+P5o=
Date:   Tue, 9 Jun 2020 09:58:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: make module name conflict fatal error
Message-ID: <20200609075848.GA509002@kroah.com>
References: <20200511042149.1712876-1-masahiroy@kernel.org>
 <20200608020256.GA256950@roeck-us.net>
 <20200609062012.GA499862@kroah.com>
 <CAK8P3a2Pn22c8Z=w0FD15w4_+7LCWOpcbJ9b-Skh5iXzBjEx1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Pn22c8Z=w0FD15w4_+7LCWOpcbJ9b-Skh5iXzBjEx1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:51:46AM +0200, Arnd Bergmann wrote:
> On Tue, Jun 9, 2020 at 8:20 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 07, 2020 at 07:02:56PM -0700, Guenter Roeck wrote:
> > > Hi,
> > >
> > > On Mon, May 11, 2020 at 01:21:49PM +0900, Masahiro Yamada wrote:
> > > > I think all the warnings have been fixed by now. Make it a fatal error.
> > > >
> > >
> > > Not entirely. With this patch in the tree, I get:
> > >
> > > Building sparc64:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > error: the following would cause module name conflict:
> > >   drivers/char/adi.ko
> > >   drivers/input/joystick/adi.ko
> > > make[1]: *** [modules_check] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [__sub-make] Error 2
> > >
> > > Reverting this patch fixes the problem.
> >
> > As it doesn't look like either of these drivers can be "auto-loaded"
> > based on hardware detection, I don't know what to suggest as for
> > renaming either of them.
> >
> > Any ideas?
> 
> I see zero chance of a kernel actually needing to provide both drivers,
> given that the hardware is 20 years apart and gameports are almost
> exclusive to x86 PCs. How about an ugly hack:
> 
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 940b744639c7..6f73f02059b5 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -45,6 +45,7 @@ config JOYSTICK_A3D
>  config JOYSTICK_ADI
>         tristate "Logitech ADI digital joysticks and gamepads"
>         select GAMEPORT
> +       depends on ADI!=m # avoid module name conflict
>         help
>           Say Y here if you have a Logitech controller using the ADI
>           protocol over the PC gameport.
> 
>       Arnd

Looks sane to me, thanks!

greg k-h
