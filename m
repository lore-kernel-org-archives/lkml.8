Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A443BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2712074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595054788;
	bh=cQVAtXCp05Y5pu1NLBnjCDHoEK5RO8u7KrRXc0+x69c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFZvZXeDCwIab69y/AuJHi4EuP33VSjRseU3ECU9RAQ/1IJZ1wG53C0iSRPZVfyOz
	 mRM7oh0WxZOFDzHkqsVbXhYpriTaxULj2V51VTodJuDyxYhS0gV7N2SJxZxSBEjHxW
	 FYQIAtccmHKWJAD77shLjkAEDAMOuV0cq86ebR3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgGRGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgGRGq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:46:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B20D2074B;
        Sat, 18 Jul 2020 06:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595054786;
        bh=cQVAtXCp05Y5pu1NLBnjCDHoEK5RO8u7KrRXc0+x69c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf59OVyrh5LrVxT/XtprL0bF7QFKAHLsXz9/fCDE8J4du6gB/aXFEklFa6DZF5ecV
         8rFLE06B20SmX68R5WXeY9fNJ5cHq396D5HoGnNLHVCG6spSqz3CzbTzc8SxjdmzyU
         VHxNXHH6P0pl31Uy2TgfQwjEBeL95hpB4yiudHEc=
Date:   Sat, 18 Jul 2020 08:46:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200718064623.GA245355@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155631.GB186665@kroah.com>
 <SN6PR11MB25742456A7DA3C99F88FA77FF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB25742456A7DA3C99F88FA77FF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:19:14PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Sunday, July 12, 2020 10:57 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > 
> > On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > > +config INTEL_DLB2
> > > +       tristate "Intel(R) Dynamic Load Balancer 2.0 Driver"
> > > +       depends on 64BIT && PCI && X86
> > 
> > Why just that platform?  What about CONFIG_TEST for everything else?
> 
> This device will only appear on an x86 platform. CONFIG_COMPILE_TEST won't work, since the driver uses the x86-only function iosubmit_cmds512().

Please wrap your lines correctly...

Anyway, there is no config option for that function that you can trigger
off of?

> > > +       help
> > > +         This driver supports the Intel(R) Dynamic Load Balancer 2.0 (DLB 2.0)
> > > +         device.
> > 
> > Are you sure you need the (R) in Kconfig texts everywhere?
> 
> The second is probably overkill. Just the first one is required.

Really?  I would just drop it.  Unless you get a signed-off-by from a
lawyer saying it is required :)

> > And a bit more info here would be nice, as no one knows if they have this or
> > not, right?
> 
> Intel hasn't yet announced more information that I can include here. For now, "lspci -d 8086:2710" will tell the user if this device is present.

That's fine, but we can't take a 1 sentance help text, that means
nothing.

> > > --- /dev/null
> > > +++ b/drivers/misc/dlb2/dlb2_hw_types.h
> > > @@ -0,0 +1,29 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> > 
> > Why dual licensed?  I thought that Intel told me they were not going to do
> > that anymore for any kernel code going forward as it was just such a pain and
> > never actually helped anything.  Has that changed?
> > 
> 
> The driver is mostly GPLv2-only, but a subset constitutes a "hardware access library" that is almost completely OS-independent. "almost" because it has calls to non-GPL symbols like kmalloc() and kfree(). This dual-licensed portion can be ported to other environments that need the more permissive BSD license.

Then put that "OS independant" part as a separate file, with a separate
license.  You all know how to do this properly, don't mix this stuff up.

But even then, I would drop such a library as that's not going to make a
good Linux driver, we do not like, or need, such things in the kernel.

> For the broader policy question, Intel's open source team will get back to you on this.

Wonderful, when will that happen?

thanks,

greg k-h
