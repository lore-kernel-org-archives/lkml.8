Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DDC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B24D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588276962;
	bh=Csk1FRgOIkPXyDs3SuTpRgxr84txcfkymZTVF3Q2W24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yODyfihbGPMAhRcol2684lYH6qGqDwAWnbhQHaHEE+nnim0WJ54PUs0Qqr6QFvbUG
	 BGZ9l8PcKT4qYHywfwqHYzGzG0++PlxLN6sleULn7rX09mo9SmR1QMCVrxugXIvVPk
	 22G9myKw3qweVGnu1/ZfpnxwMNjsH4CyUtP4CK/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD3UCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3UCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:02:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10ECF2072A;
        Thu, 30 Apr 2020 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588276960;
        bh=Csk1FRgOIkPXyDs3SuTpRgxr84txcfkymZTVF3Q2W24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4b2vurNh0IRcr02dgZoCe8UV0dnNbAlPIYG82dJ3/iq+gyl+Jgk6cMhnYk/2Lssa
         lvjUmetVvs6JLT5KJzI+rSTKAEnH5bPkdAvYSozN7nAR39nu21nXBk60lSTIAB+6Ap
         5yoYU0owO/BOkxdMuY3VqMBFr1jpkR2zA5ZAYylY=
Date:   Thu, 30 Apr 2020 22:02:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [External] Re: [PATCH v5 0/8] Add MA USB Host driver
Message-ID: <20200430200238.GB3843398@kroah.com>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200428110459.GB1145239@kroah.com>
 <b14a2f71-3931-8d32-43a1-cbf52add48bb@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14a2f71-3931-8d32-43a1-cbf52add48bb@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 06:51:10PM +0200, Vladimir Stankovic wrote:
> On 28.4.20. 13:04, Greg KH wrote:
> > On Sat, Apr 25, 2020 at 11:19:46AM +0200, vladimir.stankovic@displaylink.com wrote:
> >> Media Agnostic (MA) USB Host driver provides USB connectivity over an
> >> available network, allowing host device to access remote USB devices
> >> attached to one or more MA USB devices (accessible via network).
> >>
> >> This driver has been developed to enable the host to communicate
> >> with DisplayLink products supporting MA USB protocol (MA USB device,
> >> in terms of MA USB Specification).
> >>
> >> MA USB protocol used by MA USB Host driver has been implemented in
> >> accordance with MA USB Specification Release 1.0b.
> > 
> > Is that a USB-released spec?
> Correct, document is being maintained by USB IF and is publicly available.
> However, I just noticed a typo, correct version is 1.0a. Will correct.
> 
> In short, MA USB Specification defines an MA USB protocol that performs USB
> communication via any communication medium. As such, it defines how to pack
> USB data within MA USB payload, and how to communicate with remote MA USB device.
> > 
> >>
> >> This driver depends on the functions provided by DisplayLink's
> >> user-space driver.
> > 
> > Where can that userspace code be found?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Userspace code is not publicly available. However, in short, it's purpose is
> twofold, to provide interface to application layer, and to prepare MA USB packets
> that will be used by remote device.

So you want us to take a one-off char-driver kernel code for a closed
source userspace application for a public spec?  That feels really
really odd, if not actually against a few licenses.  I hate to ask it,
but are your lawyers ok with this?

> Related to userspace related questions (i.e. comments around two devices used),
> we can provide detailed description of the used IPC. In that sense, please state
> the most appropriate way/place to state/publish such description (i.e. is it ok
> to add it within the cover letter, or publicly available URL is preferred). 

I asked a bunch of questions about this in the patches themselves, you
all need to document the heck out of it everywhere you can, otherwise we
can't even review the code properly.  Could you review it without
knowing what userspace is supposed to be doing?

But, note, I will not take a spec-compliant driver that requires closed
source userspace code, nor should you even want me to do that if you
rely on Linux.

So please, release the userspace code, as it's going to have to be
changed anyway as your current user/kernel api is broken/incorrect
as-is.  Why not just bundle it in the kernel tree like we have the usbip
code?  That way you know it all works properly, and better yet, it can
be tested and maintained properly over time.

thanks,

greg k-h
