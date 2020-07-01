Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C3BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E43820663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593586267;
	bh=IvkldxSKy6dI7BoDzvZmf7aeX4tfPJCRDYRLEDZqKMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0yZ5HGnhcZ3NGPHHB6Z49XsceYv+aVCFC4auETcsZkNXDUznAb3lQCvFKT2T4lYlt
	 A7i8cQbvTlcAgL6Sq59n1vQCl/mU3MIf5G+KQpMdYkY6Faa6e/GSddyAkUUdz95j1Q
	 Ev1UmSzqSiUfzEbtWFbUrRRCq525pF0Lya4KlF0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGAGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgGAGvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:51:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B77120663;
        Wed,  1 Jul 2020 06:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593586264;
        bh=IvkldxSKy6dI7BoDzvZmf7aeX4tfPJCRDYRLEDZqKMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPwJpsgotx+b38Fkxsx62wgi3q01XfBP3GU//4orXtlEWskY5MZ4mak46kahneNZg
         Nm5VLRsavkVRP3LUdzeqXZnKkAF5RB11bcudAhuJYEFLYxBPB4Lvduq7qKPDs0vBv2
         ypqOvhqvALfE9KsIE/SlzwECxKdcutu33CA6uZLg=
Date:   Wed, 1 Jul 2020 08:50:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Peter Chen <hzpeterchen@gmail.com>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Fix up terminology
Message-ID: <20200701065051.GB2044019@kroah.com>
References: <20200630174123.GA1906678@kroah.com>
 <CAL411-pgboix6=1=jKNv_4JaHiC8fKDJ4_mryooMepeHdB-2AA@mail.gmail.com>
 <20200701062924.GA5927@kroah.com>
 <DB8PR04MB7162C271B04650CBCC87729D8B6C0@DB8PR04MB7162.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR04MB7162C271B04650CBCC87729D8B6C0@DB8PR04MB7162.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 06:40:20AM +0000, Peter Chen wrote:
>  
> > 
> > On Wed, Jul 01, 2020 at 02:02:00PM +0800, Peter Chen wrote:
> > > > index 3a7179e90f4e..1a12aab208b4 100644
> > > > --- a/drivers/usb/gadget/udc/Kconfig
> > > > +++ b/drivers/usb/gadget/udc/Kconfig
> > > > @@ -474,7 +474,7 @@ config USB_DUMMY_HCD
> > > >         help
> > > >           This host controller driver emulates USB, looping all data transfer
> > > >           requests back to a USB "gadget driver" in the same host.  The host
> > > > -         side is the master; the gadget side is the slave.  Gadget drivers
> > > > +         side is the controller; the gadget side is the device.  Gadget drivers
> > >
> > > 'the host side is the controller' may not be suitable.
> > 
> > Really?  It is literally a "host controller" as per the specification :)
> 
> You are right. At first, I thought, there are device controller, host controller and dual-role
> controller, why you only said, "the host side is the controller"? After checking USB 3.0 spec,
> there are only "device", "host" and "host controller" at its Terms and Abbreviations.
> 
> device
> A logical or physical entity that performs one or more functions. The actual entity
> described depends on the context of the reference. At the lowest level, device may refer
> to a single hardware component, as in a memory device. At a higher level, it may refer to
> a collection of hardware components that perform a particular function, such as a USB
> interface device. At an even higher level, device may refer to the function performed by
> an entity attached to the USB. Devices may be physical, electrical, addressable, and
> logical.
> When used as a non-specific reference, a USB device is either a hub or a peripheral
> device.
> 
> host
> The host computer system where the USB host controller is installed. This includes the
> host hardware platform (CPU, bus, etc.) and the operating system in use.
> 
> host controller
> The interface provided to the system to support devices on the USB.

Thanks for the confirmation.  This is why we had to "invent" the term
"gadget" to describe the code that runs in the device to try to reduce
the confusion here.

greg k-h
