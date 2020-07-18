Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63857C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F08D2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595054926;
	bh=AYcf4lCF4uqguLe3tllnR/0HNedkP2GPCOoNk6kdXq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V65TGj3wZqE1cGrMkoTwfiZm1MQs9irFLFmxdQgYz1jNoeG2kGg85xV/s4gZ3H8h9
	 ysTz89yhn/AcVKmh4U5/WloOC3DeKfhbxlog5RyA6kT7NsbTVJB5HJjpNSyVPOz1dK
	 23QlXgdEk9XGXEo4YGNtaSXdQeYVYA02x022l9/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGRGsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgGRGso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:48:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA1E2074B;
        Sat, 18 Jul 2020 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595054923;
        bh=AYcf4lCF4uqguLe3tllnR/0HNedkP2GPCOoNk6kdXq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzQqCtxba1xFIIIvASbEPoSm8uKUPvcTsYCF08xgeOAFsM1n37aU3T2Edip4A2nzJ
         CU+iMPW8QwLrZzG92ye0FAOVYNrRhKlQFZ+Nu/i5fYon2Zp2ChL+kPgh5T8perZpXg
         h2fMTjQPOk4AvBH+L1lUqkn67kWog1I5y8T9XdAY=
Date:   Sat, 18 Jul 2020 08:48:41 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Message-ID: <20200718064841.GC245355@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574F33CF9C422517B3C13CFF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <CAK8P3a09C6-auonW9jw30z_CijLgT+LkWfYowYoVdrwSzNGWKg@mail.gmail.com>
 <SN6PR11MB257499106855871ACD053253F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB257499106855871ACD053253F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:05:08PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Friday, July 17, 2020 1:57 PM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; gregkh <gregkh@linuxfoundation.org>;
> > Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> > <bjorn.topel@intel.com>
> > Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
> > 
> > On Fri, Jul 17, 2020 at 8:19 PM Eads, Gage <gage.eads@intel.com> wrote:
> > 
> > > > A plain copy_from_user() in place of this function should be fine.
> > >
> > > This function also validates the user size arg to prevent buffer overflow;
> > centralizing it here avoids the case where a programmer accidentally forgets
> > the check in an ioctl handler (and reduces code duplication). If it's alright with
> > you, I'll keep the function but drop the dev_err() prints.
> > 
> > Once you use a 'switch(cmd)' statement in the top ioctl handler, the data
> > structure size will be fixed, so there is no way the argument size can go wrong.
> > 
> 
> Ah, understood. Will fix in v2.
> 
> > > >
> > > > > +/* [7:0]: device revision, [15:8]: device version */ #define
> > > > > +DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > > > > +
> > > > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > > > +                                        unsigned long user_arg,
> > > > > +                                        u16 size) {
> > > > > +       struct dlb2_get_device_version_args arg;
> > > > > +       struct dlb2_cmd_response response;
> > > > > +       int ret;
> > > > > +
> > > > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > > > +
> > > > > +       response.status = 0;
> > > > > +       response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> > > > > +
> > > > > +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret = dlb2_copy_resp_to_user(dev, arg.response,
> > > > > + &response);
> > > >
> > > > Better avoid any indirect pointers. As you always return a constant
> > > > here, I think the entire ioctl command can be removed until you
> > > > actually need it. If you have an ioctl command that needs both input
> > > > and output, use _IOWR() to define it and put all arguments into the same
> > structure.
> > >
> > > Ok, I'll merge the response structure into the ioctl structure (here and
> > elsewhere).
> > >
> > > Say I add this command later: without driver versioning, how would
> > > user-space know in advance whether the command is supported?
> > > It could attempt the command and interpret -ENOTTY as "unsupported",
> > > but that strikes me as an inelegant way to reverse-engineer the version.
> > 
> > There is not really a driver "version" once the driver is upstream, the concept
> > doesn't really make sense here when arbitrary patches can get backported
> > from the latest kernel into whatever the user is running.
> > 
> 
> "Driver interface version" is the better term for what I'm trying to accomplish here. Any backports would have to be done in such a way that the interface version is honored, but if that can't be reasonably expected...then I agree, versioning is unworkable.

There is no such thing as a "driver interface version", sorry, that is
not going to be workable at all.

thanks,

greg k-h
