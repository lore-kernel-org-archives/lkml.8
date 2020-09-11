Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D07C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A5E221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599804572;
	bh=i4EvJQ4Hd4XUMCwTQL0NZfkrCdHx7ugse8XeINccp6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zeKcURErfTnnwPl0+MWCIY1LSoFex93B/xAkucDqA9ieMujWrpi1u/O51lHySgawU
	 Lz4oU7+PTgc4PPpW2k+wp9dCdl9eZF6Sh9bnGDTydtuf9quQn5RL819KkT5YNdPh9C
	 NwZQgOaTW79rPlrRseyyytMCb+KBhVOI6c1Z4x+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgIKGJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgIKGJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:09:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766E121D7E;
        Fri, 11 Sep 2020 06:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599804569;
        bh=i4EvJQ4Hd4XUMCwTQL0NZfkrCdHx7ugse8XeINccp6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfi+I0kMUG1tla9siuFgxikCDgMn+UD1N3AnfGGyzlFtj38Z1iUNuP4s85al6DOKV
         aQx9yQ4lpuzx12l1wn2CjqpCuyspjqn1oKprCxxFnxGRvFDRlYTQ7K97MZQ39P6b65
         siLwfoBGTDyORuQxpw93n2jSqCHoCi4DdHvcozPA=
Date:   Fri, 11 Sep 2020 08:09:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hector Martin <hector@marcansoft.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Lars Melin <larsm17@gmail.com>,
        Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
Message-ID: <20200911060925.GA553486@kroah.com>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de>
 <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <20200910080850.GD24441@localhost>
 <CADvTj4rDdj8KtLhGZEZP+XZcF4DTE4oW9sNf=zNWaRPzkny93A@mail.gmail.com>
 <20200910085541.GA1099591@kroah.com>
 <CADvTj4pYR9H1X1_f4DYTkb5ViXAdx9sO5yBgHgM5vFaDMs_miQ@mail.gmail.com>
 <26a723e4-e166-6377-875a-f737a15dc6b1@marcansoft.com>
 <CADvTj4o9GL5p6eZq+0Q_Pw_ZKuYHvAtav79==CJDdnTj7q+bBg@mail.gmail.com>
 <0bcb0208-04bc-40c8-7b42-56b4dcf93f21@marcansoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcb0208-04bc-40c8-7b42-56b4dcf93f21@marcansoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 04:54:08AM +0900, Hector Martin wrote:
> On 11/09/2020 03.51, James Hilliard wrote:
> > I haven't tested this yet but my assumption was that either a kernel driver
> > or libusb can issue usb control messages, but both can not be bound to
> > a device at the same time. I figured this wouldn't have come up when you
> > tested your python script since the script likely predated adding the brick PID
> > to the ftdi_sio Linux kernel driver.
> 
> Binding to interfaces is exclusive, but global device control messages are
> not issued to an interface. I think it should work even if the kernel driver
> is bound (this is how lsusb works too, since it issues control requests even
> to devices bound to drivers). Even if it is necessary to unbind it, though,
> libusb already provides a single function to do that
> (libusb_detach_kernel_driver).

You really should unbind the device from the driver when doing stuff
like this, so the kernel doesn't get confused.

thanks,

greg k-h
