Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99154C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C0E24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710571;
	bh=ztsFQuOS0jDxnxVmgdeYoi1OWAbYtzzS6bn2PGzoXXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hcu3NzobIpngmp5oNJQk8gtosa9FqCFjkeLcHS0ah/VDCyAt82gbs1ZwoipYON6Pn
	 xzFfVIlNPpQqzerP7D7+O/Uz4bV1IcXwEPOf1uyyRSRcFU5PZj4RgqM2NBO+Dagi0N
	 IzHk/SMq+a1UpcZWsMTKhSB55ejxFNV4WKTVchds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbgBNUCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgBNUCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:47 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756F124673;
        Fri, 14 Feb 2020 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710566;
        bh=ztsFQuOS0jDxnxVmgdeYoi1OWAbYtzzS6bn2PGzoXXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2NYCqcBDEnnIrQDdlzOcVVq1BES3aGdj3DrZgNnTiz8J3qTTPLMi1BN0O31c7AO/
         9YflMvVvZ6DgO3fmA0Y6FAQ9iH+37x2vY2VKidy1WCE0znwIlU4xBuqKqWYsyyWX0U
         7Sufa/UxI9CMUfe5jXVhF9Znu85MVwaqHmFUlGVs=
Date:   Fri, 14 Feb 2020 09:10:05 -0800
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     Rajan Vaja <RAJANV@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200214171005.GB4034785@kroah.com>
References: <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
 <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:57:01PM -0800, Jolly Shah wrote:
> Hi Greg,
> 
> > ------Original Message------
> > From: 'Greg Kh' <gregkh@linuxfoundation.org>
> > Sent:  Friday, January 31, 2020 1:36AM
> > To: Rajan Vaja <RAJANV@xilinx.com>
> > Cc: Jolly Shah <JOLLYS@xilinx.com>, Ard Biesheuvel
> <ard.biesheuvel@linaro.org>, Mingo <mingo@kernel.org>, Matt
> <matt@codeblueprint.co.uk>, Sudeep Holla <sudeep.holla@arm.com>, Hkallweit1
> <hkallweit1@gmail.com>, Keescook <keescook@chromium.org>, Dmitry Torokhov
> <dmitry.torokhov@gmail.com>, Michal Simek <michals@xilinx.com>,
> Linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-kernel
> <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
> >
> > On Fri, Jan 31, 2020 at 09:05:15AM +0000, Rajan Vaja wrote:
> > > Hi Greg,
> > > 
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: 31 January 2020 11:41 AM
> > > > To: Jolly Shah <JOLLYS@xilinx.com>
> > > > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk;
> > > > sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> > > > dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > > > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
> > > > 
> > > > EXTERNAL EMAIL
> > > > 
> > > > On Thu, Jan 30, 2020 at 11:59:03PM +0000, Jolly Shah wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > ﻿On 1/27/20, 10:28 PM, "linux-kernel-owner@vger.kernel.org on behalf of Greg
> > > > KH" <linux-kernel-owner@vger.kernel.org on behalf of
> > > > gregkh@linuxfoundation.org> wrote:
> > > > > 
> > > > >      On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
> > > > >      >     > > > +     ret = kstrtol(tok, 16, &value);
> > > > >      >     > > > +     if (ret) {
> > > > >      >     > > > +             ret = -EFAULT;
> > > > >      >     > > > +             goto err;
> > > > >      >     > > > +     }
> > > > >      >     > > > +
> > > > >      >     > > > +     ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
> > > > >      >     > >
> > > > >      >     > > This feels "tricky", if you tie this to the device you have your driver
> > > > >      >     > > bound to, will this make it easier instead of having to go through the
> > > > >      >     > > ioctl callback?
> > > > >      >     > >
> > > > >      >     >
> > > > >      >     > GGS(general global storage) registers are in PMU space and linux
> > > > doesn't have access to it
> > > > >      >     > Hence ioctl is used.
> > > > >      >
> > > > >      >     Why not just a "real" call to the driver to make this type of reading?
> > > > >      >     You don't have ioctls within the kernel for other drivers to call,
> > > > >      >     that's not needed at all.
> > > > >      >
> > > > >      > these registers are for users  and for special needs where users wants
> > > > >      > to retain values over resets. but as they belong to PMU address space,
> > > > >      > these interface APIs are provided. They don’t allow access to any
> > > > >      > other registers.
> > > > > 
> > > > >      That's not the issue here.  The issue is you are using an "internal"
> > > > >      ioctl, instead just make a "real" call.
> > > > > 
> > > > > Sorry I am not clear. Do you mean that we should use linux standard
> > > > > ioctl interface instead of internal ioctl by mentioning "real" ?
> > > > 
> > > > No, you should just make a "real" function call to the exact thing you
> > > > want to do.  Not have an internal multi-plexor ioctl() call that others
> > > > then call.  This isn't a microkernel :)
> > > [Rajan] Sorry for multiple back and forth but as I understand, you are suggesting to create a new API for
> > > Read/write of GGS register instead of using PM_IOCTL API (eemi_ops->ioctl) for multiple purpose. Is my understanding correct?
> > 
> > That is correct.
> 
> 
> 
> Would like to clarify purpose of having ioctl API to avoid any confusion.
> eemi interface apis are defined to be platform independent and allows clock,
> reset, power etc management through firmware but apart from these generic
> operations, there are some operations which needs secure access through
> firmware. Examples are accessing some storage registers(ggs and pggs) for
> inter agent communication, configuring another agent(RPU) mode, boot device
> configuration etc. Those operations are covered as ioctls as they are very
> platform specific. Also only whitelisted operations are allowed through
> ioctl and is not exposed to user for any random read/write operation.
> 
> Olof earlier had same concerns. We had clarified the purpose and with his
> agreement, initial set of ioctls were accepted.
> (https://www.lkml.org/lkml/2018/9/24/1570)
> 
> Please suggest the best approach to handle this for current and future
> patches.

Ok, in looking further at this, it's both better than I thought, and
totally worse.

This interface you all are using where you ask the firmware driver for a
pointer to a set of operation functions and then make calls through that
is indicitive of an api that is NOT what we normally use in Linux at
all.

Just make the direct call to the firmware driver, no need to muck around
with tables of function pointers.  In fact, with the spectre changes,
you just made things slower than needed, and you can get back a bunch of
throughput by removing that whole middle layer.

So go do that first please, before adding any new stuff.

Now for the ioctl, yeah, that's not a "normal" pattern either.  But
right now you only have 2 "different" ioctls that you call.  So why not
just turn those 2 into real function calls as well that then makes the
"ioctl" call to the hardware?  That makes things a lot more obvious on
the kernel driver side exactly what is going on.

If you need to add more "ioctl" like calls, just add them as more
functions, no big deal.  How many more of these are you going to need
over time?

But that's not all that big of a deal right now, get rid of that whole
middle-layer first, that's more important to clean up.  You will get rid
of a lot of unneeded code and indirection that way, making it simpler
and easier to understand what exactly is happening.

thanks,

greg k-h
