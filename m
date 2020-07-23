Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02008C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D154820888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595493688;
	bh=PheGDG4I+Sd5okWGMSuo1JWd9HXAe6/fNMBPEQNHz2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t4K+qta+Ygkw+KYxoH586CjGuc21U4LyYu7Ftgb+ArIs/9lm4OG2nbQfKNCpYU8VA
	 bzyzFKQqs9MXpUaOkTYEJkTgS+mRFJ+dgFpn5GmtF6KA5RWtmwOEBLmbrGfVeN7pOE
	 QPxnJLs5n3McxWG75EANvZQJyoqRF0i45eyuJXhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGWIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:41:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308BD2080D;
        Thu, 23 Jul 2020 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595493686;
        bh=PheGDG4I+Sd5okWGMSuo1JWd9HXAe6/fNMBPEQNHz2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTaq7h7RwfYMBoNmsxw1lVCjbC3pvPOFNRcvog+sxixmTbZKs668cWaGmUeAwTj7t
         7HdJG9gPG8VPyMEAxwFOw7BYL4mliAKBHHxh1ylQodA/qmVRsqfS5KcKVXcuti5z7T
         oGu9/+ZqLoJd0r6FnOohTSmOKYzaS5uPJ6uzEHfc=
Date:   Thu, 23 Jul 2020 10:41:31 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "hslester96@gmail.com" <hslester96@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carsten_Schmid@mentor.com" <Carsten_Schmid@mentor.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "Tony W. Wang(XA-RD)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= USB:Fix kernel
 NULL pointer when unbind UHCI form vfio-pci
Message-ID: <20200723084131.GA1753458@kroah.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722215313.5a842b93@x1.home>
 <371b3697614e4034aed8e9f340a7dbf1@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371b3697614e4034aed8e9f340a7dbf1@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 08:36:25AM +0000, WeitaoWang-oc wrote:
> 
> On Thu,23 July 2020 04:18:00 +0000 Alex wrote:
> > On Wed, 22 Jul 2020 19:57:48 +0800
> > WeitaoWangoc <WeitaoWang-oc@zhaoxin.com> wrote:
> > 
> > >  drivers/usb/core/hcd-pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> > > index 1547aa6..484f2a0 100644
> > > --- a/drivers/usb/core/hcd-pci.c
> > > +++ b/drivers/usb/core/hcd-pci.c
> > > @@ -34,6 +34,7 @@ static DECLARE_RWSEM(companions_rwsem);
> > >  #define CL_OHCI                PCI_CLASS_SERIAL_USB_OHCI
> > >  #define CL_EHCI                PCI_CLASS_SERIAL_USB_EHCI
> > >
> > > +#define PCI_DEV_DRV_FLAG       2
> > >  static inline int is_ohci_or_uhci(struct pci_dev *pdev)  {
> > >         return pdev->class == CL_OHCI || pdev->class == CL_UHCI; @@
> > > -68,6 +69,8 @@ static void for_each_companion(struct pci_dev *pdev, struct
> > usb_hcd *hcd,
> > >                 if (companion->class != CL_UHCI && companion->class !=
> > CL_OHCI &&
> > >                                 companion->class != CL_EHCI)
> > >                         continue;
> > > +               if (!(companion->priv_flags & PCI_DEV_DRV_FLAG))
> > 
> > But pci_dev.priv_flags is private data for the driver that currently
> > owns the device, which could be vfio-pci.  This is really no different
> > than assuming the structure at device.driver_data.  If vfio-pci were to
> > make legitimate use of pci_dev.priv_flags, this could simply blow up
> > again.  Should there instead be some sort of registration interface
> > where hcd complaint drivers register their devices and only those
> > registered devices can have their driver private data arbitrarily poked
> > by another driver?  Thanks,
> 
> Thanks for your explanation. Set pci_dev.priv_flags is really not a 
> reasonable approach. Are there any more detailed suggestions 
> to patch this issue?

This is not a kernel issue, it is a "do not do this in this way from
userspace" issue :)

thanks,

greg k-h
