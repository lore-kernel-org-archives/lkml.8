Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB80C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791DA2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgGVAni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:43:38 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34856 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgGVAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:43:38 -0400
Date:   Tue, 21 Jul 2020 20:43:28 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in
 kernel/dma/Kconfig
Message-ID: <20200722004323.GW14669@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <20200714121856.955680-9-hch@lst.de>
 <20200721031725.GO14669@brightrain.aerifal.cx>
 <20200721051134.GA9881@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721051134.GA9881@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 07:11:34AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 11:17:26PM -0400, Rich Felker wrote:
> > On Tue, Jul 14, 2020 at 02:18:54PM +0200, Christoph Hellwig wrote:
> > > Have a single definition that architetures can select.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/m68k/Kconfig         | 4 +---
> > >  arch/m68k/Kconfig.machine | 1 +
> > >  arch/um/Kconfig           | 4 +---
> > >  kernel/dma/Kconfig        | 3 +++
> > >  4 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > > index 6ad6cdac74b3dc..8e488369a7e55a 100644
> > > --- a/arch/m68k/Kconfig
> > > +++ b/arch/m68k/Kconfig
> > > @@ -17,6 +17,7 @@ config M68K
> > >  	select HAVE_COPY_THREAD_TLS
> > >  	select GENERIC_IRQ_SHOW
> > >  	select GENERIC_ATOMIC64
> > > +	select NO_DMA if !MMU && !COLDFIRE
> > >  	select HAVE_UID16
> > >  	select VIRT_TO_BUS
> > >  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> > > @@ -60,9 +61,6 @@ config TIME_LOW_RES
> > >  config NO_IOPORT_MAP
> > >  	def_bool y
> > >  
> > > -config NO_DMA
> > > -	def_bool (MMU && SUN3) || (!MMU && !COLDFIRE)
> > > -
> > >  config ZONE_DMA
> > >  	bool
> > >  	default y
> > > diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
> > > index a82651d58af483..17e8c3a292d770 100644
> > > --- a/arch/m68k/Kconfig.machine
> > > +++ b/arch/m68k/Kconfig.machine
> > > @@ -126,6 +126,7 @@ config SUN3
> > >  	depends on MMU
> > >  	depends on !MMU_MOTOROLA
> > >  	select MMU_SUN3 if MMU
> > > +	select NO_DMA
> > >  	select M68020
> > >  	help
> > >  	  This option enables support for the Sun 3 series of workstations
> > > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > > index 9318dc6d1a0cee..32c1d1945033ec 100644
> > > --- a/arch/um/Kconfig
> > > +++ b/arch/um/Kconfig
> > > @@ -15,6 +15,7 @@ config UML
> > >  	select HAVE_DEBUG_KMEMLEAK
> > >  	select HAVE_DEBUG_BUGVERBOSE
> > >  	select HAVE_COPY_THREAD_TLS
> > > +	select NO_DMA
> > >  	select GENERIC_IRQ_SHOW
> > >  	select GENERIC_CPU_DEVICES
> > >  	select GENERIC_CLOCKEVENTS
> > > @@ -168,9 +169,6 @@ config MMAPPER
> > >  	  This driver allows a host file to be used as emulated IO memory inside
> > >  	  UML.
> > >  
> > > -config NO_DMA
> > > -	def_bool y
> > > -
> > >  config PGTABLE_LEVELS
> > >  	int
> > >  	default 3 if 3_LEVEL_PGTABLES
> > > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > > index 1da3f44f2565b4..57533d07676f4a 100644
> > > --- a/kernel/dma/Kconfig
> > > +++ b/kernel/dma/Kconfig
> > > @@ -1,5 +1,8 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  
> > > +config NO_DMA
> > > +	bool
> > > +
> > >  config HAS_DMA
> > >  	bool
> > >  	depends on !NO_DMA
> > > -- 
> > > 2.26.2
> > 
> > This patch is outside the scope of what I can accept in arch/sh, and
> > the subsequent patches in the series seem to depend on it. What would
> > you like to do for its path upstream?
> > 
> > I've now picked up everything else from this series that I can.
> 
> As the dma-mapping maintainer:  please pick it.  I'd give you an
> ACK, but that looks kinda silly if I'm the author as well :)

Very well! It's now in my for-next branch along with the rest of the
series and a lot of other stuff.

Rich
