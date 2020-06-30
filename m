Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EB220772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593536126;
	bh=mpfmjdG6IGcV2SNI0L4bL1NPbP75BRIegyv1s5x/4Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbA3SmxwW2xJUa0HoF05qe1KYVmSBP6mwH7xgYlFK3qsAL9tgz2ALQNLKqrI3hWW7
	 yNAtsp/qKGFTDxzIdTElmNiKCmuCKsSDogdYv/BUrIcZwBwU0x7Z+dnMGtljhvPkVI
	 W/TjfqpamM5U/uhWhB93KEbDqVNyb0M5/uyCVuBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgF3QzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbgF3QzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:55:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F65220759;
        Tue, 30 Jun 2020 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593536124;
        bh=mpfmjdG6IGcV2SNI0L4bL1NPbP75BRIegyv1s5x/4Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaJ5lgCZfx1p6/8DR6gcC7f4PdAAro1Kp4brzrSPcLu0+ul58C6pkVAQqfWn+S+vZ
         c1lF5qQpGryKQr/WAXOvgxce3O/Tl4nwSLqrv1nFoDYlVr5Ltu41dTOUNjb4vY94uE
         Y1eDsaCYM7dxzcWFMBczjsmV2cF/paXNYxoworTw=
Date:   Tue, 30 Jun 2020 18:55:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630165512.GA1894898@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <20200630085641.GD637809@kroah.com>
 <CAFmMkTGrnZt7ZaGyYCe-LCHET4yHz9DfanaZwsOS6HCxK40apQ@mail.gmail.com>
 <20200630152832.GB1780940@kroah.com>
 <CAFmMkTGy7u8oNSPmBHf9+URzKeNOxy5TJtqF3FCruRkTgJ_wGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTGy7u8oNSPmBHf9+URzKeNOxy5TJtqF3FCruRkTgJ_wGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 01:18:28PM -0300, Daniel Gutson wrote:
> On Tue, Jun 30, 2020 at 12:28 PM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jun 30, 2020 at 11:42:58AM -0300, Daniel Gutson wrote:
> > > On Tue, Jun 30, 2020 at 5:56 AM Greg Kroah-Hartman <
> > > gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Mon, Jun 29, 2020 at 07:59:32PM -0300, Daniel Gutson wrote:
> > > > > This kernel module exports configuration attributes for the
> > > > > system SPI chip.
> > > > > This initial version exports the BIOS Write Enable (bioswe),
> > > > > BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> > > > > fields of the Bios Control register. The idea is to keep adding more
> > > > > flags, not only from the BC but also from other registers in
> > following
> > > > > versions.
> > > > >
> > > > > The goal is that the attributes are avilable to fwupd when SecureBoot
> > > > > is turned on.
> > > > >
> > > > > A technical note: I check if *ppos == BUFFER_SIZE in the reading
> > function
> > > > > to exit early and avoid an extra access to the HW, for example when
> > using
> > > > > the 'cat' command, which causes two read operations.
> > > >
> > > > Why not use the simple_* functions which should prevent that type of
> > > > thing?
> > > >
> > >
> > > a hint please? I don't see how to do it with simple_read_from_buffer, I
> > > need to return in the read fop the amount of read bytes, but don't know
> > > how to mark EOF. Because of that, 'cat' reads again just for me to tell
> > it
> > > there's nothing else to read.
> >
> > That's fine, the kernel does not tell userspace "EOF", that is up to the
> > libc to determine.  If you read the data from the hardware once, and
> > keep it in your buffer, simple_read_from_buffer() will handle all of
> > that logic for you, please let it do that.
> >
> 
> The only way I see to do this is to dynamically allocate the buffer in the
> open fop, in order to avoid concurrency issues.
> Is this correct?

Or use a lock, depends on what you want to do here.

But sysfs should handle all of this for you, when you switch to it.

> > > We debated this but didn't find a better match, since cpu/arch-specific
> > > seemed too core to put informational drivers.
> > > Do you have a suggestion?
> >
> > Make it explicitly hardware specific in your userspace location.
> >
> 
> What do you mean by "your userspace location"?

Where your files show up to userspace.  sysfs is a hierarchy, don't put
hardware-specific stuff at the "root" of it, otherwise that doesn't make
any sense.  Look at what is there today for examples of what to do.


good luck!

greg k-h
