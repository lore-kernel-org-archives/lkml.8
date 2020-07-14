Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA5AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6177221F3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594708703;
	bh=jmaTVF/e7rbplwCo+mrwHwjt9sE4SIcnDxlAELMKzbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QIpSf/yFvb9is7dnUcoLQXChY5+Z0c4JIjNbR/50vMGm1+Smi29Wjv0uOTGZ8vZ8M
	 49Izepwg+Y54QyBYS4pna42VzFkCHrDigFHrsb2CD662gbpHo1EcytHn043jV4gnm8
	 8Pw0ILbEeFrCc0IBMptHEdKxcpBvMGgPsr3Qd64k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgGNGiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:38:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF61221F0;
        Tue, 14 Jul 2020 06:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594708701;
        bh=jmaTVF/e7rbplwCo+mrwHwjt9sE4SIcnDxlAELMKzbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFtmIWo2yDIrJbkBAGZqQsHEhr0AH89WYCQyzf4LeeXCiOGd6U2V6jDz7YMdZaHlW
         Z7S9V4WAq9dnReIVEPltwp4ORYwb40wl5IyjC3QXtiiCgDboDwMUlyu2cYZL9zP2w5
         wu6Ol6Ihqn3CTOPbOWq2XFknbDsaXqjs2JFr/uFQ=
Date:   Tue, 14 Jul 2020 08:38:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200714063820.GD662760@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
 <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
 <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com>
 <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com>
 <CAK8P3a2G_UzKv5HmQk1gyaHXY+YzVedknwof+9fmCjQuF+hu2A@mail.gmail.com>
 <CAK8P3a2TUAfhdoAL7u2fun7ZztrjGLxAGAX-WWDqsyNqP2=gZA@mail.gmail.com>
 <CAFmMkTGkmBgmv6wmS1kNWxGm0ktN56u9pJVJQKyPvLipyHsgqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTGkmBgmv6wmS1kNWxGm0ktN56u9pJVJQKyPvLipyHsgqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 07:24:11PM -0300, Daniel Gutson wrote:
> On Mon, Jul 6, 2020 at 6:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Mon, Jul 6, 2020 at 11:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > Because of these reasons, I'm proposing a misc (not-device) driver
> > that supports
> > > > many Intel architectures (and families) to expose the information.
> > > > I understand your proposal to first enhance existing _device_ drivers,
> > but I
> > > > couldn't find suitable options.
> > >
> > > Maybe try adding an interface to one of the drivers at first, and then
> > extend
> > > it to the other hardware after an initial code review. Do not bypass the
> > driver
> > > model or try to do everything at once with a single module that knows
> > > details of multiple unrelated hardware implementations.
> >
> > To clarify further how I think you can have a chance of getting the
> > interface you want, here's a step-by-step list:
> >
> > 1. keep the current securityfs interface (or any other user space
> >   ABI if you have already changed it), but put it into a separate loadable
> >   module
> 
> 
> If it is a loadable module, how can I ensure that it was loaded before the
> intel-spi driver, so the latter can call
> the API of the former? What if the driver was not loaded, when the
> intel-spi driver will try to call
> your suggested spi_lpc_register_info? In other words, how can I prevent to
> call functions from an unloaded driver?

THe symbol will not be resolved so the module will not be able to be
loaded in the first place, OR your module will be loaded first by the
system to prevent that.

> Do I just add the dependency in the Kconfig? But if so, what about the
> order of initialization?
> A hint please?

Try it and see what happens, it should all "just work" :)

thanks,

greg k-h
