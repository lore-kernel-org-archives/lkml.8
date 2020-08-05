Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC602C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC1522B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596609967;
	bh=b/ISxBJkxTj71SxW9Fvr39ExmksIlTwwn0gnSM6clBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bBm1oCAl9al9ASrfffBvFfE36eDZ5ZBqQw/o8wPDhM4n5HnfhK1CA0Y0I215Y7GSB
	 3w7amrRxoKSDWei5znHCBKsY+UuoWNlyGScfWJramLbijis3Uhgf6xaaeuWiF1ssF+
	 3Az5GTbBHHlJRyclbVqy21YGc/GaNxY6bRpHjvnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHEGqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEGqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:46:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFD52076E;
        Wed,  5 Aug 2020 06:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596609965;
        bh=b/ISxBJkxTj71SxW9Fvr39ExmksIlTwwn0gnSM6clBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4QzF2WN1uR4Z537dtQAMIrYpcpzFg0eobJFDRxiG8CMXTUzn6O2xUrDeRIpkwYGE
         J1OZMNIVH4lX5U5RxyUXDJqYRQlslQwwvb6WPmhr+pIPJ3UxRe2gSoRi2P/Ja/zkwS
         nBFUh5NAzgcfQU0SCyVDB+kYTD5d9Ca1CezbuyvI=
Date:   Wed, 5 Aug 2020 08:46:22 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Message-ID: <20200805064622.GA608152@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:20:47PM +0000, Eads, Gage wrote:
> > > +/* [7:0]: device revision, [15:8]: device version */
> > > +#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > > +
> > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > +                                        unsigned long user_arg,
> > > +                                        u16 size)
> > > +{
> > > +       struct dlb2_get_device_version_args arg;
> > > +       struct dlb2_cmd_response response;
> > > +       int ret;
> > > +
> > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > +
> > > +       response.status = 0;
> > > +       response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> > > +
> > > +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
> > 
> > Better avoid any indirect pointers. As you always return a constant
> > here, I think the entire ioctl command can be removed until you
> > actually need it. If you have an ioctl command that needs both
> > input and output, use _IOWR() to define it and put all arguments
> > into the same structure.
> 
> I should've caught this in my earlier response, sorry. The device version
> command is intentionally the first in the user interface enum. My
> goal is for all device versions (e.g. DLB 1.0 in the future) to be accessible
> through a /dev/dlb%d node. To allow this, all drivers would support the same
> device-version command as command 0, then the subsequent commands can be
> tailored to that particular device. User-space would query the version first
> to determine which set of ioctl commands it needs to use.
> 
> So even though the response is constant (for now), it must occupy command 0 for
> this design to work.

"versions" for ioctls just do not work, please don't go down that path,
they should not be needed.  See the many different discussions about
this topic on lkml for other subsystem submissions if you are curious.

thanks,

greg k-h
