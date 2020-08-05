Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0217CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4F522CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658539;
	bh=gBmY82YJchlC5eNJ+4SoP6WaPlkBBETLWW2SZmQNfJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ML/rkkgDTbMQLAnlLWjQU4dKx4LIIRlOXDuNzsYrhdxQ4HM2cUQN6sub6JnMV7aa8
	 RanjEtG0nfnbKx144lGsc2VEB+IkpHO2Lep2wfVya7zdpffontLwY9LepWnA5+oGzf
	 HVou2UkfvfuRRC7xy8YMQiqCP5QQbA3meHdKy6rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHEUPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgHEQUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCD5206B6;
        Wed,  5 Aug 2020 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596640653;
        bh=gBmY82YJchlC5eNJ+4SoP6WaPlkBBETLWW2SZmQNfJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLrph8iPoGj6bvjObc8NNwkLm5v3s4RbLkhEZ5CiXq8rFbP1BrNHK0N41jM118DvI
         TyTRSBwmehDb8aQZwh1n97tVH8Yk2MhhvqwYkZ3lk8UTbzwA/31QEoAl4IjOZQpCBs
         MFv1a5+jxYiasNVEcbSw9OFjapiq72wVXDb+pbcw=
Date:   Wed, 5 Aug 2020 17:17:50 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
Message-ID: <20200805151750.GB2403607@kroah.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
 <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
 <SN6PR11MB2574422442C26A41FBC89DA1F64A0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200805064622.GA608152@kroah.com>
 <SN6PR11MB2574EE40D3120F92F1BFEEAAF64B0@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2574EE40D3120F92F1BFEEAAF64B0@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:07:50PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: gregkh <gregkh@linuxfoundation.org>
> > Sent: Wednesday, August 5, 2020 1:46 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel@vger.kernel.org;
> > Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> > <bjorn.topel@intel.com>
> > Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
> > 
> > On Tue, Aug 04, 2020 at 10:20:47PM +0000, Eads, Gage wrote:
> > > > > +/* [7:0]: device revision, [15:8]: device version */
> > > > > +#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> > > > > +
> > > > > +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> > > > > +                                        unsigned long user_arg,
> > > > > +                                        u16 size)
> > > > > +{
> > > > > +       struct dlb2_get_device_version_args arg;
> > > > > +       struct dlb2_cmd_response response;
> > > > > +       int ret;
> > > > > +
> > > > > +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> > > > > +
> > > > > +       response.status = 0;
> > > > > +       response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> > > > > +
> > > > > +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg,
> > sizeof(arg));
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
> > > >
> > > > Better avoid any indirect pointers. As you always return a constant
> > > > here, I think the entire ioctl command can be removed until you
> > > > actually need it. If you have an ioctl command that needs both
> > > > input and output, use _IOWR() to define it and put all arguments
> > > > into the same structure.
> > >
> > > I should've caught this in my earlier response, sorry. The device version
> > > command is intentionally the first in the user interface enum. My
> > > goal is for all device versions (e.g. DLB 1.0 in the future) to be accessible
> > > through a /dev/dlb%d node. To allow this, all drivers would support the
> > same
> > > device-version command as command 0, then the subsequent commands
> > can be
> > > tailored to that particular device. User-space would query the version first
> > > to determine which set of ioctl commands it needs to use.
> > >
> > > So even though the response is constant (for now), it must occupy
> > command 0 for
> > > this design to work.
> > 
> > "versions" for ioctls just do not work, please don't go down that path,
> > they should not be needed.  See the many different discussions about
> > this topic on lkml for other subsystem submissions if you are curious.
> > 
> 
> This approach is based on VFIO's modular ioctl design, which has a different
> API for Type1 vs. SPAPR IOMMUs. Similarly a DLB driver could have a different
> API for each device version (but each API would be fixed, not versioned). I
> didn't see any concerns on lkml over VFIO when it was originally submitted -- though
> that was 8 years ago, perhaps the community's feelings have changed since then.

Fixed apis for device types is usually the better way to go.  See the
review comments on the nitro_enclaves driver submission a few weeks ago
for the full details.

greg k-h
