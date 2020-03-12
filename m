Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E62C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16A2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584030780;
	bh=XLGjcGJfXkG7wsiKKKJrzQ3EFH/yCmYimdREZIuU5R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFYyrgL/777bd0zxcCZ6eIC3uHuLWxs7rPurSPko51m1SGiItlHjRlQ9vTvJerY/L
	 3w6RMgTJNFKBfUXsX2yEtLu22yU/SZB3P79/OsXl/DyuA28x9kuRSdEgV+B4t3zbda
	 GmOhhWimAC2Egnn0sLOJdEKzG7pNBq3t8F82FBNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCLQc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgCLQc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:32:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4013A206FA;
        Thu, 12 Mar 2020 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584030776;
        bh=XLGjcGJfXkG7wsiKKKJrzQ3EFH/yCmYimdREZIuU5R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSkqIGqWdh5Up9ovvgEtHEBobVk1tIXLJXKMrKeaDLNar8pUG9/IMQ9uL9Tqoj3pk
         l0ykdSXvxzZN7vBXuqrzDJFDUGiIQwc0kwESpxLD/qFmGHTz/i8phn/unQ+UtVqPZE
         YBlKe91+DyoQoNVyjKM8oBY1+nREOZJhde3GYGA8=
Date:   Thu, 12 Mar 2020 17:32:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v3 1/8] usb: Add MA-USB Host kernel module
Message-ID: <20200312163253.GA435313@kroah.com>
References: <efe5dbe1-4bd7-43cb-1eea-b6b999dd15e6@displaylink.com>
 <20200312152037.GA383349@kroah.com>
 <a950d4e0-b9e6-ef44-9c83-35958154b36f@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a950d4e0-b9e6-ef44-9c83-35958154b36f@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:23:53PM +0100, Vladimir Stankovic wrote:
> On 12.3.20. 16:20, Greg KH wrote:
> > On Thu, Mar 12, 2020 at 03:42:30PM +0100, Vladimir Stankovic wrote:
> >  > Added utility macros, kernel device creation and cleanup, functions for
> >  > handling log formatting and a placeholder module for MA-USB Host device
> >  > driver.
> >  >
> >  > Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> >  > ---
> >  > MAINTAINERS | 7 +++
> >  > drivers/usb/Kconfig | 2 +
> >  > drivers/usb/Makefile | 2 +
> >  > drivers/usb/mausb_host/Kconfig | 14 +++++
> >  > drivers/usb/mausb_host/Makefile | 12 ++++
> >  > drivers/usb/mausb_host/mausb_core.c | 90 +++++++++++++++++++++++++++++
> >  > drivers/usb/mausb_host/utils.c | 85 +++++++++++++++++++++++++++
> >  > drivers/usb/mausb_host/utils.h | 40 +++++++++++++
> >  > 8 files changed, 252 insertions(+)
> >  > create mode 100644 drivers/usb/mausb_host/Kconfig
> >  > create mode 100644 drivers/usb/mausb_host/Makefile
> >  > create mode 100644 drivers/usb/mausb_host/mausb_core.c
> >  > create mode 100644 drivers/usb/mausb_host/utils.c
> >  > create mode 100644 drivers/usb/mausb_host/utils.h
> >  >
> >  > diff --git a/MAINTAINERS b/MAINTAINERS
> >  > index 235ab38ed478..12aac44196d7 100644
> >  > --- a/MAINTAINERS
> >  > +++ b/MAINTAINERS
> >  > @@ -10226,6 +10226,13 @@ W: https://linuxtv.org <https://linuxtv.org>
> >  > S: Maintained
> >  > F: drivers/media/radio/radio-maxiradio*
> >  > +MA USB HOST DRIVER
> >  > +M: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> >  > +L: mausb-host-devel@displaylink.com
> >  > +W: https://www.displaylink.com <https://www.displaylink.com>
> >  > +S: Maintained
> >  > +F: drivers/usb/mausb_host/*
> >  > +
> >  > MCAN MMIO DEVICE DRIVER
> >  > M: Dan Murphy <dmurphy@ti.com>
> >  > M: Sriram Dash <sriram.dash@samsung.com>
> > 
> > Does that patch look correct?
> > 
> > Does this apply?
> > 
> > Something is odd here :(
> > 
> > 
> >  > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> >  > index 275568abc670..4e92f1fa0fa5 100644
> >  > --- a/drivers/usb/Kconfig
> >  > +++ b/drivers/usb/Kconfig
> >  > @@ -164,6 +164,8 @@ source "drivers/usb/misc/Kconfig"
> >  > source "drivers/usb/atm/Kconfig"
> >  > +source "drivers/usb/mausb_host/Kconfig"
> >  > +
> >  > endif # USB
> >  > source "drivers/usb/phy/Kconfig"
> > 
> > Yeah, something is really wrong with your email client :(
> > 
> > Can you use 'git send-email' to send all of these out so they do not get
> > corrupted?
> > 
> > That will also fix the lack of email threading which this series still
> > has as well.
> > 
> > thanks,
> > 
> > greg k-h
> I'd say it's the issue with mail server used by company, since patches and
> mails were generated via git (i.e. used git imap-send to create mail
> drafts). One of the reasons we've sent attachments in the first version of
> the patch was to avoid weird mail client/server issues.

If this is an Exchange server, you can give up now, they are known to
corrupt patches.  There is some "magic" settings you can do to the
server, but personally I do not know what they are.

good luck!

greg k-h
